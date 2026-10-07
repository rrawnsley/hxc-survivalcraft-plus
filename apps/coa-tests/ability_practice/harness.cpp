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
#include "AbilityPracticeDevelopmentMastery.h"
#include "AbilityPracticeDevelopmentMasteryPacing.h"
#include "AbilityPracticeDevelopmentTrainerRanks.h"
#include "AbilityPracticeDevelopmentBuffTrainerRanks.h"
#include "AbilityPracticeDevelopmentStatBuffTrainerRanks.h"
#include "AbilityPracticeDevelopmentSpellPowerBuffTrainerRanks.h"
#include "AbilityPracticeDevelopmentFixed.h"
#include "AbilityPracticeDevelopmentHelpers.h"
#include "AbilityPracticeDevelopmentConjureFixed.h"
#include "AbilityPracticeDevelopmentPassiveFixed.h"
#include "AbilityPracticeDevelopmentUtilityFixed.h"
#include "AbilityPracticeDevelopmentControlFixed.h"
#include "AbilityPracticeDevelopmentTrainerFixed.h"
#include "AbilityPracticeNativeRankChain.h"

#include "../../../src/server/game/Spells/AbilityPracticeCastReceipt.h"

#include <array>
#include <thread>
#include <cassert>
#include <iostream>
#include <fstream>
#include <map>

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

void CheckCurrentRankPolicies()
{
    std::uint32_t forecasts = 0;
    std::array<bool, 21> classes{};
    assert(DevelopmentPacing::Entries.size() == 152);
    for (auto const& entry : DevelopmentPacing::Entries)
    {
        classes.at(entry.ClassId - 12) = true;
        std::array<ProficiencyCap, 80> caps{};
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
        for (std::uint32_t level = 1; level <= 80; ++level)
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
    std::cout << "PASS: 152 current rank policies, 21 classes, one-rank-ahead caps, exact rebases and "
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
    for (auto const catalog : MasteryCatalogs())
    {
        for (auto const& authored : catalog)
        {
            auto const profile = CurrentMasteryProfile(authored);
            assert(ValidateProfiles(std::span(&profile, 1)));
            bool const healing = profile.Outcome == OutcomeKind::Healing;
            for (auto const& reward : profile.Rewards)
            {
                auto const level = reward.Requirement.CharacterLevel;
                Progress const progress{ reward.Requirement.Proficiency, 0 };
                auto const bonus = MasteryBonus(profile.Definition, profile.Rewards, progress, level, true, true, healing);
                assert(bonus == MasteryBonusAmount(reward));
                assert(MasteryBonus(profile.Definition, profile.Rewards, progress, level, false, true, healing) == 0);
                assert(MasteryBonus(profile.Definition, profile.Rewards, progress, level, true, false, healing) == 0);
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
    assert(fixedCount == 96);
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
    assert(extensions == 12 && addedRanks == 24);
    std::cout << "PASS: 9 mastery policies/rewards, 96 fixed declarations, 12 trainer extensions/24 added ranks\n";
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
            DevelopmentMastery::IsBaneOfBetrayal(profile) ?
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
            write(profile, profile.Definition.Ranks.front().Requirement.CharacterLevel, true, { 1, 0 });
            if (DevelopmentMastery::IsFelBargain(profile))
                write(profile, profile.Definition.Ranks.front().Requirement.CharacterLevel, false, { 1, 0 });
            for (auto const& reward : profile.Rewards)
                write(profile, reward.Requirement.CharacterLevel, true, { reward.Requirement.Proficiency, 0 });
            if (DevelopmentMastery::IsBaneOfBetrayal(profile) || DevelopmentMastery::IsSoulCapture(profile))
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

void WriteTypedRankCases(std::string const& filename)
{
    std::ofstream output(filename);
    std::uint32_t revision = 100;
    for (auto const& entry : DevelopmentPacing::Entries)
    {
        std::array<ProficiencyCap, 80> caps{};
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
    std::array const bands = { TrainingBand{ 1, 30, 2 }, TrainingBand{ 20, 30, 1 } };
    TrainingPolicy const policy{ bands };
    CheckScriptedDamageReceipts();
    CheckCatalog(policy);
    CheckActions();
    CheckState(policy);
    CheckMenu(policy);
    CheckPersistence(policy);
    CheckOutcome(policy);
    CheckCurrentRankPolicies();
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
