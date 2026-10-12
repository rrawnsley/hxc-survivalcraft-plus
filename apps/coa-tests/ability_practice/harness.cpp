#include "AbilityPracticeDevelopmentResourcePacing.h"
#include "AbilityPracticeEnrollment.h"
#include "AbilityPracticeProgression.h"
#include "AbilityPracticeCatalog.h"
#include "AbilityPracticeActions.h"
#include "AbilityPracticeState.h"
#include "AbilityPracticeMenu.h"
#include "AbilityPracticeWire.h"
#include "AbilityPracticePersistence.h"
#include "AbilityPracticeOutcome.h"
#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeDevelopmentPacing.h"
#include "AbilityPracticeDevelopmentRankCaps.h"
#include "AbilityPracticeCatchup.h"
#include "AbilityPracticeDevelopmentBuffs.h"
#include "AbilityPracticeDevelopmentBuffVariants.h"
#include "AbilityPracticeDevelopmentMastery.h"
#include "AbilityPracticeDevelopmentMasteryPacing.h"
#include "AbilityPracticeDevelopmentTrainerRanks.h"
#include "AbilityPracticeDevelopmentBuffTrainerRanks.h"
#include "AbilityPracticeDevelopmentStatBuffTrainerRanks.h"
#include "AbilityPracticeDevelopmentSpellPowerBuffTrainerRanks.h"
#include "AbilityPracticeDevelopmentFixed.h"
#include "AbilityPracticeDevelopmentHelpers.h"
#include "AbilityPracticeDevelopmentPeriodic.h"
#include "AbilityPracticeDevelopmentControl.h"
#include "AbilityPracticeDevelopmentConjureFixed.h"
#include "AbilityPracticeDevelopmentPassiveFixed.h"
#include "AbilityPracticeDevelopmentUtilityFixed.h"
#include "AbilityPracticeDevelopmentControlFixed.h"
#include "AbilityPracticeDevelopmentTrainerFixed.h"
#include "AbilityPracticeNativeRankChain.h"
#include "AbilityPracticeBuffReceipts.h"

#include "../../../src/server/game/Spells/AbilityPracticeCastReceipt.h"
#include "../../../src/server/game/Spells/AbilityPracticeMasteryPolicy.h"

#include <algorithm>
#include <array>
#include <thread>
#include <cassert>
#include <iostream>
#include <fstream>
#include <map>
#include <utility>

using namespace AbilityPractice;

struct SettingsPlayer
{
    struct Setting
    {
        std::uint32_t value;
    };
    std::map<std::string, std::vector<Setting>> Settings;
    std::uint32_t ClassId = 24;
    std::vector<std::uint32_t> Learned = { 101 };

    std::uint32_t getClass() const { return ClassId; }
    bool HasSpell(std::uint32_t spellId) const { return KnowsSpell(Learned, spellId); }

    std::vector<Setting> const* FindPlayerSettings(std::string const& source) const
    {
        auto const found = Settings.find(source);
        return found == Settings.end() ? nullptr : &found->second;
    }

    void UpdatePlayerSetting(std::string const& source, std::uint32_t index, std::uint32_t value)
    {
        auto& fields = Settings[source];
        fields.resize(std::max(fields.size(), std::size_t(index) + 1));
        fields[index].value = value;
    }
};

struct OutcomeSpell
{
    struct Info
    {
        std::uint32_t Id = 101;
        bool Passive = false;
        bool IsPassive() const { return Passive; }
    };
    Info SpellInfo;
    SettingsPlayer* Caster;
    bool Triggered = false;
    std::map<std::uint32_t, std::uint64_t> Values;

    bool IsTriggered() const { return Triggered; }
    SettingsPlayer* GetCaster() const { return Caster; }
    Info const* GetSpellInfo() const { return &SpellInfo; }
    std::uint64_t GetScriptValue(std::uint32_t key) const
    {
        auto const found = Values.find(key);
        return found == Values.end() ? 0 : found->second;
    }
    void SetScriptValue(std::uint32_t key, std::uint64_t value) { Values[key] = value; }
};

void CheckOutcome(TrainingPolicy policy)
{
    std::array const ranks = { AbilityRank{ 101, 1, { 4, 1 } }, AbilityRank{ 102, 2, { 16, 20 } } };
    std::array const caps = { ProficiencyCap{ 1, 10 }, ProficiencyCap{ 16, 30 } };
    AbilityDefinition const ability{ 24, 1001, AbilityKind::Ranked, ranks, caps };
    SettingsPlayer player;
    OutcomeSpell spell{ {}, &player, false, {} };
    OutcomeContext enabled{ true, true, true, true, 16 };
    assert(HandleOutcome(player, spell, ability, policy, 1, {}).Status == OutcomeStatus::Disabled);
    assert(player.Settings.empty() && spell.Values.empty());
    OutcomeContext ineligible = enabled;
    ineligible.QualifiedOutcome = false;
    assert(HandleOutcome(player, spell, ability, policy, 1, ineligible).Status == OutcomeStatus::Unqualified);
    assert(player.Settings.empty() && spell.Values.empty());
    spell.Triggered = true;
    assert(HandleOutcome(player, spell, ability, policy, 1, enabled).Status == OutcomeStatus::Unqualified);
    spell.Triggered = false;
    spell.SpellInfo.Passive = true;
    assert(HandleOutcome(player, spell, ability, policy, 1, enabled).Status == OutcomeStatus::Unqualified);
    spell.SpellInfo.Passive = false;
    OutcomeAward const first = HandleOutcome(player, spell, ability, policy, 1, enabled);
    assert(first.Status == OutcomeStatus::Awarded && first.Record.State.Points == 2);
    assert(first.Record.MigrationVersion == 1);
    for (std::uint32_t target = 0; target < 100; ++target)
        assert(HandleOutcome(player, spell, ability, policy, 1, enabled).Status == OutcomeStatus::AlreadyAwarded);
    assert(ReadPlayerProgress(player, 24, 1001, policy, 1).Record.State.Points == 2);
    OutcomeSpell next{ {}, &player, false, {} };
    assert(HandleOutcome(player, next, ability, policy, 1, enabled).Record.State.Points == 4);
    OutcomeSpell mismatch{ {}, &player, false, {} };
    assert(HandleOutcome(player, mismatch, ability, policy, 2, enabled).Status == OutcomeStatus::StateConflict);
    assert(mismatch.Values.empty());
    player.ClassId = 25;
    assert(HandleOutcome(player, mismatch, ability, policy, 1, enabled).Status == OutcomeStatus::Invalid);
    player.ClassId = 24;
    mismatch.SpellInfo.Id = 999;
    assert(HandleOutcome(player, mismatch, ability, policy, 1, enabled).Status == OutcomeStatus::Unqualified);
    SettingsPlayer existing;
    existing.Learned = { 102 };
    OutcomeSpell knownRank{ { 102, false }, &existing, false, {} };
    OutcomeAward const seeded = HandleOutcome(existing, knownRank, ability, policy, 1, enabled);
    assert(seeded.Status == OutcomeStatus::Awarded && seeded.Record.State.Proficiency == 20);
    assert(seeded.Record.State.Points == 1);
    assert(!existing.HasSpell(101));
    assert(CachePlayerProgress(existing, 24, 1001, policy, { 1, 1, { 40, 0 } }));
    OutcomeSpell capped{ { 102, false }, &existing, false, {} };
    auto const atCap = HandleOutcome(existing, capped, ability, policy, 1, enabled);
    assert(atCap.Status == OutcomeStatus::Capped && atCap.Record.State.Proficiency == 40);
}

void CheckPersistence(TrainingPolicy policy)
{
    assert(StorageSource(255, 4294967295U).size() == 40);
    assert(StorageSource(0, 1001).empty() && StorageSource(256, 1001).empty());
    assert(StorageSource(24, 0).empty());
    SettingsPlayer player;
    auto const missing = ReadPlayerProgress(player, 24, 1001, policy, 7);
    assert(missing.Status == LoadStatus::Missing && player.Settings.empty());
    std::array const ranks = { AbilityRank{ 101, 1, { 4, 1 } }, AbilityRank{ 102, 2, { 16, 20 } } };
    std::array const caps = { ProficiencyCap{ 1, 10 }, ProficiencyCap{ 16, 30 } };
    AbilityDefinition const ability{ 24, 1001, AbilityKind::Ranked, ranks, caps };
    std::array const known = { 102U };
    auto const migrated = MigrateLearnedRanks(ability, policy, missing, known);
    assert(migrated && migrated->State.Proficiency == 20 && migrated->MigrationVersion == 1);
    assert(CachePlayerProgress(player, 24, 1001, policy, *migrated));
    auto const loaded = ReadPlayerProgress(player, 24, 1001, policy, 7);
    assert(loaded.Status == LoadStatus::Loaded && loaded.Record.State.Proficiency == 20);
    assert(loaded.Record.DefinitionVersion == 7 && loaded.Record.MigrationVersion == 1);
    assert(ReadPlayerProgress(player, 24, 1001, policy, 8).Status == LoadStatus::DefinitionMismatch);
    assert(ReadPlayerProgress(player, 25, 1001, policy, 7).Status == LoadStatus::Missing);
    assert(ReadPlayerProgress(player, 24, 1002, policy, 7).Status == LoadStatus::Missing);
    auto const fields = EncodeStoredProgress(policy, loaded.Record);
    assert(fields && (*fields)[3] == 20 && (*fields)[4] == 0);
    std::array broken = *fields;
    broken[0] = 2;
    assert(DecodeStoredProgress(policy, 7, broken, true).Status == LoadStatus::UnsupportedSchema);
    broken = *fields;
    broken[2] = 2;
    assert(DecodeStoredProgress(policy, 7, broken, true).Status == LoadStatus::UnsupportedMigration);
    broken = *fields;
    broken[3] = 0;
    assert(DecodeStoredProgress(policy, 7, broken, true).Status == LoadStatus::Invalid);
    broken = *fields;
    broken[4] = 30;
    assert(DecodeStoredProgress(policy, 7, broken, true).Status == LoadStatus::Invalid);
    assert(DecodeStoredProgress(policy, 7, std::span(*fields).first(4), true).Status == LoadStatus::Invalid);
    LoadedProgress partial{ LoadStatus::Loaded, { 7, 0, { 9, 15 } } };
    auto const retained = MigrateLearnedRanks(ability, policy, partial, known);
    assert(retained && retained->State.Proficiency == 20 && retained->State.Points == 15);
    assert(retained->MigrationVersion == 1);
    std::array const scaledBands = { TrainingBand{ 1, 30, 2 }, TrainingBand{ 20, 60, 1 } };
    auto const scaled = MigrateLearnedRanks(ability, { scaledBands }, partial, known);
    assert(scaled && scaled->State.Proficiency == 20 && scaled->State.Points == 30);
    std::array const inexactBands = { TrainingBand{ 1, 30, 2 }, TrainingBand{ 20, 7, 1 } };
    assert(!MigrateLearnedRanks(ability, { inexactBands }, partial, known));
    assert(partial.Record.State.Proficiency == 9 && partial.Record.State.Points == 15);
    LoadedProgress once{ LoadStatus::Loaded, { 7, 1, { 1, 0 } } };
    auto const notReseeded = MigrateLearnedRanks(ability, policy, once, known);
    assert(notReseeded && notReseeded->State.Proficiency == 1);
    assert(!MigrateLearnedRanks(ability, policy, { LoadStatus::UnsupportedSchema, {} }, known));
    auto const before = player.Settings;
    assert(!CachePlayerProgress(player, 24, 1001, policy, { 0, 1, { 1, 0 } }));
    assert(player.Settings.size() == before.size());
    assert(ReadPlayerProgress(player, 24, 1001, policy, 7).Record.State.Proficiency == 20);
    assert(!CachePlayerProgress(player, 24, 1001, policy, { 8, 1, { 20, 0 } }));
    assert(!CachePlayerProgress(player, 24, 1001, policy, { 7, 0, { 20, 0 } }));
    assert(!CachePlayerProgress(player, 24, 1001, policy, { 7, 1, { 19, 0 } }));
    assert(CachePlayerProgress(player, 24, 1001, policy, { 7, 1, { 20, 5 } }));
    assert(!CachePlayerProgress(player, 24, 1001, policy, { 7, 1, { 20, 4 } }));
    assert(CachePlayerProgress(player, 24, 1001, policy, { 7, 1, { 21, 0 } }));
}

void CheckMenu(TrainingPolicy policy)
{
    std::array const ranks = { AbilityRank{ 101, 1, { 4, 1 } }, AbilityRank{ 102, 2, { 16, 20 } },
        AbilityRank{ 103, 3, { 24, 40 } } };
    std::array const caps = { ProficiencyCap{ 1, 10 }, ProficiencyCap{ 16, 30 }, ProficiencyCap{ 24, 60 } };
    AbilityDefinition const ability{ 24, 1001, AbilityKind::Ranked, ranks, caps };
    std::array const known = { 101U, 102U };
    AbilityView const training = BuildAbilityView(ability, policy, { 23, 18 }, 24, known, true);
    assert(training.SchemaVersion == 1 && training.ClassId == 24 && training.AbilityId == 1001);
    assert(training.DisplaySpellId == 102 && training.LearnedRank == 2);
    assert(training.Availability == PracticeAvailability::Training);
    assert(training.State.Proficiency == 23 && training.State.Points == 18 && training.PointsPerLevel == 30);
    assert(training.Cap == 60 && training.NextPoint.Uses == 12);
    assert(training.NextRank && training.NextRank->SpellId == 103 && training.NextRank->Practice.Uses == 492);
    AbilityView const waiting = BuildAbilityView(ability, policy, { 23, 18 }, 16, known, true);
    assert(waiting.Availability == PracticeAvailability::Training && waiting.NextPoint.Uses == 12);
    assert(waiting.NextRank->State == RankState::NeedsBoth);
    assert(waiting.NextRank->Practice.Status == ForecastStatus::BeyondCap);
    AbilityView const capped = BuildAbilityView(ability, policy, { 40, 0 }, 16, known, true);
    assert(capped.Availability == PracticeAvailability::Capped && capped.State.Proficiency == 40);
    assert(capped.NextPoint.Status == ForecastStatus::BeyondCap);
    assert(capped.NextRank->State == RankState::NeedsCharacterLevel);
    std::array const allKnown = { 101U, 102U, 103U };
    assert(!BuildAbilityView(ability, policy, { 40, 0 }, 24, allKnown, true).NextRank);
    std::array<std::uint32_t, 0> const unknown{};
    AbilityView const acquire = BuildAbilityView(ability, policy, { 1, 0 }, 4, unknown, true);
    assert(acquire.Availability == PracticeAvailability::AcquireAbility);
    assert(acquire.LearnedRank == 0 && acquire.DisplaySpellId == 101);
    assert(acquire.NextPoint.Status == ForecastStatus::Invalid);
    assert(acquire.NextRank->State == RankState::AcquireIntroductoryAbility);
    assert(BuildAbilityView(ability, policy, { 1, 0 }, 3, unknown, true).Availability ==
        PracticeAvailability::NeedsCharacterLevel);
    assert(BuildAbilityView(ability, policy, { 23, 18 }, 24, known, false).Availability ==
        PracticeAvailability::MissingPrerequisite);
    assert(BuildAbilityView(ability, policy, { 1, 30 }, 24, known, true).Availability ==
        PracticeAvailability::Invalid);
    assert(BuildAbilityView(ability, policy, { 1, 0 }, 0, known, true).Availability ==
        PracticeAvailability::Invalid);
    AbilityDefinition const fixed{ 24, 1002, AbilityKind::Fixed, std::span(ranks).first(1), {} };
    AbilityView const fixedKnown = BuildAbilityView(fixed, { {} }, {}, 4, known, true);
    assert(fixedKnown.Availability == PracticeAvailability::Fixed && !fixedKnown.NextRank);
    assert(fixedKnown.PointsPerLevel == 0 && fixedKnown.NextPoint.Status == ForecastStatus::Invalid);
    AbilityView const fixedNew = BuildAbilityView(fixed, { {} }, {}, 4, unknown, true);
    assert(fixedNew.Availability == PracticeAvailability::AcquireAbility);
    assert(fixedNew.NextRank->State == RankState::AcquireIntroductoryAbility);
    assert(BuildAbilityView(fixed, { {} }, {}, 3, unknown, true).NextRank->State ==
        RankState::NeedsCharacterLevel);
}

void CheckState(TrainingPolicy policy)
{
    ProgressState state(501, 24, 1001, 1);
    assert(!state.Ready() && !state.Dirty() && !state.BeginSave());
    assert(state.Apply(policy, 80).Status == AwardStatus::Invalid);
    assert(!state.Replace(policy, { 1, 0 }));
    assert(!state.Initialize(policy, { 1, 30 }, false));
    assert(state.Initialize(policy, { 1, 0 }, false));
    assert(state.Ready() && !state.Dirty());
    assert(!state.Initialize(policy, { 40, 0 }, true));
    assert(state.Apply(policy, 80).Status == AwardStatus::Applied);
    assert(state.Get().Points == 2 && state.Dirty());
    auto const first = state.BeginSave();
    assert(first && first->State.Points == 2 && first->DefinitionVersion == 1);
    assert(!state.BeginSave());
    assert(state.Apply(policy, 80).Status == AwardStatus::Applied);
    assert(state.Get().Points == 4);
    SaveTicket wrong = first->Ticket;
    ++wrong.Session;
    assert(!state.CompleteSave(wrong, true));
    wrong = first->Ticket;
    ++wrong.AbilityId;
    assert(!state.CompleteSave(wrong, true));
    wrong = first->Ticket;
    ++wrong.ClassId;
    assert(!state.CompleteSave(wrong, true));
    assert(state.CompleteSave(first->Ticket, true) && state.Dirty());
    assert(!state.CompleteSave(first->Ticket, true));

    auto const second = state.BeginSave();
    assert(second && second->State.Points == 4 && second->Ticket.Revision > first->Ticket.Revision);
    assert(!state.CompleteSave(first->Ticket, true));
    assert(state.CompleteSave(second->Ticket, false) && state.Dirty());
    auto const retry = state.BeginSave();
    assert(retry && retry->Ticket.Revision == second->Ticket.Revision);
    assert(retry->Ticket.Attempt > second->Ticket.Attempt);
    assert(!state.CompleteSave(second->Ticket, true));
    assert(state.CompleteSave(retry->Ticket, true) && !state.Dirty());
    assert(!state.BeginSave());
    assert(state.Replace(policy, state.Get()) && !state.Dirty());
    assert(!state.Replace(policy, { 0, 0 }) && !state.Dirty());
    assert(state.Replace(policy, { 80, 0 }) && state.Dirty());
    auto const last = state.BeginSave();
    assert(last && state.CompleteSave(last->Ticket, true) && !state.Dirty());
    assert(state.Apply(policy, 80).Status == AwardStatus::Capped && !state.Dirty());

    ProgressState migrated(502, 24, 1001, 1);
    assert(migrated.Initialize(policy, { 40, 0 }, true) && migrated.Dirty());
    auto const migration = migrated.BeginSave();
    assert(migration && migration->State.Proficiency == 40);
    assert(!migrated.CompleteSave(last->Ticket, true));
    assert(migrated.CompleteSave(migration->Ticket, true) && !migrated.Dirty());
    ProgressState invalidSession(0, 24, 1001, 1);
    ProgressState invalidClass(501, 0, 1001, 1);
    ProgressState invalidAbility(501, 24, 0, 1);
    ProgressState invalidVersion(501, 24, 1001, 0);
    assert(!invalidSession.Initialize(policy, { 1, 0 }, true));
    assert(!invalidClass.Initialize(policy, { 1, 0 }, true));
    assert(!invalidAbility.Initialize(policy, { 1, 0 }, true));
    assert(!invalidVersion.Initialize(policy, { 1, 0 }, true));
}

void CheckActions()
{
    ActionLedger<2> actions(501);
    ActionToken const first = actions.Begin(1001);
    assert(first.Session == 501 && first.Sequence == 1 && actions.Active() == 1);
    assert(actions.Consume(first, 1001, false) == ActionResult::Unqualified);
    assert(actions.Consume(first, 1002, true) == ActionResult::Invalid);
    assert(actions.Consume({ 502, first.Sequence }, 1001, true) == ActionResult::Invalid);
    assert(actions.Consume({ 501, 99 }, 1001, true) == ActionResult::Invalid);
    assert(actions.Consume({}, 1001, true) == ActionResult::Invalid);
    assert(actions.Consume(first, 1001, true) == ActionResult::Award);
    for (std::uint32_t event = 0; event < 1000; ++event)
        assert(actions.Consume(first, 1001, true) == ActionResult::AlreadyAwarded);
    assert(actions.Consume(first, 1001, false) == ActionResult::AlreadyAwarded);

    ActionToken const second = actions.Begin(1001);
    assert(second.Sequence == 2 && actions.Active() == 2);
    assert(actions.Begin(1001).Sequence == 0 && actions.Active() == 2);
    assert(actions.Consume(second, 1001, true) == ActionResult::Award);
    assert(!actions.End({ 502, first.Sequence }));
    assert(actions.End(first) && actions.Active() == 1);
    assert(!actions.End(first));
    assert(actions.Consume(first, 1001, true) == ActionResult::Invalid);
    ActionToken const third = actions.Begin(1002);
    assert(third.Sequence == 3 && actions.Active() == 2);
    assert(actions.Consume(first, 1001, true) == ActionResult::Invalid);
    assert(actions.Consume(third, 1002, true) == ActionResult::Award);
    assert(actions.End(second) && actions.End(third) && actions.Active() == 0);
    assert(actions.Begin(0).Sequence == 0 && actions.Active() == 0);

    ActionLedger<2> nextSession(502);
    ActionToken const next = nextSession.Begin(1001);
    assert(next.Sequence == 1);
    assert(nextSession.Consume(first, 1001, true) == ActionResult::Invalid);
    assert(nextSession.Consume(next, 1001, true) == ActionResult::Award);
    ActionLedger<0> empty(501);
    assert(empty.Begin(1001).Sequence == 0);
    ActionLedger<2> invalid(0);
    assert(invalid.Begin(1001).Sequence == 0);
}

void CheckCatalog(TrainingPolicy policy)
{
    std::array const ranks = { AbilityRank{ 101, 1, { 4, 1 } }, AbilityRank{ 102, 2, { 16, 20 } },
        AbilityRank{ 103, 3, { 24, 40 } } };
    std::array const caps = { ProficiencyCap{ 1, 10 }, ProficiencyCap{ 16, 30 }, ProficiencyCap{ 24, 60 } };
    AbilityDefinition const ability{ 24, 1001, AbilityKind::Ranked, ranks, caps };
    std::array const catalog = { ability };
    assert(ValidateCatalog(catalog) == CatalogError::None);
    assert(CapAtLevel(ability, 1) == 10);
    assert(CapAtLevel(ability, 15) == 10);
    assert(CapAtLevel(ability, 16) == 30);
    assert(CapAtLevel(ability, 100) == 60);
    assert(CapAtLevel(ability, 0) == 0);

    std::array<std::uint32_t, 0> const unknown{};
    std::array const first = { 101U };
    std::array const second = { 102U };
    std::array const firstTwo = { 101U, 102U };
    assert(DescribeRank(ability, 0, policy, { 1, 0 }, 4, unknown, true).State ==
        RankState::AcquireIntroductoryAbility);
    assert(DescribeRank(ability, 0, policy, { 1, 0 }, 3, unknown, true).State ==
        RankState::NeedsCharacterLevel);
    assert(DescribeRank(ability, 0, policy, { 1, 0 }, 80, unknown, false).State ==
        RankState::MissingPrerequisite);
    assert(DescribeRank(ability, 1, policy, { 40, 0 }, 80, unknown, true).State ==
        RankState::MissingPrerequisite);
    assert(DescribeRank(ability, 1, policy, { 40, 0 }, 80, first, false).State ==
        RankState::MissingPrerequisite);
    assert(DescribeRank(ability, 1, policy, { 40, 0 }, 80, first, true).State == RankState::Ready);
    assert(DescribeRank(ability, 1, policy, { 10, 0 }, 80, first, true).State == RankState::NeedsPractice);
    assert(DescribeRank(ability, 1, policy, { 40, 0 }, 15, first, true).State == RankState::NeedsCharacterLevel);
    assert(DescribeRank(ability, 1, policy, { 10, 0 }, 15, first, true).State == RankState::NeedsBoth);
    assert(DescribeRank(ability, 1, policy, { 1, 0 }, 1, second, false).State == RankState::Learned);
    RankView const locked = DescribeRank(ability, 2, policy, { 23, 18 }, 16, firstTwo, true);
    assert(locked.State == RankState::NeedsBoth && locked.Practice.Status == ForecastStatus::BeyondCap);
    RankView const trainable = DescribeRank(ability, 2, policy, { 23, 18 }, 24, firstTwo, true);
    assert(trainable.State == RankState::NeedsPractice && trainable.Practice.Uses == 492);
    assert(DescribeRank(ability, 3, policy, { 1, 0 }, 80, first, true).State == RankState::Invalid);
    assert(DescribeRank(ability, 0, policy, { 0, 0 }, 80, first, true).State == RankState::Invalid);

    Progress const seeded = SeedLearnedRanks(ability, { 1, 0 }, second);
    assert(seeded.Proficiency == 20 && seeded.Points == 0);
    Progress const retained = SeedLearnedRanks(ability, { 23, 18 }, second);
    assert(retained.Proficiency == 23 && retained.Points == 18);
    assert(SeedLearnedRanks(ability, { 1, 0 }, unknown).Proficiency == 1);

    AbilityDefinition changed = ability;
    changed.ClassId = 0;
    assert(ValidateDefinition(changed) == CatalogError::InvalidIdentity);
    changed = ability;
    changed.Kind = AbilityKind::Fixed;
    assert(ValidateDefinition(changed) == CatalogError::InvalidRank);
    changed.Kind = AbilityKind::Mastery;
    assert(ValidateDefinition(changed) == CatalogError::InvalidRank);
    changed.Kind = static_cast<AbilityKind>(99);
    assert(ValidateDefinition(changed) == CatalogError::InvalidKind);
    changed = ability;
    changed.Ranks = std::span(ranks).first(1);
    changed.Kind = AbilityKind::Fixed;
    assert(ValidateDefinition(changed) == CatalogError::InvalidCap);
    changed.Caps = {};
    assert(ValidateDefinition(changed) == CatalogError::None);
    assert(CapAtLevel(changed, 80) == 1);
    changed.Kind = AbilityKind::Mastery;
    assert(ValidateDefinition(changed) == CatalogError::InvalidCap);
    changed.Caps = caps;
    assert(ValidateDefinition(changed) == CatalogError::None);

    std::array duplicate = { ability, ability };
    assert(ValidateCatalog(duplicate) == CatalogError::DuplicateAbility);
    duplicate[1].AbilityId = 1002;
    assert(ValidateCatalog(duplicate) == CatalogError::DuplicateSpell);
    duplicate[1].ClassId = 25;
    assert(ValidateCatalog(duplicate) == CatalogError::None);

    std::array brokenRanks = ranks;
    brokenRanks[1].RankNumber = 3;
    changed = ability;
    changed.Ranks = brokenRanks;
    assert(ValidateDefinition(changed) == CatalogError::InvalidRank);
    brokenRanks = ranks;
    brokenRanks[1].SpellId = 101;
    assert(ValidateDefinition(changed) == CatalogError::DuplicateSpell);
    brokenRanks = ranks;
    brokenRanks[1].Requirement.CharacterLevel = 2;
    assert(ValidateDefinition(changed) == CatalogError::InvalidRank);
    brokenRanks = ranks;
    brokenRanks[1].Requirement.Proficiency = 50;
    assert(ValidateDefinition(changed) == CatalogError::InvalidRank);
    brokenRanks = ranks;
    brokenRanks[0].Requirement.Proficiency = 2;
    assert(ValidateDefinition(changed) == CatalogError::InvalidRank);

    std::array brokenCaps = caps;
    changed = ability;
    changed.Caps = brokenCaps;
    brokenCaps[0].CharacterLevel = 2;
    assert(ValidateDefinition(changed) == CatalogError::InvalidCap);
    brokenCaps = caps;
    brokenCaps[1].CharacterLevel = 1;
    assert(ValidateDefinition(changed) == CatalogError::InvalidCap);
    brokenCaps = caps;
    brokenCaps[1].Proficiency = 0;
    assert(ValidateDefinition(changed) == CatalogError::InvalidCap);
    brokenCaps = caps;
    brokenCaps[2].Proficiency = 20;
    assert(ValidateDefinition(changed) == CatalogError::InvalidCap);
}

void CheckResourcePacing()
{
    std::uint32_t count = 0;
    for (auto const& entry : DevelopmentPacing::Entries)
    {
        std::array<ProficiencyCap, 80> caps{};
        for (std::size_t index = 0; index < caps.size(); ++index)
            caps[index] = { static_cast<std::uint32_t>(index + 1),
                std::min(static_cast<std::uint32_t>((index + 1) * 5),
                    entry.ExpectedRanks.back().Requirement.Proficiency) };
        AbilityProfile profile{ 4, AcquisitionSource::ClassGrant,
            { entry.ClassId, entry.AbilityId, AbilityKind::Ranked, entry.ExpectedRanks, caps },
            entry.Policy, OutcomeKind::Damage };
        auto adjusted = DevelopmentResourcePacing::Build(profile);
        if (!DevelopmentResourcePacing::Supports(profile))
        {
            assert(!adjusted);
            continue;
        }
        assert(adjusted);
        ++count;
        TrainingPolicy const revised{ adjusted->Bands };
        for (std::size_t index = 0; index < entry.Policy.Bands.size(); ++index)
        {
            auto const& old = entry.Policy.Bands[index];
            auto const& next = adjusted->Bands[index];
            assert(old.FirstProficiency == next.FirstProficiency && old.PointsPerLevel == next.PointsPerLevel);
            assert(next.PointsPerUse == old.PointsPerUse * 5);
            auto const converted = RebaseStoredProgress(entry.Policy, revised, 5,
                { 1, 4, { old.FirstProficiency, old.PointsPerLevel / 2 } });
            assert(converted && converted->State.Proficiency == old.FirstProficiency &&
                converted->State.Points == old.PointsPerLevel / 2);
        }
        assert(UsesUntil(entry.Policy, { 1, 0 }, 10, 10).Uses == 540);
        assert(UsesUntil(revised, { 1, 0 }, 10, 10).Uses == 108);
        assert(UsesUntil(revised, { 1, 0 }, 2, 10).Uses == 12);
        profile.DefinitionVersion = 2;
        assert(!DevelopmentResourcePacing::Build(profile));
    }
    assert(count == 3);
    std::cout << "PASS: three Ember spenders, fivefold practice, exact forecasts and saved fractions\n";
}

void CheckCurrentRankPolicies()
{
    std::uint32_t forecasts = 0;
    std::array<bool, 21> classes{};
    assert(DevelopmentPacing::Entries.size() == 198);
    for (auto const& entry : DevelopmentPacing::Entries)
    {
        classes.at(entry.ClassId - 12) = true;
        std::vector<ProficiencyCap> caps(std::max<std::size_t>(
            80, entry.ExpectedRanks.back().Requirement.CharacterLevel));
        for (std::size_t index = 0; index < caps.size(); ++index)
            caps[index] = { static_cast<std::uint32_t>(index + 1),
                std::min(static_cast<std::uint32_t>((index + 1) * 5),
                    entry.ExpectedRanks.back().Requirement.Proficiency) };
        AbilityProfile profile{ 2, AcquisitionSource::ClassGrant,
            { entry.ClassId, entry.AbilityId, AbilityKind::Ranked, entry.ExpectedRanks, caps },
            entry.Policy, OutcomeKind::Damage };
        auto revised = DevelopmentRankCaps::Build(profile);
        assert(revised);
        profile.Definition.Caps = revised->Caps;
        profile.DefinitionVersion = 4;
        for (std::uint32_t level = 1; level <= caps.size(); ++level)
        {
            std::uint32_t permitted = entry.ExpectedRanks.back().Requirement.Proficiency;
            for (auto const& rank : entry.ExpectedRanks.subspan(1))
                if (level < rank.Requirement.CharacterLevel)
                {
                    permitted = rank.Requirement.Proficiency;
                    break;
                }
            assert(CapAtLevel(profile.Definition, level) == std::min(level * 5, permitted));
        }
        for (std::size_t rankIndex = 1; rankIndex < entry.ExpectedRanks.size(); ++rankIndex)
        {
            auto const& previous = entry.ExpectedRanks[rankIndex - 1];
            auto const& rank = entry.ExpectedRanks[rankIndex];
            auto const level = previous.Requirement.CharacterLevel;
            auto const cap = CapAtLevel(profile.Definition, level);
            std::vector<std::uint32_t> learned;
            for (auto const& known : entry.ExpectedRanks.first(rankIndex))
                learned.push_back(known.SpellId);
            auto const waiting = DescribeRank(profile.Definition, rankIndex, profile.Policy,
                { rank.Requirement.Proficiency, 0 }, rank.Requirement.CharacterLevel - 1, learned, true);
            assert(waiting.State == RankState::NeedsCharacterLevel);
            for (auto const catchup : { CatchupSettings{}, CatchupSettings{ true, 40, 2 } })
            {
                auto const effective = BuildCatchupPolicy(entry.Policy, cap, catchup);
                assert(effective);
                auto const policy = effective->View();
                auto const proficiency = previous.Requirement.Proficiency;
                auto const cost = policy.Bands[Detail::BandIndex(policy, proficiency)].PointsPerLevel;
                for (std::uint32_t points : { 0U, cost / 2, cost - 1 })
                {
                    Progress const initial{ proficiency, points };
                    auto const target = std::min(rank.Requirement.Proficiency, cap);
                    auto const forecast = UsesUntil(policy, initial, target, cap);
                    Progress observed = initial;
                    std::uint64_t actual = 0;
                    while (observed.Proficiency < target)
                    {
                        auto const award = ApplyQualifyingUse(policy, observed, cap);
                        assert(award.Status == AwardStatus::Applied);
                        observed = award.State;
                        assert(++actual < 100000);
                    }
                    assert(forecast.Uses == actual);
                    ++forecasts;
                    StoredProgress const old{ 1, 1, { proficiency, 15 } };
                    auto const rebased = RebaseStoredProgress(DevelopmentPacing::PreviousPolicy,
                        entry.Policy, 2, old);
                    assert(rebased && rebased->State.Proficiency == proficiency);
                    auto const nextCost = entry.Policy.Bands[
                        Detail::BandIndex(entry.Policy, proficiency)].PointsPerLevel;
                    assert(rebased->State.Points * 30 == std::uint64_t(15) * nextCost);
                    auto const version4 = RebaseStoredProgress(entry.Policy, entry.Policy, 4, *rebased);
                    assert(version4 && version4->State.Points == rebased->State.Points);
                    auto const retainedCost = policy.Bands[Detail::BandIndex(policy, cap + 1)].PointsPerLevel;
                    auto const retainedPoints = std::min(points, retainedCost - 1);
                    auto const capped = ApplyQualifyingUse(policy, { cap + 1, retainedPoints }, cap);
                    assert(capped.Status == AwardStatus::Capped && capped.State.Proficiency == cap + 1);
                    assert(capped.State.Points == retainedPoints);
                }
            }
        }
    }
    assert(std::all_of(classes.begin(), classes.end(), [](bool present) { return present; }));
    std::cout << "PASS: " << DevelopmentPacing::Entries.size()
        << " current rank policies, 21 classes, one-rank-ahead caps, exact rebases and "
        << forecasts << " current forecast/award comparisons\n";
}

std::array<std::span<AbilityProfile const>, 6> FixedCatalogs()
{
    return { DevelopmentFixed::Profiles, DevelopmentConjureFixed::Profiles, DevelopmentPassiveFixed::Profiles,
        DevelopmentUtilityFixed::Profiles, DevelopmentControlFixed::Profiles, DevelopmentTrainerFixed::Profiles };
}

AbilityProfile CurrentMasteryProfile(AbilityProfile profile)
{
    for (auto const& entry : DevelopmentMasteryPacing::Entries)
        if (profile.Definition.ClassId == entry.ClassId && profile.Definition.AbilityId == entry.AbilityId)
        {
            auto const migrated = RebaseStoredProgress(entry.PreviousPolicy, entry.Policy, 2, { 1, 1, { 39, 15 } });
            assert(migrated && migrated->State.Proficiency == 39);
            assert(migrated->State.Points * 30 == std::uint64_t(15) * entry.Policy.Bands.front().PointsPerLevel);
            profile.Policy = entry.Policy;
            profile.DefinitionVersion = 2;
        }
    return profile;
}

std::array<std::span<AbilityProfile const>, 2> MasteryCatalogs()
{
    return { DevelopmentMastery::Profiles, DevelopmentMastery::ScriptedProfiles };
}

void CheckMasteryFixedAndTrainerPolicies()
{
    assert(DevelopmentHelpers::Profiles.size() == 7);
    for (auto const& profile : DevelopmentHelpers::Profiles)
        if (auto const* mechanic = DevelopmentHelpers::TriggeredDamageFor(profile))
        {
            assert(DevelopmentHelpers::IsTriggeredDamageHelper(mechanic->ClassId, mechanic->HelperId));
            assert(!DevelopmentHelpers::IsTriggeredDamageHelper(14, mechanic->HelperId));
            for (auto const& rank : profile.Definition.Ranks)
            {
                assert(DevelopmentHelpers::IsTriggeredDamage(profile, rank.SpellId, mechanic->HelperId));
                assert(!DevelopmentHelpers::IsTriggeredDamage(profile, rank.SpellId, 807554));
            }
            assert(!DevelopmentHelpers::IsTriggeredDamage(profile, mechanic->HelperId, mechanic->HelperId));
        }
    assert(DevelopmentMastery::Profiles.size() == 6);
    auto const& bargain = DevelopmentMastery::ScriptedProfiles.front();
    assert(DevelopmentMastery::IsFelBargain(bargain));
    assert(CapAtLevel(bargain.Definition, 21) == 1);
    assert(CapAtLevel(bargain.Definition, 22) == 40);
    assert(CapAtLevel(bargain.Definition, 29) == 40);
    assert(CapAtLevel(bargain.Definition, 30) == 70);
    assert(CapAtLevel(bargain.Definition, 37) == 70);
    assert(CapAtLevel(bargain.Definition, 38) == 100);
    assert(UsesUntil(bargain.Policy, { 1, 0 }, 40, 40).Uses == 15);
    assert(UsesUntil(bargain.Policy, { 40, 0 }, 70, 70).Uses == 15);
    assert(UsesUntil(bargain.Policy, { 70, 0 }, 100, 100).Uses == 15);
    assert(HealingMasteryBonus(bargain.Definition, bargain.Rewards, { 100, 0 }, 29, true, true) == 0);
    assert(HealingMasteryBonus(bargain.Definition, bargain.Rewards, { 40, 0 }, 30, true, true) == 50);
    assert(HealingMasteryBonus(bargain.Definition, bargain.Rewards, { 70, 0 }, 38, true, true) == 100);
    assert(HealingMasteryBonus(bargain.Definition, bargain.Rewards, { 100, 0 }, 46, true, true) == 200);
    auto const frost = std::find_if(DevelopmentMastery::ScriptedProfiles.begin(),
        DevelopmentMastery::ScriptedProfiles.end(), DevelopmentMastery::IsFrostSigil);
    assert(frost != DevelopmentMastery::ScriptedProfiles.end());
    assert(CapAtLevel(frost->Definition, 33) == 1);
    assert(CapAtLevel(frost->Definition, 34) == 40);
    assert(CapAtLevel(frost->Definition, 41) == 40);
    assert(CapAtLevel(frost->Definition, 42) == 70);
    assert(CapAtLevel(frost->Definition, 49) == 70);
    assert(CapAtLevel(frost->Definition, 50) == 100);
    assert(UsesUntil(frost->Policy, { 1, 0 }, 40, 40).Uses == 270);
    assert(UsesUntil(frost->Policy, { 40, 0 }, 70, 70).Uses == 270);
    assert(UsesUntil(frost->Policy, { 70, 0 }, 100, 100).Uses == 270);
    assert(DamageMasteryBonus(frost->Definition, frost->Rewards, { 40, 0 }, 41, true, true) == 0);
    assert(DamageMasteryBonus(frost->Definition, frost->Rewards, { 40, 0 }, 42, true, true) == 50);
    assert(DamageMasteryBonus(frost->Definition, frost->Rewards, { 70, 0 }, 50, true, true) == 100);
    assert(DamageMasteryBonus(frost->Definition, frost->Rewards, { 100, 0 }, 58, true, true) == 200);
    std::array resourceRewards = {
        MasteryReward{ { 42, 40 }, 0, 0, 50 },
        MasteryReward{ { 50, 70 }, 0, 0, 100 },
        MasteryReward{ { 58, 100 }, 0, 0, 200 }
    };
    auto resourcePrototype = *frost;
    resourcePrototype.Outcome = OutcomeKind::ResourceDrain;
    resourcePrototype.Rewards = resourceRewards;
    assert(ValidateProfiles(std::span(&resourcePrototype, 1)));
    assert(ResourceDrainMasteryBonus(resourcePrototype.Definition, resourceRewards, { 40, 0 }, 41,
        true, true) == 0);
    for (auto const& reward : resourceRewards)
    {
        Progress const progress{ reward.Requirement.Proficiency, 0 };
        auto const level = reward.Requirement.CharacterLevel;
        assert(ResourceDrainMasteryBonus(resourcePrototype.Definition, resourceRewards, progress, level,
            true, true) == reward.ResourceDrainBonusBasisPoints);
        assert(ResourceDrainMasteryBonus(resourcePrototype.Definition, resourceRewards, progress, level,
            false, true) == 0);
        assert(ResourceDrainMasteryBonus(resourcePrototype.Definition, resourceRewards, progress, level,
            true, false) == 0);
        assert(DamageMasteryBonus(resourcePrototype.Definition, resourceRewards, progress, level,
            true, true) == 0);
        assert(HealingMasteryBonus(resourcePrototype.Definition, resourceRewards, progress, level,
            true, true) == 0);
    }
    assert(ApplyResourceDrainMastery(10000, 0) == 10000);
    assert(ApplyResourceDrainMastery(10000, 50) == 10050);
    assert(ApplyResourceDrainMastery(10000, 100) == 10100);
    assert(ApplyResourceDrainMastery(10000, 200) == 10200);
    assert(ApplyResourceDrainMastery(10000, 201) == 10000);
    assert(ApplyResourceDrainMastery(5, 200) == 5);
    assert(ApplyResourceDrainMastery(0, 200) == 0);
    auto const signedMaximum = static_cast<std::uint32_t>(std::numeric_limits<std::int32_t>::max());
    assert(ApplyResourceDrainMastery(signedMaximum, 200) == signedMaximum);
    assert(ApplyResourceDrainMastery(signedMaximum + 1, 200) == signedMaximum + 1);
    CoAAbilityPractice::CastReceipt resourceReceipt{ 1, 1, 32, 500639, 1, 0, 0 };
    assert(CoAAbilityPractice::ModifyMasteryResourceDrain(nullptr, nullptr, 807818, 0, 10000,
        &resourceReceipt) == 10000);
    CoAAbilityPractice::SetResourceDrainMasteryProvider(
        [](Unit*, Unit*, std::uint32_t spellId, std::uint8_t power, std::uint32_t amount,
            CoAAbilityPractice::CastReceipt const* receipt)
        {
            return spellId == 807818 && power == 0 && receipt->SpellId == 500639 ?
                ApplyResourceDrainMastery(amount, 200) : amount;
        });
    assert(CoAAbilityPractice::ModifyMasteryResourceDrain(nullptr, nullptr, 807818, 0, 10000,
        &resourceReceipt) == 10200);
    assert(CoAAbilityPractice::ModifyMasteryResourceDrain(nullptr, nullptr, 807818, 0, 10000,
        nullptr) == 10000);
    assert(CoAAbilityPractice::ModifyMasteryResourceDrain(nullptr, nullptr, 807818, 1, 10000,
        &resourceReceipt) == 10000);
    assert(CoAAbilityPractice::ModifyMasteryDamage(nullptr, nullptr, 807818, 10000,
        &resourceReceipt) == 10000);
    assert(CoAAbilityPractice::ModifyMasteryHealing(nullptr, nullptr, 807818, 10000,
        &resourceReceipt) == 10000);
    CoAAbilityPractice::SetResourceDrainMasteryProvider(nullptr);
    resourcePrototype.Outcome = OutcomeKind::Damage;
    assert(!ValidateProfiles(std::span(&resourcePrototype, 1)));
    resourcePrototype.Outcome = OutcomeKind::ResourceDrain;
    resourceRewards[0].DamageBonusBasisPoints = 50;
    assert(!ValidateProfiles(std::span(&resourcePrototype, 1)));
    resourceRewards[0].DamageBonusBasisPoints = 0;
    resourceRewards[2].ResourceDrainBonusBasisPoints = 201;
    assert(!ValidateProfiles(std::span(&resourcePrototype, 1)));

    for (auto const catalog : MasteryCatalogs())
    {
        for (auto const& authored : catalog)
        {
            auto const profile = CurrentMasteryProfile(authored);
            assert(ValidateProfiles(std::span(&profile, 1)));
            auto const effect = MasteryEffectOf(profile.Rewards.front());
            for (auto const& reward : profile.Rewards)
            {
                auto const level = reward.Requirement.CharacterLevel;
                Progress const progress{ reward.Requirement.Proficiency, 0 };
                auto const bonus = MasteryBonus(profile.Definition, profile.Rewards, progress, level, true, true, effect);
                assert(bonus == MasteryBonusAmount(reward));
                assert(MasteryBonus(profile.Definition, profile.Rewards, progress, level, false, true, effect) == 0);
                assert(MasteryBonus(profile.Definition, profile.Rewards, progress, level, true, false, effect) == 0);
                auto const waiting = DescribeMasteryRewards(profile.Definition, profile.Rewards, profile.Policy,
                    progress, level - 1, true, true);
                auto const index = static_cast<std::size_t>(&reward - profile.Rewards.data());
                assert(waiting[index].State == RankState::NeedsCharacterLevel);
                auto const cap = CapAtLevel(profile.Definition, level);
                auto const forecast = UsesUntil(profile.Policy, { 1, 0 }, progress.Proficiency, cap);
                Progress observed{ 1, 0 };
                std::uint64_t uses = 0;
                while (observed.Proficiency < progress.Proficiency)
                {
                    auto const award = ApplyQualifyingUse(profile.Policy, observed, cap);
                    assert(award.Status == AwardStatus::Applied);
                    observed = award.State;
                    assert(++uses < 100000);
                }
                assert(forecast.Uses == uses);
            }
        }
    }
    std::uint32_t fixedCount = 0;
    for (auto const catalog : FixedCatalogs())
    {
        assert(ValidateProfiles(catalog));
        for (auto const& profile : catalog)
        {
            ++fixedCount;
            auto const& definition = profile.Definition;
            assert(definition.Kind == AbilityKind::Fixed && definition.Caps.empty());
            std::array learned{ definition.Ranks.front().SpellId };
            auto const view = BuildAbilityView(definition, profile.Policy, { 99, 1000 },
                definition.Ranks.front().Requirement.CharacterLevel, learned, true);
            assert(view.Availability == PracticeAvailability::Fixed && view.LearnedRank == 1);
            assert(view.State.Proficiency == 1 && view.State.Points == 0 && view.PointsPerLevel == 0);
            assert(!view.NextTrainingCap && view.Rewards.empty());
        }
    }
    assert(fixedCount == 118);
    for (auto const& profile : DevelopmentUtilityFixed::Profiles)
        for (auto const& rank : profile.Definition.Ranks)
        {
            auto const mechanic = std::find_if(DevelopmentUtilityFixed::Mechanics.begin(),
                DevelopmentUtilityFixed::Mechanics.end(), [&profile, &rank](auto const& entry)
                {
                    return entry.ClassId == profile.Definition.ClassId && entry.SpellId == rank.SpellId;
                });
            assert(mechanic != DevelopmentUtilityFixed::Mechanics.end());
            std::vector<std::uint32_t> learned;
            for (auto const& preceding : profile.Definition.Ranks)
                if (preceding.RankNumber < rank.RankNumber)
                    learned.push_back(preceding.SpellId);
            auto const before = DescribeRank(profile.Definition, rank.RankNumber - 1, profile.Policy,
                { 1, 0 }, rank.Requirement.CharacterLevel - 1, learned, true);
            auto const eligible = DescribeRank(profile.Definition, rank.RankNumber - 1, profile.Policy,
                { 1, 0 }, rank.Requirement.CharacterLevel, learned, true);
            if (rank.RankNumber > 1)
            {
                assert(before.State == RankState::NeedsCharacterLevel);
                assert(eligible.State == RankState::Ready);
            }
        }
    std::array<std::span<DevelopmentTrainerRanks::Entry const>, 4> const trainers = {
        DevelopmentTrainerRanks::Entries, DevelopmentBuffTrainerRanks::Entries,
        DevelopmentStatBuffTrainerRanks::Entries, DevelopmentSpellPowerBuffTrainerRanks::Entries };
    std::uint32_t extensions = 0;
    std::uint32_t addedRanks = 0;
    for (auto const catalog : trainers)
        for (auto const& entry : catalog)
        {
            ++extensions;
            auto const& profile = entry.Profile;
            assert(ValidateProfiles(std::span(&profile, 1)));
            assert(profile.Definition.Ranks.size() == entry.PreviousRanks.size() + entry.AdditionalTrainerRanks.size());
            for (std::size_t index = 0; index < entry.PreviousRanks.size(); ++index)
            {
                auto const& prior = entry.PreviousRanks[index];
                auto const& current = profile.Definition.Ranks[index];
                assert(prior.SpellId == current.SpellId && prior.RankNumber == current.RankNumber);
                assert(prior.Requirement.CharacterLevel == current.Requirement.CharacterLevel);
                assert(prior.Requirement.Proficiency == current.Requirement.Proficiency);
            }
            std::vector<std::optional<NativeRankLink>> links(profile.Definition.Ranks.size());
            for (std::size_t index = 0; index < entry.PreviousRanks.size(); ++index)
                links[index] = NativeRankLink{ entry.PreviousRanks.front().SpellId,
                    entry.PreviousRanks.back().SpellId, index ? entry.PreviousRanks[index - 1].SpellId : 0,
                    index + 1 < entry.PreviousRanks.size() ? entry.PreviousRanks[index + 1].SpellId : 0,
                    entry.PreviousRanks[index].RankNumber };
            assert(!MatchesNativeRankChain(profile.Definition.Ranks, links));
            assert(MatchesNativeRankChain(profile.Definition.Ranks, links, entry.PreviousRanks.size()));
            auto broken = links;
            broken.front()->Last = 1;
            assert(!MatchesNativeRankChain(profile.Definition.Ranks, broken, entry.PreviousRanks.size()));
            broken = links;
            broken.front() = std::nullopt;
            assert(!MatchesNativeRankChain(profile.Definition.Ranks, broken, entry.PreviousRanks.size()));
            broken = links;
            broken.back() = NativeRankLink{ 1, 2, 3, 4, 5 };
            assert(!MatchesNativeRankChain(profile.Definition.Ranks, broken, entry.PreviousRanks.size()));
            auto revised = DevelopmentRankCaps::Build(profile);
            assert(revised);
            auto definition = profile.Definition;
            definition.Caps = revised->Caps;
            for (std::size_t index = 0; index < entry.AdditionalTrainerRanks.size(); ++index)
            {
                ++addedRanks;
                auto const& trainer = entry.AdditionalTrainerRanks[index];
                auto const& rank = definition.Ranks[entry.PreviousRanks.size() + index];
                auto const& previous = definition.Ranks[entry.PreviousRanks.size() + index - 1];
                assert(rank.SpellId == trainer.SpellId && rank.Requirement.CharacterLevel == trainer.CharacterLevel);
                assert(trainer.TrainerId && trainer.RequiredAbilities[0]);
                auto const preceding = definition.Ranks.first(entry.PreviousRanks.size() + index);
                assert(std::any_of(preceding.begin(), preceding.end(), [&trainer](AbilityRank const& known)
                {
                    return known.SpellId == trainer.RequiredAbilities[0];
                }));
                assert(CapAtLevel(definition, previous.Requirement.CharacterLevel) <= rank.Requirement.Proficiency);
            }
            auto const converted = RebaseStoredProgress(profile.Policy, profile.Policy, 4,
                { 3, 1, { entry.PreviousRanks.back().Requirement.Proficiency, 0 } });
            assert(converted && converted->State.Proficiency == entry.PreviousRanks.back().Requirement.Proficiency);
        }
    assert(DevelopmentBuffVariants::Variants.size() == 34);
    constexpr std::array expectedProficiencies = {
        std::pair{ 572390u, 80u },
        std::pair{ 575045u, 40u }, std::pair{ 681160u, 100u },
        std::pair{ 572396u, 60u }, std::pair{ 680307u, 40u },
        std::pair{ 582536u, 20u }, std::pair{ 680280u, 80u },
        std::pair{ 575846u, 20u }, std::pair{ 578316u, 60u }, std::pair{ 680291u, 80u },
        std::pair{ 680294u, 100u }, std::pair{ 680315u, 100u }, std::pair{ 680310u, 100u },
        std::pair{ 712458u, 80u }, std::pair{ 523495u, 80u }, std::pair{ 680303u, 80u },
        std::pair{ 803665u, 80u }, std::pair{ 572817u, 80u }, std::pair{ 680298u, 80u },
        std::pair{ 561241u, 40u }, std::pair{ 680872u, 40u }, std::pair{ 523510u, 40u },
        std::pair{ 681442u, 40u }, std::pair{ 570756u, 40u }, std::pair{ 578130u, 40u },
        std::pair{ 523513u, 60u }, std::pair{ 803657u, 60u }, std::pair{ 680301u, 60u },
        std::pair{ 575842u, 20u }, std::pair{ 573348u, 20u }, std::pair{ 561242u, 1u },
        std::pair{ 561243u, 1u }, std::pair{ 800195u, 1u }, std::pair{ 582261u, 10u }
    };
    assert(expectedProficiencies.size() == DevelopmentBuffVariants::Variants.size());
    for (auto const& variant : DevelopmentBuffVariants::Variants)
    {
        AbilityProfile const* parent = nullptr;
        for (auto const& profile : DevelopmentBuffs::Profiles)
            if (profile.Definition.AbilityId == variant.AbilityId)
                parent = &profile;
        for (auto const& profile : DevelopmentUtilityFixed::Profiles)
            if (profile.Definition.AbilityId == variant.AbilityId)
                parent = &profile;
        assert(parent && DevelopmentBuffVariants::Find(variant.ClassId, variant.SpellId) == &variant);
        assert(!DevelopmentBuffVariants::Find(variant.ClassId == 13 ? 14 : 13, variant.SpellId));
        assert(!DevelopmentBuffVariants::Find(variant.ClassId, variant.AbilityId));
        auto const* rank = DevelopmentBuffVariants::EquivalentRank(*parent, variant);
        assert(rank && rank->SpellId == variant.EquivalentSpellId);
        auto const expected = std::find_if(expectedProficiencies.begin(), expectedProficiencies.end(),
            [&variant](auto const& entry) { return entry.first == variant.SpellId; });
        assert(expected != expectedProficiencies.end() && rank->Requirement.Proficiency == expected->second);
        auto invalid = variant;
        invalid.EquivalentSpellId = 1;
        assert(!DevelopmentBuffVariants::EquivalentRank(*parent, invalid));
        invalid = variant;
        invalid.CharacterLevel = 1;
        assert(!DevelopmentBuffVariants::EquivalentRank(*parent, invalid));
    }
    assert(extensions == 18 && addedRanks == 30);
    std::size_t fixedDeclarations = 0;
    for (auto const catalog : FixedCatalogs())
        fixedDeclarations += catalog.size();
    std::cout << "PASS: 11 mastery policies/rewards, " << fixedDeclarations << " fixed declarations, " << extensions
        << " trainer extensions/" << addedRanks << " added ranks\n";
}

void WriteSharedCases(std::string const& filename)
{
    std::ofstream output(filename);
    for (auto const& variant : DevelopmentBuffVariants::Variants)
    {
        AbilityProfile const* parent = nullptr;
        for (auto const& profile : DevelopmentBuffs::Profiles)
            if (profile.Definition.AbilityId == variant.AbilityId)
                parent = &profile;
        for (auto const& profile : DevelopmentUtilityFixed::Profiles)
            if (profile.Definition.AbilityId == variant.AbilityId)
                parent = &profile;
        assert(parent);
        auto const* equivalent = DevelopmentBuffVariants::EquivalentRank(*parent, variant);
        assert(equivalent);
        for (std::uint32_t phase = 0; phase < 3; ++phase)
        {
            std::array known{ parent->Definition.Ranks.front().SpellId };
            Progress const progress{ phase == 0 ? 1U : equivalent->Requirement.Proficiency, 0 };
            auto view = BuildAbilityView(parent->Definition, parent->Policy, progress,
                variant.CharacterLevel, known, true);
            bool const fixed = parent->Definition.Kind == AbilityKind::Fixed;
            view.Route = fixed ? PracticeRoute::Fixed : PracticeRoute::BuffCombat;
            view.RuleSet = 1;
            view.AcquisitionSourceId = 1;
            if (!fixed)
                view.BuffState = BuffPracticeState::Ready;
            auto shared = view.Ranks[equivalent->RankNumber - 1];
            shared.SpellId = variant.SpellId;
            shared.Requirement.CharacterLevel = variant.CharacterLevel;
            shared.State = phase == 2 ? RankState::Learned : fixed ? RankState::AcquireIntroductoryAbility :
                phase == 0 ? RankState::NeedsPractice : RankState::Ready;
            view.SharedAbilities.push_back({ shared, variant.EquivalentSpellId });
            std::array views{ view };
            auto const encoded = EncodeMenuSnapshot(variant.ClassId, variant.CharacterLevel, phase + 1, views,
                SessionPractice{}, true, true, 779, 80, std::nullopt, std::nullopt, true);
            assert(encoded);
            for (auto const& line : *encoded)
                output << line << '\n';
            output << '\n';
            views[0].SharedAbilities[0].EquivalentSpellId = 999999;
            assert(!EncodeMenuSnapshot(variant.ClassId, variant.CharacterLevel, phase + 1, views,
                SessionPractice{}, true, true, 779, 80, std::nullopt, std::nullopt, true));
        }
    }
    assert(output.good());
}

void WriteTypedMasteryAndFixedCases(std::ofstream& output, std::uint32_t& revision)
{
    auto write = [&output, &revision](AbilityProfile const& profile, std::uint32_t level, bool learned,
        Progress state, bool catchup = false)
    {
        std::vector<std::uint32_t> known;
        if (learned)
            known.push_back(profile.Definition.Ranks.front().SpellId);
        auto const effective = BuildCatchupPolicy(profile.Policy, CapAtLevel(profile.Definition, level),
            { catchup, 40, 2 });
        assert(effective);
        auto view = BuildAbilityView(profile.Definition, effective->View(), state, level, known, true);
        view.Route = profile.Definition.Kind == AbilityKind::Fixed ? PracticeRoute::Fixed :
            profile.Outcome == OutcomeKind::Healing ? PracticeRoute::Healing : PracticeRoute::Damage;
        view.RuleSet = DevelopmentMastery::IsSoulCapture(profile) ?
            (catchup ? HumanPvECorpseRecoveryCatchupRuleSet : HumanPvECorpseRecoveryRuleSet) :
            (DevelopmentMastery::IsBaneOfBetrayal(profile) || DevelopmentMastery::IsFrostSigil(profile)) ?
            (catchup ? HumanPvEScriptedDamageCatchupRuleSet : HumanPvEScriptedDamageRuleSet) : 1;
        if (catchup)
        {
            auto const base = profile.Policy.Bands[Detail::BandIndex(profile.Policy, state.Proficiency)];
            auto const rate = effective->View().Bands[Detail::BandIndex(effective->View(), state.Proficiency)];
            view.Catchup = CatchupView{ 40, 2, base.PointsPerUse, rate.PointsPerUse,
                state.Proficiency < view.Cap && view.Cap - state.Proficiency >= 40 };
        }
        view.AcquisitionSourceId = static_cast<std::uint32_t>(profile.Acquisition);
        if (profile.Definition.Kind == AbilityKind::Mastery)
            view.Rewards = DescribeMasteryRewards(profile.Definition, profile.Rewards, effective->View(),
                state, level, learned, true);
        std::array views{ view };
        auto const encoded = EncodeMenuSnapshot(profile.Definition.ClassId, level, ++revision, views,
            SessionPractice{}, true, true, 777, 80);
        assert(encoded);
        for (auto const& line : *encoded)
            output << line << '\n';
        output << '\n';
    };
    for (auto const catalog : MasteryCatalogs())
    {
        for (auto const& authored : catalog)
        {
            auto const profile = CurrentMasteryProfile(authored);
            if (profile.Outcome == OutcomeKind::ResourceDrain)
                continue;
            write(profile, profile.Definition.Ranks.front().Requirement.CharacterLevel, true, { 1, 0 });
            if (DevelopmentMastery::IsFelBargain(profile))
                write(profile, profile.Definition.Ranks.front().Requirement.CharacterLevel, false, { 1, 0 });
            for (auto const& reward : profile.Rewards)
                write(profile, reward.Requirement.CharacterLevel, true, { reward.Requirement.Proficiency, 0 });
            if (DevelopmentMastery::IsBaneOfBetrayal(profile) || DevelopmentMastery::IsSoulCapture(profile) ||
                DevelopmentMastery::IsFrostSigil(profile))
            {
                write(profile, profile.Definition.Ranks.front().Requirement.CharacterLevel, true, { 1, 0 }, true);
                for (auto const& reward : profile.Rewards)
                    write(profile, reward.Requirement.CharacterLevel, true, { reward.Requirement.Proficiency, 0 }, true);
            }
        }
    }
    for (auto const catalog : FixedCatalogs())
        for (auto const& profile : catalog)
        {
            auto const level = profile.Definition.Ranks.front().Requirement.CharacterLevel;
            write(profile, std::max(1U, level - 1), false, { 1, 0 });
            write(profile, level, false, { 1, 0 });
            write(profile, level, true, { 1, 0 });
        }
}

void WriteResourceCases(std::string const& filename)
{
    std::ofstream output(filename);
    auto const water = std::find_if(DevelopmentMastery::ScriptedProfiles.begin(),
        DevelopmentMastery::ScriptedProfiles.end(), DevelopmentMastery::IsWaterSigil);
    assert(water != DevelopmentMastery::ScriptedProfiles.end());
    assert(ValidateProfiles(std::span(&*water, 1)));
    auto const& definition = water->Definition;
    auto const rewards = water->Rewards;
    auto const policy = water->Policy;
    assert(CapAtLevel(definition, 31) == 1);
    assert(CapAtLevel(definition, 32) == 40);
    assert(CapAtLevel(definition, 39) == 40);
    assert(CapAtLevel(definition, 40) == 70);
    assert(CapAtLevel(definition, 47) == 70);
    assert(CapAtLevel(definition, 48) == 100);
    assert(UsesUntil(policy, { 1, 0 }, 40, 40).Uses == 270);
    assert(UsesUntil(policy, { 40, 0 }, 70, 70).Uses == 270);
    assert(UsesUntil(policy, { 70, 0 }, 100, 100).Uses == 270);
    std::uint32_t revision = 2000;
    auto write = [&](std::uint32_t level, bool learned, Progress progress, bool catchup)
    {
        std::vector<std::uint32_t> known;
        if (learned)
            known.push_back(500639);
        auto const effective = BuildCatchupPolicy(policy, CapAtLevel(definition, level), { catchup, 40, 2 });
        assert(effective);
        auto view = BuildAbilityView(definition, effective->View(), progress, level, known, true);
        view.Route = PracticeRoute::ResourceDrain;
        view.RuleSet = catchup ? HumanPvEResourceDrainCatchupRuleSet : HumanPvEResourceDrainRuleSet;
        view.AcquisitionSourceId = 1;
        view.Rewards = DescribeMasteryRewards(definition, rewards, effective->View(), progress, level, learned, true);
        if (catchup)
        {
            auto const base = policy.Bands[Detail::BandIndex(policy, progress.Proficiency)];
            auto const rate = effective->View().Bands[Detail::BandIndex(effective->View(), progress.Proficiency)];
            view.Catchup = CatchupView{ 40, 2, base.PointsPerUse, rate.PointsPerUse,
                view.Cap > progress.Proficiency && view.Cap - progress.Proficiency >= 40 };
        }
        SessionMastery history;
        for (std::size_t index = 0; index < view.Rewards.size(); ++index)
            if (view.Rewards[index].State == RankState::Learned)
                history.Record(definition.AbilityId, static_cast<std::uint32_t>(index + 1), rewards[index]);
        std::array views{ view };
        assert(!EncodeMenuSnapshot(32, level, revision, views, SessionPractice{}, true, true, 780, 80,
            std::nullopt, history.View(), true));
        auto encoded = EncodeMenuSnapshot(32, level, ++revision, views, SessionPractice{}, true, true, 780, 80,
            std::nullopt, history.View(), true, true);
        assert(encoded);
        for (auto const& line : *encoded)
            output << line << '\n';
        output << '\n';
        views[0].Rewards[0].Reward.DamageBonusBasisPoints = 1;
        assert(!EncodeMenuSnapshot(32, level, revision, views, SessionPractice{}, true, true, 780, 80,
            std::nullopt, history.View(), true, true));
    };
    write(31, false, { 1, 0 }, false);
    write(32, true, { 1, 0 }, false);
    write(32, true, { 40, 0 }, false);
    write(40, true, { 40, 0 }, false);
    write(48, true, { 70, 0 }, false);
    write(56, true, { 100, 0 }, false);
    write(56, true, { 1, 0 }, true);
    write(56, true, { 40, 0 }, true);
    assert(output.good());
}

void WriteTypedRankCases(std::string const& filename)
{
    std::ofstream output(filename);
    std::uint32_t revision = 100;
    for (auto const& entry : DevelopmentPacing::Entries)
    {
        if (entry.ClassId == 31 && entry.AbilityId == 704101)
            continue;
        std::vector<ProficiencyCap> caps(std::max<std::size_t>(
            80, entry.ExpectedRanks.back().Requirement.CharacterLevel));
        for (std::size_t index = 0; index < caps.size(); ++index)
            caps[index] = { static_cast<std::uint32_t>(index + 1),
                std::min(static_cast<std::uint32_t>((index + 1) * 5),
                    entry.ExpectedRanks.back().Requirement.Proficiency) };
        AbilityProfile profile{ 2, AcquisitionSource::ClassGrant,
            { entry.ClassId, entry.AbilityId, AbilityKind::Ranked, entry.ExpectedRanks, caps },
            entry.Policy, OutcomeKind::Damage };
        auto revised = DevelopmentRankCaps::Build(profile);
        assert(revised);
        profile.Definition.Caps = revised->Caps;
        std::array learned{ entry.ExpectedRanks.front().SpellId };
        auto const level = entry.ExpectedRanks.front().Requirement.CharacterLevel;
        auto const cap = CapAtLevel(profile.Definition, level);
        auto const effective = BuildCatchupPolicy(entry.Policy, cap, { true, 40, 2 });
        assert(effective);
        auto const policy = effective->View();
        for (std::uint32_t phase = 0; phase < 3; ++phase)
        {
            Progress state{ phase == 0 ? 1U : phase == 1 ? cap : cap + 1, 0 };
            auto view = BuildAbilityView(profile.Definition, policy, state, level, learned, true);
            bool const buff = DevelopmentBuffs::IsSupportedStatBuff(profile);
            view.Route = buff ? PracticeRoute::BuffCombat : PracticeRoute::Damage;
            view.RuleSet = 4;
            view.AcquisitionSourceId = 1;
            if (buff)
                view.BuffState = phase == 0 ? BuffPracticeState::Inactive :
                    phase == 1 ? BuffPracticeState::Ready : BuffPracticeState::Suppressed;
            auto const base = entry.Policy.Bands[Detail::BandIndex(entry.Policy, state.Proficiency)];
            auto const rate = policy.Bands[Detail::BandIndex(policy, state.Proficiency)];
            view.Catchup = CatchupView{ 40, 2, base.PointsPerUse, rate.PointsPerUse,
                state.Proficiency < cap && cap - state.Proficiency >= 40 };
            std::array views{ view };
            auto const encoded = EncodeMenuSnapshot(entry.ClassId, level, ++revision, views,
                SessionPractice{}, true, true, 777, 80);
            assert(encoded);
            for (auto const& line : *encoded)
                output << line << '\n';
            output << '\n';
        }
    }
    WriteTypedMasteryAndFixedCases(output, revision);
    assert(output.good());
}

void WriteDebuffCases(std::string const& path)
{
    std::ofstream output(path);
    auto profile = DevelopmentControl::Profiles.front();
    auto const entry = std::find_if(DevelopmentPacing::Entries.begin(), DevelopmentPacing::Entries.end(),
        [](auto const& value) { return value.ClassId == 31 && value.AbilityId == 704101; });
    assert(entry != DevelopmentPacing::Entries.end() && DevelopmentControl::IsUrsocBellow(profile));
    profile.Policy = entry->Policy;
    profile.DefinitionVersion = DevelopmentPacing::DefinitionVersion;
    auto revised = DevelopmentRankCaps::Build(profile);
    assert(revised);
    profile.Definition.Caps = revised->Caps;
    auto const& definition = profile.Definition;
    auto const policy = profile.Policy;
    std::uint32_t revision = 3000;
    auto write = [&](std::uint32_t level, std::vector<std::uint32_t> const& known, Progress progress)
    {
        auto view = BuildAbilityView(definition, policy, progress, level, known, true);
        view.Route = PracticeRoute::AttackPowerReduction;
        view.RuleSet = 1;
        view.AcquisitionSourceId = 1;
        std::array views{ view };
        assert(!EncodeMenuSnapshot(31, level, revision, views, SessionPractice{}, true, true, 781, 80,
            std::nullopt, std::nullopt, true, true));
        assert(!EncodeMenuSnapshot(31, level, revision, views, SessionPractice{}, true, true, 781, 80,
            std::nullopt, std::nullopt, true, false, true));
        auto const encoded = EncodeMenuSnapshot(31, level, ++revision, views, SessionPractice{}, true, true, 781,
            80, std::nullopt, std::nullopt, true, true, true);
        assert(encoded && encoded->front().starts_with("B|7|"));
        for (auto const& line : *encoded)
            output << line << '\n';
        output << '\n';
        views[0].RuleSet = HumanPvEResourceDrainRuleSet;
        assert(!EncodeMenuSnapshot(31, level, revision, views, SessionPractice{}, true, true, 781, 80,
            std::nullopt, std::nullopt, true, true, true));
    };
    write(19, {}, { 1, 0 });
    write(20, { 704101 }, { 1, 0 });
    write(26, { 704101 }, { 9, policy.Bands.front().PointsPerLevel - policy.Bands.front().PointsPerUse });
    write(26, { 704101 }, { 10, 0 });
    write(48, { 704101, 707732, 707733, 707734, 707735 }, { 60, 0 });
    assert(output.good());
}

class Unit { };

void CheckAttackPowerReductionReceipts()
{
    using CoAAbilityPractice::CastReceipt;
    Unit caster;
    Unit target;
    auto receipt = std::make_shared<CastReceipt>(1, 2, 31, 704101, 1, 0, 0);
    auto const previous = CoAAbilityPractice::AttackPowerReductionHandler.load();
    static std::uint32_t observations = 0;
    observations = 0;
    CoAAbilityPractice::SetAttackPowerReductionProvider([](Unit* source, Unit* victim, std::uint32_t spellId,
        float reduction, std::shared_ptr<CastReceipt> const& original)
    {
        assert(source && victim && spellId == 704101 && reduction == 32.0f);
        assert(original && original->SpellId == spellId && !original->IsConsumed());
        ++observations;
        original->MarkConsumed();
    });
    for (auto const& values : std::array{ std::pair{ 0.0f, 0.0f }, std::pair{ 642.0f, 642.0f },
        std::pair{ 610.0f, 642.0f }, std::pair{ 642.0f, -1.0f },
        std::pair{ std::numeric_limits<float>::infinity(), 610.0f },
        std::pair{ 642.0f, std::numeric_limits<float>::quiet_NaN() } })
        CoAAbilityPractice::ReportAttackPowerReduction(&caster, &target, 704101,
            values.first, values.second, receipt);
    CoAAbilityPractice::ReportAttackPowerReduction(nullptr, &target, 704101, 642.0f, 610.0f, receipt);
    CoAAbilityPractice::ReportAttackPowerReduction(&caster, nullptr, 704101, 642.0f, 610.0f, receipt);
    CoAAbilityPractice::ReportAttackPowerReduction(&caster, &target, 0, 642.0f, 610.0f, receipt);
    CoAAbilityPractice::ReportAttackPowerReduction(&caster, &target, 704101, 642.0f, 610.0f, {});
    assert(observations == 0 && !receipt->IsConsumed());
    CoAAbilityPractice::ReportAttackPowerReduction(&caster, &target, 704101, 642.0f, 610.0f, receipt);
    assert(observations == 1 && receipt->IsConsumed());
    CoAAbilityPractice::ReportAttackPowerReduction(&caster, &target, 704101, 642.0f, 610.0f, receipt);
    assert(observations == 1);
    CoAAbilityPractice::SetAttackPowerReductionProvider(nullptr);
    auto unobserved = std::make_shared<CastReceipt>(1, 2, 31, 704101, 1, 0, 0);
    CoAAbilityPractice::ReportAttackPowerReduction(&caster, &target, 704101, 642.0f, 610.0f, unobserved);
    assert(observations == 1 && !unobserved->IsConsumed());
    CoAAbilityPractice::SetAttackPowerReductionProvider(previous);
}

void CheckBuffReceipts()
{
    assert(DevelopmentBuffs::ArcaneDurationContributes(-20, -20, 0));
    assert(!DevelopmentBuffs::ArcaneDurationContributes(-20, -20, -30));
    assert(DevelopmentBuffs::ArcaneDurationContributes(-20, -40, -30));
    assert(!DevelopmentBuffs::ArcaneDurationContributes(-20, 0, 0));
    assert(!DevelopmentBuffs::ArcaneDurationContributes(-20, -120, 0));
    assert(DevelopmentBuffs::ArcaneDurationContributes(-20, -100, 0));
    assert(!DevelopmentBuffs::ArcaneDurationContributes(-10, -10, 0));
    assert(!DevelopmentBuffs::ArcaneDurationContributes(20, 20, 0));
    using CoAAbilityPractice::CastReceipt;
    BuffCastLedger ledger;
    auto origin = std::make_shared<CastReceipt>(1, 2, 22, 801523, 1, 0, 0);
    auto replacement = std::make_shared<CastReceipt>(1, 2, 22, 801523, 1, 0, 0);
    auto action = std::make_shared<CastReceipt>(1, 2, 22, 804418, 1, 0, 0);
    assert(!ledger.Capture({}, { { 1, origin } }));
    assert(!ledger.Capture(action, {}));
    assert(ledger.Capture(action, { { 1, origin } }));
    assert(!ledger.Capture(action, { { 2, origin } }));
    assert(action.use_count() == 1 && origin.use_count() == 1);
    auto* cast = ledger.Find(action);
    assert(cast && cast->MatchesOrigin(1, origin));
    assert(!cast->MatchesOrigin(1, replacement) && !cast->MatchesOrigin(2, origin));
    assert(!cast->MatchesOrigin(1, {}));
    cast->AwardedBits |= 1;
    action->MarkConsumed();
    assert(ledger.Find(action) == cast && cast->AwardedBits == 1);
    assert(cast->ObservePeriodic() && !cast->ObservePeriodic());
    assert(action->IsConsumed());
    origin.reset();
    assert(!cast->MatchesOrigin(1, replacement));
    ledger.Clear();
    assert(!ledger.Find(action));
    std::vector<std::shared_ptr<CastReceipt>> active;
    for (std::size_t index = 0; index < BuffCastLedger::MaximumCasts; ++index)
    {
        active.push_back(std::make_shared<CastReceipt>(1, 2, 22, 804418, 1, 0, 0));
        assert(ledger.Capture(active.back(), { { 1, replacement } }));
    }
    assert(!ledger.Capture(action, { { 1, replacement } }));
    active.front().reset();
    assert(ledger.Capture(action, { { 1, replacement } }));
    assert(ledger.Find(action) && ledger.Find(action)->ObservePeriodic());
    active.clear();
    ledger.Clear();
    assert(!ledger.Find(action) && !ledger.Find({}));

    static std::uint32_t observations = 0;
    observations = 0;
    auto const previous = CoAAbilityPractice::PeriodicOutcomeHandler.load();
    CoAAbilityPractice::SetPeriodicOutcomeProvider([](Unit*, Unit*, std::uint32_t, std::uint32_t,
        std::uint32_t, std::uint32_t, std::shared_ptr<CastReceipt> const& receipt)
    {
        assert(receipt && receipt->IsConsumed());
        ++observations;
    });
    Unit caster;
    Unit target;
    CoAAbilityPractice::ReportPeriodicOutcome(&caster, &target, 804418, 3, 1, 0, action);
    assert(observations == 1 && action->IsConsumed());
    CoAAbilityPractice::ReportPeriodicOutcome(&caster, &target, 804418, 3, 1, 0, action);
    assert(observations == 2);
    CoAAbilityPractice::ReportAuraOutcome(&caster, &target, 804418, 3, 1, 0, action);
    CoAAbilityPractice::ReportPeriodicOutcome(nullptr, &target, 804418, 3, 1, 0, action);
    CoAAbilityPractice::ReportPeriodicOutcome(&caster, nullptr, 804418, 3, 1, 0, action);
    CoAAbilityPractice::ReportPeriodicOutcome(&caster, &target, 804418, 3, 0, 0, action);
    CoAAbilityPractice::ReportPeriodicOutcome(&caster, &target, 804418, 3, 1, 0, {});
    assert(observations == 2);
    CoAAbilityPractice::SetPeriodicOutcomeProvider(previous);
}

void CheckScriptedDamageReceipts()
{
    using CoAAbilityPractice::CastReceipt;
    using Scope = CoAAbilityPractice::ScopedScriptedDamageCast;
    for (std::size_t index = 0; index < DevelopmentHelpers::TwinSlice.size(); ++index)
    {
        auto const originId = DevelopmentHelpers::TwinSlice[index].SpellId;
        auto const& pair = DevelopmentHelpers::TwinDamageHelpers[index];
        assert(DevelopmentHelpers::IsTwinDamage(originId, pair[0]));
        assert(DevelopmentHelpers::IsTwinDamage(originId, pair[1]));
        assert(!DevelopmentHelpers::IsTwinDamage(originId, 800058));
        assert(!DevelopmentHelpers::IsTwinDamage(originId, 807554));
        assert(!DevelopmentHelpers::IsTwinDamage(712483, pair[0]));
        auto twin = std::make_shared<CastReceipt>(1, 2, 14, originId, 1, 0, 0);
        std::shared_ptr<CastReceipt> main;
        std::shared_ptr<CastReceipt> off;
        {
            Scope scope(twin, 3, pair[0]);
            assert(!Scope::Take(1, 3, pair[1]));
            main = Scope::Take(1, 3, pair[0]);
        }
        {
            Scope scope(twin, 3, pair[1]);
            off = Scope::Take(1, 3, pair[1]);
        }
        assert(main == twin && off == twin);
        main->MarkConsumed();
        assert(off->IsConsumed());
        Scope consumed(twin, 3, pair[1]);
        assert(!Scope::Take(1, 3, pair[1]));
    }
    for (auto const& rank : DevelopmentHelpers::FireSigil)
    {
        assert(DevelopmentHelpers::IsFireSigilDamage(rank.SpellId, 807012));
        assert(!DevelopmentHelpers::IsFireSigilDamage(rank.SpellId, 807825));
    }
    assert(!DevelopmentHelpers::IsFireSigilDamage(802202, 807012));
    assert(DevelopmentHelpers::FirePracticeIntervalSeconds == 10);
    assert(DevelopmentPeriodic::Earthquake.size() == 6);
    assert(DevelopmentPeriodic::EarthquakePracticeIntervalSeconds == 10);
    assert(DevelopmentHelpers::GeodeBarrage.size() == 10);
    assert(DevelopmentHelpers::GeodePracticeIntervalSeconds == 5);
    for (auto const& rank : DevelopmentHelpers::GeodeBarrage)
    {
        assert(DevelopmentHelpers::IsGeodeDamage(rank.SpellId, 803138));
        assert(!DevelopmentHelpers::IsGeodeDamage(rank.SpellId, 802885));
        assert(!DevelopmentHelpers::IsGeodeDamage(rank.SpellId, 804002));
    }
    assert(!DevelopmentHelpers::IsGeodeDamage(803138, 803138));
    for (auto const& rank : DevelopmentHelpers::ArcaneSigil)
    {
        assert(DevelopmentHelpers::IsArcaneSigilDamage(rank.SpellId, 807819));
        assert(!DevelopmentHelpers::IsArcaneSigilDamage(rank.SpellId, 807012));
        assert(!DevelopmentHelpers::IsArcaneSigilDamage(rank.SpellId, 808020));
    }
    assert(!DevelopmentHelpers::IsArcaneSigilDamage(805381, 807819));
    assert(DevelopmentHelpers::ArcanePracticeIntervalSeconds == 10);
    auto const& arcane = DevelopmentHelpers::ArcaneProfiles.front();
    assert(DevelopmentHelpers::IsArcaneSigil(arcane));
    auto pacedArcane = arcane;
    pacedArcane.DefinitionVersion = DevelopmentPacing::DefinitionVersion;
    pacedArcane.Policy = { DevelopmentPacing::BandsClass32Ability805380 };
    auto const arcaneCaps = DevelopmentRankCaps::Build(pacedArcane);
    assert(arcaneCaps);
    auto arcaneDefinition = arcane.Definition;
    arcaneDefinition.Caps = arcaneCaps->Caps;
    assert(CapAtLevel(arcaneDefinition, 20) == 10);
    assert(CapAtLevel(arcaneDefinition, 33) == 10);
    assert(CapAtLevel(arcaneDefinition, 34) == 20);
    assert(CapAtLevel(arcaneDefinition, 50) == 20);
    TrainingPolicy const arcanePolicy{ DevelopmentPacing::BandsClass32Ability805380 };
    assert(UsesUntil(arcanePolicy, { 1, 0 }, 10, 10).Uses == 270);
    assert(UsesUntil(arcanePolicy, { 10, 0 }, 20, 20).Uses == 270);
    auto original = std::make_shared<CastReceipt>(1, 2, 14, 712483, 1, 0, 0);
    assert(!original->BindCapturedCorpse(0, true));
    assert(original->BindCapturedCorpse(4, true));
    assert(original->GetCapturedCorpseGUID() == 4 && original->HasCapturedResourceGain());
    assert(!original->BindCapturedCorpse(5, false));
    assert(original->GetCapturedCorpseGUID() == 4 && original->HasCapturedResourceGain());
    assert(!Scope::Take(1, 3, 807554));
    {
        Scope outer(original, 3, 807554);
        assert(!Scope::Take(9, 3, 807554));
        assert(!Scope::Take(1, 9, 807554));
        assert(!Scope::Take(1, 3, 9));
        std::thread other([] { assert(!Scope::Take(1, 3, 807554)); });
        other.join();
        {
            Scope inner({}, 3, 807554);
            assert(!Scope::Take(1, 3, 807554));
        }
        auto bound = Scope::Take(1, 3, 807554);
        assert(bound == original);
        assert(!Scope::Take(1, 3, 807554));
        auto secondTarget = bound;
        bound->MarkConsumed();
        assert(secondTarget->IsConsumed());
    }
    assert(!Scope::Take(1, 3, 807554));
    assert(!original->BindCapturedCorpse(6, false));
    {
        Scope consumed(original, 3, 807554);
        assert(!Scope::Take(1, 3, 807554));
    }
    auto nested = std::make_shared<CastReceipt>(1, 2, 14, 712483, 1, 0, 0);
    {
        Scope outer(nested, 3, 807554);
        {
            auto another = std::make_shared<CastReceipt>(1, 2, 14, 712483, 1, 0, 0);
            Scope inner(another, 4, 807554);
            assert(Scope::Take(1, 4, 807554) == another);
        }
        assert(Scope::Take(1, 3, 807554) == nested);
    }
}

int main(int argc, char** argv)
{
    auto const enrollment = ParseCharacterEnrollment("10", "13,16,24,27,29", "100");
    assert(enrollment && !enrollment->empty() && enrollment->size() == 1);
    assert(enrollment->Matches(10, 12));
    assert(!enrollment->Matches(99, 24));
    for (auto const classId : { 13U, 16U, 24U, 27U, 29U })
    {
        assert(enrollment->Matches(100, classId));
        assert(enrollment->Matches(101, classId));
    }
    assert(!enrollment->Matches(100, 12));
    assert(!enrollment->Matches(4294967296ULL, 24));
    assert(ParseCharacterEnrollment("")->empty());
    assert(!ParseCharacterEnrollment("1,1"));
    assert(!ParseCharacterEnrollment("0"));
    assert(!ParseCharacterEnrollment("4294967296"));
    assert(!ParseCharacterEnrollment("1,"));
    assert(!ParseCharacterEnrollment("", "24,24", "100"));
    assert(!ParseCharacterEnrollment("", "11", "100"));
    assert(!ParseCharacterEnrollment("", "33", "100"));
    assert(!ParseCharacterEnrollment("", "24", "0"));
    assert(!ParseCharacterEnrollment("", "", "100"));
    assert(!ParseCharacterEnrollment("", "24", "-1"));
    assert(!ParseCharacterEnrollment("", "24", "4294967296"));
    assert(!ParseCharacterEnrollment("", "24", "100x"));
    std::cout << "PASS: new-character class enrollment, existing-character exclusion and malformed rejection\n";

    std::array const bands = { TrainingBand{ 1, 30, 2 }, TrainingBand{ 20, 30, 1 } };
    TrainingPolicy const policy{ bands };
    CheckBuffReceipts();
    CheckAttackPowerReductionReceipts();
    CheckScriptedDamageReceipts();
    CheckCatalog(policy);
    CheckActions();
    CheckState(policy);
    CheckMenu(policy);
    CheckPersistence(policy);
    CheckOutcome(policy);
    CheckCurrentRankPolicies();
    CheckResourcePacing();
    CheckMasteryFixedAndTrainerPolicies();
    assert(ValidateCatalog(Development::Abilities) == CatalogError::None);
    assert(Development::Find(503232)->AbilityId == 803950);
    assert(Development::Find(803825)->AbilityId == 803819);
    assert(!Development::Find(101));
    std::array const pyroLearned = { 503232U };
    AbilityView const pyro = BuildAbilityView(Development::Abilities[0], Development::Policy,
        { 23, 18 }, 16, pyroLearned, true);
    assert(pyro.Cap == 80 && pyro.LearnedRank == 3 && pyro.NextPoint.Uses == 12);
    assert(pyro.NextRank->SpellId == 503233 && pyro.NextRank->Practice.Uses == 492);
    if (argc > 1)
    {
        WriteTypedRankCases(std::string(argv[1]) + ".typed");
        WriteSharedCases(std::string(argv[1]) + ".shared");
        WriteResourceCases(std::string(argv[1]) + ".resources");
        WriteDebuffCases(std::string(argv[1]) + ".debuffs");
        std::array const ranks = { AbilityRank{ 101, 1, { 4, 1 } }, AbilityRank{ 102, 2, { 16, 20 } },
            AbilityRank{ 103, 3, { 24, 40 } } };
        std::array const caps = { ProficiencyCap{ 1, 10 }, ProficiencyCap{ 16, 30 }, ProficiencyCap{ 24, 60 } };
        AbilityDefinition const ability{ 24, 1001, AbilityKind::Ranked, ranks, caps };
        std::array const known = { 101U, 102U };
        std::array views = { BuildAbilityView(ability, policy, { 23, 18 }, 24, known, true) };
        auto const encoded = EncodeMenuSnapshot(24, 24, 10, views);
        assert(encoded && encoded->size() == 5);
        std::ofstream output(argv[1]);
        for (std::string const& line : *encoded)
        {
            assert(line.size() <= 240);
            output << line << '\n';
        }
        assert(output.good());
        assert(!EncodeMenuSnapshot(25, 24, 10, views));
        assert(!EncodeMenuSnapshot(24, 24, 0, views));
        views[0].NextPoint = { ForecastStatus::Training, 9007199254740993ULL };
        auto const exact = EncodeMenuSnapshot(24, 24, 11, views);
        assert(exact && (*exact)[2].find("9007199254740993") != std::string::npos);
        views[0].NextPoint = { ForecastStatus::Complete, 1 };
        assert(!EncodeMenuSnapshot(24, 24, 11, views));
        views[0].NextPoint = { ForecastStatus::Training, 12 };
        std::vector<AbilityView> maximum;
        maximum.reserve(513);
        for (std::uint32_t index = 0; index < 512; ++index)
        {
            AbilityView view = views[0];
            view.AbilityId += index;
            view.DisplaySpellId += index;
            maximum.push_back(view);
        }
        auto const full = EncodeMenuSnapshot(24, 24, 12, maximum);
        assert(full && full->size() == 1538);
        for (std::string const& line : *full)
            assert(line.size() <= 240);
        maximum.push_back(views[0]);
        assert(!EncodeMenuSnapshot(24, 24, 12, maximum));
        maximum.resize(2);
        maximum[1].AbilityId = maximum[0].AbilityId;
        assert(!EncodeMenuSnapshot(24, 24, 12, maximum));
    }
    assert(ValidPolicy(policy));
    assert(UsesUntil(policy, { 23, 18 }, 24, 80).Uses == 12);
    assert(UsesUntil(policy, { 27, 24 }, 28, 80).Uses == 6);
    assert(UsesUntil(policy, { 12, 18 }, 13, 80).Uses == 6);
    assert(UsesUntil(policy, { 12, 18 }, 25, 80).Uses == 261);
    assert(UsesUntil(policy, { 23, 18 }, 40, 80).Uses == 492);
    assert(UsesUntil(policy, { 23, 18 }, 81, 80).Status == ForecastStatus::BeyondCap);
    assert(UsesUntil(policy, { 40, 0 }, 40, 80).Status == ForecastStatus::Complete);

    Award const capped = ApplyQualifyingUse(policy, { 79, 29 }, 80);
    assert(capped.Status == AwardStatus::Applied);
    assert(capped.State.Proficiency == 80 && capped.State.Points == 0);
    assert(ApplyQualifyingUse(policy, capped.State, 80).Status == AwardStatus::Capped);
    Award const retained = ApplyQualifyingUse(policy, { 80, 4 }, 40);
    assert(retained.Status == AwardStatus::Capped);
    assert(retained.State.Proficiency == 80 && retained.State.Points == 4);
    assert(UsesUntil(policy, retained.State, 70, 40).Status == ForecastStatus::Complete);

    std::array const transitions = { TrainingBand{ 1, 7, 5 }, TrainingBand{ 3, 2, 1 } };
    TrainingPolicy const transitionPolicy{ transitions };
    Award const carried = ApplyQualifyingUse(transitionPolicy, { 2, 6 }, 20);
    assert(carried.State.Proficiency == 5 && carried.State.Points == 0);
    assert(UsesUntil(transitionPolicy, { 2, 6 }, 4, 20).Uses == 1);
    assert(UsesUntil(transitionPolicy, { 2, 6 }, 6, 20).Uses == 3);
    Award const cappedCarry = ApplyQualifyingUse(transitionPolicy, { 2, 6 }, 4);
    assert(cappedCarry.State.Proficiency == 4 && cappedCarry.State.Points == 0);

    std::array const hugeBands = { TrainingBand{ 1, 4294967295U, 1 } };
    assert(UsesUntil({ hugeBands }, { 1, 0 }, 4294967295U, 4294967295U).Uses == 18446744060824649730ULL);
    std::array const hugeAward = { TrainingBand{ 1, 1, 4294967295U } };
    Award const huge = ApplyQualifyingUse({ hugeAward }, { 1, 0 }, 4294967295U);
    assert(huge.State.Proficiency == 4294967295U && huge.State.Points == 0);
    assert(UsesUntil({ hugeAward }, { 1, 0 }, 4294967295U, 4294967295U).Uses == 1);

    std::array const invalidOrder = { TrainingBand{ 1, 30, 1 }, TrainingBand{ 1, 30, 2 } };
    std::array const invalidStart = { TrainingBand{ 2, 30, 1 } };
    std::array const zeroRate = { TrainingBand{ 1, 30, 0 } };
    std::array const zeroCost = { TrainingBand{ 1, 0, 1 } };
    assert(!ValidPolicy({ {} }));
    assert(!ValidPolicy({ invalidOrder }));
    assert(!ValidPolicy({ invalidStart }));
    assert(!ValidPolicy({ zeroRate }));
    assert(!ValidPolicy({ zeroCost }));
    assert(ApplyQualifyingUse(policy, { 0, 0 }, 80).Status == AwardStatus::Invalid);
    assert(ApplyQualifyingUse(policy, { 1, 30 }, 80).Status == AwardStatus::Invalid);
    assert(ApplyQualifyingUse(policy, { 1, 0 }, 0).Status == AwardStatus::Invalid);
    assert(UsesUntil(policy, { 1, 0 }, 0, 80).Status == ForecastStatus::Invalid);
    assert(UsesUntil({ zeroRate }, { 1, 0 }, 2, 80).Status == ForecastStatus::Invalid);

    Milestone const rank{ 24, 40 };
    assert(EvaluateMilestone(rank, { 23, 18 }, 16, true) == MilestoneStatus::NeedsBoth);
    assert(EvaluateMilestone(rank, { 40, 0 }, 16, true) == MilestoneStatus::NeedsCharacterLevel);
    assert(EvaluateMilestone(rank, { 23, 18 }, 24, true) == MilestoneStatus::NeedsPractice);
    assert(EvaluateMilestone(rank, { 40, 0 }, 24, true) == MilestoneStatus::Ready);
    assert(EvaluateMilestone(rank, { 40, 0 }, 24, false) == MilestoneStatus::MissingPrerequisite);
    assert(EvaluateMilestone({ 0, 0 }, { 1, 0 }, 16, true) == MilestoneStatus::Invalid);

    std::uint32_t comparisons = 0;
    for (TrainingPolicy const sample : { policy, transitionPolicy })
    {
        for (std::uint32_t proficiency = 1; proficiency < 30; ++proficiency)
        {
            std::uint32_t const cost = sample.Bands[Detail::BandIndex(sample, proficiency)].PointsPerLevel;
            for (std::uint32_t points = 0; points < cost; ++points)
            {
                for (std::uint32_t target = proficiency + 1; target <= 30; ++target)
                {
                    Progress observed{ proficiency, points };
                    std::uint64_t actualUses = 0;
                    while (observed.Proficiency < target)
                    {
                        observed = ApplyQualifyingUse(sample, observed, 30).State;
                        ++actualUses;
                    }
                    Forecast const expected = UsesUntil(sample, { proficiency, points }, target, 30);
                    assert(expected.Status == ForecastStatus::Training && expected.Uses == actualUses);
                    ++comparisons;
                }
            }
        }
    }
    std::cout << "PASS: " << comparisons << " forecast/award comparisons and progression boundary cases\n";
}
