// SPDX-License-Identifier: GPL-2.0-or-later

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeCatchup.h"
#include "AbilityPracticeDevelopmentSamples.h"
#include "AbilityPracticeDevelopmentPeriodic.h"
#include "AbilityPracticeDevelopmentRanked.h"
#include "AbilityPracticeDevelopmentPacing.h"
#include "AbilityPracticeDevelopmentRankCaps.h"
#include "AbilityPracticeDevelopmentMastery.h"
#include "AbilityPracticeDevelopmentHelpers.h"
#include "AbilityPracticeDevelopmentLeech.h"
#include "AbilityPracticeDevelopmentBuffs.h"
#include "AbilityPracticeDevelopmentBuffVariants.h"
#include "AbilityPracticeDevelopmentFixed.h"
#include "AbilityPracticeDevelopmentConjureFixed.h"
#include "AbilityPracticeDevelopmentPassiveFixed.h"
#include "AbilityPracticeDevelopmentUtilityFixed.h"
#include "AbilityPracticeDevelopmentTrainerFixed.h"
#include "AbilityPracticeDevelopmentTrainerRanks.h"
#include "AbilityPracticeDevelopmentBuffTrainerRanks.h"
#include "AbilityPracticeDevelopmentStatBuffTrainerRanks.h"
#include "AbilityPracticeDevelopmentSpellPowerBuffTrainerRanks.h"
#include "AbilityPracticeDevelopmentAbsorption.h"
#include "AbilityPracticeDevelopmentControl.h"
#include "AbilityPracticeDevelopmentControlFixed.h"
#include "AbilityPracticeDevelopmentMasteryPacing.h"
#include "AbilityPracticeProfiles.h"
#include "AbilityPracticeRankPolicy.h"
#include "AbilityPracticeMasteryPolicy.h"
#include "AbilityPracticeCastReceipt.h"
#include "AbilityPracticeBuffReceipts.h"
#include "AbilityPracticeOutcome.h"
#include "AbilityPracticeNativeRankChain.h"
#include "AbilityPracticeWire.h"
#include "AscensionCustomClassData.h"
#include "AscensionSpellProgressionData.h"
#include "AscensionSpellEligibility.h"
#include "AscensionFelswornData.h"
#include "Chat.h"
#include "Config.h"
#include "CryptoRandom.h"
#include "CombatManager.h"
#include "Creature.h"
#include "DBCStores.h"
#include "Formulas.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellAuras.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"
#include "Trainer.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"

#include <array>
#include <atomic>
#include <chrono>
#include <charconv>
#include <memory>
#include <limits>
#include <mutex>
#include <string_view>
#include <unordered_map>
#include <unordered_set>
#include <vector>

namespace
{
namespace Practice = AbilityPractice;
namespace Dev = AbilityPractice::Development;
constexpr std::array Profiles = {
    Practice::AbilityProfile{ Dev::DefinitionVersion, Practice::AcquisitionSource::ClassGrant,
        Dev::Abilities[0], Dev::Policy, Practice::OutcomeKind::Damage },
    Practice::AbilityProfile{ Dev::DefinitionVersion, Practice::AcquisitionSource::ClassGrant,
        Dev::Abilities[1], Dev::Policy, Practice::OutcomeKind::Healing },
    Practice::AbilityProfile{ Dev::DefinitionVersion, Practice::AcquisitionSource::ClassGrant,
        Dev::Abilities[2], Dev::Policy, Practice::OutcomeKind::Healing }
};
constexpr auto AllClassSampleProfiles = []
{
    std::array<Practice::AbilityProfile, Profiles.size() + Practice::DevelopmentSamples::Profiles.size()> result{};
    std::copy(Profiles.begin(), Profiles.end(), result.begin());
    std::copy(Practice::DevelopmentSamples::Profiles.begin(), Practice::DevelopmentSamples::Profiles.end(),
        result.begin() + Profiles.size());
    return result;
}();
std::span<Practice::AbilityProfile const> SelectProfiles(bool classSamples, bool ranked)
{
    if (ranked)
        return Practice::DevelopmentRanked::Profiles;
    if (classSamples)
        return AllClassSampleProfiles;
    return Profiles;
}

bool SameMilestone(Practice::Milestone const& left, Practice::Milestone const& right)
{
    return left.CharacterLevel == right.CharacterLevel && left.Proficiency == right.Proficiency;
}

bool SameProfile(Practice::AbilityProfile const& left, Practice::AbilityProfile const& right)
{
    auto const& first = left.Definition;
    auto const& second = right.Definition;
    return left.DefinitionVersion == right.DefinitionVersion && left.Acquisition == right.Acquisition &&
        left.Outcome == right.Outcome && first.ClassId == second.ClassId && first.AbilityId == second.AbilityId &&
        first.Kind == second.Kind &&
        std::equal(first.Ranks.begin(), first.Ranks.end(), second.Ranks.begin(), second.Ranks.end(),
            [](Practice::AbilityRank const& lhs, Practice::AbilityRank const& rhs)
            {
                return lhs.SpellId == rhs.SpellId && lhs.RankNumber == rhs.RankNumber &&
                    SameMilestone(lhs.Requirement, rhs.Requirement);
            }) &&
        std::equal(first.Caps.begin(), first.Caps.end(), second.Caps.begin(), second.Caps.end(),
            [](Practice::ProficiencyCap const& lhs, Practice::ProficiencyCap const& rhs)
            {
                return lhs.CharacterLevel == rhs.CharacterLevel && lhs.Proficiency == rhs.Proficiency;
            }) &&
        std::equal(left.Policy.Bands.begin(), left.Policy.Bands.end(),
            right.Policy.Bands.begin(), right.Policy.Bands.end(),
            [](Practice::TrainingBand const& lhs, Practice::TrainingBand const& rhs)
            {
                return lhs.FirstProficiency == rhs.FirstProficiency && lhs.PointsPerLevel == rhs.PointsPerLevel &&
                    lhs.PointsPerUse == rhs.PointsPerUse;
            }) &&
        std::equal(left.Rewards.begin(), left.Rewards.end(), right.Rewards.begin(), right.Rewards.end(),
            [](Practice::MasteryReward const& lhs, Practice::MasteryReward const& rhs)
            {
                return SameMilestone(lhs.Requirement, rhs.Requirement) &&
                    lhs.HealingBonusBasisPoints == rhs.HealingBonusBasisPoints &&
                    lhs.DamageBonusBasisPoints == rhs.DamageBonusBasisPoints &&
                    lhs.ResourceDrainBonusBasisPoints == rhs.ResourceDrainBonusBasisPoints;
            });
}

bool AppendProfiles(std::vector<Practice::AbilityProfile>& destination,
    std::span<Practice::AbilityProfile const> additions)
{
    if (!Practice::ValidateProfiles(additions))
    {
        LOG_ERROR("module.ability_practice", "Rejected invalid optional development profile group");
        return false;
    }
    bool valid = true;
    for (Practice::AbilityProfile const& profile : additions)
    {
        auto const existing = std::find_if(destination.begin(), destination.end(),
            [&profile](Practice::AbilityProfile const& entry)
            {
                return entry.Definition.ClassId == profile.Definition.ClassId &&
                    entry.Definition.AbilityId == profile.Definition.AbilityId;
            });
        if (existing == destination.end())
            destination.push_back(profile);
        else if (!SameProfile(*existing, profile))
        {
            valid = false;
            LOG_ERROR("module.ability_practice", "Conflicting development profile: class={}, ability={}",
                profile.Definition.ClassId, profile.Definition.AbilityId);
        }
    }
    return valid;
}
bool ApplyDevelopmentPacing(std::vector<Practice::AbilityProfile>& profiles)
{
    if (Practice::DevelopmentPacing::DefinitionVersion <= Practice::DevelopmentPacing::PreviousDefinitionVersion ||
        !Practice::ValidPolicy(Practice::DevelopmentPacing::PreviousPolicy))
        return false;
    for (Practice::AbilityProfile& profile : profiles)
    {
        if (profile.Definition.Kind != Practice::AbilityKind::Ranked)
            continue;
        auto const& entries = Practice::DevelopmentPacing::Entries;
        auto const entry = std::find_if(entries.begin(), entries.end(),
            [&profile](Practice::DevelopmentPacing::Entry const& value)
            {
                return value.ClassId == profile.Definition.ClassId && value.AbilityId == profile.Definition.AbilityId;
            });
        auto const& previous = Practice::DevelopmentPacing::PreviousPolicy;
        if (entry == entries.end() ||
            profile.DefinitionVersion != Practice::DevelopmentPacing::PreviousDefinitionVersion ||
            !std::equal(profile.Definition.Ranks.begin(), profile.Definition.Ranks.end(),
                entry->ExpectedRanks.begin(), entry->ExpectedRanks.end(),
                [](Practice::AbilityRank const& left, Practice::AbilityRank const& right)
                {
                    return left.SpellId == right.SpellId && left.RankNumber == right.RankNumber &&
                        SameMilestone(left.Requirement, right.Requirement);
                }) ||
            !std::equal(profile.Policy.Bands.begin(), profile.Policy.Bands.end(),
                previous.Bands.begin(), previous.Bands.end(),
                [](Practice::TrainingBand const& left, Practice::TrainingBand const& right)
                {
                    return left.FirstProficiency == right.FirstProficiency &&
                        left.PointsPerLevel == right.PointsPerLevel && left.PointsPerUse == right.PointsPerUse;
                }))
        {
            LOG_ERROR("module.ability_practice", "Rejected development pacing source: class={}, ability={}",
                profile.Definition.ClassId, profile.Definition.AbilityId);
            return false;
        }
        profile.Policy = entry->Policy;
        profile.DefinitionVersion = Practice::DevelopmentPacing::DefinitionVersion;
    }
    return true;
}

Practice::DevelopmentMasteryPacing::Entry const* MasteryPacingEntry(Practice::AbilityProfile const& profile)
{
    auto const& entries = Practice::DevelopmentMasteryPacing::Entries;
    auto const found = std::find_if(entries.begin(), entries.end(),
        [&profile](Practice::DevelopmentMasteryPacing::Entry const& entry)
        {
            return entry.ClassId == profile.Definition.ClassId && entry.AbilityId == profile.Definition.AbilityId;
        });
    return found == entries.end() ? nullptr : &*found;
}

bool ApplyDevelopmentMasteryPacing(std::vector<Practice::AbilityProfile>& profiles)
{
    if (Practice::DevelopmentMasteryPacing::DefinitionVersion <=
        Practice::DevelopmentMasteryPacing::PreviousDefinitionVersion)
        return false;
    for (Practice::AbilityProfile& profile : profiles)
    {
        if (profile.Definition.Kind != Practice::AbilityKind::Mastery)
            continue;
        auto const* entry = MasteryPacingEntry(profile);
        if (!entry)
            continue;
        Practice::AbilityProfile const expected{
            Practice::DevelopmentMasteryPacing::PreviousDefinitionVersion, Practice::AcquisitionSource::ClassGrant,
            { entry->ClassId, entry->AbilityId, Practice::AbilityKind::Mastery,
                entry->ExpectedRanks, profile.Definition.Caps },
            entry->PreviousPolicy, entry->ExpectedOutcome, entry->ExpectedRewards };
        if (!Practice::ValidPolicy(entry->Policy) || !SameProfile(profile, expected))
        {
            LOG_ERROR("module.ability_practice", "Rejected mastery pacing source: class={}, ability={}",
                profile.Definition.ClassId, profile.Definition.AbilityId);
            return false;
        }
        profile.Policy = entry->Policy;
        profile.DefinitionVersion = Practice::DevelopmentMasteryPacing::DefinitionVersion;
    }
    return true;
}

Practice::DevelopmentTrainerRanks::Entry const* TrainerRankExtensionForIdentity(
    std::uint32_t classId, std::uint32_t abilityId)
{
    std::array<std::span<Practice::DevelopmentTrainerRanks::Entry const>, 4> const catalogs = {
        Practice::DevelopmentTrainerRanks::Entries, Practice::DevelopmentBuffTrainerRanks::Entries,
        Practice::DevelopmentStatBuffTrainerRanks::Entries,
        Practice::DevelopmentSpellPowerBuffTrainerRanks::Entries };
    Practice::DevelopmentTrainerRanks::Entry const* result = nullptr;
    for (auto const entries : catalogs)
        for (auto const& entry : entries)
            if (entry.Profile.Definition.ClassId == classId && entry.Profile.Definition.AbilityId == abilityId)
            {
                if (result)
                    return nullptr;
                result = &entry;
            }
    return result;
}

std::unordered_map<std::uint64_t, Practice::DevelopmentRankCaps::Entry> RankCapEntries;

Practice::AbilityProfile const* PreviousRankCapProfile(Practice::AbilityProfile const& profile)
{
    if (profile.DefinitionVersion != Practice::DevelopmentRankCaps::DefinitionVersion ||
        profile.Definition.Kind != Practice::AbilityKind::Ranked)
        return nullptr;
    std::uint64_t const key = (std::uint64_t(profile.Definition.ClassId) << 32) | profile.Definition.AbilityId;
    auto const found = RankCapEntries.find(key);
    if (found == RankCapEntries.end())
        return nullptr;
    Practice::AbilityProfile expected = found->second.Previous;
    expected.DefinitionVersion = Practice::DevelopmentRankCaps::DefinitionVersion;
    expected.Definition.Caps = found->second.Caps;
    return SameProfile(profile, expected) ? &found->second.Previous : nullptr;
}

bool ApplyDevelopmentRankCaps(std::vector<Practice::AbilityProfile>& profiles)
{
    RankCapEntries.clear();
    std::size_t count = 0;
    for (auto& profile : profiles)
    {
        if (profile.Definition.Kind != Practice::AbilityKind::Ranked)
            continue;
        auto entry = Practice::DevelopmentRankCaps::Build(profile);
        if (!entry)
            return false;
        std::uint64_t const key = (std::uint64_t(profile.Definition.ClassId) << 32) | profile.Definition.AbilityId;
        auto const [position, inserted] = RankCapEntries.emplace(key, std::move(*entry));
        if (!inserted)
            return false;
        profile.Definition.Caps = position->second.Caps;
        profile.DefinitionVersion = Practice::DevelopmentRankCaps::DefinitionVersion;
        ++count;
    }
    return count != 0;
}

Practice::DevelopmentTrainerRanks::Entry const* TrainerRankExtensionEntry(Practice::AbilityProfile const& profile)
{
    if (auto const* previous = PreviousRankCapProfile(profile))
        return TrainerRankExtensionEntry(*previous);
    auto const* entry = TrainerRankExtensionForIdentity(profile.Definition.ClassId, profile.Definition.AbilityId);
    return entry && profile.DefinitionVersion == entry->Profile.DefinitionVersion ? entry : nullptr;
}

bool ApplyDevelopmentTrainerRankExtensions(std::vector<Practice::AbilityProfile>& profiles)
{
    std::size_t count = 0;
    for (auto& profile : profiles)
    {
        auto const* found = TrainerRankExtensionForIdentity(profile.Definition.ClassId, profile.Definition.AbilityId);
        if (!found)
            continue;
        Practice::AbilityProfile const expected{
            Practice::DevelopmentPacing::DefinitionVersion, Practice::AcquisitionSource::ClassGrant,
            { profile.Definition.ClassId, profile.Definition.AbilityId, Practice::AbilityKind::Ranked,
                found->PreviousRanks, found->PreviousCaps }, found->PreviousPolicy, found->Profile.Outcome };
        if (!SameProfile(profile, expected))
            return false;
        profile = found->Profile;
        ++count;
    }
    return count != 0;
}

std::vector<Practice::AbilityProfile> RuntimeProfiles;
std::unordered_set<std::uint64_t> PeriodicPracticeAbilities;
std::optional<Practice::ProfileIndex> ProfileLookup;
std::recursive_mutex Mutex;
bool Requested = false;
bool DevelopmentAllowed = false;
bool Ready = false;
bool CharacterSelectionReady = false;
using CharacterSelection = std::unordered_set<std::uint64_t>;
std::atomic<std::shared_ptr<CharacterSelection const>> SelectedCharacters;
std::atomic<bool> RealmEnrollment{ false };
bool RankRequested = false;
bool PeriodicRequested = false;
bool MasteryRequested = false;
bool HelpersRequested = false;
bool DirectLeechRequested = false;
bool BuffContributionRequested = false;
bool SharedBuffVariantsRequested = false;
bool TrainerRanksRequested = false;
bool AbsorptionRequested = false;
bool PacingRequested = false;
bool RankCapsRequested = false;
bool MasteryPacingRequested = false;
bool ControlRequested = false;
Practice::CatchupSettings Catchup;

struct PreviousPacing
{
    Practice::TrainingPolicy Policy;
    std::uint32_t DefinitionVersion;
};

std::array<std::optional<PreviousPacing>, 3> PreviousPacingFor(Practice::AbilityProfile const& profile)
{
    if (RankCapsRequested)
        if (auto const* previous = PreviousRankCapProfile(profile))
        {
            auto result = PreviousPacingFor(*previous);
            auto const empty = std::find_if(result.begin(), result.end(),
                [](std::optional<PreviousPacing> const& value) { return !value; });
            if (empty == result.end())
                return {};
            *empty = PreviousPacing{ previous->Policy, previous->DefinitionVersion };
            return result;
        }
    if (TrainerRanksRequested)
        if (auto const* entry = TrainerRankExtensionEntry(profile))
            return { PreviousPacing{ Practice::DevelopmentPacing::PreviousPolicy,
                Practice::DevelopmentPacing::PreviousDefinitionVersion },
                PreviousPacing{ entry->PreviousPolicy, Practice::DevelopmentPacing::DefinitionVersion } };
    if (PacingRequested && profile.Definition.Kind == Practice::AbilityKind::Ranked &&
        profile.DefinitionVersion == Practice::DevelopmentPacing::DefinitionVersion)
        return { PreviousPacing{ Practice::DevelopmentPacing::PreviousPolicy,
            Practice::DevelopmentPacing::PreviousDefinitionVersion }, std::nullopt };
    if (MasteryPacingRequested && profile.Definition.Kind == Practice::AbilityKind::Mastery &&
        profile.DefinitionVersion == Practice::DevelopmentMasteryPacing::DefinitionVersion)
        if (auto const* entry = MasteryPacingEntry(profile))
            return { PreviousPacing{ entry->PreviousPolicy,
                Practice::DevelopmentMasteryPacing::PreviousDefinitionVersion }, std::nullopt };
    return {};
}
std::uint64_t NextActionSession = 0;
std::atomic<bool> RankActive = false;
std::atomic<bool> Active = false;
std::uint32_t Revision = 0;
std::uint64_t ServerGeneration = 0;
using Clock = std::chrono::steady_clock;
constexpr auto RefreshInterval = std::chrono::seconds(2);
constexpr auto InterestDuration = std::chrono::seconds(30);
constexpr auto DeliveryInterval = std::chrono::milliseconds(100);
constexpr auto DeliveryDuration = std::chrono::seconds(90);
constexpr std::size_t DeliveryBatchSize = 8;
constexpr std::size_t MaxQueuedMessages = 512 * 10 + 2048 + Practice::MaximumSessionLearns +
    Practice::MaximumSessionMasteries + 4;
constexpr std::uint32_t PracticeCastSourceKey = 0x41504353;
constexpr std::uint32_t PracticeClientRequestKey = 0x41504352;
constexpr std::uint32_t PracticeBuffContributionKey = 0x41504342;
constexpr std::uint32_t PracticeBuffEligibilityKey = 0x41504253;
std::string const ActiveSpecializationSource = "core.ascension_active_spec";
struct ClassSession
{
    Practice::SessionPractice Totals;
    Practice::SessionLearning Learning;
    Practice::SessionMastery Mastery;
    std::unordered_map<std::uint32_t, std::uint32_t> MasterySeen;
    std::unordered_map<std::uint32_t, Practice::SessionPractice> Abilities;
};

struct BuffPracticeSession
{
    std::shared_ptr<CoAAbilityPractice::CastReceipt> Origin;
    Clock::time_point NextContribution{};
    std::optional<Practice::BuffPracticeState> LastState;
};

struct MenuSession
{
    Clock::time_point LastRequest{};
    Clock::time_point NextRefresh{};
    Clock::time_point InterestedUntil{};
    bool Dirty = true;
    bool CheckRanks = true;
    bool Initialized = false;
    bool LoginObserved = false;
    std::uint32_t Protocol = Practice::MenuSchemaVersion;
    std::uint32_t LastClass = 0;
    std::uint32_t LastRace = 0;
    std::uint32_t LastSpec = 0;
    std::uint32_t LastCustomSpecialization = 0;
    std::uint64_t ActionSession = 0;
    std::unordered_map<std::uint32_t, BuffPracticeSession> Buffs;
    Practice::BuffCastLedger PeriodicBuffCasts;
    Clock::time_point NextBuffStateRefresh{};
    Clock::time_point NextFireSigilPractice{};
    Clock::time_point NextFrostSigilPractice{};
    std::uint32_t OutgoingClass = 0;
    std::vector<std::string> Outgoing;
    std::size_t NextMessage = 0;
    Clock::time_point NextDelivery{};
    Clock::time_point DeliveryDeadline{};
    std::unordered_map<std::uint32_t, ClassSession> Progress;
};
std::unordered_map<std::uint64_t, MenuSession> Sessions;

Practice::PracticeRoute RouteFor(Practice::OutcomeKind outcome)
{
    switch (outcome)
    {
        case Practice::OutcomeKind::Damage: return Practice::PracticeRoute::Damage;
        case Practice::OutcomeKind::Healing: return Practice::PracticeRoute::Healing;
        case Practice::OutcomeKind::Interrupt: return Practice::PracticeRoute::Interrupt;
        case Practice::OutcomeKind::Dispel: return Practice::PracticeRoute::Dispel;
        case Practice::OutcomeKind::Steal: return Practice::PracticeRoute::Steal;
        case Practice::OutcomeKind::None: return Practice::PracticeRoute::Fixed;
        case Practice::OutcomeKind::DamageOrInterrupt: return Practice::PracticeRoute::DamageOrInterrupt;
        case Practice::OutcomeKind::DamageOrDispel: return Practice::PracticeRoute::DamageOrDispel;
        case Practice::OutcomeKind::Fear: return Practice::PracticeRoute::Fear;
        case Practice::OutcomeKind::ResourceDrain: return Practice::PracticeRoute::ResourceDrain;
    }
    return Practice::PracticeRoute::Unknown;
}

std::uint64_t ProfileKey(Practice::AbilityDefinition const& ability)
{
    return (static_cast<std::uint64_t>(ability.ClassId) << 32) | ability.AbilityId;
}

bool HasSupportedPeriodicOutcome(SpellInfo const* info, Practice::OutcomeKind outcome)
{
    if (!info)
        return false;
    if (outcome == Practice::OutcomeKind::Damage)
        return info->HasAura(SPELL_AURA_PERIODIC_DAMAGE) || info->HasAura(SPELL_AURA_PERIODIC_DAMAGE_PERCENT) ||
            info->HasAura(SPELL_AURA_PERIODIC_LEECH);
    return outcome == Practice::OutcomeKind::Healing && info->HasAura(SPELL_AURA_PERIODIC_HEAL);
}

bool HasSupportedOutcome(SpellInfo const* info, Practice::OutcomeKind outcome)
{
    if (!info)
        return false;
    bool const directDamage = info->HasEffect(SPELL_EFFECT_SCHOOL_DAMAGE) ||
        info->HasEffect(SPELL_EFFECT_WEAPON_DAMAGE) || info->HasEffect(SPELL_EFFECT_WEAPON_DAMAGE_NOSCHOOL) ||
        info->HasEffect(SPELL_EFFECT_NORMALIZED_WEAPON_DMG) || info->HasEffect(SPELL_EFFECT_WEAPON_PERCENT_DAMAGE);
    if (outcome == Practice::OutcomeKind::DamageOrInterrupt || outcome == Practice::OutcomeKind::DamageOrDispel)
        return directDamage && HasSupportedOutcome(info, outcome == Practice::OutcomeKind::DamageOrInterrupt
            ? Practice::OutcomeKind::Interrupt : Practice::OutcomeKind::Dispel);
    if (outcome == Practice::OutcomeKind::Damage)
        return directDamage || (PeriodicRequested && HasSupportedPeriodicOutcome(info, outcome));
    if (outcome == Practice::OutcomeKind::Healing)
        return info->HasEffect(SPELL_EFFECT_HEAL) || info->HasEffect(SPELL_EFFECT_HEAL_PCT) ||
            info->HasEffect(SPELL_EFFECT_HEAL_MAX_HEALTH) ||
            (PeriodicRequested && HasSupportedPeriodicOutcome(info, outcome));
    if (outcome == Practice::OutcomeKind::Interrupt)
        return info->HasEffect(SPELL_EFFECT_INTERRUPT_CAST);
    if (outcome == Practice::OutcomeKind::Dispel)
        return info->HasEffect(SPELL_EFFECT_DISPEL);
    if (outcome == Practice::OutcomeKind::Steal)
        return info->HasEffect(SPELL_EFFECT_STEAL_BENEFICIAL_BUFF);
    if (outcome == Practice::OutcomeKind::Fear)
        return ControlRequested && info->HasAura(SPELL_AURA_MOD_FEAR);
    return false;
}

bool HasExpectedRiteGroup(std::uint32_t spellId)
{
    constexpr auto group = static_cast<SpellGroup>(2100001);
    if (sSpellMgr->GetSpellGroupStackRule(group) != SPELL_GROUP_STACK_RULE_EXCLUSIVE ||
        !sSpellMgr->IsSpellMemberOfSpellGroup(spellId, group))
        return false;
    constexpr std::array<std::int32_t, 6> expected{ 575839, 575842, 578126, 578130, 800198, 680298 };
    std::array<bool, expected.size()> seen{};
    auto const members = sSpellMgr->GetSpellGroupSpellMapBounds(group);
    for (auto member = members.first; member != members.second; ++member)
    {
        auto const found = std::find(expected.begin(), expected.end(), member->second);
        if (found == expected.end())
            return false;
        auto const index = static_cast<std::size_t>(found - expected.begin());
        if (seen[index])
            return false;
        seen[index] = true;
    }
    return std::all_of(seen.begin(), seen.end(), [](bool present) { return present; });
}

bool HasExpectedAdaptationGroup(std::uint32_t abilityId, std::uint32_t spellId)
{
    bool const footpad = abilityId == 523489;
    if (!footpad && abilityId != 800266)
        return false;
    auto const group = static_cast<SpellGroup>(footpad ? 2100002 : 2100003);
    if (sSpellMgr->GetSpellGroupStackRule(group) != SPELL_GROUP_STACK_RULE_EXCLUSIVE_HIGHEST ||
        !sSpellMgr->IsSpellMemberOfSpellGroup(spellId, group))
        return false;
    std::array<std::int32_t, 2> const expected{ footpad ? 523489 : 800266, footpad ? 523513 : 680294 };
    std::array<bool, 2> seen{};
    auto const members = sSpellMgr->GetSpellGroupSpellMapBounds(group);
    for (auto member = members.first; member != members.second; ++member)
    {
        auto const found = std::find(expected.begin(), expected.end(), member->second);
        if (found == expected.end())
            return false;
        auto const index = static_cast<std::size_t>(found - expected.begin());
        if (seen[index])
            return false;
        seen[index] = true;
    }
    return std::all_of(seen.begin(), seen.end(), [](bool present) { return present; });
}

bool HasExactBuffGroup(std::uint32_t spellId, std::uint32_t groupId, SpellGroupStackRule rule,
    std::span<std::int32_t const> expected)
{
    auto const group = static_cast<SpellGroup>(groupId);
    if (sSpellMgr->GetSpellGroupStackRule(group) != rule ||
        !sSpellMgr->IsSpellMemberOfSpellGroup(spellId, group))
        return false;
    std::vector<std::int32_t> members;
    auto const bounds = sSpellMgr->GetSpellGroupSpellMapBounds(group);
    for (auto member = bounds.first; member != bounds.second; ++member)
        members.push_back(member->second);
    if (members.size() != expected.size())
        return false;
    std::sort(members.begin(), members.end());
    return std::equal(members.begin(), members.end(), expected.begin());
}

bool HasExpectedStormbornSharedGroup(std::uint32_t abilityId, std::uint32_t spellId)
{
    auto const groups = sSpellMgr->GetSpellSpellGroupMapBounds(spellId);
    if (groups.first != groups.second)
        return false;
    if (abilityId == 575843)
    {
        auto const regular = sSpellMgr->GetSpellSpellGroupMapBounds(abilityId);
        return regular.first == regular.second;
    }
    if (abilityId != 578311 && abilityId != 804018)
        return false;
    constexpr std::array<std::int32_t, 2> calls{ 578311, 804018 };
    return HasExactBuffGroup(abilityId, 1171, SPELL_GROUP_STACK_RULE_EXCLUSIVE_FROM_SAME_CASTER, calls);
}

bool HasExpectedStarcallerGroup(std::uint32_t abilityId, std::uint32_t spellId)
{
    constexpr std::array<std::int32_t, 2> mind{ 300255, 680301 };
    constexpr std::array<std::int32_t, 2> protection{ 573343, 573348 };
    if (abilityId == 300255)
        return HasExactBuffGroup(spellId, 1150, SPELL_GROUP_STACK_RULE_EXCLUSIVE_FROM_SAME_CASTER, mind);
    return abilityId == 573343 &&
        HasExactBuffGroup(spellId, 1151, SPELL_GROUP_STACK_RULE_EXCLUSIVE_FROM_SAME_CASTER, protection);
}

bool HasExpectedGeomancerGroup(std::uint32_t abilityId, std::uint32_t spellId)
{
    if (abilityId == 570752)
    {
        auto const groups = sSpellMgr->GetSpellSpellGroupMapBounds(spellId);
        return groups.first == groups.second;
    }
    if (abilityId != 572810 && abilityId != 800197)
        return false;
    constexpr std::array<std::int32_t, 5> instincts{ 572810, 572816, 572817, 680310, 800197 };
    return HasExactBuffGroup(spellId, 103955, SPELL_GROUP_STACK_RULE_EXCLUSIVE_FROM_SAME_CASTER, instincts);
}

bool HasExpectedModuleGroup(std::uint32_t spellId)
{
    constexpr std::array<std::int32_t, 4> modules{ 680315, 706742, 803658, 803665 };
    if (spellId == 803664)
    {
        if (sSpellMgr->GetSpellChainNode(spellId) ||
            sSpellMgr->IsSpellMemberOfSpellGroup(spellId, static_cast<SpellGroup>(1136)))
            return false;
        spellId = 803658;
    }
    return HasExactBuffGroup(spellId, 1136, SPELL_GROUP_STACK_RULE_EXCLUSIVE_FROM_SAME_CASTER, modules);
}

bool HasExpectedEtchingGroup(std::uint32_t abilityId, std::uint32_t spellId)
{
    constexpr std::array<std::int32_t, 6> etchings{ 560295, 561236, 561237, 561241, 561242, 561243 };
    constexpr std::array<std::int32_t, 2> dextrous{ 561237, 561241 };
    constexpr std::array<std::int32_t, 2> leylines{ 561236, 561242 };
    constexpr std::array<std::int32_t, 2> magi{ 560295, 561243 };
    if (!HasExactBuffGroup(spellId, 1140, SPELL_GROUP_STACK_RULE_EXCLUSIVE_FROM_SAME_CASTER, etchings))
        return false;
    if (abilityId == 561237)
        return HasExactBuffGroup(spellId, 1042, SPELL_GROUP_STACK_RULE_EXCLUSIVE, dextrous);
    if (abilityId == 561236)
        return HasExactBuffGroup(spellId, 1043, SPELL_GROUP_STACK_RULE_EXCLUSIVE, leylines);
    return abilityId == 560295 && HasExactBuffGroup(spellId, 1044, SPELL_GROUP_STACK_RULE_EXCLUSIVE, magi);
}

bool HasExpectedArmorOrEdictGroup(std::uint32_t abilityId, std::uint32_t spellId)
{
    constexpr std::array<std::int32_t, 4> intuition{ 1126, 523478, 523495, 1101126 };
    constexpr std::array<std::int32_t, 6> pheromones{ 680312, 707689, 712459, 803177, 803651, 803657 };
    constexpr std::array<std::int32_t, 6> edicts{ 523485, 523510, 680303, 681442, 706741, 707684 };
    constexpr std::array<std::int32_t, 2> knights{ 523485, 523510 };
    constexpr std::array<std::int32_t, 2> inquisitors{ 680303, 706741 };
    constexpr std::array<std::int32_t, 2> witching{ 681442, 707684 };
    if (abilityId == 523478)
        return HasExactBuffGroup(spellId, 1078, SPELL_GROUP_STACK_RULE_DEFAULT, intuition);
    if (abilityId == 803651)
        return HasExactBuffGroup(spellId, 1138, SPELL_GROUP_STACK_RULE_EXCLUSIVE_FROM_SAME_CASTER, pheromones);
    if (!HasExactBuffGroup(spellId, 1139, SPELL_GROUP_STACK_RULE_EXCLUSIVE_FROM_SAME_CASTER, edicts))
        return false;
    if (abilityId == 523485)
        return HasExactBuffGroup(spellId, 1039, SPELL_GROUP_STACK_RULE_EXCLUSIVE, knights);
    if (abilityId == 706741)
        return HasExactBuffGroup(spellId, 1040, SPELL_GROUP_STACK_RULE_EXCLUSIVE, inquisitors);
    return abilityId == 707684 && HasExactBuffGroup(spellId, 1041, SPELL_GROUP_STACK_RULE_EXCLUSIVE, witching);
}

bool IsArmorOrEdictProfile(Practice::AbilityProfile const& profile)
{
    return (profile.Definition.ClassId == 14 && profile.Definition.AbilityId == 523478) ||
        (profile.Definition.ClassId == 29 && profile.Definition.AbilityId == 803651) ||
        (profile.Definition.ClassId == 15 && (profile.Definition.AbilityId == 523485 ||
            profile.Definition.AbilityId == 706741 || profile.Definition.AbilityId == 707684));
}

bool HasSupportedSpecializedOutcome(SpellInfo const* info, Practice::AbilityProfile const& profile)
{
    if (!info)
        return false;
    if (HelpersRequested && MasteryRequested && Practice::DevelopmentMastery::IsFelBargain(profile))
        return info->Id == 807942 && profile.Outcome == Practice::OutcomeKind::Healing;
    if (HelpersRequested && MasteryRequested && Practice::DevelopmentMastery::IsFrostSigil(profile))
    {
        auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
        auto entry = scripts.first;
        auto const* proc = sSpellMgr->GetSpellProcEntry(info->Id);
        auto const* helper = sSpellMgr->GetSpellInfo(807825);
        auto const* slow = sSpellMgr->GetSpellInfo(808022);
        if (info->Id != 805381 || entry == scripts.second || sObjectMgr->GetScriptName(entry->second) !=
            "aura_ascension_damage_palm_sigil" || ++entry != scripts.second ||
            info->SpellFamilyName != 38 || info->SpellFamilyFlags[0] != 67108864 ||
            info->SpellFamilyFlags[1] || info->SpellFamilyFlags[2] != 8192 ||
            info->SpellLevel != 34 || info->BaseLevel != 34 || info->MaxLevel ||
            info->GetDuration() != 6000 || info->CasterAuraSpell != 808089 ||
            info->ManaCost || info->ManaCostPercentage != 4 || info->RecoveryTime ||
            info->CategoryRecoveryTime || info->ProcFlags || info->ProcChance != 100 || info->ProcCharges ||
            !proc || proc->SchoolMask != SPELL_SCHOOL_MASK_MAGIC || proc->SpellFamilyName || proc->SpellFamilyMask ||
            proc->ProcFlags != 69972 || proc->SpellTypeMask != 1 || proc->SpellPhaseMask != 2 ||
            proc->HitMask != 3 || proc->AttributesMask != 2 || proc->DisableEffectsMask != 2 ||
            proc->ProcsPerMinute || proc->Chance != 100 || proc->Cooldown.count() || proc->Charges != 1 ||
            !helper || helper->DmgClass != SPELL_DAMAGE_CLASS_MAGIC ||
            helper->SchoolMask != SPELL_SCHOOL_MASK_FROST || !helper->AscensionInheritsResolvedAmount ||
            !helper->HasAttribute(SPELL_ATTR2_CANT_CRIT) ||
            !helper->HasAttribute(SPELL_ATTR3_IGNORE_CASTER_MODIFIERS) ||
            !helper->HasAttribute(SPELL_ATTR4_IGNORE_DAMAGE_TAKEN_MODIFIERS) ||
            !slow || slow->GetDuration() != 8000 || slow->ProcFlags || slow->ProcChance || slow->ProcCharges ||
            sSpellMgr->GetSpellProcEntry(807825) || sSpellMgr->GetSpellProcEntry(808022))
            return false;
        constexpr std::array rootEffects{ 6u, 6u, 0u };
        constexpr std::array rootAuras{ 354u, 42u, 0u };
        constexpr std::array rootTriggers{ 807825u, 808022u, 0u };
        constexpr std::array rootAmounts{ 29, 0, -1 };
        constexpr std::array damageEffects{ 2u, 64u, 0u };
        for (std::size_t slot = 0; slot < 3; ++slot)
        {
            auto const& effect = info->Effects[slot];
            auto const& damage = helper->Effects[slot];
            auto const& debuff = slow->Effects[slot];
            if (effect.Effect != rootEffects[slot] || effect.ApplyAuraName != rootAuras[slot] ||
                effect.TargetA.GetTarget() != (slot < 2 ? TARGET_UNIT_CASTER : 0u) || effect.TargetB.GetTarget() ||
                effect.TriggerSpell != rootTriggers[slot] || effect.BasePoints != rootAmounts[slot] ||
                effect.DieSides != (slot == 1 ? 0 : 1) || effect.RealPointsPerLevel ||
                effect.MiscValue || effect.MiscValueB || effect.SpellClassMask ||
                damage.Effect != damageEffects[slot] || damage.ApplyAuraName ||
                damage.TargetA.GetTarget() != (slot < 2 ? TARGET_UNIT_TARGET_ENEMY : 0u) ||
                damage.TargetB.GetTarget() || damage.TriggerSpell != (slot == 1 ? 808022u : 0u) ||
                damage.MiscValue != (slot == 1 ? 524287 : 0) || damage.MiscValueB || damage.RealPointsPerLevel ||
                damage.BasePoints != (slot == 2 ? -1 : 0) || damage.DieSides != (slot == 1 ? 0 : 1) ||
                damage.BonusMultiplier || damage.SpellClassMask ||
                debuff.Effect != (slot == 0 ? SPELL_EFFECT_APPLY_AURA : 0u) ||
                debuff.ApplyAuraName != (slot == 0 ? SPELL_AURA_MOD_DECREASE_SPEED : 0u) ||
                debuff.TargetA.GetTarget() != (slot == 0 ? TARGET_UNIT_TARGET_ENEMY : 0u) ||
                debuff.TargetB.GetTarget() || debuff.TriggerSpell || debuff.MiscValue || debuff.MiscValueB ||
                debuff.RealPointsPerLevel || debuff.SpellClassMask ||
                debuff.BasePoints != (slot == 0 ? -71 : slot == 2 ? -1 : 0) ||
                debuff.DieSides != (slot == 1 ? 0 : 1))
                return false;
        }
        return true;
    }
    if (HelpersRequested && Practice::DevelopmentHelpers::IsFireSigil(profile))
    {
        constexpr std::array levels{ 4u, 26u, 34u, 42u, 50u };
        constexpr std::array amounts{ 69, 79, 89, 99, 119 };
        auto const& ranks = Practice::DevelopmentHelpers::FireSigil;
        auto const rank = std::find_if(ranks.begin(), ranks.end(), [info](Practice::AbilityRank const& value)
        {
            return value.SpellId == info->Id;
        });
        if (rank == ranks.end())
            return false;
        auto const index = static_cast<std::size_t>(rank - ranks.begin());
        auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
        auto entry = scripts.first;
        auto const* proc = sSpellMgr->GetSpellProcEntry(info->Id);
        auto const* helper = sSpellMgr->GetSpellInfo(807012);
        if (entry == scripts.second || sObjectMgr->GetScriptName(entry->second) !=
            "aura_ascension_damage_palm_sigil" || ++entry != scripts.second ||
            info->SpellFamilyName != 38 || info->SpellFamilyFlags[0] != 67108864 ||
            info->SpellFamilyFlags[1] || info->SpellFamilyFlags[2] != 8192 ||
            info->SpellLevel != levels[index] || info->BaseLevel != levels[index] || info->MaxLevel ||
            info->GetDuration() != 6000 || info->CasterAuraSpell != 808089 ||
            info->ManaCost != 15 || info->ManaCostPercentage != 15 || info->RecoveryTime ||
            info->CategoryRecoveryTime || info->ProcFlags || info->ProcChance != 100 || info->ProcCharges ||
            !proc || proc->SchoolMask || proc->SpellFamilyName || proc->SpellFamilyMask ||
            proc->ProcFlags != 69972 || proc->SpellTypeMask != 1 || proc->SpellPhaseMask != 2 ||
            proc->HitMask != 3 || proc->AttributesMask != 2 || proc->DisableEffectsMask ||
            proc->ProcsPerMinute || proc->Chance != 100 || proc->Cooldown.count() || proc->Charges != 1 ||
            !helper || helper->DmgClass != SPELL_DAMAGE_CLASS_MELEE || helper->SchoolMask != SPELL_SCHOOL_MASK_FIRE ||
            !helper->AscensionInheritsResolvedAmount || !helper->HasAttribute(SPELL_ATTR2_CANT_CRIT) ||
            !helper->HasAttribute(SPELL_ATTR3_IGNORE_CASTER_MODIFIERS) ||
            !helper->HasAttribute(SPELL_ATTR4_IGNORE_DAMAGE_TAKEN_MODIFIERS))
            return false;
        for (std::size_t slot = 0; slot < 3; ++slot)
        {
            auto const& effect = info->Effects[slot];
            auto const& damage = helper->Effects[slot];
            if (effect.Effect != (slot ? 0u : SPELL_EFFECT_APPLY_AURA) ||
                effect.ApplyAuraName != (slot ? 0u : 354u) ||
                effect.TargetA.GetTarget() != (slot ? 0u : TARGET_UNIT_CASTER) || effect.TargetB.GetTarget() ||
                effect.TriggerSpell != (slot ? 0u : 807012u) ||
                effect.BasePoints != (slot ? 0 : amounts[index]) || effect.DieSides != (slot ? 0 : 1) ||
                effect.RealPointsPerLevel || effect.MiscValue || effect.MiscValueB ||
                damage.Effect != (slot ? 0u : SPELL_EFFECT_SCHOOL_DAMAGE) || damage.ApplyAuraName ||
                damage.TargetA.GetTarget() != (slot ? 0u : TARGET_UNIT_TARGET_ENEMY) ||
                damage.TargetB.GetTarget() || damage.TriggerSpell || damage.RealPointsPerLevel ||
                damage.MiscValue || damage.MiscValueB || damage.BonusMultiplier)
                return false;
        }
        return true;
    }
    if (HelpersRequested && Practice::DevelopmentHelpers::IsTwinSlice(profile))
    {
        auto const rank = std::find_if(Practice::DevelopmentHelpers::TwinSlice.begin(),
            Practice::DevelopmentHelpers::TwinSlice.end(), [info](Practice::AbilityRank const& value)
            {
                return value.SpellId == info->Id;
            });
        if (rank == Practice::DevelopmentHelpers::TwinSlice.end())
            return false;
        auto const index = std::distance(Practice::DevelopmentHelpers::TwinSlice.begin(), rank);
        auto const& helpers = Practice::DevelopmentHelpers::TwinDamageHelpers[index];
        for (std::size_t slot = 0; slot < 3; ++slot)
        {
            auto const& effect = info->Effects[slot];
            auto const expectedEffect = slot == 2 || index < 2 ? SPELL_EFFECT_TRIGGER_SPELL :
                SPELL_EFFECT_TRIGGER_SPELL_WITH_VALUE;
            if (effect.Effect != expectedEffect || effect.ApplyAuraName ||
                effect.TargetA.GetTarget() != TARGET_UNIT_TARGET_ENEMY || effect.TargetB.GetTarget() ||
                effect.TriggerSpell != (slot < 2 ? helpers[slot] : 800058u))
                return false;
            if (slot == 2)
                continue;
            SpellInfo const* helper = sSpellMgr->GetSpellInfo(helpers[slot]);
            if (!helper || helper->IsPassive() || helper->IsDeprecatedForPlayers)
                return false;
            for (std::size_t helperSlot = 0; helperSlot < 3; ++helperSlot)
            {
                auto const& value = helper->Effects[helperSlot];
                auto const expected = helperSlot == 0 ? SPELL_EFFECT_NORMALIZED_WEAPON_DMG :
                    helperSlot == 1 && index < 2 ? SPELL_EFFECT_WEAPON_PERCENT_DAMAGE : 0u;
                if (value.Effect != expected || value.ApplyAuraName || value.TriggerSpell ||
                    value.TargetA.GetTarget() != (helperSlot == 0 ? TARGET_UNIT_TARGET_ENEMY : 0u) ||
                    value.TargetB.GetTarget())
                    return false;
            }
        }
        return true;
    }
    if (BuffContributionRequested && Practice::DevelopmentBuffs::IsSupportedStatBuff(profile))
    {
        if (profile.Definition.ClassId == 30 && (profile.Definition.AbilityId == 575839 ||
            profile.Definition.AbilityId == 578126 || profile.Definition.AbilityId == 800198))
        {
            auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
            if (info->SpellFamilyName != 36 || scripts.first != scripts.second || !HasExpectedRiteGroup(info->Id))
                return false;
        }
        if (Practice::DevelopmentBuffs::IsCultistWhispers(profile))
        {
            auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
            auto entry = scripts.first;
            if (entry == scripts.second || sObjectMgr->GetScriptName(entry->second) !=
                "aura_ascension_cultist_lifecycle")
                return false;
            if (++entry != scripts.second)
                return false;
        }
        if (profile.Definition.ClassId == 32 && profile.Definition.AbilityId == 561237)
        {
            auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
            if (info->SpellFamilyName != 38 || info->SpellFamilyFlags[0] ||
                info->SpellFamilyFlags[1] || info->SpellFamilyFlags[2] != 2048 ||
                scripts.first != scripts.second || !HasExpectedEtchingGroup(561237, info->Id))
                return false;
        }
        if (Practice::DevelopmentBuffs::IsLeylineInscription(profile))
        {
            constexpr std::array spells{ 561260u, 561261u, 561262u, 561263u };
            constexpr std::array levels{ 16u, 28u, 40u, 52u };
            constexpr std::array damageTaken{ 14, 29, 49, 74 };
            constexpr std::array healingReceived{ 15, 31, 52, 79 };
            auto const rank = std::find(spells.begin(), spells.end(), info->Id);
            auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
            auto const groups = sSpellMgr->GetSpellSpellGroupMapBounds(info->Id);
            auto const& vulnerability = info->Effects[EFFECT_0];
            if (rank == spells.end() || info->SpellFamilyName != 38 || info->SpellFamilyFlags ||
                scripts.first != scripts.second || groups.first != groups.second ||
                info->GetDuration() != 1800000 || info->ProcFlags || info->ProcChance != 10 ||
                info->ProcCharges || sSpellMgr->GetSpellProcEntry(info->Id) ||
                info->ManaCostPercentage != 7 || info->EquippedItemClass != -1 ||
                info->EquippedItemSubClassMask || info->EquippedItemInventoryTypeMask ||
                vulnerability.Effect != SPELL_EFFECT_APPLY_AURA ||
                vulnerability.ApplyAuraName != SPELL_AURA_MOD_DAMAGE_TAKEN ||
                vulnerability.TargetA.GetTarget() != TARGET_UNIT_TARGET_RAID ||
                vulnerability.TargetB.GetTarget() || vulnerability.TriggerSpell || vulnerability.MiscValue != 126)
                return false;
            auto const index = static_cast<std::size_t>(rank - spells.begin());
            if (info->SpellLevel != levels[index] || info->BaseLevel != levels[index] || info->MaxLevel ||
                vulnerability.BasePoints != damageTaken[index] ||
                info->Effects[EFFECT_1].BasePoints != healingReceived[index] ||
                info->Effects[EFFECT_2].BasePoints != -1)
                return false;
            for (auto const& effect : info->Effects)
                if (effect.DieSides != 1 || effect.RealPointsPerLevel || effect.MiscValueB || effect.SpellClassMask)
                    return false;
        }
        if (Practice::DevelopmentBuffs::IsTemporalResilience(profile))
        {
            constexpr std::array spells{ 680389u, 536258u, 536259u, 536260u, 536261u, 536262u, 536263u };
            constexpr std::array levels{ 2u, 10u, 20u, 32u, 42u, 50u, 60u };
            constexpr std::array maximumLevels{ 8u, 18u, 30u, 40u, 48u, 58u, 60u };
            constexpr std::array armor{ 49, 109, 199, 269, 359, 469, 759 };
            auto const rank = std::find(spells.begin(), spells.end(), info->Id);
            auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
            auto const groups = sSpellMgr->GetSpellSpellGroupMapBounds(info->Id);
            auto const& proc = info->Effects[EFFECT_1];
            if (rank == spells.end() || info->SpellFamilyName != 28 || info->SpellFamilyFlags[0] ||
                info->SpellFamilyFlags[1] || info->SpellFamilyFlags[2] != 67108864 ||
                scripts.first != scripts.second || groups.first != groups.second ||
                info->GetDuration() != 1800000 || info->ProcFlags || info->ProcChance != 100 ||
                info->ProcCharges || sSpellMgr->GetSpellProcEntry(info->Id) ||
                proc.Effect != SPELL_EFFECT_APPLY_AURA || proc.ApplyAuraName != SPELL_AURA_PROC_TRIGGER_SPELL ||
                proc.TargetA.GetTarget() != TARGET_UNIT_CASTER || proc.TargetB.GetTarget() ||
                proc.TriggerSpell != 536265 || proc.MiscValue || proc.BasePoints ||
                info->ManaCostPercentage != 24)
                return false;
            auto const index = static_cast<std::size_t>(rank - spells.begin());
            if (info->SpellLevel != levels[index] || info->BaseLevel != levels[index] ||
                info->MaxLevel != maximumLevels[index] || info->Effects[EFFECT_0].BasePoints != armor[index])
                return false;
            for (std::size_t slot = 0; slot < 3; ++slot)
                if (info->Effects[slot].DieSides != (slot == 1 ? 0 : 1) ||
                    info->Effects[slot].RealPointsPerLevel || info->Effects[slot].MiscValueB ||
                    info->Effects[slot].SpellClassMask)
                    return false;
        }
        if (Practice::DevelopmentBuffs::IsFrostTattoo(profile))
        {
            constexpr std::array<std::int32_t, 6> tattoos{ 801094, 801106, 801107, 802630, 803748, 807834 };
            constexpr std::array spells{ 807834u, 807835u, 807836u, 807837u, 807838u, 807839u };
            constexpr std::array levels{ 10u, 22u, 34u, 46u, 58u, 70u };
            auto const rank = std::find(spells.begin(), spells.end(), info->Id);
            auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
            auto const& proc = info->Effects[EFFECT_1];
            if (rank == spells.end() || info->SpellFamilyName != 38 || info->SpellFamilyFlags[0] != 4 ||
                info->SpellFamilyFlags[1] || info->SpellFamilyFlags[2] || scripts.first != scripts.second ||
                info->GetDuration() != -1 || info->ProcFlags || info->ProcChance != 100 || info->ProcCharges ||
                sSpellMgr->GetSpellProcEntry(info->Id) ||
                !HasExactBuffGroup(info->Id, 111001, SPELL_GROUP_STACK_RULE_EXCLUSIVE, tattoos))
                return false;
            auto const index = static_cast<std::size_t>(rank - spells.begin());
            if (info->SpellLevel != levels[index] || info->BaseLevel != levels[index] || info->MaxLevel ||
                info->Effects[EFFECT_0].BasePoints != 4 + 5 * static_cast<std::int32_t>(index) ||
                info->Effects[EFFECT_0].DieSides != 1 ||
                proc.Effect != SPELL_EFFECT_APPLY_AURA || proc.ApplyAuraName != SPELL_AURA_PROC_TRIGGER_SPELL ||
                proc.TargetA.GetTarget() != TARGET_UNIT_CASTER || proc.TargetB.GetTarget() ||
                proc.TriggerSpell != 707731 || proc.BasePoints || proc.DieSides || proc.MiscValue)
                return false;
            for (auto const& effect : info->Effects)
                if (effect.RealPointsPerLevel || effect.MiscValueB || effect.SpellClassMask)
                    return false;
        }
        if (Practice::DevelopmentBuffs::IsArcaneTattoo(profile))
        {
            constexpr std::array<std::int32_t, 6> tattoos{ 801094, 801106, 801107, 802630, 803748, 807834 };
            constexpr std::array spells{ 803748u, 803759u, 803760u, 803761u, 803762u, 803763u };
            constexpr std::array levels{ 20u, 32u, 44u, 56u, 60u, 76u };
            auto const rank = std::find(spells.begin(), spells.end(), info->Id);
            auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
            if (rank == spells.end() || info->SpellFamilyName != 38 || info->SpellFamilyFlags[0] != 4 ||
                info->SpellFamilyFlags[1] || info->SpellFamilyFlags[2] || scripts.first != scripts.second ||
                info->GetDuration() != -1 ||
                !HasExactBuffGroup(info->Id, 111001, SPELL_GROUP_STACK_RULE_EXCLUSIVE, tattoos))
                return false;
            auto const index = static_cast<std::size_t>(rank - spells.begin());
            if (info->SpellLevel != levels[index] || info->BaseLevel != levels[index] || info->MaxLevel ||
                info->Effects[EFFECT_0].BasePoints != 4 + 5 * static_cast<std::int32_t>(index) ||
                info->Effects[EFFECT_1].BasePoints != -21 || info->Effects[EFFECT_2].BasePoints != -21)
                return false;
            for (auto const& effect : info->Effects)
                if (effect.DieSides != 1 || effect.RealPointsPerLevel || effect.MiscValueB || effect.SpellClassMask)
                    return false;
        }
        if (Practice::DevelopmentBuffs::IsFireTattoo(profile))
        {
            constexpr std::array<std::int32_t, 6> tattoos{ 801094, 801106, 801107, 802630, 803748, 807834 };
            constexpr std::array spells{ 801106u, 803749u, 803750u, 803751u, 803752u, 803753u };
            constexpr std::array levels{ 24u, 36u, 48u, 58u, 60u, 76u };
            auto const rank = std::find(spells.begin(), spells.end(), info->Id);
            auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
            if (rank == spells.end() || info->SpellFamilyName != 38 || info->SpellFamilyFlags[0] != 4 ||
                info->SpellFamilyFlags[1] || info->SpellFamilyFlags[2] || scripts.first != scripts.second ||
                info->GetDuration() != -1 ||
                !HasExactBuffGroup(info->Id, 111001, SPELL_GROUP_STACK_RULE_EXCLUSIVE, tattoos))
                return false;
            auto const index = static_cast<std::size_t>(rank - spells.begin());
            if (info->SpellLevel != levels[index] || info->BaseLevel != levels[index] || info->MaxLevel ||
                info->Effects[EFFECT_0].BasePoints != 4 + 5 * static_cast<std::int32_t>(index) ||
                info->Effects[EFFECT_1].BasePoints != 14)
                return false;
            for (auto const& effect : info->Effects)
                if (effect.DieSides != 1 || effect.RealPointsPerLevel || effect.MiscValueB)
                    return false;
            auto const& modifier = info->Effects[EFFECT_2];
            if (modifier.Effect != SPELL_EFFECT_APPLY_AURA || modifier.ApplyAuraName != SPELL_AURA_ADD_FLAT_MODIFIER ||
                modifier.TargetA.GetTarget() != 1 || modifier.TargetB.GetTarget() || modifier.TriggerSpell ||
                modifier.MiscValue != 17 || modifier.BasePoints != -1 ||
                modifier.SpellClassMask != flag96(0, 0, 65536))
                return false;
        }
        if (Practice::DevelopmentBuffs::IsWhirlwindAegis(profile))
        {
            constexpr std::array<std::int32_t, 3> aegis{ 680282, 680316, 680334 };
            constexpr std::array spells{ 680282u, 680590u, 680591u, 680592u, 680593u, 680594u };
            constexpr std::array levels{ 4u, 12u, 22u, 32u, 42u, 52u };
            constexpr std::array maximumLevels{ 12u, 22u, 32u, 42u, 52u, 60u };
            constexpr std::array armor{ 59, 129, 224, 329, 444, 559 };
            auto const rank = std::find(spells.begin(), spells.end(), info->Id);
            auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
            if (rank == spells.end() || info->SpellFamilyName != 22 || info->SpellFamilyFlags[0] != 8 ||
                info->SpellFamilyFlags[1] || info->SpellFamilyFlags[2] || scripts.first != scripts.second ||
                info->GetDuration() != 1800000 ||
                !HasExactBuffGroup(info->Id, 111010, SPELL_GROUP_STACK_RULE_EXCLUSIVE_FROM_SAME_CASTER, aegis))
                return false;
            auto const index = static_cast<std::size_t>(rank - spells.begin());
            if (info->SpellLevel != levels[index] || info->BaseLevel != levels[index] ||
                info->MaxLevel != maximumLevels[index] || info->Effects[EFFECT_0].BasePoints != armor[index] ||
                info->Effects[EFFECT_1].BasePoints != 2)
                return false;
            for (auto const& effect : info->Effects)
                if (effect.DieSides != 1 || effect.RealPointsPerLevel || effect.MiscValueB)
                    return false;
        }
        if (Practice::DevelopmentBuffs::IsVoidResilience(profile))
        {
            constexpr std::array spells{ 1119881u, 1119889u, 1119892u };
            constexpr std::array levels{ 28u, 38u, 48u };
            constexpr std::array amounts{ 29, 44, 59 };
            auto const rank = std::find(spells.begin(), spells.end(), info->Id);
            auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
            auto const groups = sSpellMgr->GetSpellSpellGroupMapBounds(info->Id);
            if (rank == spells.end() || info->SpellFamilyName != 31 || info->SpellFamilyFlags[0] ||
                info->SpellFamilyFlags[1] || info->SpellFamilyFlags[2] || scripts.first != scripts.second ||
                groups.first != groups.second || info->GetDuration() != -1)
                return false;
            auto const index = static_cast<std::size_t>(rank - spells.begin());
            if (info->SpellLevel != levels[index] || info->BaseLevel != levels[index] || info->MaxLevel ||
                info->Effects[EFFECT_0].BasePoints != amounts[index] ||
                info->Effects[EFFECT_0].DieSides != 1 || info->Effects[EFFECT_0].RealPointsPerLevel ||
                info->Effects[EFFECT_0].MiscValueB)
                return false;
        }
        if (Practice::DevelopmentBuffs::IsWaterTattoo(profile))
        {
            constexpr std::array<std::int32_t, 6> tattoos{ 801094, 801106, 801107, 802630, 803748, 807834 };
            constexpr std::array spells{ 801107u, 803783u, 803784u, 803785u };
            constexpr std::array regeneration{ 9, 42, 99, 145 };
            constexpr std::array levels{ 12u, 24u, 36u, 48u };
            constexpr std::array maximumLevels{ 22u, 34u, 46u, 60u };
            auto const rank = std::find(spells.begin(), spells.end(), info->Id);
            auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
            if (rank == spells.end() || info->SpellFamilyName != 38 ||
                info->SpellFamilyFlags[0] != 2097152 || info->SpellFamilyFlags[1] || info->SpellFamilyFlags[2] ||
                scripts.first != scripts.second ||
                !HasExactBuffGroup(info->Id, 111001, SPELL_GROUP_STACK_RULE_EXCLUSIVE, tattoos))
                return false;
            auto const index = static_cast<std::size_t>(rank - spells.begin());
            if (info->SpellLevel != levels[index] || info->BaseLevel != levels[index] ||
                info->MaxLevel != maximumLevels[index] ||
                info->Effects[EFFECT_1].SpellClassMask != flag96(2097152, 2147483648u, 2) ||
                info->Effects[EFFECT_0].BasePoints != regeneration[index] ||
                info->Effects[EFFECT_0].RealPointsPerLevel != 3.3f || info->Effects[EFFECT_0].DieSides != 1 ||
                info->Effects[EFFECT_1].BasePoints != -6 - 5 * static_cast<std::int32_t>(index) ||
                info->Effects[EFFECT_1].DieSides != 1 || info->Effects[EFFECT_1].RealPointsPerLevel)
                return false;
            auto const& modifier = info->Effects[EFFECT_2];
            if (modifier.Effect != SPELL_EFFECT_APPLY_AURA || modifier.ApplyAuraName != SPELL_AURA_ADD_FLAT_MODIFIER ||
                modifier.TargetA.GetTarget() != 1 || modifier.TargetB.GetTarget() || modifier.TriggerSpell ||
                modifier.MiscValue != 12 || modifier.MiscValueB || modifier.BasePoints != -1 || modifier.DieSides != 1 ||
                modifier.RealPointsPerLevel || modifier.SpellClassMask != flag96(0, 0, 1024))
                return false;
        }
        if (profile.Definition.ClassId == 32 && profile.Definition.AbilityId == 801094)
        {
            constexpr std::array<std::int32_t, 6> tattoos{ 801094, 801106, 801107, 802630, 803748, 807834 };
            auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
            if (info->SpellFamilyName != 38 || info->SpellFamilyFlags[0] != 1024 ||
                info->SpellFamilyFlags[1] || info->SpellFamilyFlags[2] != 16386 ||
                scripts.first != scripts.second ||
                !HasExactBuffGroup(info->Id, 111001, SPELL_GROUP_STACK_RULE_EXCLUSIVE, tattoos))
                return false;
        }
        if (IsArmorOrEdictProfile(profile))
        {
            auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
            auto entry = scripts.first;
            std::uint32_t const classId = profile.Definition.ClassId;
            if (info->SpellFamilyName != classId + 6 ||
                info->SpellFamilyFlags[0] != (classId == 14 ? 512u : 0u) ||
                info->SpellFamilyFlags[1] != (classId == 29 ? 4096u : 0u) ||
                info->SpellFamilyFlags[2] != (classId == 15 ? 536870912u : 0u) ||
                !HasExpectedArmorOrEdictGroup(profile.Definition.AbilityId, info->Id))
                return false;
            if (classId == 15)
            {
                if (entry == scripts.second ||
                    sObjectMgr->GetScriptName(entry->second) != "spell_ascension_witch_hunter_ability" ||
                    ++entry != scripts.second)
                    return false;
            }
            else if (entry != scripts.second)
                return false;
        }
        if (Practice::DevelopmentBuffs::IsDevotionOfGrace(profile))
        {
            auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
            auto entry = scripts.first;
            if (info->SpellFamilyName != 33 || info->SpellFamilyFlags[0] ||
                info->SpellFamilyFlags[1] != 32768u || info->SpellFamilyFlags[2] || entry == scripts.second ||
                sObjectMgr->GetScriptName(entry->second) != "aura_ascension_sun_cleric_lifecycle")
                return false;
            if (++entry != scripts.second)
                return false;
        }
        if (Practice::DevelopmentBuffs::IsRangerAdaptation(profile))
        {
            auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
            if (info->SpellFamilyName != 27 || info->SpellFamilyFlags[0] || info->SpellFamilyFlags[1] ||
                info->SpellFamilyFlags[2] != (info->Id == 800266 ? 0u : 512u) ||
                scripts.first != scripts.second ||
                !HasExpectedAdaptationGroup(profile.Definition.AbilityId, info->Id))
                return false;
        }
        if (profile.Definition.ClassId == 31 && (profile.Definition.AbilityId == 570752 ||
            profile.Definition.AbilityId == 572810 || profile.Definition.AbilityId == 800197))
        {
            auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
            if (info->SpellFamilyName != 37 || scripts.first != scripts.second ||
                !HasExpectedGeomancerGroup(profile.Definition.AbilityId, info->Id))
                return false;
        }
        if (Practice::DevelopmentBuffs::IsXorothMark(profile))
        {
            auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
            auto entry = scripts.first;
            if (info->SpellFamilyName != 23 || info->SpellFamilyFlags[0] ||
                info->SpellFamilyFlags[1] != 2147483648u || info->SpellFamilyFlags[2] || entry == scripts.second ||
                sObjectMgr->GetScriptName(entry->second) != "aura_ascension_xoroth_lifecycle")
                return false;
            if (++entry != scripts.second)
                return false;
        }
        if (Practice::DevelopmentBuffs::IsSpiritWuju(profile) || Practice::DevelopmentBuffs::IsPowerWuju(profile))
        {
            auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
            auto entry = scripts.first;
            bool const powerWuju = Practice::DevelopmentBuffs::IsPowerWuju(profile);
            if (info->SpellFamilyName != 19 || info->SpellFamilyFlags[0] != (powerWuju ? 0u : 256u) ||
                info->SpellFamilyFlags[1] || info->SpellFamilyFlags[2] != (powerWuju ? 16777216u : 0u) ||
                entry == scripts.second ||
                sObjectMgr->GetScriptName(entry->second) != "aura_ascension_witch_doctor_lifecycle")
                return false;
            if (++entry != scripts.second)
                return false;
        }
        if (Practice::DevelopmentBuffs::IsPowerModule(profile) || Practice::DevelopmentBuffs::IsManaModule(profile))
        {
            auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
            auto entry = scripts.first;
            if (info->SpellFamilyName != 34 || info->SpellFamilyFlags[0] != 524288 ||
                info->SpellFamilyFlags[1] || info->SpellFamilyFlags[2] || !HasExpectedModuleGroup(info->Id) ||
                entry == scripts.second ||
                sObjectMgr->GetScriptName(entry->second) != "aura_ascension_tinker_lifecycle")
                return false;
            if (++entry != scripts.second)
                return false;
        }
        if (Practice::DevelopmentBuffs::IsManaModule(profile))
        {
            constexpr std::array spells{ 803658u, 803659u, 803660u, 803661u, 803662u, 803663u, 803664u };
            constexpr std::array regeneration{ 9, 14, 19, 24, 29, 32, 40 };
            auto const rank = std::find(spells.begin(), spells.end(), info->Id);
            auto const& slot = info->Effects[EFFECT_2];
            if (rank == spells.end() || info->Effects[EFFECT_0].BasePoints !=
                regeneration[static_cast<std::size_t>(rank - spells.begin())] ||
                info->Effects[EFFECT_0].DieSides != 1 || info->Effects[EFFECT_0].RealPointsPerLevel ||
                slot.Effect != 168 || slot.ApplyAuraName || slot.TargetA.GetTarget() != 1 ||
                slot.TargetB.GetTarget() || slot.TriggerSpell || slot.MiscValue != 117151 || slot.MiscValueB ||
                slot.BasePoints != -1 || slot.DieSides != 1 || slot.RealPointsPerLevel)
                return false;
        }
        auto const effectIndex = Practice::DevelopmentBuffs::EffectIndex(profile);
        if (effectIndex >= 3)
            return false;
        for (std::size_t index = 0; index < 3; ++index)
        {
            auto const& slot = info->Effects[index];
            if ((Practice::DevelopmentBuffs::IsFrostTattoo(profile) ||
                Practice::DevelopmentBuffs::IsTemporalResilience(profile)) && index == EFFECT_1)
                continue;
            if (Practice::DevelopmentBuffs::IsLeylineInscription(profile) && index == EFFECT_0)
                continue;
            auto const* secondary = Practice::DevelopmentBuffs::SecondaryMechanicFor(profile, index);
            if (secondary && index == secondary->EffectIndex)
            {
                bool const graceCost = Practice::DevelopmentBuffs::IsDevotionOfGrace(profile) && index == 1;
                bool const waterCost = Practice::DevelopmentBuffs::IsWaterTattoo(profile) && index == 1;
                bool const arcaneDuration = Practice::DevelopmentBuffs::IsArcaneTattoo(profile) &&
                    (index == 1 || index == 2);
                if (slot.Effect != SPELL_EFFECT_APPLY_AURA || slot.ApplyAuraName != secondary->Aura ||
                    slot.TargetA.GetTarget() != secondary->TargetA || slot.TargetB.GetTarget() ||
                    slot.TriggerSpell || slot.MiscValue != secondary->Stat || slot.MiscValueB ||
                    (graceCost ? (slot.BasePoints != -6 || slot.DieSides != 1) :
                        waterCost ? (slot.BasePoints >= -1 || slot.DieSides != 1) :
                            arcaneDuration ? (slot.BasePoints != -21 || slot.DieSides != 1) : slot.BasePoints < 0))
                    return false;
                continue;
            }
            if ((Practice::DevelopmentBuffs::IsWaterTattoo(profile) ||
                Practice::DevelopmentBuffs::IsFireTattoo(profile) ||
                Practice::DevelopmentBuffs::IsManaModule(profile)) && index == 2)
                continue;
            if (Practice::DevelopmentBuffs::IsPairedAttackPower(profile) && index == 1)
            {
                bool const finalPowerWuju = Practice::DevelopmentBuffs::IsPowerWuju(profile) && info->Id == 707677;
                if (slot.Effect != SPELL_EFFECT_APPLY_AURA || slot.ApplyAuraName != SPELL_AURA_MOD_RANGED_ATTACK_POWER ||
                    slot.TargetA.GetTarget() != Practice::DevelopmentBuffs::RangedTarget(profile, info->Id) ||
                    slot.TargetB.GetTarget() || slot.TriggerSpell || slot.MiscValue ||
                    (finalPowerWuju ? (slot.BasePoints != 231 || info->Effects[EFFECT_0].BasePoints != 305 ||
                        slot.DieSides != 1 || info->Effects[EFFECT_0].DieSides != 1) :
                        (slot.BasePoints != info->Effects[EFFECT_0].BasePoints ||
                            slot.DieSides != info->Effects[EFFECT_0].DieSides)))
                    return false;
                continue;
            }
            auto const primaryEffect = Practice::DevelopmentBuffs::IsVoidResilience(profile) ?
                SPELL_EFFECT_APPLY_AREA_AURA_RAID : SPELL_EFFECT_APPLY_AURA;
            if (slot.Effect != (index == effectIndex ? primaryEffect : 0u) ||
                slot.ApplyAuraName != (index == effectIndex ? Practice::DevelopmentBuffs::Aura(profile) : 0u) ||
                slot.TargetA.GetTarget() != (index == effectIndex ? Practice::DevelopmentBuffs::Target(profile) : 0u) ||
                slot.TargetB.GetTarget() || slot.TriggerSpell ||
                slot.MiscValue != (index == effectIndex ? Practice::DevelopmentBuffs::StatSelector(profile, info->Id) : 0))
                return false;
        }
        return true;
    }
    if (DirectLeechRequested && Practice::DevelopmentLeech::IsBloodbolt(profile))
        return info->Effects[EFFECT_0].Effect == SPELL_EFFECT_HEALTH_LEECH &&
            !info->Effects[EFFECT_0].TriggerSpell &&
            info->Effects[EFFECT_1].Effect == SPELL_EFFECT_APPLY_AURA &&
            info->Effects[EFFECT_1].ApplyAuraName == SPELL_AURA_MOD_HEALING_PCT &&
            !info->Effects[EFFECT_1].TriggerSpell && !info->Effects[EFFECT_2].Effect;
    if (DirectLeechRequested && Practice::DevelopmentLeech::IsRavenousStrike(profile))
    {
        constexpr std::array<std::uint32_t, 3> effects = {
            SPELL_EFFECT_HEALTH_LEECH, SPELL_EFFECT_TRIGGER_SPELL_WITH_VALUE, 0u
        };
        constexpr std::array<std::uint32_t, 3> targets = {
            TARGET_UNIT_TARGET_ENEMY, TARGET_UNIT_TARGET_ENEMY, 0u
        };
        constexpr std::array triggers = { 0u, 805352u, 0u };
        for (std::size_t index = 0; index < effects.size(); ++index)
        {
            auto const& slot = info->Effects[index];
            if (slot.Effect != effects[index] || slot.ApplyAuraName || slot.TargetA.GetTarget() != targets[index] ||
                slot.TargetB.GetTarget() || slot.TriggerSpell != triggers[index])
                return false;
        }
        SpellInfo const* helper = sSpellMgr->GetSpellInfo(805352);
        if (!helper || helper->IsPassive() || helper->IsDeprecatedForPlayers)
            return false;
        for (std::size_t index = 0; index < effects.size(); ++index)
        {
            auto const& slot = helper->Effects[index];
            if (slot.Effect != (index == 0 ? SPELL_EFFECT_ENERGIZE : 0u) || slot.ApplyAuraName ||
                slot.TargetA.GetTarget() != (index == 0 ? TARGET_UNIT_CASTER : 0u) ||
                slot.TargetB.GetTarget() || slot.TriggerSpell)
                return false;
        }
        return true;
    }
    if (DirectLeechRequested && Practice::DevelopmentLeech::IsTitanstrike(profile))
    {
        constexpr std::array<std::uint32_t, 3> effects = {
            SPELL_EFFECT_HEALTH_LEECH, SPELL_EFFECT_TRIGGER_SPELL, 0u
        };
        constexpr std::array<std::uint32_t, 3> targets = {
            TARGET_UNIT_TARGET_ENEMY, TARGET_UNIT_TARGET_ENEMY, 0u
        };
        constexpr std::array triggers = { 0u, 707896u, 0u };
        for (std::size_t index = 0; index < effects.size(); ++index)
        {
            auto const& slot = info->Effects[index];
            if (slot.Effect != effects[index] || slot.ApplyAuraName || slot.TargetA.GetTarget() != targets[index] ||
                slot.TargetB.GetTarget() || slot.TriggerSpell != triggers[index])
                return false;
        }
        SpellInfo const* helper = sSpellMgr->GetSpellInfo(707896);
        if (!helper || helper->IsPassive() || helper->IsDeprecatedForPlayers)
            return false;
        constexpr std::array auraIds = { 704576u, 706426u, 0u };
        for (std::size_t index = 0; index < auraIds.size(); ++index)
        {
            auto const& slot = helper->Effects[index];
            if (slot.Effect != (index < 2 ? SPELL_EFFECT_ASCENSION_MODIFY_AURA_DURATION : 0u) ||
                slot.ApplyAuraName || slot.TargetA.GetTarget() != (index < 2 ? TARGET_UNIT_CASTER : 0u) ||
                slot.TargetB.GetTarget() || slot.TriggerSpell != auraIds[index] ||
                slot.MiscValue != static_cast<std::int32_t>(auraIds[index]) ||
                (index < 2 && slot.BasePoints != 2999))
                return false;
            if (index < 2)
            {
                SpellInfo const* aura = sSpellMgr->GetSpellInfo(auraIds[index]);
                if (!aura || aura->IsPassive() || aura->IsDeprecatedForPlayers ||
                    !aura->HasEffect(SPELL_EFFECT_APPLY_AURA))
                    return false;
            }
        }
        return true;
    }
    if (HelpersRequested && MasteryRequested && Practice::DevelopmentMastery::IsBaneOfBetrayal(profile))
    {
        SpellInfo const* helper = sSpellMgr->GetSpellInfo(807554);
        auto const& root = info->Effects;
        return info->Id == 712483 && info->GetDuration() == 30000 && info->StackAmount == 30 &&
            root[EFFECT_0].Effect == SPELL_EFFECT_APPLY_AURA &&
            root[EFFECT_0].ApplyAuraName == SPELL_AURA_DUMMY &&
            root[EFFECT_0].TargetA.GetTarget() == TARGET_UNIT_TARGET_ENEMY &&
            !root[EFFECT_0].TargetB.GetTarget() && !root[EFFECT_0].TriggerSpell &&
            !root[EFFECT_1].Effect && !root[EFFECT_2].Effect && helper &&
            helper->Effects[EFFECT_0].Effect == SPELL_EFFECT_SCHOOL_DAMAGE &&
            helper->Effects[EFFECT_0].TargetA.GetTarget() == TARGET_UNIT_TARGET_ENEMY &&
            !helper->Effects[EFFECT_0].TargetB.GetTarget() &&
            !helper->Effects[EFFECT_0].TriggerSpell && !helper->Effects[EFFECT_1].Effect &&
            !helper->Effects[EFFECT_2].Effect;
    }
    return HelpersRequested && Practice::DevelopmentHelpers::IsManafeed(profile) &&
        info->Effects[EFFECT_0].Effect == SPELL_EFFECT_APPLY_AURA &&
        info->Effects[EFFECT_0].ApplyAuraName == SPELL_AURA_PERIODIC_DUMMY;
}

bool MatchesAdditionalMasteryMechanic(SpellInfo const* info, Practice::AbilityProfile const& profile)
{
    if (Practice::DevelopmentMastery::IsFelBargain(profile))
    {
        if (!HelpersRequested || !MasteryRequested || !info || info->Id != 807942 ||
            info->SpellFamilyName != 20 || info->IsPassive() || info->RecoveryTime != 180000)
            return false;
        for (std::size_t index = 0; index < 3; ++index)
        {
            auto const& effect = info->Effects[index];
            if (effect.Effect != (index == 0 ? SPELL_EFFECT_DUMMY : 0u) || effect.ApplyAuraName ||
                effect.TriggerSpell || effect.TargetB.GetTarget() ||
                effect.TargetA.GetTarget() != (index == 0 ? TARGET_UNIT_CASTER : 0u))
                return false;
        }
        auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
        auto entry = scripts.first;
        if (entry == scripts.second || sObjectMgr->GetScriptName(entry->second) !=
            "spell_ascension_felsworn_ability")
            return false;
        return ++entry == scripts.second;
    }
    if (Practice::DevelopmentMastery::IsSoulCapture(profile))
    {
        if (!HelpersRequested || !MasteryRequested || !info || info->Id != 561289)
            return false;
        constexpr std::array effects = { 64u, 64u, 136u };
        constexpr std::array targets = { 93u, 93u, 1u };
        constexpr std::array triggers = { 572887u, 500363u, 0u };
        for (std::size_t index = 0; index < effects.size(); ++index)
            if (info->Effects[index].Effect != effects[index] || info->Effects[index].ApplyAuraName ||
                info->Effects[index].TargetA.GetTarget() != targets[index] ||
                info->Effects[index].TargetB.GetTarget() || info->Effects[index].TriggerSpell != triggers[index])
                return false;
        auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
        auto entry = scripts.first;
        if (entry == scripts.second || sObjectMgr->GetScriptName(entry->second) != "spell_ascension_soul_capture")
            return false;
        return ++entry == scripts.second && info->Effects[EFFECT_2].BasePoints == 9;
    }
    auto const& ability = profile.Definition;
    if (ability.Kind != Practice::AbilityKind::Mastery ||
        (ability.AbilityId != 680515 && ability.AbilityId != 500126))
        return true;
    if (!info || info->Id != ability.AbilityId || profile.Outcome != Practice::OutcomeKind::Damage)
        return false;
    auto const& effects = info->Effects;
    if (ability.AbilityId == 680515)
    {
        SpellInfo const* helper = sSpellMgr->GetSpellInfo(582588);
        return ability.ClassId == 15 && effects[EFFECT_0].Effect == SPELL_EFFECT_NORMALIZED_WEAPON_DMG &&
            effects[EFFECT_1].Effect == SPELL_EFFECT_TRIGGER_SPELL && effects[EFFECT_1].TriggerSpell == 582588 &&
            effects[EFFECT_2].Effect == SPELL_EFFECT_THREAT && helper &&
            helper->Effects[EFFECT_0].Effect == SPELL_EFFECT_APPLY_AURA &&
            helper->Effects[EFFECT_0].ApplyAuraName == SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN &&
            helper->Effects[EFFECT_1].Effect == SPELL_EFFECT_APPLY_AURA &&
            helper->Effects[EFFECT_1].ApplyAuraName == SPELL_AURA_MOD_DAMAGE_FROM_CASTER &&
            !helper->Effects[EFFECT_2].Effect;
    }
    SpellInfo const* helper = sSpellMgr->GetSpellInfo(804864);
    return ability.ClassId == 20 && effects[EFFECT_0].Effect == SPELL_EFFECT_JUMP_DEST &&
        effects[EFFECT_1].Effect == SPELL_EFFECT_SCHOOL_DAMAGE && effects[EFFECT_2].Effect == 178 &&
        effects[EFFECT_2].TriggerSpell == 50259 && helper &&
        helper->Effects[EFFECT_0].Effect == SPELL_EFFECT_ENERGIZE &&
        !helper->Effects[EFFECT_1].Effect && !helper->Effects[EFFECT_2].Effect;
}

bool MatchesNativeClassGrant(Practice::AbilityProfile const& profile)
{
    if (auto const* previous = PreviousRankCapProfile(profile))
        return MatchesNativeClassGrant(*previous);
    Practice::AbilityDefinition const& ability = profile.Definition;
    if (profile.Acquisition != Practice::AcquisitionSource::ClassGrant || ability.Ranks.empty())
        return false;
    if (auto const* extension = TrainerRankExtensionEntry(profile))
    {
        if (!TrainerRanksRequested || !SameProfile(profile, extension->Profile))
            return false;
        Practice::AbilityProfile const prefix{
            Practice::DevelopmentPacing::PreviousDefinitionVersion, Practice::AcquisitionSource::ClassGrant,
            { ability.ClassId, ability.AbilityId, Practice::AbilityKind::Ranked,
                extension->PreviousRanks, extension->PreviousCaps },
            Practice::DevelopmentPacing::PreviousPolicy, profile.Outcome };
        if (!MatchesNativeClassGrant(prefix))
            return false;
        auto const& trainers = sObjectMgr->GetTrainers();
        for (auto const& rank : extension->AdditionalTrainerRanks)
        {
            auto const found = trainers.find(rank.TrainerId);
            if (found == trainers.end() || found->second.GetTrainerType() != Trainer::Type::Class ||
                found->second.GetTrainerRequirement() != ability.ClassId)
                return false;
            auto const& spells = found->second.GetSpells();
            if (std::count_if(spells.begin(), spells.end(),
                    [&rank](Trainer::Spell const& offer) { return offer.SpellId == rank.SpellId; }) != 1)
                return false;
            Trainer::Spell const* offer = found->second.GetSpell(rank.SpellId);
            if (!offer || offer->ReqLevel != rank.CharacterLevel || offer->ReqSkillLine || offer->ReqSkillRank ||
                offer->ReqAbility != rank.RequiredAbilities)
                return false;
        }
        return true;
    }
    Practice::AbilityRank const& first = ability.Ranks.front();
    if (std::count_if(AscensionCompatData::ClassSpells.begin(), AscensionCompatData::ClassSpells.end(),
            [&ability, &first](AscensionCompatData::ClassSpell const& entry)
            {
                return entry.ClassId == ability.ClassId && entry.SpellId == first.SpellId;
            }) != 1)
        return false;
    auto const grant = std::find_if(AscensionCompatData::ClassSpells.begin(), AscensionCompatData::ClassSpells.end(),
        [&ability, &first](AscensionCompatData::ClassSpell const& entry)
        {
            return entry.ClassId == ability.ClassId && entry.SpellId == first.SpellId &&
                entry.RequiredLevel == first.Requirement.CharacterLevel;
        });
    if (grant == AscensionCompatData::ClassSpells.end())
        return false;
    std::size_t count = 0;
    for (AscensionProgression::Rank const& entry : AscensionProgression::Ranks)
    {
        if (entry.ClassId != ability.ClassId || entry.FirstSpellId != first.SpellId)
            continue;
        ++count;
        auto const found = std::find_if(ability.Ranks.begin() + 1, ability.Ranks.end(),
            [&entry](Practice::AbilityRank const& rank)
            {
                return rank.SpellId == entry.SpellId && rank.Requirement.CharacterLevel == entry.RequiredLevel;
            });
        if (found == ability.Ranks.end())
            return false;
    }
    if (count != ability.Ranks.size() - 1)
        return false;
    for (auto const& rank : ability.Ranks.subspan(1))
        if (std::count_if(AscensionProgression::Ranks.begin(), AscensionProgression::Ranks.end(),
                [&ability, &first, &rank](AscensionProgression::Rank const& entry)
                {
                    return entry.ClassId == ability.ClassId && entry.FirstSpellId == first.SpellId &&
                        entry.SpellId == rank.SpellId;
                }) != 1)
            return false;
    return true;
}

bool MatchesStatBuffTrainer(Practice::AbilityProfile const& profile)
{
    if (!Practice::DevelopmentBuffs::IsSupportedStatBuff(profile) || profile.Definition.AbilityId == 300857)
        return true;
    auto const* mechanic = Practice::DevelopmentBuffs::MechanicFor(profile);
    if (!mechanic || profile.Definition.Ranks.size() < 2)
        return false;
    auto const& trainers = sObjectMgr->GetTrainers();
    auto const found = trainers.find(900000 + profile.Definition.ClassId);
    if (found == trainers.end() || found->second.GetTrainerType() != Trainer::Type::Class ||
        found->second.GetTrainerRequirement() != profile.Definition.ClassId)
        return false;
    auto const& spells = found->second.GetSpells();
    std::uint32_t prerequisite = 0;
    for (auto const& rank : profile.Definition.Ranks)
    {
        if (std::count_if(spells.begin(), spells.end(),
                [&rank](Trainer::Spell const& offer) { return offer.SpellId == rank.SpellId; }) != 1)
            return false;
        Trainer::Spell const* offer = found->second.GetSpell(rank.SpellId);
        std::array<std::uint32_t, 3> const required = { prerequisite, 0, 0 };
        if (!offer || offer->ReqLevel != rank.Requirement.CharacterLevel || offer->ReqSkillLine ||
            offer->ReqSkillRank || offer->ReqAbility != required)
            return false;
        prerequisite = rank.SpellId;
    }
    return true;
}

bool MatchesConjureFixedMechanic(Practice::AbilityProfile const& profile)
{
    auto const& authored = Practice::DevelopmentConjureFixed::Profiles;
    auto const found = std::find_if(authored.begin(), authored.end(),
        [&profile](Practice::AbilityProfile const& entry)
        {
            return entry.Definition.ClassId == profile.Definition.ClassId &&
                entry.Definition.AbilityId == profile.Definition.AbilityId;
        });
    if (found == authored.end())
        return true;
    if (!SameProfile(profile, *found))
        return false;
    for (auto const& rank : profile.Definition.Ranks)
    {
        SpellInfo const* info = sSpellMgr->GetSpellInfo(rank.SpellId);
        if (!info || info->IsPassive() || info->Effects[EFFECT_0].Effect != SPELL_EFFECT_CREATE_ITEM ||
            info->Effects[EFFECT_1].Effect || info->Effects[EFFECT_2].Effect ||
            !info->Effects[EFFECT_0].ItemType || !sObjectMgr->GetItemTemplate(info->Effects[EFFECT_0].ItemType))
            return false;
    }
    return true;
}

bool MatchesPassiveFixedMechanic(Practice::AbilityProfile const& profile)
{
    auto const& authored = Practice::DevelopmentPassiveFixed::Profiles;
    auto const found = std::find_if(authored.begin(), authored.end(),
        [&profile](Practice::AbilityProfile const& entry)
        {
            return entry.Definition.ClassId == profile.Definition.ClassId &&
                entry.Definition.AbilityId == profile.Definition.AbilityId;
        });
    if (found == authored.end())
        return true;
    if (!SameProfile(profile, *found))
        return false;
    auto const& mechanics = Practice::DevelopmentPassiveFixed::Mechanics;
    auto const mechanic = std::find_if(mechanics.begin(), mechanics.end(),
        [&profile](Practice::DevelopmentPassiveFixed::Mechanic const& entry)
        {
            return entry.ClassId == profile.Definition.ClassId && entry.SpellId == profile.Definition.AbilityId;
        });
    SpellInfo const* info = sSpellMgr->GetSpellInfo(profile.Definition.AbilityId);
    if (mechanic == mechanics.end() || !info || !info->IsPassive() ||
        (mechanic->RequiredSpellFamily && info->SpellFamilyName != mechanic->RequiredSpellFamily))
        return false;
    auto const& auraIds = mechanic->EffectiveAuraIds ? *mechanic->EffectiveAuraIds : mechanic->AuraIds;
    auto const& triggers = mechanic->EffectiveTriggerSpellIds ?
        *mechanic->EffectiveTriggerSpellIds : mechanic->TriggerSpellIds;
    for (std::size_t index = 0; index < auraIds.size(); ++index)
    {
        auto const& effect = info->Effects[index];
        if (effect.Effect != mechanic->EffectIds[index] || effect.ApplyAuraName != auraIds[index] ||
            effect.TriggerSpell != triggers[index] ||
            effect.TargetA.GetTarget() != mechanic->TargetAIds[index] ||
            effect.TargetB.GetTarget())
            return false;
        if (effect.TriggerSpell && !sSpellMgr->GetSpellInfo(effect.TriggerSpell))
            return false;
    }
    return true;
}

bool MatchesUtilityFixedRankMechanic(std::uint32_t classId, std::uint32_t spellId)
{
    auto const& mechanics = Practice::DevelopmentUtilityFixed::Mechanics;
    auto const mechanic = std::find_if(mechanics.begin(), mechanics.end(),
        [classId, spellId](Practice::DevelopmentUtilityFixed::Mechanic const& entry)
        {
            return entry.ClassId == classId && entry.SpellId == spellId;
        });
    SpellInfo const* info = sSpellMgr->GetSpellInfo(spellId);
    if (mechanic == mechanics.end() || !info || info->IsPassive())
        return false;
    if (classId == 32)
    {
        auto const& enchants = Practice::DevelopmentUtilityFixed::TemporaryEnchants;
        auto const native = std::find_if(enchants.begin(), enchants.end(),
            [spellId](auto const& entry) { return entry.SpellId == spellId; });
        if (native != enchants.end())
        {
            auto const scripts = sObjectMgr->GetSpellScriptsBounds(spellId);
            SpellItemEnchantmentEntry const* enchant = sSpellItemEnchantmentStore.LookupEntry(native->EnchantmentId);
            SpellInfo const* equip = sSpellMgr->GetSpellInfo(native->EquipSpellId);
            if (info->SpellFamilyName != 38 || scripts.first != scripts.second ||
                info->SpellLevel != native->CharacterLevel || info->BaseLevel != native->CharacterLevel ||
                info->MaxLevel || info->GetDuration() || info->ManaCost || info->ManaCostPerlevel ||
                info->ManaCostPercentage != 6 || info->EquippedItemClass != ITEM_CLASS_WEAPON ||
                info->EquippedItemSubClassMask != 173555 || info->EquippedItemInventoryTypeMask ||
                !enchant || enchant->charges || enchant->requiredSkill || enchant->requiredSkillValue ||
                enchant->requiredLevel != 1 || enchant->EnchantmentCondition ||
                !equip || !equip->IsPassive() || equip->IsDeprecatedForPlayers)
                return false;
            for (std::size_t index = 0; index < 3; ++index)
                if (info->SpellFamilyFlags[index] != native->FamilyFlags[index] ||
                    info->Effects[index].DieSides != (index == 0 ? native->PrimaryDieSides : index == 1 ? 1 : 0) ||
                    info->Effects[index].RealPointsPerLevel || info->Effects[index].MiscValueB ||
                    info->Effects[index].SpellClassMask ||
                    enchant->type[index] != (index == 0 ? ITEM_ENCHANTMENT_TYPE_EQUIP_SPELL : 0u) ||
                    enchant->amount[index] != (index == 0 ? 100u : 0u) ||
                    enchant->spellid[index] != (index == 0 ? native->EquipSpellId : 0u))
                    return false;
        }
    }
    if (classId == 32 && spellId == 807828)
    {
        SpellInfo const* patch = sSpellMgr->GetSpellInfo(808023);
        SpellInfo const* mark = sSpellMgr->GetSpellInfo(535213);
        auto const scripts = sObjectMgr->GetSpellScriptsBounds(spellId);
        auto const patchScripts = sObjectMgr->GetSpellScriptsBounds(808023);
        auto const markScripts = sObjectMgr->GetSpellScriptsBounds(535213);
        auto const groups = sSpellMgr->GetSpellSpellGroupMapBounds(spellId);
        if (info->SpellFamilyName != 38 || info->SpellFamilyFlags[0] || info->SpellFamilyFlags[1] ||
            info->SpellFamilyFlags[2] != 8192 || scripts.first != scripts.second ||
            patchScripts.first != patchScripts.second || markScripts.first != markScripts.second ||
            groups.first != groups.second || info->GetDuration() != 10000 ||
            info->SpellLevel != 26 || info->BaseLevel != 26 || info->MaxLevel ||
            info->Stances != 536870912 || info->StancesNot || info->AttributesEx != 134480928 ||
            info->ProcFlags || info->ProcChance || info->ProcCharges || sSpellMgr->GetSpellProcEntry(spellId) ||
            info->ManaCost || info->ManaCostPercentage != 9 || info->RecoveryTime != 20000 ||
            info->CategoryRecoveryTime || info->Effects[EFFECT_0].Amplitude != 1000 ||
            !patch || patch->GetDuration() != 10000 || patch->Effects[EFFECT_2].Amplitude != 2000 ||
            !mark || mark->GetDuration() != 60000 ||
            mark->Effects[EFFECT_0].Effect != SPELL_EFFECT_APPLY_AURA ||
            mark->Effects[EFFECT_0].ApplyAuraName != SPELL_AURA_MOD_STALKED ||
            mark->Effects[EFFECT_0].TargetA.GetTarget() != TARGET_UNIT_TARGET_ENEMY ||
            mark->Effects[EFFECT_0].TargetB.GetTarget() || mark->Effects[EFFECT_0].TriggerSpell ||
            mark->Effects[EFFECT_1].Effect || mark->Effects[EFFECT_2].Effect ||
            patch->ProcFlags || patch->ProcChance || patch->ProcCharges ||
            sSpellMgr->GetSpellProcEntry(808023) || sSpellMgr->GetSpellProcEntry(535213))
            return false;
        for (std::size_t index = 0; index < 3; ++index)
            if (info->Effects[index].DieSides != (index == 0 ? 1 : 0) ||
                info->Effects[index].RealPointsPerLevel || info->Effects[index].MiscValueB ||
                info->Effects[index].SpellClassMask || patch->Effects[index].BasePoints ||
                patch->Effects[index].DieSides || patch->Effects[index].RealPointsPerLevel ||
                patch->Effects[index].MiscValue != (index == 1 ? 5 : 0) ||
                patch->Effects[index].MiscValueB || patch->Effects[index].SpellClassMask ||
                patch->Effects[index].CalcRadius() != 3.0f)
                return false;
    }
    if (classId == 32 && spellId == 807823)
    {
        auto const scripts = sObjectMgr->GetSpellScriptsBounds(spellId);
        auto const groups = sSpellMgr->GetSpellSpellGroupMapBounds(spellId);
        if (info->SpellFamilyName != 38 || info->SpellFamilyFlags[0] || info->SpellFamilyFlags[1] ||
            info->SpellFamilyFlags[2] != 8192 || scripts.first != scripts.second ||
            groups.first != groups.second || info->GetDuration() != 2000 ||
            info->SpellLevel != 18 || info->BaseLevel != 18 || info->MaxLevel ||
            info->Stances != 536870912 || info->StancesNot || info->AttributesEx != 1056 ||
            info->ProcFlags || info->ProcChance != 101 || info->ProcCharges ||
            sSpellMgr->GetSpellProcEntry(spellId) || info->ManaCost || info->ManaCostPercentage != 5 ||
            info->RecoveryTime != 6000 || info->CategoryRecoveryTime != 6000)
            return false;
        for (std::size_t index = 0; index < 3; ++index)
            if (info->Effects[index].DieSides != (index < 2 ? 1 : 0) ||
                info->Effects[index].RealPointsPerLevel || info->Effects[index].MiscValueB ||
                info->Effects[index].SpellClassMask ||
                (index < 2 && info->Effects[index].CalcRadius() != 10.0f))
                return false;
    }
    if (classId == 32 && spellId == 804674)
    {
        auto const scripts = sObjectMgr->GetSpellScriptsBounds(spellId);
        auto const groups = sSpellMgr->GetSpellSpellGroupMapBounds(spellId);
        SummonPropertiesEntry const* summon = sSummonPropertiesStore.LookupEntry(65);
        CreatureTemplate const* orb = sObjectMgr->GetCreatureTemplate(50038);
        if (info->SpellFamilyName != 38 || info->SpellFamilyFlags || !info->IsChanneled() ||
            scripts.first != scripts.second || groups.first != groups.second ||
            info->GetDuration() != 60000 || info->SpellLevel != 22 || info->BaseLevel != 22 || info->MaxLevel ||
            info->ProcFlags || info->ProcChance != 101 || info->ProcCharges ||
            info->ManaCostPercentage != 22 || info->RecoveryTime || info->CategoryRecoveryTime ||
            !summon || summon->Category != SUMMON_CATEGORY_PUPPET || summon->Faction ||
            summon->Type || summon->Slot || summon->Flags || !orb || orb->type != 1 || orb->unit_class != 1)
            return false;
        for (std::size_t index = 0; index < 3; ++index)
            if (info->Effects[index].DieSides != (index == 1 ? 0 : 1) ||
                info->Effects[index].RealPointsPerLevel || info->Effects[index].SpellClassMask ||
                info->Effects[index].MiscValueB != (index == 0 ? 65 : 0))
                return false;
    }
    if (classId == 32 && spellId == 500288)
    {
        auto const scripts = sObjectMgr->GetSpellScriptsBounds(spellId);
        auto const groups = sSpellMgr->GetSpellSpellGroupMapBounds(spellId);
        auto const* linked = sSpellMgr->GetSpellLinked(spellId + SPELL_LINK_AURA);
        SpellInfo const* slow = sSpellMgr->GetSpellInfo(808090);
        if (info->SpellFamilyName != 38 || info->SpellFamilyFlags[0] != 32768 ||
            info->SpellFamilyFlags[1] || info->SpellFamilyFlags[2] != 134217728 ||
            scripts.first != scripts.second || groups.first != groups.second ||
            info->GetDuration() != -1 || info->SpellLevel != 4 || info->BaseLevel != 4 || info->MaxLevel != 60 ||
            info->ProcFlags != 664232 || info->ProcChance != 100 || info->ProcCharges != 1 ||
            info->ManaCostPercentage != 8 || info->RecoveryTime != 10000 || info->CategoryRecoveryTime ||
            !linked || *linked != std::vector<std::int32_t>{ 808090 } || !slow ||
            slow->GetDuration() != -1 || slow->Effects[EFFECT_0].Effect != SPELL_EFFECT_APPLY_AURA ||
            slow->Effects[EFFECT_0].ApplyAuraName != SPELL_AURA_MOD_DECREASE_SPEED ||
            slow->Effects[EFFECT_0].TargetA.GetTarget() != TARGET_UNIT_CASTER ||
            slow->Effects[EFFECT_0].TargetB.GetTarget() || slow->Effects[EFFECT_0].BasePoints != -31 ||
            slow->Effects[EFFECT_0].DieSides != 1 || slow->Effects[EFFECT_0].RealPointsPerLevel)
            return false;
        for (std::size_t index = 0; index < 3; ++index)
            if (info->Effects[index].DieSides != 1 || info->Effects[index].MiscValueB ||
                info->Effects[index].RealPointsPerLevel != (index == 1 ? 8.0f : 0.0f))
                return false;
    }
    if (classId == 32 && spellId == 802630)
    {
        constexpr std::array<std::int32_t, 6> tattoos{ 801094, 801106, 801107, 802630, 803748, 807834 };
        auto const scripts = sObjectMgr->GetSpellScriptsBounds(spellId);
        if (info->SpellFamilyName != 38 || info->SpellFamilyFlags[0] || info->SpellFamilyFlags[1] ||
            info->SpellFamilyFlags[2] != 32 || scripts.first != scripts.second || info->GetDuration() != -1 ||
            info->SpellLevel != 16 || info->BaseLevel != 16 || info->MaxLevel ||
            info->ProcFlags != 20 || info->ProcChance != 100 || info->ProcCharges ||
            !HasExactBuffGroup(spellId, 111001, SPELL_GROUP_STACK_RULE_EXCLUSIVE, tattoos))
            return false;
        for (auto const& effect : info->Effects)
            if (effect.DieSides != 1 || effect.RealPointsPerLevel || effect.MiscValueB || effect.SpellClassMask)
                return false;
    }
    if (classId == 32 && (spellId == 561236 || spellId == 560295))
    {
        auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
        if (info->SpellFamilyName != 38 || info->SpellFamilyFlags[0] ||
            info->SpellFamilyFlags[1] || info->SpellFamilyFlags[2] ||
            scripts.first != scripts.second || !HasExpectedEtchingGroup(spellId, info->Id))
            return false;
        for (std::size_t index = 0; index < 3; ++index)
            if (info->Effects[index].DieSides != (spellId == 560295 && index == 0 ? 0 : 1) ||
                info->Effects[index].RealPointsPerLevel || info->Effects[index].MiscValueB)
                return false;
    }
    if (classId == 13 && spellId == 578344)
    {
        auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
        auto entry = scripts.first;
        if (info->SpellFamilyName != 19 || info->SpellFamilyFlags[0] != 256 ||
            info->SpellFamilyFlags[1] || info->SpellFamilyFlags[2] || entry == scripts.second ||
            sObjectMgr->GetScriptName(entry->second) != "aura_ascension_witch_doctor_lifecycle")
            return false;
        if (++entry != scripts.second)
            return false;
    }
    if (classId == 14 && (spellId == 500028 || spellId == 500422 || spellId == 500423))
    {
        SpellInfo const* jump = sSpellMgr->GetSpellInfo(802028);
        SpellInfo const* removal = sSpellMgr->GetSpellInfo(802030);
        if (info->SpellFamilyName != 20 || info->MaxCharges != 3 || info->ChargeRecoveryTime != 10000 ||
            info->ChargeRecoveryKey != 500028 || info->ChargeCategoryId != 356 || !jump || !removal ||
            jump->SpellFamilyName != 20 || jump->Effects[EFFECT_1].Amplitude != 90 ||
            removal->SpellFamilyName != 20 || removal->IsPassive() || removal->IsDeprecatedForPlayers)
            return false;
        for (std::size_t index = 0; index < 3; ++index)
        {
            auto const& effect = removal->Effects[index];
            if (effect.Effect != (index == 0 ? 164u : 0u) || effect.ApplyAuraName ||
                effect.TriggerSpell != (index == 0 ? 802025u : 0u) ||
                effect.TargetA.GetTarget() != (index == 0 ? 1u : 0u) || effect.TargetB.GetTarget())
                return false;
        }
    }
    if (spellId == 803343)
    {
        if (info->SpellFamilyName != 20 || info->RecoveryTime || info->GetDuration() != -1)
            return false;
        auto const scripts = sObjectMgr->GetSpellScriptsBounds(spellId);
        auto entry = scripts.first;
        if (entry == scripts.second || sObjectMgr->GetScriptName(entry->second) !=
            "aura_ascension_felsworn_lifecycle" || ++entry != scripts.second)
            return false;
    }
    if (spellId == 532229)
    {
        SummonPropertiesEntry const* summon = sSummonPropertiesStore.LookupEntry(65);
        CreatureTemplate const* eye = sObjectMgr->GetCreatureTemplate(4277);
        CreatureAddon const* addon = sObjectMgr->GetCreatureTemplateAddon(4277);
        SpellInfo const* stealth = sSpellMgr->GetSpellInfo(2585);
        if (info->SpellFamilyName != 20 || !info->IsChanneled() || info->GetDuration() != 45000 ||
            info->Effects[EFFECT_0].MiscValueB != 65 || !summon || summon->Category != SUMMON_CATEGORY_PUPPET ||
            summon->Faction || summon->Type || summon->Slot || summon->Flags || !eye || eye->type != 3 ||
            eye->unit_class != 2 || !addon || addon->auras != std::vector<std::uint32_t>{ 2585 } || !stealth)
            return false;
        constexpr std::array<std::uint32_t, 3> auras = { 16, 105, 31 };
        for (std::size_t index = 0; index < auras.size(); ++index)
        {
            auto const& effect = stealth->Effects[index];
            if (effect.Effect != SPELL_EFFECT_APPLY_AURA || effect.ApplyAuraName != auras[index] ||
                effect.TargetA.GetTarget() != TARGET_UNIT_CASTER || effect.TargetB.GetTarget() || effect.TriggerSpell)
                return false;
        }
    }
    if (spellId == 578345 &&
        (info->SpellFamilyName != 20 || info->RecoveryTime != 30000 || info->GetDuration() != 6000))
        return false;
    if (spellId == 562720 &&
        (info->SpellFamilyName != 26 || info->Effects[EFFECT_1].Amplitude != 3000 ||
            info->Effects[EFFECT_2].Amplitude != 3000 ||
            info->Effects[EFFECT_2].RealPointsPerLevel != 1.0f))
        return false;
    if (info->Effects[0].IsEffect(SPELL_EFFECT_TRANS_DOOR))
    {
        auto const& objects = Practice::DevelopmentUtilityFixed::Objects;
        auto const spec = std::find_if(objects.begin(), objects.end(), [classId, spellId](auto const& entry)
        {
            return entry.ClassId == classId && entry.SpellId == spellId;
        });
        if (spec == objects.end() || info->Effects[0].MiscValue != static_cast<std::int32_t>(spec->Entry))
            return false;
        GameObjectTemplate const* object = sObjectMgr->GetGameObjectTemplate(spec->Entry);
        if (!object || object->type != spec->Type || object->displayId != spec->DisplayId)
            return false;
    }
    for (std::size_t index = 0; index < mechanic->EffectIds.size(); ++index)
    {
        auto const& effect = info->Effects[index];
        if (effect.Effect != mechanic->EffectIds[index] || effect.ApplyAuraName != mechanic->AuraIds[index] ||
            effect.TriggerSpell != mechanic->TriggerSpellIds[index] ||
            effect.TargetA.GetTarget() != mechanic->TargetAIds[index] ||
            effect.TargetB.GetTarget() != mechanic->TargetBIds[index])
        {
            LOG_ERROR("module.ability_practice",
                "Rejected utility shape: class={}, spell={}, slot={}, effect={}, aura={}, trigger={}, "
                "targetA={}, targetB={}",
                classId, spellId, index, effect.Effect, effect.ApplyAuraName, effect.TriggerSpell,
                effect.TargetA.GetTarget(), effect.TargetB.GetTarget());
            return false;
        }
        if ((mechanic->MiscValues && effect.MiscValue != (*mechanic->MiscValues)[index]) ||
            (mechanic->BasePoints && effect.BasePoints != (*mechanic->BasePoints)[index]))
        {
            LOG_ERROR("module.ability_practice",
                "Rejected utility values: class={}, spell={}, slot={}, misc={}, base={}",
                classId, spellId, index, effect.MiscValue, effect.BasePoints);
            return false;
        }
        if (!effect.TriggerSpell)
            continue;
        auto const& helpers = Practice::DevelopmentUtilityFixed::Helpers;
        auto const spec = std::find_if(helpers.begin(), helpers.end(),
            [&effect](Practice::DevelopmentUtilityFixed::HelperMechanic const& entry)
            {
                return entry.SpellId == effect.TriggerSpell;
            });
        SpellInfo const* helper = sSpellMgr->GetSpellInfo(effect.TriggerSpell);
        if (spec == helpers.end() || !helper || helper->IsPassive() || helper->IsDeprecatedForPlayers)
            return false;
        for (std::size_t helperIndex = 0; helperIndex < spec->EffectIds.size(); ++helperIndex)
        {
            auto const& slot = helper->Effects[helperIndex];
            if (slot.Effect != spec->EffectIds[helperIndex] || slot.ApplyAuraName != spec->AuraIds[helperIndex] ||
                slot.TriggerSpell != spec->TriggerSpellIds[helperIndex] ||
                slot.TargetA.GetTarget() != spec->TargetAIds[helperIndex] || slot.TargetB.GetTarget())
                return false;
        }
    }
    return true;
}

bool MatchesUtilityFixedMechanic(Practice::AbilityProfile const& profile)
{
    auto const& authored = Practice::DevelopmentUtilityFixed::Profiles;
    auto const found = std::find_if(authored.begin(), authored.end(),
        [&profile](Practice::AbilityProfile const& entry)
        {
            return entry.Definition.ClassId == profile.Definition.ClassId &&
                entry.Definition.AbilityId == profile.Definition.AbilityId;
        });
    if (found == authored.end())
        return true;
    if (!SameProfile(profile, *found))
        return false;
    return std::all_of(profile.Definition.Ranks.begin(), profile.Definition.Ranks.end(),
        [&profile](Practice::AbilityRank const& rank)
        {
            return MatchesUtilityFixedRankMechanic(profile.Definition.ClassId, rank.SpellId);
        });
}

bool MatchesSharedBuffVariants()
{
    if (!SharedBuffVariantsRequested)
        return true;
    if (!BuffContributionRequested || !RankRequested || !RankCapsRequested || !TrainerRanksRequested ||
        !ProfileLookup)
        return false;
    for (auto const& variant : Practice::DevelopmentBuffVariants::Variants)
    {
        auto const* profile = ProfileLookup->Find(variant.ClassId, variant.AbilityId);
        auto const* rank = profile ? Practice::DevelopmentBuffVariants::EquivalentRank(*profile, variant) : nullptr;
        SpellInfo const* info = sSpellMgr->GetSpellInfo(variant.SpellId);
        SpellInfo const* parent = sSpellMgr->GetSpellInfo(variant.EquivalentSpellId);
        if (ProfileLookup->Find(variant.ClassId, variant.SpellId) ||
            !rank || !info || !parent || info->IsPassive() || info->IsDeprecatedForPlayers ||
            info->SpellFamilyName != parent->SpellFamilyName)
            return false;
        if (profile->Definition.Kind == Practice::AbilityKind::Ranked &&
            (profile->DefinitionVersion != Practice::DevelopmentRankCaps::DefinitionVersion ||
                std::any_of(profile->Policy.Bands.begin(), profile->Policy.Bands.end(),
                    [profile](auto const& band)
                    {
                        return band.PointsPerLevel != profile->Policy.Bands.front().PointsPerLevel;
                    })))
            return false;
        for (std::size_t index = 0; index < 3; ++index)
        {
            auto const& slot = info->Effects[index];
            auto const& expected = parent->Effects[index];
            bool const inactiveModuleSlot = Practice::DevelopmentBuffs::IsManaModule(*profile) && index == 2 &&
                expected.Effect == 168 && expected.TargetA.GetTarget() == 1 && expected.MiscValue == 117151;
            bool const dawnRangedSlot = variant.ClassId == 27 && variant.SpellId == 572390 &&
                variant.AbilityId == 572384 && variant.EquivalentSpellId == 572389 &&
                variant.CharacterLevel == 60 && index == EFFECT_1 && expected.Effect == SPELL_EFFECT_APPLY_AURA &&
                expected.ApplyAuraName == SPELL_AURA_MOD_RANGED_ATTACK_POWER &&
                expected.TargetA.GetTarget() == TARGET_UNIT_TARGET_ALLY;
            if (info->SpellFamilyFlags[index] != parent->SpellFamilyFlags[index] ||
                slot.Effect != expected.Effect || slot.ApplyAuraName != expected.ApplyAuraName ||
                slot.TargetA.GetTarget() != (inactiveModuleSlot ? 1u : dawnRangedSlot ? 21u :
                    expected.TargetA.GetTarget() ? 56u : 0u) ||
                slot.TargetB.GetTarget() || slot.TriggerSpell != expected.TriggerSpell ||
                slot.MiscValue != expected.MiscValue || slot.MiscValueB != expected.MiscValueB ||
                slot.BasePoints != expected.BasePoints || slot.DieSides != expected.DieSides ||
                slot.RealPointsPerLevel != expected.RealPointsPerLevel)
                return false;
        }
        auto const scripts = sObjectMgr->GetSpellScriptsBounds(info->Id);
        auto entry = scripts.first;
        if (variant.ClassId == 13)
        {
            if (entry == scripts.second ||
                sObjectMgr->GetScriptName(entry->second) != "aura_ascension_witch_doctor_lifecycle" ||
                ++entry != scripts.second)
                return false;
        }
        else if (variant.ClassId == 28)
        {
            if ((!Practice::DevelopmentBuffs::IsPowerModule(*profile) &&
                !Practice::DevelopmentBuffs::IsManaModule(*profile)) || !HasExpectedModuleGroup(info->Id) ||
                entry == scripts.second || sObjectMgr->GetScriptName(entry->second) !=
                    "aura_ascension_tinker_lifecycle" || ++entry != scripts.second)
                return false;
        }
        else if (variant.ClassId == 27)
        {
            auto const groups = sSpellMgr->GetSpellSpellGroupMapBounds(info->Id);
            if (info->SpellFamilyName != 33 || groups.first != groups.second || entry == scripts.second ||
                sObjectMgr->GetScriptName(entry->second) != "aura_ascension_sun_cleric_lifecycle" ||
                ++entry != scripts.second)
                return false;
        }
        else if (variant.ClassId == 22)
        {
            constexpr std::array<std::int32_t, 4> wisdom{ 572391, 572396, 680307, 801523 };
            if (info->SpellFamilyName != 28 || entry != scripts.second ||
                !HasExactBuffGroup(info->Id, 1135, SPELL_GROUP_STACK_RULE_EXCLUSIVE_FROM_SAME_CASTER, wisdom))
                return false;
        }
        else if (variant.ClassId == 18)
        {
            auto const groups = sSpellMgr->GetSpellSpellGroupMapBounds(info->Id);
            auto const regular = sSpellMgr->GetSpellSpellGroupMapBounds(parent->Id);
            if (info->SpellFamilyName != 24 || entry != scripts.second ||
                groups.first != groups.second || regular.first != regular.second)
                return false;
        }
        else if (variant.ClassId == 16)
        {
            if (info->SpellFamilyName != 22 || entry != scripts.second ||
                !HasExpectedStormbornSharedGroup(variant.AbilityId, info->Id))
                return false;
        }
        else if (variant.ClassId == 26)
        {
            if (info->SpellFamilyName != 32 || entry != scripts.second ||
                !HasExpectedStarcallerGroup(variant.AbilityId, info->Id))
                return false;
        }
        else if (variant.ClassId == 30)
        {
            if (info->SpellFamilyName != 36 || entry != scripts.second || !HasExpectedRiteGroup(info->Id))
                return false;
        }
        else if (variant.ClassId == 31)
        {
            if (info->SpellFamilyName != 37 || entry != scripts.second ||
                !HasExpectedGeomancerGroup(variant.AbilityId, info->Id))
                return false;
        }
        else if (variant.ClassId == 32)
        {
            if (entry != scripts.second || !HasExpectedEtchingGroup(variant.AbilityId, info->Id))
                return false;
        }
        else if (variant.ClassId == 21)
        {
            if (entry != scripts.second || !HasExpectedAdaptationGroup(variant.AbilityId, info->Id))
                return false;
        }
        else if (!IsArmorOrEdictProfile(*profile) || entry != scripts.second ||
            !HasExpectedArmorOrEdictGroup(variant.AbilityId, info->Id))
            return false;
        std::array const ranks = { Practice::AbilityRank{ variant.SpellId, 1, { variant.CharacterLevel, 1 } } };
        Practice::AbilityProfile const native{
            Practice::Development::DefinitionVersion, Practice::AcquisitionSource::ClassGrant,
            { variant.ClassId, variant.SpellId, Practice::AbilityKind::Fixed, ranks, {} },
            Practice::Development::Policy, Practice::OutcomeKind::None };
        if (!MatchesNativeClassGrant(native))
            return false;
        auto const& trainers = sObjectMgr->GetTrainers();
        auto const found = trainers.find(900000 + variant.ClassId);
        if (found == trainers.end() || found->second.GetTrainerType() != Trainer::Type::Class ||
            found->second.GetTrainerRequirement() != variant.ClassId)
            return false;
        auto const& offers = found->second.GetSpells();
        if (std::count_if(offers.begin(), offers.end(), [&variant](Trainer::Spell const& offer)
            {
                return offer.SpellId == variant.SpellId;
            }) != 1)
            return false;
        auto const* offer = found->second.GetSpell(variant.SpellId);
        if (!offer || offer->ReqLevel != variant.CharacterLevel || offer->ReqSkillLine || offer->ReqSkillRank ||
            std::any_of(offer->ReqAbility.begin(), offer->ReqAbility.end(),
                [](std::uint32_t required) { return required != 0; }))
            return false;
    }
    return true;
}

bool MatchesControlFixedMechanic(Practice::AbilityProfile const& profile)
{
    auto const& authored = Practice::DevelopmentControlFixed::Profiles;
    auto const found = std::find_if(authored.begin(), authored.end(),
        [&profile](Practice::AbilityProfile const& entry)
        {
            return entry.Definition.ClassId == profile.Definition.ClassId &&
                entry.Definition.AbilityId == profile.Definition.AbilityId;
        });
    if (found == authored.end())
        return true;
    if (!SameProfile(profile, *found))
        return false;
    auto const& mechanics = Practice::DevelopmentControlFixed::Mechanics;
    auto const mechanic = std::find_if(mechanics.begin(), mechanics.end(),
        [&profile](Practice::DevelopmentControlFixed::Mechanic const& entry)
        {
            return entry.ClassId == profile.Definition.ClassId && entry.SpellId == profile.Definition.AbilityId;
        });
    SpellInfo const* info = sSpellMgr->GetSpellInfo(profile.Definition.AbilityId);
    if (mechanic == mechanics.end() || !info || info->IsPassive())
        return false;
    if (profile.Definition.AbilityId == 954534 &&
        (info->SpellFamilyName != 20 || info->TargetCreatureType != 8 || info->GetDuration() != 40000 ||
            info->RecoveryTime || info->Effects[EFFECT_0].BasePoints != -1 ||
            info->Effects[EFFECT_0].DieSides != 1 || info->Effects[EFFECT_0].RealPointsPerLevel != 0.0f))
        return false;
    if (profile.Definition.AbilityId == 807846 &&
        (info->TargetCreatureType != 256 || info->Effects[EFFECT_0].BasePoints != 0 ||
            info->Effects[EFFECT_0].RealPointsPerLevel != 1.0f || info->Effects[EFFECT_1].BasePoints != 24 ||
            info->Effects[EFFECT_2].BasePoints != 1 || info->Effects[EFFECT_2].Amplitude != 3000))
        return false;
    if (profile.Definition.AbilityId == 805097 &&
        (info->CasterAuraSpell != 803183 || info->Effects[EFFECT_2].BasePoints != 0 ||
            info->Effects[EFFECT_2].DieSides != 1))
        return false;
    for (std::size_t index = 0; index < mechanic->EffectIds.size(); ++index)
    {
        auto const& effect = info->Effects[index];
        if (effect.Effect != mechanic->EffectIds[index] || effect.ApplyAuraName != mechanic->AuraIds[index] ||
            effect.TriggerSpell != mechanic->TriggerSpellIds[index] ||
            effect.TargetA.GetTarget() != mechanic->TargetAIds[index] ||
            effect.TargetB.GetTarget() != mechanic->TargetBIds[index])
            return false;
        if (!effect.TriggerSpell)
            continue;
        SpellInfo const* helper = sSpellMgr->GetSpellInfo(effect.TriggerSpell);
        if (effect.TriggerSpell != 801260 || !helper || helper->IsPassive() || helper->IsDeprecatedForPlayers)
            return false;
        for (std::size_t helperIndex = 0; helperIndex < mechanic->EffectIds.size(); ++helperIndex)
        {
            auto const& slot = helper->Effects[helperIndex];
            if (slot.Effect != (helperIndex == 0 ? SPELL_EFFECT_HEAL_PCT : 0u) ||
                slot.ApplyAuraName || slot.TriggerSpell || slot.TargetB.GetTarget() ||
                slot.TargetA.GetTarget() != (helperIndex == 0 ? TARGET_UNIT_TARGET_ENEMY : 0u))
                return false;
        }
    }
    return true;
}

bool MatchesNativeClassTrainer(Practice::AbilityProfile const& profile)
{
    auto const& authored = Practice::DevelopmentTrainerFixed::Profiles;
    if (profile.Acquisition != Practice::AcquisitionSource::ClassTrainer ||
        std::none_of(authored.begin(), authored.end(),
            [&profile](Practice::AbilityProfile const& entry) { return SameProfile(profile, entry); }))
        return false;
    auto const& trainers = sObjectMgr->GetTrainers();
    auto const found = trainers.find(900014);
    if (found == trainers.end() || found->second.GetTrainerType() != Trainer::Type::Class ||
        found->second.GetTrainerRequirement() != profile.Definition.ClassId)
        return false;
    auto const& rank = profile.Definition.Ranks.front();
    auto const& spells = found->second.GetSpells();
    if (std::count_if(spells.begin(), spells.end(),
            [&rank](Trainer::Spell const& entry) { return entry.SpellId == rank.SpellId; }) != 1)
        return false;
    Trainer::Spell const* offer = found->second.GetSpell(rank.SpellId);
    if (!offer || offer->ReqLevel != rank.Requirement.CharacterLevel || offer->ReqSkillLine || offer->ReqSkillRank ||
        std::any_of(offer->ReqAbility.begin(), offer->ReqAbility.end(), [](uint32 spell) { return spell != 0; }))
        return false;
    SpellInfo const* info = sSpellMgr->GetSpellInfo(rank.SpellId);
    if (!info || info->IsPassive() || info->Effects[EFFECT_0].Effect != SPELL_EFFECT_TRANS_DOOR ||
        info->Effects[EFFECT_1].Effect || info->Effects[EFFECT_2].Effect)
        return false;
    return std::count_if(std::begin(FelswornRifts), std::end(FelswornRifts),
        [&rank, info](FelswornRift const& entry)
        {
            return entry.spell == rank.SpellId && entry.entry &&
                info->Effects[EFFECT_0].MiscValue == static_cast<int32>(entry.entry);
        }) == 1;
}

bool MatchesEffectiveRankChain(Practice::AbilityProfile const& profile)
{
    auto const& ability = profile.Definition;
    std::vector<std::optional<Practice::NativeRankLink>> links;
    links.reserve(ability.Ranks.size());
    for (auto const& rank : ability.Ranks)
    {
        SpellChainNode const* node = sSpellMgr->GetSpellChainNode(rank.SpellId);
        if (!node)
            links.push_back(std::nullopt);
        else
            links.push_back(Practice::NativeRankLink{ node->first ? node->first->Id : 0,
                node->last ? node->last->Id : 0, node->prev ? node->prev->Id : 0,
                node->next ? node->next->Id : 0, node->rank });
    }
    auto const* extension = TrainerRankExtensionEntry(profile);
    return Practice::MatchesNativeRankChain(ability.Ranks, links,
        extension && TrainerRanksRequested ? extension->PreviousRanks.size() : 0);
}

std::optional<std::uint32_t> NativeRankLabel(SpellInfo const* info)
{
    if (!info || !info->Rank[0])
        return {};
    std::string_view label(info->Rank[0]);
    if (!label.starts_with("Rank "))
        return {};
    label.remove_prefix(5);
    std::uint32_t rank = 0;
    auto const parsed = std::from_chars(label.data(), label.data() + label.size(), rank);
    if (parsed.ec != std::errc{} || parsed.ptr != label.data() + label.size() || !rank || rank > 64)
        return {};
    return rank;
}

bool MatchesTrainerRankBoundary(Practice::AbilityDefinition const& ability)
{
    if (ability.Kind == Practice::AbilityKind::Fixed)
        return true;
    SpellInfo const* first = sSpellMgr->GetSpellInfo(ability.Ranks.front().SpellId);
    if (!first || !first->SpellName[0] || !*first->SpellName[0])
        return false;
    auto known = [&ability](std::uint32_t spell)
    {
        return std::any_of(ability.Ranks.begin(), ability.Ranks.end(),
            [spell](Practice::AbilityRank const& rank) { return rank.SpellId == spell; });
    };
    for (auto const& [trainerId, trainer] : sObjectMgr->GetTrainers())
    {
        if (trainer.GetTrainerType() != Trainer::Type::Class || trainer.GetTrainerRequirement() != ability.ClassId)
            continue;
        for (auto const& offer : trainer.GetSpells())
        {
            if (std::none_of(offer.ReqAbility.begin(), offer.ReqAbility.end(), known))
                continue;
            std::array<std::uint32_t, 32> spells{};
            spells[0] = offer.SpellId;
            std::size_t count = 1;
            for (std::size_t index = 0; index < count; ++index)
            {
                SpellInfo const* info = sSpellMgr->GetSpellInfo(spells[index]);
                if (!info)
                    return false;
                auto const rank = NativeRankLabel(info);
                if (!known(info->Id) && rank && *rank > ability.Ranks.back().RankNumber && info->SpellName[0] &&
                    std::string_view(info->SpellName[0]) == first->SpellName[0])
                {
                    LOG_ERROR("module.ability_practice",
                        "Unprofiled trainer-linked rank: trainer={}, class={}, ability={}, spell={}",
                        trainerId, ability.ClassId, ability.AbilityId, info->Id);
                    return false;
                }
                for (auto const& effect : info->GetEffects())
                {
                    if (!effect.IsEffect(SPELL_EFFECT_LEARN_SPELL) || !effect.TriggerSpell)
                        continue;
                    auto const end = spells.begin() + count;
                    if (std::find(spells.begin(), end, effect.TriggerSpell) != end)
                        continue;
                    if (count == spells.size())
                        return false;
                    spells[count++] = effect.TriggerSpell;
                }
            }
        }
    }
    return true;
}

std::shared_ptr<CharacterSelection const> ParseSelectedCharacters(std::string_view setting)
{
    if (setting.size() > 4096)
        return {};
    auto selection = std::make_shared<CharacterSelection>();
    if (setting.empty())
        return selection;
    while (!setting.empty())
    {
        std::size_t const delimiter = setting.find(',');
        std::string_view token = setting.substr(0, delimiter);
        std::size_t const first = token.find_first_not_of(" \t");
        if (first == std::string_view::npos)
            return {};
        token = token.substr(first, token.find_last_not_of(" \t") - first + 1);
        std::uint32_t characterId = 0;
        auto const parsed = std::from_chars(token.data(), token.data() + token.size(), characterId);
        if (parsed.ec != std::errc{} || parsed.ptr != token.data() + token.size() || !characterId ||
            !selection->insert(ObjectGuid::Create<HighGuid::Player>(characterId).GetRawValue()).second ||
            selection->size() > 128)
            return {};
        if (delimiter == std::string_view::npos)
            break;
        setting.remove_prefix(delimiter + 1);
        if (setting.empty())
            return {};
    }
    return selection;
}

bool IsDevelopmentPlayer(Player const* player)
{
    if (!player || !player->GetSession() || player->GetSession()->IsBot())
        return false;
    auto const selection = SelectedCharacters.load();
    if (!selection)
        return false;
    if (RealmEnrollment.load())
        return selection->empty() && ProfileLookup && !ProfileLookup->ForClass(player->getClass()).empty();
    return selection->contains(player->GetGUID().GetRawValue());
}

Practice::AbilityProfile const* FindProfile(Player const* player, std::uint32_t spellId)
{
    if (!player || !ProfileLookup)
        return nullptr;
    if (auto const* profile = ProfileLookup->Find(player->getClass(), spellId))
        return profile;
    auto const* variant = SharedBuffVariantsRequested ?
        Practice::DevelopmentBuffVariants::Find(player->getClass(), spellId) : nullptr;
    return variant ? ProfileLookup->Find(variant->ClassId, variant->AbilityId) : nullptr;
}

std::uint32_t SharedBuffRankSpellId(Practice::AbilityDefinition const& ability, std::uint32_t spellId)
{
    auto const* variant = SharedBuffVariantsRequested ?
        Practice::DevelopmentBuffVariants::Find(ability.ClassId, spellId) : nullptr;
    return variant && variant->AbilityId == ability.AbilityId ? variant->EquivalentSpellId : spellId;
}

std::uint32_t SharedBuffSeedMinimum(Player const* player, Practice::AbilityProfile const& profile)
{
    std::uint32_t required = 0;
    if (SharedBuffVariantsRequested)
        for (auto const& variant : Practice::DevelopmentBuffVariants::Variants)
            if (auto const* rank = Practice::DevelopmentBuffVariants::EquivalentRank(profile, variant);
                rank && player->HasSpell(variant.SpellId))
                required = std::max(required, rank->Requirement.Proficiency);
    return required;
}

std::span<Practice::AbilityProfile const* const> ProfilesForClass(std::uint32_t classId)
{
    return ProfileLookup ? ProfileLookup->ForClass(classId) : std::span<Practice::AbilityProfile const* const>{};
}

bool IsProfiledPlayer(Player const* player)
{
    return IsDevelopmentPlayer(player) && ProfileLookup && ProfileLookup->HasClass(player->getClass());
}

bool Affects(Player const* player)
{
    return Requested && DevelopmentAllowed && Ready && IsProfiledPlayer(player);
}

std::uint32_t NativeReplacement(Player const* player, Practice::AbilityDefinition const& ability)
{
    if (!player || player->getClass() != ability.ClassId)
        return 0;
    for (Practice::AbilityRank const& rank : ability.Ranks)
    {
        std::uint32_t const replacement = player->GetTemporarySpellReplacement(rank.SpellId);
        if (replacement != rank.SpellId && std::none_of(ability.Ranks.begin(), ability.Ranks.end(),
                [replacement](Practice::AbilityRank const& existing) { return existing.SpellId == replacement; }))
            return replacement;
    }
    return 0;
}

bool AcquisitionAllowed(Player const* player, Practice::AbilityDefinition const& ability, std::uint32_t spellId)
{
    auto const* profile = FindProfile(player, ability.AbilityId);
    bool const trainer = profile && profile->Acquisition == Practice::AcquisitionSource::ClassTrainer;
    if (player && profile && TrainerRanksRequested)
        if (auto const* extension = TrainerRankExtensionEntry(*profile))
            for (auto const& rank : extension->AdditionalTrainerRanks)
                if (rank.SpellId == spellId && !player->HasSpell(spellId) &&
                    (!player->IsSpellFitByClassAndRace(spellId) ||
                        std::any_of(rank.RequiredAbilities.begin(), rank.RequiredAbilities.end(),
                            [player](std::uint32_t required) { return required && !player->HasSpell(required); })))
                    return false;
    return player && player->getClass() == ability.ClassId && !ability.Ranks.empty() &&
        !NativeReplacement(player, ability) &&
        (!trainer || (player->IsSpellFitByClassAndRace(ability.Ranks.front().SpellId) &&
            player->IsSpellFitByClassAndRace(spellId))) &&
        AscensionAcquisition::CanLearnRacialSpell(player, ability.Ranks.front().SpellId) &&
        AscensionAcquisition::CanLearnRacialSpell(player, spellId);
}

bool IsMeleeOrRangedAbility(SpellInfo const* info)
{
    return info && (info->DmgClass == SPELL_DAMAGE_CLASS_MELEE || info->DmgClass == SPELL_DAMAGE_CLASS_RANGED);
}

bool IsBuffObserver(Player const* player)
{
    if (!BuffContributionRequested || !player)
        return false;
    auto const profiles = ProfilesForClass(player->getClass());
    return std::any_of(profiles.begin(), profiles.end(),
        [](Practice::AbilityProfile const* profile)
        {
            return Practice::DevelopmentBuffs::IsSupportedStatBuff(*profile);
        });
}

bool EffectiveBuffComponent(Player* player, AuraApplication const& application, std::uint8_t effectIndex,
    std::uint32_t aura, std::int32_t selector, bool rankedCostReduction = false)
{
    if (effectIndex >= 3 || application.GetRemoveMode() != AURA_REMOVE_NONE || !application.HasEffect(effectIndex) ||
        application.GetBase()->IsRemoved())
        return false;
    AuraEffect const* effect = application.GetBase()->GetEffect(effectIndex);
    bool const costReduction = aura == SPELL_AURA_MOD_POWER_COST_SCHOOL_PCT;
    bool const durationReduction = aura == SPELL_AURA_MOD_AURA_DURATION_BY_DISPEL;
    if ((aura != SPELL_AURA_MOD_STAT && aura != SPELL_AURA_ASCENSION_MOD_SPELL_POWER_FLAT &&
            aura != SPELL_AURA_MOD_POWER_REGEN && aura != SPELL_AURA_MOD_RESISTANCE &&
            aura != SPELL_AURA_MOD_RESISTANCE_EXCLUSIVE && aura != SPELL_AURA_MOD_POWER_COST_SCHOOL_PCT &&
            aura != SPELL_AURA_MOD_ATTACK_POWER && aura != SPELL_AURA_MOD_RANGED_ATTACK_POWER &&
            aura != SPELL_AURA_HASTE_SPELLS && aura != SPELL_AURA_MOD_CRIT_DAMAGE_BONUS &&
            aura != SPELL_AURA_MOD_AURA_DURATION_BY_DISPEL && aura != SPELL_AURA_MOD_HEALING) ||
        !effect || effect->GetAuraType() != aura || effect->GetMiscValue() != selector ||
        (costReduction ? ((rankedCostReduction ? effect->GetAmount() >= 0 : effect->GetAmount() != -5) ||
            selector != 127) : durationReduction ?
                (effect->GetAmount() != -20 || (selector != 1 && selector != 2)) : effect->GetAmount() <= 0))
        return false;
    if (costReduction)
        return true;
    if (durationReduction)
        return Practice::DevelopmentBuffs::ArcaneDurationContributes(effect->GetAmount(),
            player->GetTotalAuraModifierByMiscValue(SPELL_AURA_MOD_AURA_DURATION_BY_DISPEL, selector),
            player->GetMaxNegativeAuraModifierByMiscValue(SPELL_AURA_MOD_AURA_DURATION_BY_DISPEL_NOT_STACK, selector));
    if (aura == SPELL_AURA_MOD_POWER_REGEN && (player->getPowerType() != POWER_MANA ||
        !player->GetMaxPower(POWER_MANA) ||
        player->HasAuraTypeWithMiscvalue(SPELL_AURA_PREVENT_REGENERATE_POWER, POWER_MANA + 1) ||
        sWorld->getRate(RATE_POWER_MANA) <= 0.0f ||
        player->GetFloatValue(UNIT_FIELD_POWER_REGEN_INTERRUPTED_FLAT_MODIFIER + POWER_MANA) <= 0.0f))
        return false;
    if (aura == SPELL_AURA_MOD_RESISTANCE_EXCLUSIVE)
        return player->GetMaxPositiveAuraModifierByMiscMask(SPELL_AURA_MOD_RESISTANCE_EXCLUSIVE,
            static_cast<std::uint32_t>(effect->GetMiscValue()), effect) <= effect->GetAmount();
    std::int64_t const competing = player->GetHighestExclusiveSameEffectSpellGroupValue(
        effect, effect->GetAuraType(),
        aura != SPELL_AURA_ASCENSION_MOD_SPELL_POWER_FLAT && aura != SPELL_AURA_MOD_ATTACK_POWER &&
            aura != SPELL_AURA_MOD_RANGED_ATTACK_POWER && aura != SPELL_AURA_HASTE_SPELLS,
        effect->GetMiscValue());
    std::int64_t const magnitude = competing < 0 ? -competing : competing;
    return magnitude <= effect->GetAmount();
}

bool EffectiveBuffApplication(Player* player, AuraApplication const& application,
    Practice::AbilityProfile const& profile)
{
    if (!EffectiveBuffComponent(player, application, Practice::DevelopmentBuffs::EffectIndex(profile),
        Practice::DevelopmentBuffs::Aura(profile), Practice::DevelopmentBuffs::StatSelector(
            profile, application.GetBase()->GetSpellInfo()->Id)))
        return false;
    if (Practice::DevelopmentBuffs::IsLeylineInscription(profile))
    {
        auto const* vulnerability = application.GetBase()->GetEffect(EFFECT_0);
        if (!application.HasEffect(EFFECT_0) || !vulnerability ||
            vulnerability->GetAuraType() != SPELL_AURA_MOD_DAMAGE_TAKEN ||
            vulnerability->GetMiscValue() != 126 || vulnerability->GetAmount() <= 0)
            return false;
    }
    if (Practice::DevelopmentBuffs::IsPairedAttackPower(profile) &&
        !EffectiveBuffComponent(player, application, EFFECT_1, SPELL_AURA_MOD_RANGED_ATTACK_POWER, 0))
        return false;
    for (std::uint8_t index = 0; index < 3; ++index)
        if (auto const* secondary = Practice::DevelopmentBuffs::SecondaryMechanicFor(profile, index))
            if (!EffectiveBuffComponent(player, application, secondary->EffectIndex, secondary->Aura, secondary->Stat,
                Practice::DevelopmentBuffs::IsWaterTattoo(profile)))
                return false;
    return true;
}

SpellInfo const* AcceptedBuffSpell(Player* player, MenuSession const& session,
    Practice::AbilityProfile const& profile)
{
    auto const found = session.Buffs.find(profile.Definition.AbilityId);
    if (found == session.Buffs.end())
        return nullptr;
    auto const& origin = found->second.Origin;
    if (!origin || !player->HasSpell(origin->SpellId) ||
        !AcquisitionAllowed(player, profile.Definition, origin->SpellId) ||
        std::none_of(profile.Definition.Ranks.begin(), profile.Definition.Ranks.end(),
            [&origin, &profile](Practice::AbilityRank const& rank)
            {
                return rank.SpellId == SharedBuffRankSpellId(profile.Definition, origin->SpellId);
            }))
        return nullptr;
    AuraApplication* application = player->GetAuraApplication(origin->SpellId, player->GetGUID());
    return application && EffectiveBuffApplication(player, *application, profile) &&
        application->GetBase()->GetPracticeCast() == origin ?
        sSpellMgr->GetSpellInfo(origin->SpellId) : nullptr;
}

Practice::BuffPracticeState BuffStateFor(Player* player, MenuSession const& session,
    Practice::AbilityProfile const& profile)
{
    if (!AcquisitionAllowed(player, profile.Definition, profile.Definition.Ranks.front().SpellId) ||
        (std::none_of(profile.Definition.Ranks.begin(), profile.Definition.Ranks.end(),
            [player](Practice::AbilityRank const& rank) { return player->HasSpell(rank.SpellId); }) &&
            (!SharedBuffVariantsRequested || std::none_of(Practice::DevelopmentBuffVariants::Variants.begin(),
                Practice::DevelopmentBuffVariants::Variants.end(), [&profile, player](auto const& variant)
                {
                    return Practice::DevelopmentBuffVariants::EquivalentRank(profile, variant) &&
                        player->HasSpell(variant.SpellId);
                }))))
        return Practice::BuffPracticeState::Unavailable;
    if (AcceptedBuffSpell(player, session, profile))
        return Practice::BuffPracticeState::Ready;
    for (auto const& rank : profile.Definition.Ranks)
        if (AuraApplication* application = player->GetAuraApplication(rank.SpellId, player->GetGUID());
            application && !application->GetBase()->IsRemoved() && application->GetRemoveMode() == AURA_REMOVE_NONE)
            return EffectiveBuffApplication(player, *application, profile) ?
                Practice::BuffPracticeState::Reapply : Practice::BuffPracticeState::Suppressed;
    if (SharedBuffVariantsRequested)
        for (auto const& variant : Practice::DevelopmentBuffVariants::Variants)
            if (Practice::DevelopmentBuffVariants::EquivalentRank(profile, variant))
                if (AuraApplication* application = player->GetAuraApplication(variant.SpellId, player->GetGUID());
                    application && !application->GetBase()->IsRemoved() &&
                        application->GetRemoveMode() == AURA_REMOVE_NONE)
                    return EffectiveBuffApplication(player, *application, profile) ?
                        Practice::BuffPracticeState::Reapply : Practice::BuffPracticeState::Suppressed;
    return Practice::BuffPracticeState::Inactive;
}

std::uint32_t CachedCustomSpecialization(Player const* player)
{
    auto const* values = player->FindPlayerSettings(ActiveSpecializationSource);
    return values && !values->empty() ? values->front().value : 0;
}

std::uint64_t NewActionSession()
{
    return NextActionSession == std::numeric_limits<std::uint64_t>::max() ? 0 : ++NextActionSession;
}

bool ReceiptOwnerMatches(Player const* player, MenuSession const& session,
    CoAAbilityPractice::CastReceipt const& receipt)
{
    return session.Initialized && receipt.Session && receipt.Session == session.ActionSession &&
        receipt.CasterGUID == player->GetGUID().GetRawValue() && receipt.ClassId == player->getClass() &&
        receipt.RaceId == player->getRace() && receipt.TalentSet == player->GetActiveSpec() &&
        receipt.Specialization == CachedCustomSpecialization(player);
}

bool ReceiptMatches(Player const* player, MenuSession const& session, CoAAbilityPractice::CastReceipt const& receipt)
{
    return !receipt.IsConsumed() && ReceiptOwnerMatches(player, session, receipt);
}

bool IsDevelopmentOpponent(Player const* player, Unit const* opponent)
{
    if (!opponent || !opponent->IsCreature() || opponent->IsControlledByPlayer() || opponent->IsPet() ||
        opponent->IsTotem() || opponent->IsCritter() || player->IsFriendlyTo(opponent) ||
        opponent->getLevelForTarget(player) <= Acore::XP::GetGrayLevel(player->GetLevel()))
        return false;
    std::string const& script = sObjectMgr->GetScriptName(opponent->ToCreature()->GetScriptId());
    return script != "npc_training_dummy" && script != "npc_target_dummy";
}

bool HasCapturedCorpse(Player const* player, CoAAbilityPractice::CastReceipt const& receipt)
{
    if (!HelpersRequested || !MasteryRequested || !player || !player->IsInWorld() || !player->FindMap() ||
        receipt.ClassId != 30 || receipt.SpellId != 561289 || !receipt.GetCapturedCorpseGUID())
        return false;
    Unit* corpse = ObjectAccessor::GetUnit(*player, ObjectGuid(receipt.GetCapturedCorpseGUID()));
    return corpse && !corpse->IsAlive() && corpse->IsInMap(player) && corpse->InSamePhase(player) &&
        corpse->HasAura(572887, player->GetGUID()) && IsDevelopmentOpponent(player, corpse);
}

void BindCorpseRecovery(Spell* spell, Unit* corpse, bool resourceGain)
{
    if (!Active.load() || !HelpersRequested || !MasteryRequested || !spell || !corpse || corpse->IsAlive() ||
        !spell->GetCaster() || !spell->GetSpellInfo() || spell->GetSpellInfo()->Id != 561289)
        return;
    Player* player = spell->GetCaster()->ToPlayer();
    auto const* profile = FindProfile(player, 561289);
    auto const receipt = spell->GetPracticeCast();
    std::uint64_t const source = (std::uint64_t{ 30 } << 32) | 561289;
    if (!IsProfiledPlayer(player) || !player->IsInWorld() || !player->FindMap() || !player->HasSpell(561289) ||
        !profile || !Practice::DevelopmentMastery::IsSoulCapture(*profile) ||
        !receipt || spell->GetScriptValue(PracticeCastSourceKey) != source || spell->IsTriggered() ||
        receipt->SpellId != 561289 || !IsDevelopmentOpponent(player, corpse) ||
        !corpse->HasAura(572887, player->GetGUID()))
        return;
    std::lock_guard lock(Mutex);
    auto const session = Sessions.find(player->GetGUID().GetRawValue());
    if (Affects(player) && !player->isBeingLoaded() && session != Sessions.end() &&
        ReceiptMatches(player, session->second, *receipt) &&
        AcquisitionAllowed(player, profile->Definition, 561289))
        receipt->BindCapturedCorpse(corpse->GetGUID().GetRawValue(), resourceGain);
}

bool HasDevelopmentEncounter(Player const* player, Unit const* recipient)
{
    for (auto const& entry : recipient->GetCombatManager().GetPvECombatRefs())
    {
        CombatReference const* reference = entry.second;
        if (!reference || reference->IsSuppressedFor(recipient))
            continue;
        Unit const* opponent = reference->GetOther(recipient);
        if (!reference->IsSuppressedFor(opponent) && opponent->IsAlive() &&
            IsDevelopmentOpponent(player, opponent))
            return true;
    }
    return false;
}

bool QualifiesDevelopmentOutcome(Practice::OutcomeKind outcome, Player const* player, Unit const* target,
    uint32 damage, uint32 healing)
{
    if (outcome == Practice::OutcomeKind::Damage || outcome == Practice::OutcomeKind::DamageOrInterrupt ||
        outcome == Practice::OutcomeKind::DamageOrDispel)
        return damage && IsDevelopmentOpponent(player, target);
    return outcome == Practice::OutcomeKind::Healing && healing && player->IsFriendlyTo(target) &&
        HasDevelopmentEncounter(player, target);
}

std::vector<std::uint32_t> Learned(Player const* player, Practice::AbilityDefinition const& ability,
    bool includeEarlierNativeEquivalent = true)
{
    std::vector<std::uint32_t> spells;
    for (Practice::AbilityRank const& rank : ability.Ranks)
        if (player->HasSpell(rank.SpellId))
            spells.push_back(rank.SpellId);
    if (SharedBuffVariantsRequested)
        for (auto const& variant : Practice::DevelopmentBuffVariants::Variants)
            if (variant.ClassId == ability.ClassId && variant.AbilityId == ability.AbilityId &&
                (includeEarlierNativeEquivalent || !Practice::DevelopmentBuffVariants::HasEarlierNativeLevel(variant)) &&
                player->HasSpell(variant.SpellId) && !Practice::KnowsSpell(spells, variant.EquivalentSpellId))
                spells.push_back(variant.EquivalentSpellId);
    return spells;
}

CoAAbilityPractice::RankDecision EvaluateRank(Player const* player, std::uint32_t spellId)
{
    using Decision = CoAAbilityPractice::RankDecision;
    if (!RankActive.load() || !IsProfiledPlayer(player))
        return Decision::Unmanaged;
    auto const* variant = SharedBuffVariantsRequested ?
        Practice::DevelopmentBuffVariants::Find(player->getClass(), spellId) : nullptr;
    if (variant && player->HasSpell(spellId))
        return Decision::Allowed;
    if (variant && player->GetLevel() < variant->CharacterLevel)
        return Decision::Blocked;
    auto const* profile = FindProfile(player, spellId);
    if (!profile || profile->Definition.Kind == Practice::AbilityKind::Fixed ||
        spellId == profile->Definition.Ranks.front().SpellId)
        return Decision::Unmanaged;
    auto const* ability = &profile->Definition;
    std::lock_guard lock(Mutex);
    if (!RankRequested || !Affects(player))
        return Decision::Unmanaged;
    std::uint32_t const canonicalSpellId = SharedBuffRankSpellId(*ability, spellId);
    auto const desired = std::find_if(ability->Ranks.begin(), ability->Ranks.end(),
        [canonicalSpellId](Practice::AbilityRank const& rank) { return rank.SpellId == canonicalSpellId; });
    if (desired == ability->Ranks.end())
        return Decision::Blocked;
    if (!variant && !player->HasSpell(spellId) && player->GetLevel() < desired->Requirement.CharacterLevel)
        return Decision::Blocked;
    auto const learned = Learned(player, *ability);
    for (Practice::AbilityRank const& rank : ability->Ranks)
        if (rank.RankNumber >= desired->RankNumber && Practice::KnowsSpell(learned, rank.SpellId))
            return Decision::Allowed;
    if (!AcquisitionAllowed(player, *ability, spellId))
        return Decision::Blocked;
    auto const loaded = Practice::ReadPlayerProgress(*player, ability->ClassId, ability->AbilityId,
        profile->Policy, profile->DefinitionVersion);
    auto const record = Practice::MigrateLearnedRanks(*ability, profile->Policy, loaded, learned);
    if (!record)
        return Decision::Blocked;
    auto view = Practice::DescribeRank(*ability, static_cast<std::size_t>(desired - ability->Ranks.begin()),
        profile->Policy, record->State, player->GetLevel(), learned, true);
    if (variant && Practice::DevelopmentBuffVariants::HasEarlierNativeLevel(*variant) &&
        view.State == Practice::RankState::NeedsCharacterLevel)
        view.State = Practice::RankState::Ready;
    return view.State == Practice::RankState::Ready ? Decision::Allowed : Decision::Blocked;
}

bool CanPurchaseSpell(Player const* player, std::uint32_t spellId)
{
    if (!RankActive.load() || !IsProfiledPlayer(player))
        return true;
    std::lock_guard lock(Mutex);
    if (!RankRequested || !Affects(player))
        return true;
    std::array<std::uint32_t, 128> spells{};
    spells[0] = spellId;
    std::size_t count = 1;
    for (std::size_t index = 0; index < count; ++index)
    {
        std::uint32_t const current = spells[index];
        if (!player->HasSpell(current) && EvaluateRank(player, current) != CoAAbilityPractice::RankDecision::Unmanaged)
            return false;
        SpellInfo const* info = sSpellMgr->GetSpellInfo(current);
        if (!info)
            return false;
        for (SpellEffectInfo const& effect : info->GetEffects())
        {
            if (!effect.IsEffect(SPELL_EFFECT_LEARN_SPELL) || !effect.TriggerSpell)
                continue;
            auto const end = spells.begin() + count;
            if (std::find(spells.begin(), end, effect.TriggerSpell) != end)
                continue;
            if (count == spells.size())
                return false;
            spells[count++] = effect.TriggerSpell;
        }
    }
    return true;
}

void PromoteRanks(Player* player)
{
    if (!RankActive.load() || !IsProfiledPlayer(player))
        return;
    for (Practice::AbilityProfile const* indexed : ProfilesForClass(player->getClass()))
    {
        Practice::AbilityProfile const& profile = *indexed;
        if (profile.Definition.ClassId != player->getClass())
            continue;
        for (Practice::AbilityRank const& rank : profile.Definition.Ranks)
            if (RankActive.load() && profile.Definition.ClassId == player->getClass() && rank.RankNumber > 1 &&
                !player->HasSpell(rank.SpellId) &&
                EvaluateRank(player, rank.SpellId) == CoAAbilityPractice::RankDecision::Allowed)
                player->learnSpell(rank.SpellId, false);
    }
    if (SharedBuffVariantsRequested)
        for (auto const& variant : Practice::DevelopmentBuffVariants::Variants)
        {
            auto const* profile = FindProfile(player, variant.SpellId);
            if (variant.ClassId == player->getClass() && profile &&
                profile->Definition.Kind == Practice::AbilityKind::Ranked &&
                !player->HasSpell(variant.SpellId) &&
                (player->HasSpell(variant.EquivalentSpellId) ||
                    Practice::DevelopmentBuffVariants::HasEarlierNativeLevel(variant)) &&
                EvaluateRank(player, variant.SpellId) == CoAAbilityPractice::RankDecision::Allowed)
                player->learnSpell(variant.SpellId, false);
        }
}

void SendMenuMessage(Player* player, std::string const& message)
{
    WorldPacket packet;
    ChatHandler::BuildChatPacket(packet, CHAT_MSG_WHISPER, LANG_ADDON, player, nullptr, "HXAP\t" + message);
    player->SendDirectMessage(&packet);
}

void ClearDelivery(MenuSession& session)
{
    std::vector<std::string>().swap(session.Outgoing);
    session.NextMessage = 0;
    session.OutgoingClass = 0;
    session.DeliveryDeadline = {};
}

void QueueDelivery(MenuSession& session, std::uint32_t classId, std::vector<std::string> messages,
    Clock::time_point now)
{
    session.Outgoing = std::move(messages);
    session.NextMessage = 0;
    session.OutgoingClass = classId;
    session.DeliveryDeadline = now + DeliveryDuration;
}

void Deliver(Player* player, MenuSession& session, Clock::time_point now)
{
    if (session.Outgoing.empty() || now < session.NextDelivery)
        return;
    std::size_t const end = std::min(session.Outgoing.size(), session.NextMessage + DeliveryBatchSize);
    while (session.NextMessage < end)
        SendMenuMessage(player, session.Outgoing[session.NextMessage++]);
    session.NextDelivery = now + DeliveryInterval;
    if (session.NextMessage == session.Outgoing.size())
        ClearDelivery(session);
}

bool Send(Player* player, MenuSession& session, Clock::time_point now)
{
    if (!Requested || !DevelopmentAllowed || !Ready || !IsDevelopmentPlayer(player) ||
        Revision == std::numeric_limits<std::uint32_t>::max())
        return false;
    auto const currentProgress = session.Progress.find(player->getClass());
    std::vector<Practice::AbilityView> views;
    bool const supported = Affects(player);
    if (supported)
        for (Practice::AbilityProfile const* indexed : ProfilesForClass(player->getClass()))
        {
            Practice::AbilityProfile const& profile = *indexed;
            Practice::AbilityDefinition const& ability = profile.Definition;
            if (ability.ClassId != player->getClass())
                continue;
            if (session.Protocol < Practice::TypedMenuSchemaVersion &&
                (ability.Kind == Practice::AbilityKind::Mastery ||
                    Practice::DevelopmentBuffs::IsSupportedStatBuff(profile)))
                continue;
            if (profile.Outcome == Practice::OutcomeKind::ResourceDrain &&
                session.Protocol < Practice::ResourceMenuSchemaVersion)
                continue;
            auto const learned = Learned(player, ability, false);
            Practice::Progress state;
            if (ability.Kind != Practice::AbilityKind::Fixed)
            {
                auto const loaded = Practice::ReadPlayerProgress(*player, ability.ClassId, ability.AbilityId,
                    profile.Policy, profile.DefinitionVersion);
                auto const migrated = Practice::MigrateLearnedRanks(ability, profile.Policy, loaded, learned);
                if (!migrated)
                {
                    if (session.Protocol < Practice::TypedMenuSchemaVersion)
                        return false;
                    auto const failure = Practice::EncodeMenuProgressFailure(++Revision, ability.ClassId,
                        ability.AbilityId, ability.Ranks.front().SpellId, ServerGeneration,
                        loaded.Status == Practice::LoadStatus::DefinitionMismatch ?
                            Practice::ProgressIssue::DefinitionMismatch : Practice::ProgressIssue::Unreadable);
                    if (!failure)
                        return false;
                    QueueDelivery(session, player->getClass(), { *failure }, now);
                    return true;
                }
                state = migrated->State;
            }
            bool const acquisition = AcquisitionAllowed(player, ability, ability.Ranks.front().SpellId);
            auto const effective = Practice::BuildCatchupPolicy(profile.Policy,
                Practice::CapAtLevel(ability, player->GetLevel()), Catchup);
            if (!effective)
                return false;
            auto view = Practice::BuildAbilityView(ability, effective->View(), state,
                player->GetLevel(), learned, acquisition);
            if (ability.Kind == Practice::AbilityKind::Mastery)
                view.Rewards = Practice::DescribeMasteryRewards(ability, profile.Rewards, effective->View(),
                    state, player->GetLevel(), !learned.empty(), acquisition);
            for (Practice::RankView& rank : view.Ranks)
                if (rank.State != Practice::RankState::Learned && !AcquisitionAllowed(player, ability, rank.SpellId))
                    rank.State = Practice::RankState::MissingPrerequisite;
            if (view.NextRank)
                view.NextRank = view.Ranks[view.NextRank->RankNumber - 1];
            view.Route = BuffContributionRequested && Practice::DevelopmentBuffs::IsSupportedStatBuff(profile)
                ? Practice::PracticeRoute::BuffCombat :
                ControlRequested && Practice::DevelopmentControl::SupportsStun(profile)
                ? Practice::PracticeRoute::DamageOrStun :
                ControlRequested && Practice::DevelopmentControl::SupportsRoot(profile)
                ? Practice::PracticeRoute::DamageOrRoot :
                AbsorptionRequested && Practice::DevelopmentAbsorption::IsEmeraldVeil(profile)
                ? Practice::PracticeRoute::HealingAbsorption : RouteFor(profile.Outcome);
            view.AcquisitionSourceId = static_cast<std::uint32_t>(profile.Acquisition);
            if (view.Route == Practice::PracticeRoute::BuffCombat)
                view.BuffState = BuffStateFor(player, session, profile);
            view.ReplacementSpellId = NativeReplacement(player, ability);
            view.RuleSet = HelpersRequested && MasteryRequested &&
                Practice::DevelopmentMastery::IsSoulCapture(profile) ? Practice::HumanPvECorpseRecoveryRuleSet :
                HelpersRequested && MasteryRequested && (Practice::DevelopmentMastery::IsBaneOfBetrayal(profile) ||
                    Practice::DevelopmentMastery::IsFrostSigil(profile)) ?
                Practice::HumanPvEScriptedDamageRuleSet :
                HelpersRequested && Practice::DevelopmentHelpers::IsManafeed(profile) ?
                Practice::HumanPvEScriptedHealRuleSet :
                PeriodicPracticeAbilities.contains(ProfileKey(ability)) ?
                    Practice::HumanPvEPeriodicRuleSet : Practice::HumanPvERuleSet;
            if (Catchup.Enabled && ability.Kind != Practice::AbilityKind::Fixed)
            {
                view.RuleSet = view.RuleSet == Practice::HumanPvECorpseRecoveryRuleSet ?
                    Practice::HumanPvECorpseRecoveryCatchupRuleSet :
                    view.RuleSet == Practice::HumanPvEScriptedDamageRuleSet ?
                    Practice::HumanPvEScriptedDamageCatchupRuleSet : view.RuleSet + 3;
                auto const base = profile.Policy.Bands[Practice::Detail::BandIndex(profile.Policy, state.Proficiency)];
                auto const rate = effective->View().Bands[
                    Practice::Detail::BandIndex(effective->View(), state.Proficiency)];
                view.Catchup = Practice::CatchupView{ Catchup.Gap, Catchup.Multiplier,
                    base.PointsPerUse, rate.PointsPerUse,
                    state.Proficiency < view.Cap && view.Cap - state.Proficiency >= Catchup.Gap };
            }
            view.Session = {};
            if (currentProgress != session.Progress.end())
            {
                auto const progress = currentProgress->second.Abilities.find(ability.AbilityId);
                if (progress != currentProgress->second.Abilities.end())
                    view.Session = progress->second;
            }
            if (session.Protocol >= Practice::SharedMenuSchemaVersion && SharedBuffVariantsRequested)
                for (auto const& variant : Practice::DevelopmentBuffVariants::Variants)
                    if (auto const* equivalent = Practice::DevelopmentBuffVariants::EquivalentRank(profile, variant))
                    {
                        auto rank = view.Ranks[equivalent->RankNumber - 1];
                        rank.SpellId = variant.SpellId;
                        rank.Requirement.CharacterLevel = variant.CharacterLevel;
                        bool const levelMet = player->GetLevel() >= variant.CharacterLevel;
                        bool const practiceMet = state.Proficiency >= equivalent->Requirement.Proficiency;
                        rank.State = player->HasSpell(variant.SpellId) ? Practice::RankState::Learned :
                            !AcquisitionAllowed(player, ability, variant.SpellId) ?
                                Practice::RankState::MissingPrerequisite :
                            ability.Kind == Practice::AbilityKind::Fixed ?
                                (levelMet ? Practice::RankState::AcquireIntroductoryAbility :
                                    Practice::RankState::NeedsCharacterLevel) :
                            learned.empty() ? Practice::RankState::AcquireIntroductoryAbility :
                            levelMet && practiceMet ? Practice::RankState::Ready :
                            levelMet ? Practice::RankState::NeedsPractice :
                            practiceMet ? Practice::RankState::NeedsCharacterLevel : Practice::RankState::NeedsBoth;
                        view.SharedAbilities.push_back({ rank, variant.EquivalentSpellId });
                    }
            views.push_back(std::move(view));
        }
    auto const progress = !supported ? Practice::SessionPractice{ false, 0, 0 } :
        currentProgress == session.Progress.end() ? Practice::SessionPractice{} : currentProgress->second.Totals;
    auto mastery = !supported ? Practice::SessionMasteryView{ false, 0, {} } :
        currentProgress == session.Progress.end() ? Practice::SessionMasteryView{ true, 0, {} } :
        currentProgress->second.Mastery.View();
    if (session.Protocol < Practice::ResourceMenuSchemaVersion &&
        std::any_of(mastery.Events.begin(), mastery.Events.end(), [](auto const& event)
        { return event.Reward.ResourceDrainBonusBasisPoints != 0; }))
        mastery = { false, 0, {} };
    auto messages = Practice::EncodeMenuSnapshot(player->getClass(), player->GetLevel(), ++Revision, views,
        session.Protocol >= Practice::SessionMenuSchemaVersion
            ? std::optional<Practice::SessionPractice>(progress) : std::nullopt,
        session.Protocol >= Practice::RoadmapMenuSchemaVersion, session.Protocol >= Practice::TypedMenuSchemaVersion,
        ServerGeneration, sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL),
        session.Protocol >= Practice::TypedMenuSchemaVersion
            ? std::optional<Practice::SessionLearningView>(!supported
                ? Practice::SessionLearningView{ false, 0, {} } : currentProgress == session.Progress.end()
                    ? Practice::SessionLearningView{ true, 0, {} } : currentProgress->second.Learning.View())
            : std::nullopt,
        session.Protocol >= Practice::TypedMenuSchemaVersion
            ? std::optional<Practice::SessionMasteryView>(mastery)
            : std::nullopt, session.Protocol >= Practice::SharedMenuSchemaVersion,
        session.Protocol >= Practice::ResourceMenuSchemaVersion);
    if (!messages || messages->size() > MaxQueuedMessages)
        return false;
    if (session.Protocol >= Practice::TypedMenuSchemaVersion)
    {
        QueueDelivery(session, player->getClass(), std::move(*messages), now);
        return true;
    }
    for (std::string const& message : *messages)
        SendMenuMessage(player, message);
    return true;
}

void Refresh(Player* player, MenuSession& session, Clock::time_point now)
{
    if (now < session.InterestedUntil && now >= session.NextBuffStateRefresh && IsBuffObserver(player))
    {
        session.NextBuffStateRefresh = now + RefreshInterval;
        for (auto const* profile : ProfilesForClass(player->getClass()))
        {
            if (!Practice::DevelopmentBuffs::IsSupportedStatBuff(*profile))
                continue;
            auto const state = BuffStateFor(player, session, *profile);
            auto& previous = session.Buffs[profile->Definition.AbilityId].LastState;
            if (previous != state)
            {
                previous = state;
                session.Dirty = true;
            }
        }
    }
    if (!session.Outgoing.empty())
    {
        if (session.OutgoingClass != player->getClass() || now >= session.DeliveryDeadline)
        {
            ClearDelivery(session);
            session.Dirty = true;
        }
        else
        {
            Deliver(player, session, now);
            if (!session.Outgoing.empty())
                return;
        }
    }
    if (!session.Dirty || now < session.NextRefresh || now >= session.InterestedUntil)
        return;
    session.NextRefresh = now + RefreshInterval;
    if (Send(player, session, now))
    {
        session.Dirty = false;
        Deliver(player, session, now);
    }
}

void ObserveMastery(Player* player, MenuSession& session, bool baseline,
    std::uint32_t characterLevel = 0);

void RecordAward(Player* player, MenuSession& session, Practice::AbilityProfile const& profile,
    Practice::OutcomeAward const& award, bool refresh = true)
{
    if (award.Status != Practice::OutcomeStatus::Awarded)
        return;
    ClassSession& progress = session.Progress[player->getClass()];
    progress.Totals.RecordAward(award.ProficiencyGained);
    progress.Abilities[profile.Definition.AbilityId].RecordAward(award.ProficiencyGained);
    if (profile.Definition.Kind == Practice::AbilityKind::Mastery)
        ObserveMastery(player, session, false);
    session.Dirty = true;
    session.CheckRanks = true;
    if (refresh)
        Refresh(player, session, Clock::now());
}

void AwardOutcome(Player* player, Spell* spell, Practice::AbilityProfile const& profile)
{
    std::lock_guard lock(Mutex);
    std::uint64_t const source = (static_cast<std::uint64_t>(profile.Definition.ClassId) << 32) |
        spell->GetSpellInfo()->Id;
    if (!Affects(player) || player->isBeingLoaded() || spell->GetScriptValue(PracticeCastSourceKey) != source ||
        !AcquisitionAllowed(player, profile.Definition, spell->GetSpellInfo()->Id))
        return;
    auto const found = Sessions.find(player->GetGUID().GetRawValue());
    auto const receipt = spell->GetPracticeCast();
    if (found == Sessions.end() || !receipt || !ReceiptMatches(player, found->second, *receipt) ||
        receipt->SpellId != spell->GetSpellInfo()->Id)
        return;
    auto& session = found->second;
    Practice::OutcomeContext const context{ true, true, true, true, player->GetLevel() };
    auto const effective = Practice::BuildCatchupPolicy(profile.Policy,
        Practice::CapAtLevel(profile.Definition, player->GetLevel()), Catchup);
    if (!effective)
        return;
    if (profile.Definition.Kind == Practice::AbilityKind::Mastery)
        ObserveMastery(player, session, false);
    auto const award = Practice::HandleOutcome(*player, *spell, profile.Definition,
        effective->View(), profile.DefinitionVersion, context);
    if (award.Status == Practice::OutcomeStatus::Awarded || award.Status == Practice::OutcomeStatus::Capped)
        receipt->MarkConsumed();
    RecordAward(player, session, profile, award);
}

bool IsBaneDamage(Practice::AbilityProfile const* profile, std::uint32_t spellId)
{
    return HelpersRequested && MasteryRequested && profile &&
        Practice::DevelopmentMastery::IsBaneOfBetrayal(*profile) && spellId == 807554;
}

bool IsDamagePalmSigil(Practice::AbilityProfile const& profile, std::uint32_t originId, std::uint32_t helperId)
{
    return (Practice::DevelopmentHelpers::IsFireSigil(profile) &&
        Practice::DevelopmentHelpers::IsFireSigilDamage(originId, helperId)) ||
        (MasteryRequested && Practice::DevelopmentMastery::IsFrostSigil(profile) &&
            originId == 805381 && helperId == 807825);
}

bool IsScriptedDamage(Practice::AbilityProfile const* profile, std::uint32_t originId, std::uint32_t helperId)
{
    return IsBaneDamage(profile, helperId) || (HelpersRequested && profile &&
        ((Practice::DevelopmentHelpers::IsTwinSlice(*profile) &&
            Practice::DevelopmentHelpers::IsTwinDamage(originId, helperId)) ||
            IsDamagePalmSigil(*profile, originId, helperId)));
}

struct ReceiptCast
{
    Player* Caster;
    SpellInfo const* Info;
    CoAAbilityPractice::CastReceipt& Receipt;

    bool IsTriggered() const { return false; }
    Player* GetCaster() const { return Caster; }
    SpellInfo const* GetSpellInfo() const { return Info; }
    std::uint64_t GetScriptValue(std::uint32_t key) const
    {
        return key == Practice::PracticeAwardScriptKey && Receipt.IsConsumed();
    }
    void SetScriptValue(std::uint32_t key, std::uint64_t value)
    {
        if (key == Practice::PracticeAwardScriptKey && value)
            Receipt.MarkConsumed();
    }
};

void AwardScriptedDamage(Player* player, Spell* spell, Unit* target, std::uint32_t damage)
{
    auto const receipt = spell->GetPracticeCast();
    if (!receipt || receipt->IsConsumed())
        return;
    auto const* profile = FindProfile(player, receipt->SpellId);
    if (!IsScriptedDamage(profile, receipt->SpellId, spell->GetSpellInfo()->Id) ||
        !QualifiesDevelopmentOutcome(Practice::OutcomeKind::Damage, player, target, damage, 0))
        return;
    std::lock_guard lock(Mutex);
    auto const found = Sessions.find(player->GetGUID().GetRawValue());
    if (!Affects(player) || player->isBeingLoaded() || found == Sessions.end() ||
        !ReceiptMatches(player, found->second, *receipt) ||
        !AcquisitionAllowed(player, profile->Definition, receipt->SpellId))
        return;
    auto* nextPractice = Practice::DevelopmentHelpers::IsFireSigil(*profile) ?
        &found->second.NextFireSigilPractice : Practice::DevelopmentMastery::IsFrostSigil(*profile) ?
        &found->second.NextFrostSigilPractice : nullptr;
    auto const now = Clock::now();
    if (nextPractice && now < *nextPractice)
    {
        receipt->MarkConsumed();
        return;
    }
    auto const effective = Practice::BuildCatchupPolicy(profile->Policy,
        Practice::CapAtLevel(profile->Definition, player->GetLevel()), Catchup);
    if (!effective)
        return;
    if (profile->Definition.Kind == Practice::AbilityKind::Mastery)
        ObserveMastery(player, found->second, false);
    ReceiptCast cast{ player, sSpellMgr->GetSpellInfo(receipt->SpellId), *receipt };
    Practice::OutcomeContext const context{ true, true, true, true, player->GetLevel() };
    auto const award = Practice::HandleOutcome(*player, cast, profile->Definition,
        effective->View(), profile->DefinitionVersion, context);
    if (award.Status == Practice::OutcomeStatus::Capped)
        receipt->MarkConsumed();
    if (nextPractice && award.Status == Practice::OutcomeStatus::Awarded)
        *nextPractice = now + std::chrono::seconds(Practice::DevelopmentHelpers::IsFireSigil(*profile) ?
            Practice::DevelopmentHelpers::FirePracticeIntervalSeconds :
            Practice::DevelopmentMastery::FrostPracticeIntervalSeconds);
    RecordAward(player, found->second, *profile, award);
}

void BindBuffOrigin(Player* player, Spell* spell, Unit* target)
{
    if (!IsBuffObserver(player) || target != player || !spell)
        return;
    auto const* profile = FindProfile(player, spell->GetSpellInfo()->Id);
    if (!profile || !Practice::DevelopmentBuffs::IsSupportedStatBuff(*profile))
        return;
    std::lock_guard lock(Mutex);
    auto const session = Sessions.find(player->GetGUID().GetRawValue());
    auto const receipt = spell->GetPracticeCast();
    Aura* aura = player->GetAura(spell->GetSpellInfo()->Id, player->GetGUID());
    if (Affects(player) && session != Sessions.end() && receipt && aura &&
        ReceiptOwnerMatches(player, session->second, *receipt) && aura->GetPracticeCast() == receipt &&
        receipt->SpellId == spell->GetSpellInfo()->Id)
        session->second.Buffs[profile->Definition.AbilityId].Origin = receipt;
}

bool AwardOwnedBuffContribution(Player* player, MenuSession& session,
    Practice::AbilityProfile const& profile, Clock::time_point now)
{
    auto const buff = session.Buffs.find(profile.Definition.AbilityId);
    if (buff == session.Buffs.end())
        return false;
    auto const origin = buff->second.Origin;
    if (!origin || !ReceiptOwnerMatches(player, session, *origin) || now < buff->second.NextContribution)
        return false;
    SpellInfo const* info = AcceptedBuffSpell(player, session, profile);
    if (!info)
        return false;
    auto const effective = Practice::BuildCatchupPolicy(profile.Policy,
        Practice::CapAtLevel(profile.Definition, player->GetLevel()), Catchup);
    if (!effective)
        return false;
    CoAAbilityPractice::CastReceipt contribution(player->GetGUID().GetRawValue(), session.ActionSession,
        player->getClass(), origin->SpellId, player->getRace(), player->GetActiveSpec(),
        session.LastCustomSpecialization);
    ReceiptCast cast{ player, sSpellMgr->GetSpellInfo(
        SharedBuffRankSpellId(profile.Definition, info->Id)), contribution };
    Practice::OutcomeContext const context{ true, true, true, true, player->GetLevel() };
    auto const award = Practice::HandleOutcome(*player, cast, profile.Definition,
        effective->View(), profile.DefinitionVersion, context);
    bool const accepted = award.Status == Practice::OutcomeStatus::Awarded ||
        award.Status == Practice::OutcomeStatus::Capped;
    if (accepted)
        buff->second.NextContribution = now + std::chrono::seconds(5);
    RecordAward(player, session, profile, award, false);
    return accepted;
}

void AwardBuffContribution(Player* player, Spell* spell, Unit* target, std::uint32_t damage, std::uint32_t healing)
{
    if (!IsBuffObserver(player) || !spell || !spell->GetScriptValue(PracticeBuffEligibilityKey) ||
        (!QualifiesDevelopmentOutcome(Practice::OutcomeKind::Damage, player, target, damage, 0) &&
            !QualifiesDevelopmentOutcome(Practice::OutcomeKind::Healing, player, target, 0, healing)))
        return;
    std::lock_guard lock(Mutex);
    auto const found = Sessions.find(player->GetGUID().GetRawValue());
    auto const action = spell->GetPracticeCast();
    if (!Affects(player) || player->isBeingLoaded() || found == Sessions.end() || !action ||
        !ReceiptOwnerMatches(player, found->second, *action) || action->SpellId != spell->GetSpellInfo()->Id ||
        spell->IsTriggered() || spell->m_CastItem || !spell->m_castItemGUID.IsEmpty() ||
        spell->GetSpellInfo()->IsAutoRepeatRangedSpell() ||
        !player->HasSpell(action->SpellId) || !player->IsSpellFitByClassAndRace(action->SpellId))
        return;
    auto& session = found->second;
    auto* periodic = session.PeriodicBuffCasts.Find(action);
    auto const now = Clock::now();
    for (auto const* profile : ProfilesForClass(player->getClass()))
    {
        if (Practice::DevelopmentBuffs::IsPairedAttackPower(*profile) &&
            (!damage || !IsMeleeOrRangedAbility(spell->GetSpellInfo())))
            continue;
        std::uint64_t const bit = Practice::DevelopmentBuffs::ContributionBit(*profile);
        if (!bit || !(spell->GetScriptValue(PracticeBuffEligibilityKey) & bit) ||
            (spell->GetScriptValue(PracticeBuffContributionKey) & bit) ||
            (periodic && (periodic->AwardedBits & bit)))
            continue;
        auto const buff = session.Buffs.find(profile->Definition.AbilityId);
        if (periodic && (buff == session.Buffs.end() || !periodic->MatchesOrigin(bit, buff->second.Origin)))
            continue;
        if (AwardOwnedBuffContribution(player, session, *profile, now))
        {
            spell->SetScriptValue(PracticeBuffContributionKey,
                spell->GetScriptValue(PracticeBuffContributionKey) | bit);
            if (periodic)
                periodic->AwardedBits |= bit;
        }
    }
}

void AwardPeriodicBuffContribution(Player* player, Unit* target, std::uint32_t auraSpellId,
    std::uint32_t auraType, std::uint32_t damage, std::uint32_t healing,
    std::shared_ptr<CoAAbilityPractice::CastReceipt> const& action)
{
    if (!PeriodicRequested || !IsBuffObserver(player) || auraSpellId != action->SpellId)
        return;
    auto const* info = sSpellMgr->GetSpellInfo(action->SpellId);
    bool const periodicDamage = auraType == SPELL_AURA_PERIODIC_DAMAGE ||
        auraType == SPELL_AURA_PERIODIC_DAMAGE_PERCENT || auraType == SPELL_AURA_PERIODIC_LEECH;
    bool const periodicHealing = auraType == SPELL_AURA_PERIODIC_HEAL;
    if (!info || (!periodicDamage && !periodicHealing) || !info->HasAura(static_cast<AuraType>(auraType)) ||
        !QualifiesDevelopmentOutcome(periodicDamage ? Practice::OutcomeKind::Damage : Practice::OutcomeKind::Healing,
            player, target, periodicDamage ? damage : 0, periodicHealing ? healing : 0))
        return;
    std::lock_guard lock(Mutex);
    auto const found = Sessions.find(player->GetGUID().GetRawValue());
    auto const* profile = FindProfile(player, action->SpellId);
    if (!Affects(player) || player->isBeingLoaded() || found == Sessions.end() ||
        !ReceiptOwnerMatches(player, found->second, *action) ||
        !player->HasSpell(action->SpellId) || !player->IsSpellFitByClassAndRace(action->SpellId) ||
        !AscensionAcquisition::CanLearnRacialSpell(player, action->SpellId) ||
        (profile && !AcquisitionAllowed(player, profile->Definition, action->SpellId)))
        return;
    auto& session = found->second;
    auto* periodic = session.PeriodicBuffCasts.Find(action);
    if (!periodic || !periodic->ObservePeriodic())
        return;
    auto const now = Clock::now();
    for (auto const* buffProfile : ProfilesForClass(player->getClass()))
    {
        std::uint64_t const bit = Practice::DevelopmentBuffs::ContributionBit(*buffProfile);
        if (!bit || (periodic->AwardedBits & bit) ||
            (Practice::DevelopmentBuffs::IsPairedAttackPower(*buffProfile) &&
                (!periodicDamage || !IsMeleeOrRangedAbility(info))))
            continue;
        auto const buff = session.Buffs.find(buffProfile->Definition.AbilityId);
        if (buff == session.Buffs.end() || !periodic->MatchesOrigin(bit, buff->second.Origin))
            continue;
        if (AwardOwnedBuffContribution(player, session, *buffProfile, now))
            periodic->AwardedBits |= bit;
    }
}

void AwardPeriodicOutcome(Unit* caster, Unit* target, std::uint32_t auraSpellId, std::uint32_t auraType,
    std::uint32_t damage, std::uint32_t healing, std::shared_ptr<CoAAbilityPractice::CastReceipt> const& receipt)
{
    if (!Active.load() || !caster || !target || !receipt)
        return;
    Player* player = caster->ToPlayer();
    if (!IsProfiledPlayer(player))
        return;
    AwardPeriodicBuffContribution(player, target, auraSpellId, auraType, damage, healing, receipt);
    if (receipt->IsConsumed())
        return;
    auto const* profile = FindProfile(player, receipt->SpellId);
    bool const scripted = profile && HelpersRequested && Practice::DevelopmentHelpers::IsManafeed(*profile) &&
        auraType == SPELL_AURA_PERIODIC_DUMMY;
    bool const absorption = profile && AbsorptionRequested &&
        Practice::DevelopmentAbsorption::IsEmeraldVeil(*profile) && auraType == SPELL_AURA_SCHOOL_ABSORB;
    if (!profile || (!scripted && !absorption && (profile->Outcome == Practice::OutcomeKind::Damage ?
            auraType != SPELL_AURA_PERIODIC_DAMAGE && auraType != SPELL_AURA_PERIODIC_DAMAGE_PERCENT &&
                auraType != SPELL_AURA_PERIODIC_LEECH :
            profile->Outcome != Practice::OutcomeKind::Healing || auraType != SPELL_AURA_PERIODIC_HEAL)) ||
        std::none_of(profile->Definition.Ranks.begin(), profile->Definition.Ranks.end(),
            [auraSpellId](Practice::AbilityRank const& rank) { return rank.SpellId == auraSpellId; }) ||
        (absorption ? !damage || !IsDevelopmentOpponent(player, target) :
            scripted ? !healing || !target->IsAlive() || !IsDevelopmentOpponent(player, target) ||
            !HasDevelopmentEncounter(player, player) :
            !QualifiesDevelopmentOutcome(profile->Outcome, player, target, damage, healing)))
        return;
    std::lock_guard lock(Mutex);
    auto const found = Sessions.find(player->GetGUID().GetRawValue());
    if ((!scripted && !absorption && !PeriodicRequested) || (scripted && !HelpersRequested) ||
        (absorption && !AbsorptionRequested) ||
        !Affects(player) || player->isBeingLoaded() || found == Sessions.end() ||
        !ReceiptMatches(player, found->second, *receipt) ||
        !AcquisitionAllowed(player, profile->Definition, receipt->SpellId))
        return;
    ReceiptCast cast{ player, sSpellMgr->GetSpellInfo(receipt->SpellId), *receipt };
    Practice::OutcomeContext const context{ true, true, true, true, player->GetLevel() };
    auto const effective = Practice::BuildCatchupPolicy(profile->Policy,
        Practice::CapAtLevel(profile->Definition, player->GetLevel()), Catchup);
    if (!effective)
        return;
    auto const award = Practice::HandleOutcome(*player, cast, profile->Definition,
        effective->View(), profile->DefinitionVersion, context);
    RecordAward(player, found->second, *profile, award);
}

void AwardControlOutcome(Unit* caster, Unit* target, std::uint32_t auraSpellId, std::uint32_t auraType,
    std::shared_ptr<CoAAbilityPractice::CastReceipt> const& receipt)
{
    if (!Active.load() || !ControlRequested || !caster || !target || !target->IsAlive() ||
        !receipt || receipt->IsConsumed() || auraSpellId != receipt->SpellId)
        return;
    Player* player = caster->ToPlayer();
    if (!IsProfiledPlayer(player))
        return;
    auto const* profile = FindProfile(player, receipt->SpellId);
    bool const supported = profile &&
        ((auraType == SPELL_AURA_MOD_FEAR && profile->Outcome == Practice::OutcomeKind::Fear) ||
            (auraType == SPELL_AURA_MOD_STUN && Practice::DevelopmentControl::SupportsStun(*profile)) ||
            (auraType == SPELL_AURA_MOD_ROOT && Practice::DevelopmentControl::SupportsRoot(*profile)));
    if (!supported || !IsDevelopmentOpponent(player, target))
        return;
    std::lock_guard lock(Mutex);
    auto const found = Sessions.find(player->GetGUID().GetRawValue());
    if (!Affects(player) || player->isBeingLoaded() || found == Sessions.end() ||
        !ReceiptMatches(player, found->second, *receipt) ||
        !AcquisitionAllowed(player, profile->Definition, receipt->SpellId))
        return;
    ReceiptCast cast{ player, sSpellMgr->GetSpellInfo(receipt->SpellId), *receipt };
    Practice::OutcomeContext const context{ true, true, true, true, player->GetLevel() };
    auto const effective = Practice::BuildCatchupPolicy(profile->Policy,
        Practice::CapAtLevel(profile->Definition, player->GetLevel()), Catchup);
    if (!effective)
        return;
    auto const award = Practice::HandleOutcome(*player, cast, profile->Definition,
        effective->View(), profile->DefinitionVersion, context);
    RecordAward(player, found->second, *profile, award);
}

void AwardUtilityOutcome(Spell* spell, Unit* target, Practice::OutcomeKind kind, std::uint32_t count)
{
    if (!Active.load() || !spell || !spell->GetCaster() || !target || !target->IsAlive() || !count)
        return;
    Player* player = spell->GetCaster()->ToPlayer();
    if (!IsProfiledPlayer(player))
        return;
    auto const* profile = FindProfile(player, spell->GetSpellInfo()->Id);
    if (!profile || (profile->Outcome != kind &&
        !(profile->Outcome == Practice::OutcomeKind::DamageOrInterrupt && kind == Practice::OutcomeKind::Interrupt) &&
        !(profile->Outcome == Practice::OutcomeKind::DamageOrDispel && kind == Practice::OutcomeKind::Dispel)))
        return;
    bool const qualified = player->IsFriendlyTo(target) ?
        kind == Practice::OutcomeKind::Dispel && HasDevelopmentEncounter(player, target) :
        IsDevelopmentOpponent(player, target);
    if (qualified)
        AwardOutcome(player, spell, *profile);
}

void InitializeProgress(Player* player)
{
    for (Practice::AbilityProfile const* indexed : ProfilesForClass(player->getClass()))
    {
        Practice::AbilityProfile const& profile = *indexed;
        Practice::AbilityDefinition const& ability = profile.Definition;
        if (ability.ClassId != player->getClass() || ability.Kind == Practice::AbilityKind::Fixed)
            continue;
        auto const learned = Learned(player, ability);
        auto const previousPacing = PreviousPacingFor(profile);
        bool const hasPrevious = std::any_of(previousPacing.begin(), previousPacing.end(),
            [](std::optional<PreviousPacing> const& previous) { return previous.has_value(); });
        if (learned.empty() && !hasPrevious)
            continue;
        auto loaded = Practice::ReadPlayerProgress(*player, ability.ClassId, ability.AbilityId,
            profile.Policy, profile.DefinitionVersion);
        if (hasPrevious && loaded.Status == Practice::LoadStatus::DefinitionMismatch)
        {
            std::uint32_t const minimum = std::max(SharedBuffSeedMinimum(player, profile),
                TrainerRankExtensionEntry(profile) ? Practice::SeedLearnedRanks(ability, {}, learned).Proficiency : 0);
            for (auto const& previousDefinition : previousPacing)
            {
                if (!previousDefinition)
                    continue;
                auto const previous = Practice::ReadPlayerProgress(*player, ability.ClassId, ability.AbilityId,
                    previousDefinition->Policy, previousDefinition->DefinitionVersion);
                if (previous.Status != Practice::LoadStatus::Loaded)
                    continue;
                if (Practice::CacheRebasedPlayerProgress(*player, ability.ClassId, ability.AbilityId,
                        previousDefinition->Policy, profile.Policy, profile.DefinitionVersion,
                        previous.Record, minimum))
                    loaded = Practice::ReadPlayerProgress(*player, ability.ClassId, ability.AbilityId,
                        profile.Policy, profile.DefinitionVersion);
                break;
            }
        }
        if (learned.empty())
            continue;
        if (loaded.Status == Practice::LoadStatus::Loaded)
            loaded.Record.State.Proficiency = std::max(loaded.Record.State.Proficiency,
                SharedBuffSeedMinimum(player, profile));
        auto const record = Practice::MigrateLearnedRanks(ability, profile.Policy, loaded, learned);
        if (record)
            Practice::CachePlayerProgress(*player, ability.ClassId, ability.AbilityId, profile.Policy, *record);
    }
}

void ObserveMastery(Player* player, MenuSession& session, bool baseline, std::uint32_t characterLevel)
{
    if (!MasteryRequested || !Affects(player) || player->isBeingLoaded())
        return;
    std::uint32_t const observedLevel = characterLevel ? characterLevel : player->GetLevel();
    ClassSession& progress = session.Progress[player->getClass()];
    for (Practice::AbilityProfile const* profile : ProfilesForClass(player->getClass()))
    {
        auto const& ability = profile->Definition;
        if (ability.Kind != Practice::AbilityKind::Mastery)
            continue;
        auto const learned = Learned(player, ability);
        auto const loaded = Practice::ReadPlayerProgress(*player, ability.ClassId, ability.AbilityId,
            profile->Policy, profile->DefinitionVersion);
        auto const migrated = Practice::MigrateLearnedRanks(ability, profile->Policy, loaded, learned);
        if (!migrated)
            continue;
        auto const [found, firstObservation] = progress.MasterySeen.try_emplace(ability.AbilityId, 0);
        std::uint32_t& seen = found->second;
        bool const establishBaseline = baseline || firstObservation;
        bool const eligible = !learned.empty() &&
            AcquisitionAllowed(player, ability, ability.Ranks.front().SpellId);
        for (std::size_t index = 0; index < profile->Rewards.size(); ++index)
        {
            auto const& reward = profile->Rewards[index];
            std::uint32_t const bit = std::uint32_t(1) << index;
            if ((seen & bit) || observedLevel < reward.Requirement.CharacterLevel ||
                migrated->State.Proficiency < reward.Requirement.Proficiency || (!establishBaseline && !eligible))
                continue;
            seen |= bit;
            if (!establishBaseline)
            {
                progress.Mastery.Record(ability.AbilityId, static_cast<std::uint32_t>(index + 1), reward);
                session.Dirty = true;
            }
        }
    }
}

void RefreshOwnerState(Player* player, MenuSession& session, std::uint32_t customSpecialization)
{
    if (session.Initialized && session.LastClass == player->getClass() && session.LastRace == player->getRace() &&
        session.LastSpec == player->GetActiveSpec() && session.LastCustomSpecialization == customSpecialization)
        return;
    ClearDelivery(session);
    session.NextRefresh = {};
    InitializeProgress(player);
    ObserveMastery(player, session, true);
    session.Initialized = true;
    session.LastClass = player->getClass();
    session.LastRace = player->getRace();
    session.LastSpec = player->GetActiveSpec();
    session.LastCustomSpecialization = customSpecialization;
    session.ActionSession = NewActionSession();
    session.Buffs.clear();
    session.PeriodicBuffCasts.Clear();
    session.Dirty = true;
    session.CheckRanks = true;
}

void MarkDirty(Player* player, bool invalidateActions = false)
{
    if (!Active.load() || !IsProfiledPlayer(player))
        return;
    std::lock_guard lock(Mutex);
    auto const found = Sessions.find(player->GetGUID().GetRawValue());
    if (Affects(player) && found != Sessions.end())
    {
        ClearDelivery(found->second);
        found->second.NextRefresh = {};
        if (invalidateActions)
        {
            found->second.ActionSession = NewActionSession();
            found->second.PeriodicBuffCasts.Clear();
        }
        found->second.Dirty = true;
        found->second.CheckRanks = true;
    }
}

void ReplacementChanged(Player* player, std::uint32_t originalSpellId)
{
    if (!Active.load() || !IsProfiledPlayer(player) || player->isBeingLoaded() ||
        !FindProfile(player, originalSpellId))
        return;
    MarkDirty(player, true);
}

class PracticeWorld : public WorldScript
{
public:
    PracticeWorld() : WorldScript("AbilityPracticeWorld",
        { WORLDHOOK_ON_AFTER_CONFIG_LOAD, WORLDHOOK_ON_STARTUP }) { }

    void OnAfterConfigLoad(bool) override
    {
        std::lock_guard lock(Mutex);
        Requested = sConfigMgr->GetOption<bool>("AbilityPractice.Enable", false);
        DevelopmentAllowed = sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentObservation", false);
        RankRequested = sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentRankLearning", false);
        auto const selected = ParseSelectedCharacters(
            sConfigMgr->GetOption<std::string>("AbilityPractice.DevelopmentCharacterGuids", ""));
        SelectedCharacters.store(selected);
        bool const realmEnrollment = RealmEnrollment.load();
        CharacterSelectionReady = selected && (realmEnrollment ? selected->empty() : !selected->empty());
        if (!selected)
            LOG_ERROR("module.ability_practice", "Rejected invalid development character selection; effects disabled");
        if (realmEnrollment && selected && !selected->empty())
            LOG_ERROR("module.ability_practice", "Rejected simultaneous realm and character enrollment; effects disabled");
        LOG_INFO("module.ability_practice", "Development character selection: valid={}, selected count={}",
            static_cast<bool>(selected), selected ? selected->size() : 0);
        Active.store(Requested && DevelopmentAllowed && Ready && CharacterSelectionReady);
        RankActive.store(Requested && DevelopmentAllowed && Ready && CharacterSelectionReady && RankRequested);
        for (auto entry = Sessions.begin(); entry != Sessions.end();)
        {
            if (!selected || (realmEnrollment ? !selected->empty() : !selected->contains(entry->first)))
            {
                entry = Sessions.erase(entry);
                continue;
            }
            ClearDelivery(entry->second);
            entry->second.ActionSession = NewActionSession();
            entry->second.Buffs.clear();
            entry->second.PeriodicBuffCasts.Clear();
            entry->second.Dirty = true;
            entry->second.CheckRanks = true;
            ++entry;
        }
    }

    void OnStartup() override
    {
        std::lock_guard lock(Mutex);
        if (ProfileLookup)
        {
            Ready = false;
            Active.store(false);
            RankActive.store(false);
            LOG_ERROR("module.ability_practice", "Rejected repeated development catalog initialization");
            return;
        }
        RealmEnrollment.store(sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentRealmEnrollment", false));
        auto const characterSelection = SelectedCharacters.load();
        CharacterSelectionReady = characterSelection &&
            (RealmEnrollment.load() ? characterSelection->empty() : !characterSelection->empty());
        if (RealmEnrollment.load() && characterSelection && !characterSelection->empty())
            LOG_ERROR("module.ability_practice", "Rejected simultaneous realm and character enrollment; effects disabled");
        Catchup.Enabled = sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentCatchup", false);
        Catchup.Gap = sConfigMgr->GetOption<std::uint32_t>("AbilityPractice.DevelopmentCatchupGap", 40);
        Catchup.Multiplier = sConfigMgr->GetOption<std::uint32_t>("AbilityPractice.DevelopmentCatchupMultiplier", 2);
        PeriodicRequested = sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentPeriodicObservation", false);
        MasteryRequested = sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentMastery", false);
        HelpersRequested = sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentScriptedObservation", false);
        TrainerRanksRequested =
            sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentTrainerRankExtensions", false);
        DirectLeechRequested =
            sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentDirectLeech", false);
        BuffContributionRequested =
            sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentBuffContribution", false);
        SharedBuffVariantsRequested =
            sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentSharedBuffVariants", false);
        AbsorptionRequested = sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentAbsorption", false);
        PacingRequested = sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentRankPacing", false);
        RankCapsRequested = sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentOneRankAhead", false);
        MasteryPacingRequested = sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentMasteryPacing", false);
        ControlRequested = sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentControlObservation", false);
        if (!Requested || !DevelopmentAllowed)
        {
            Active.store(false);
            RankActive.store(false);
            LOG_INFO("module.ability_practice", "Development observation disabled");
            return;
        }
        if (!ServerGeneration)
        {
            auto const bytes = Acore::Crypto::GetRandomBytes<8>();
            for (std::uint8_t byte : bytes)
                ServerGeneration = (ServerGeneration << 8) | byte;
            if (!ServerGeneration)
                ServerGeneration = 1;
        }
        bool const classSamples = sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentClassSamples", false);
        bool const rankedCatalog = sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentRankedCatalog", false);
        bool const fixedCatalog = sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentFixedCatalog", false);
        bool const conjureFixedCatalog =
            sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentConjureFixedCatalog", false);
        bool const passiveFixedCatalog =
            sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentPassiveFixedCatalog", false);
        bool const utilityFixedCatalog =
            sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentUtilityFixedCatalog", false);
        bool const controlFixedCatalog =
            sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentControlFixedCatalog", false);
        bool const trainerFixedCatalog =
            sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentTrainerFixedCatalog", false);
        std::span<Practice::AbilityProfile const> const selected =
            SelectProfiles(classSamples, rankedCatalog);
        RuntimeProfiles.assign(selected.begin(), selected.end());
        PeriodicPracticeAbilities.clear();
        bool const periodicValid = !PeriodicRequested ||
            AppendProfiles(RuntimeProfiles, Practice::DevelopmentPeriodic::Profiles);
        bool const masteryValid = !MasteryRequested ||
            AppendProfiles(RuntimeProfiles, Practice::DevelopmentMastery::Profiles);
        bool const scriptedMasteryValid = !HelpersRequested || !MasteryRequested ||
            AppendProfiles(RuntimeProfiles, Practice::DevelopmentMastery::ScriptedProfiles);
        bool const helpersValid = !HelpersRequested ||
            AppendProfiles(RuntimeProfiles, Practice::DevelopmentHelpers::Profiles);
        bool const directLeechValid = !DirectLeechRequested ||
            AppendProfiles(RuntimeProfiles, Practice::DevelopmentLeech::Profiles);
        bool const buffValid = !BuffContributionRequested ||
            (PacingRequested && TrainerRanksRequested &&
                AppendProfiles(RuntimeProfiles, Practice::DevelopmentBuffs::Profiles));
        bool const absorptionValid = !AbsorptionRequested ||
            AppendProfiles(RuntimeProfiles, Practice::DevelopmentAbsorption::Profiles);
        bool const fixedValid = !fixedCatalog || AppendProfiles(RuntimeProfiles, Practice::DevelopmentFixed::Profiles);
        bool const conjureFixedValid = !conjureFixedCatalog ||
            AppendProfiles(RuntimeProfiles, Practice::DevelopmentConjureFixed::Profiles);
        bool const passiveFixedValid = !passiveFixedCatalog ||
            AppendProfiles(RuntimeProfiles, Practice::DevelopmentPassiveFixed::Profiles);
        bool const utilityFixedValid = !utilityFixedCatalog ||
            AppendProfiles(RuntimeProfiles, Practice::DevelopmentUtilityFixed::Profiles);
        bool const controlFixedValid = !controlFixedCatalog ||
            AppendProfiles(RuntimeProfiles, Practice::DevelopmentControlFixed::Profiles);
        bool const trainerFixedValid = !trainerFixedCatalog ||
            AppendProfiles(RuntimeProfiles, Practice::DevelopmentTrainerFixed::Profiles);
        bool const controlValid = !ControlRequested ||
            AppendProfiles(RuntimeProfiles, Practice::DevelopmentControl::Profiles);
        bool const pacingValid = !PacingRequested || ApplyDevelopmentPacing(RuntimeProfiles);
        bool const masteryPacingValid = !MasteryPacingRequested || ApplyDevelopmentMasteryPacing(RuntimeProfiles);
        bool const trainerRanksValid = !TrainerRanksRequested ||
            (PacingRequested && pacingValid && ApplyDevelopmentTrainerRankExtensions(RuntimeProfiles));
        bool const rankCapsValid = !RankCapsRequested ||
            (PacingRequested && pacingValid && trainerRanksValid && ApplyDevelopmentRankCaps(RuntimeProfiles));
        std::span<Practice::AbilityProfile const> const profiles(RuntimeProfiles);
        ProfileLookup.emplace(profiles);
        Ready = ProfileLookup->IsValid() && periodicValid && masteryValid && scriptedMasteryValid &&
            helpersValid && fixedValid &&
            absorptionValid && controlValid && pacingValid && masteryPacingValid && trainerFixedValid &&
            directLeechValid && conjureFixedValid && trainerRanksValid && passiveFixedValid && utilityFixedValid &&
            controlFixedValid && buffValid && rankCapsValid && MatchesSharedBuffVariants() &&
            Practice::ValidCatchupSettings(Catchup);
        for (Practice::AbilityProfile const& profile : profiles)
        {
            std::uint32_t const maximumCap = profile.Definition.Caps.empty() ? 1 :
                profile.Definition.Caps.back().Proficiency;
            if (!Practice::BuildCatchupPolicy(profile.Policy, maximumCap, Catchup))
            {
                Ready = false;
                LOG_ERROR("module.ability_practice", "Rejected catch-up policy: class={}, ability={}",
                    profile.Definition.ClassId, profile.Definition.AbilityId);
            }
            bool const acquisitionValid = profile.Acquisition == Practice::AcquisitionSource::ClassTrainer ?
                MatchesNativeClassTrainer(profile) : MatchesNativeClassGrant(profile);
            if (!acquisitionValid || !MatchesStatBuffTrainer(profile) ||
                !MatchesConjureFixedMechanic(profile) || !MatchesPassiveFixedMechanic(profile) ||
                !MatchesUtilityFixedMechanic(profile) || !MatchesControlFixedMechanic(profile))
            {
                Ready = false;
                LOG_ERROR("module.ability_practice", "Rejected native acquisition: class={}, ability={}",
                    profile.Definition.ClassId, profile.Definition.AbilityId);
            }
            if (!MatchesEffectiveRankChain(profile) || !MatchesTrainerRankBoundary(profile.Definition))
            {
                Ready = false;
                LOG_ERROR("module.ability_practice", "Rejected effective rank chain: class={}, ability={}",
                    profile.Definition.ClassId, profile.Definition.AbilityId);
            }
            for (Practice::AbilityRank const& rank : profile.Definition.Ranks)
            {
                SpellInfo const* info = sSpellMgr->GetSpellInfo(rank.SpellId);
                if (PeriodicRequested && profile.Definition.Kind == Practice::AbilityKind::Ranked &&
                    HasSupportedPeriodicOutcome(info, profile.Outcome))
                    PeriodicPracticeAbilities.insert(ProfileKey(profile.Definition));
                bool const fixed = profile.Definition.Kind == Practice::AbilityKind::Fixed;
                bool const expectedOutcome = info && (fixed || HasSupportedOutcome(info, profile.Outcome) ||
                    HasSupportedSpecializedOutcome(info, profile)) &&
                    (profile.Definition.Kind != Practice::AbilityKind::Mastery ||
                        (!info->HasAura(SPELL_AURA_PERIODIC_HEAL) && !info->HasAura(SPELL_AURA_PERIODIC_LEECH) &&
                            !info->HasAura(SPELL_AURA_PERIODIC_DAMAGE) &&
                            !info->HasAura(SPELL_AURA_PERIODIC_DAMAGE_PERCENT) &&
                            !info->HasEffect(SPELL_EFFECT_HEALTH_LEECH)));
                bool const expectedAbsorption = !AbsorptionRequested ||
                    !Practice::DevelopmentAbsorption::IsEmeraldVeil(profile) ||
                    (info && info->HasAura(SPELL_AURA_SCHOOL_ABSORB));
                bool const expectedControl = !ControlRequested ||
                    ((!Practice::DevelopmentControl::SupportsStun(profile) ||
                        (info && info->HasAura(SPELL_AURA_MOD_STUN))) &&
                        (!Practice::DevelopmentControl::SupportsRoot(profile) ||
                            (info && info->HasAura(SPELL_AURA_MOD_ROOT))));
                if (!info || info->IsDeprecatedForPlayers || (!fixed && info->IsPassive()) ||
                    !expectedOutcome || !expectedAbsorption || !expectedControl ||
                    !MatchesAdditionalMasteryMechanic(info, profile))
                {
                    Ready = false;
                    LOG_ERROR("module.ability_practice", "Rejected development profile: class={}, ability={}, spell={}",
                        profile.Definition.ClassId, profile.Definition.AbilityId, rank.SpellId);
                }
            }
        }
        Active.store(Requested && DevelopmentAllowed && Ready && CharacterSelectionReady);
        RankActive.store(Requested && DevelopmentAllowed && Ready && CharacterSelectionReady && RankRequested);
        LOG_INFO("module.ability_practice", "Development observation: requested={}, allowed={}, data ready={}",
            Requested, DevelopmentAllowed, Ready);
        LOG_INFO("module.ability_practice", "Development realm enrollment: enabled={}, enrollment ready={}",
            RealmEnrollment.load(), CharacterSelectionReady);
        LOG_INFO("module.ability_practice", "Development class samples: enabled={}, profile count={}",
            classSamples, profiles.size());
        LOG_INFO("module.ability_practice", "Development periodic observation: enabled={}", PeriodicRequested);
        LOG_INFO("module.ability_practice", "Development ranked catalog: enabled={}", rankedCatalog);
        LOG_INFO("module.ability_practice", "Development mastery: enabled={}", MasteryRequested);
        LOG_INFO("module.ability_practice", "Development scripted observation: enabled={}", HelpersRequested);
        LOG_INFO("module.ability_practice", "Development fixed catalog: enabled={}", fixedCatalog);
        LOG_INFO("module.ability_practice", "Development passive roadmap: enabled={}", passiveFixedCatalog);
        LOG_INFO("module.ability_practice", "Development utility roadmap: enabled={}", utilityFixedCatalog);
        LOG_INFO("module.ability_practice", "Development native control roadmap: enabled={}", controlFixedCatalog);
        LOG_INFO("module.ability_practice", "Development trainer rank extensions: enabled={}", TrainerRanksRequested);
        LOG_INFO("module.ability_practice", "Development direct leech observation: enabled={}", DirectLeechRequested);
        LOG_INFO("module.ability_practice", "Development absorption observation: enabled={}", AbsorptionRequested);
        LOG_INFO("module.ability_practice", "Development rank pacing: enabled={}", PacingRequested);
        LOG_INFO("module.ability_practice", "Development mastery pacing: enabled={}", MasteryPacingRequested);
        LOG_INFO("module.ability_practice", "Development control observation: enabled={}", ControlRequested);
    }
};

class PracticePlayer : public PlayerScript
{
public:
    PracticePlayer() : PlayerScript("AbilityPracticePlayer",
        { PLAYERHOOK_ON_LOGIN, PLAYERHOOK_ON_LOGOUT, PLAYERHOOK_CAN_PLAYER_USE_PRIVATE_CHAT,
            PLAYERHOOK_ON_UPDATE, PLAYERHOOK_ON_LEVEL_CHANGED, PLAYERHOOK_ON_LEARN_SPELL,
            PLAYERHOOK_ON_FORGOT_SPELL }) { }

    void OnPlayerLogin(Player* player) override
    {
        if (!Active.load() || !IsDevelopmentPlayer(player))
            return;
        std::lock_guard lock(Mutex);
        if (!Requested || !DevelopmentAllowed || !Ready || !IsDevelopmentPlayer(player))
            return;
        auto& session = Sessions[player->GetGUID().GetRawValue()];
        if (session.LoginObserved)
            session = {};
        RefreshOwnerState(player, session, CachedCustomSpecialization(player));
        session.LoginObserved = true;
        session.ActionSession = NewActionSession();
        session.Buffs.clear();
        session.PeriodicBuffCasts.Clear();
    }

    void OnPlayerUpdate(Player* player, uint32) override
    {
        if (!Active.load() || !IsDevelopmentPlayer(player) || player->isBeingLoaded())
            return;
        std::uint32_t const customSpecialization = CachedCustomSpecialization(player);
        bool checkRanks = false;
        {
            std::lock_guard lock(Mutex);
            if (!Requested || !DevelopmentAllowed || !Ready || !IsDevelopmentPlayer(player))
                return;
            MenuSession& session = Sessions[player->GetGUID().GetRawValue()];
            RefreshOwnerState(player, session, customSpecialization);
            checkRanks = session.CheckRanks;
            session.CheckRanks = false;
            if (checkRanks && (PacingRequested || MasteryPacingRequested))
                InitializeProgress(player);
        }
        if (checkRanks)
            PromoteRanks(player);
        std::lock_guard lock(Mutex);
        auto const found = Sessions.find(player->GetGUID().GetRawValue());
        if (found != Sessions.end())
        {
            if (checkRanks)
                ObserveMastery(player, found->second, false);
            Refresh(player, found->second, Clock::now());
        }
    }

    void OnPlayerLevelChanged(Player* player, uint8 previousLevel) override
    {
        if (Active.load() && IsProfiledPlayer(player) && !player->isBeingLoaded())
        {
            std::lock_guard lock(Mutex);
            auto const found = Sessions.find(player->GetGUID().GetRawValue());
            if (previousLevel && Affects(player) && found != Sessions.end())
                ObserveMastery(player, found->second, true, previousLevel);
        }
        MarkDirty(player);
    }

    void OnPlayerLearnSpell(Player* player, uint32 spellId) override
    {
        if (!Active.load() || !IsProfiledPlayer(player) || player->isBeingLoaded())
            return;
        auto const* profile = FindProfile(player, spellId);
        if (!profile)
        {
            MarkDirty(player);
            return;
        }
        if (SharedBuffVariantsRequested && Practice::DevelopmentBuffVariants::Find(player->getClass(), spellId))
        {
            MarkDirty(player);
            return;
        }
        auto const rank = std::find_if(profile->Definition.Ranks.begin(), profile->Definition.Ranks.end(),
            [spellId](Practice::AbilityRank const& entry) { return entry.SpellId == spellId; });
        std::lock_guard lock(Mutex);
        if (!Affects(player) || rank == profile->Definition.Ranks.end() || !player->HasSpell(spellId))
            return;
        auto& session = Sessions[player->GetGUID().GetRawValue()];
        RefreshOwnerState(player, session, CachedCustomSpecialization(player));
        session.Progress[player->getClass()].Learning.Record(profile->Definition.AbilityId, *rank);
        MarkDirty(player);
    }

    void OnPlayerForgotSpell(Player* player, uint32 spellId) override
    {
        if (Active.load() && IsProfiledPlayer(player) && !player->isBeingLoaded())
            MarkDirty(player, FindProfile(player, spellId) != nullptr);
    }

    void OnPlayerLogout(Player* player) override
    {
        std::lock_guard lock(Mutex);
        if (player)
            Sessions.erase(player->GetGUID().GetRawValue());
    }

    bool OnPlayerCanUseChat(Player* player, uint32, uint32 language, std::string& message, Player* receiver) override
    {
        if (!Active.load() || !IsDevelopmentPlayer(player) || language != LANG_ADDON ||
            message.rfind("HXAP\t", 0) != 0)
            return true;
        std::lock_guard lock(Mutex);
        if (!Requested || !DevelopmentAllowed || !Ready || !IsDevelopmentPlayer(player))
            return true;
        if (receiver != player || (message != "HXAP\tHELLO|1" && message != "HXAP\tHELLO|2" &&
            message != "HXAP\tHELLO|3" && message != "HXAP\tHELLO|4" && message != "HXAP\tHELLO|5" &&
            message != "HXAP\tHELLO|6"))
            return false;
        auto const now = Clock::now();
        auto& session = Sessions[player->GetGUID().GetRawValue()];
        if (now - session.LastRequest < RefreshInterval)
            return false;
        session.LastRequest = now;
        session.InterestedUntil = now + InterestDuration;
        std::uint32_t const protocol = message == "HXAP\tHELLO|6" ? Practice::ResourceMenuSchemaVersion :
            message == "HXAP\tHELLO|5" ? Practice::SharedMenuSchemaVersion :
            message == "HXAP\tHELLO|4" ? Practice::TypedMenuSchemaVersion :
            message == "HXAP\tHELLO|3" ? Practice::RoadmapMenuSchemaVersion :
            message == "HXAP\tHELLO|2" ? Practice::SessionMenuSchemaVersion : Practice::MenuSchemaVersion;
        if (protocol != session.Protocol)
            ClearDelivery(session);
        session.Protocol = protocol;
        session.Dirty = true;
        Refresh(player, session, now);
        return false;
    }
};

class PracticeClientCast : public MiscScript
{
public:
    PracticeClientCast() : MiscScript("AbilityPracticeClientCast",
        { MISCHOOK_VALIDATE_SPELL_AT_CAST_SPELL_RESULT }) { }

    void ValidateSpellAtCastSpellResult(Player* player, Unit* mover, Spell* spell, uint32, uint32) override
    {
        if (!Active.load() || !IsProfiledPlayer(player) || mover != player || !spell ||
            spell->GetCaster() != player || !spell->GetSpellInfo() ||
            (!FindProfile(player, spell->GetSpellInfo()->Id) && !IsBuffObserver(player)))
            return;
        std::uint64_t const request = (static_cast<std::uint64_t>(player->getClass()) << 32) |
            spell->GetSpellInfo()->Id;
        spell->SetScriptValue(PracticeClientRequestKey, request);
    }
};

std::uint32_t ModifyMasteryHealing(Unit* healer, Unit* target, std::uint32_t spellId, std::uint32_t healing,
    CoAAbilityPractice::CastReceipt const* receipt)
{
    if (!Active.load() || !MasteryRequested || !target || !healer || !spellId || !healing || !receipt ||
        receipt->SpellId != spellId)
        return healing;
    Player* player = healer->ToPlayer();
    if (!IsProfiledPlayer(player) || player->isBeingLoaded())
        return healing;
    auto const* profile = FindProfile(player, spellId);
    if (!profile || profile->Definition.Kind != Practice::AbilityKind::Mastery ||
        profile->Outcome != Practice::OutcomeKind::Healing ||
        !(Practice::DevelopmentMastery::IsSoulCapture(*profile) ?
            target == player && HasCapturedCorpse(player, *receipt) :
            QualifiesDevelopmentOutcome(Practice::OutcomeKind::Healing, player, target, 0, healing)))
        return healing;
    std::lock_guard lock(Mutex);
    auto const session = Sessions.find(player->GetGUID().GetRawValue());
    if (!Affects(player) || session == Sessions.end() || !ReceiptOwnerMatches(player, session->second, *receipt) ||
        !player->HasSpell(spellId) || !AcquisitionAllowed(player, profile->Definition, spellId))
        return healing;
    auto const loaded = Practice::ReadPlayerProgress(*player, profile->Definition.ClassId,
        profile->Definition.AbilityId, profile->Policy, profile->DefinitionVersion);
    if (loaded.Status != Practice::LoadStatus::Loaded ||
        loaded.Record.MigrationVersion != Practice::LearnedRankMigrationVersion)
        return healing;
    std::uint32_t const bonus = Practice::HealingMasteryBonus(profile->Definition, profile->Rewards,
        loaded.Record.State, player->GetLevel(), true, true);
    return Practice::ApplyHealingMastery(healing, bonus);
}

std::uint32_t ModifyMasteryDamage(Unit* caster, Unit* target, std::uint32_t spellId, std::uint32_t damage,
    CoAAbilityPractice::CastReceipt const* receipt)
{
    if (!Active.load() || !MasteryRequested || !target || !caster || !spellId || !damage || !receipt)
        return damage;
    Player* player = caster->ToPlayer();
    if (!IsProfiledPlayer(player) || player->isBeingLoaded())
        return damage;
    auto const* profile = FindProfile(player, receipt->SpellId);
    if (!profile || (receipt->SpellId != spellId && !IsBaneDamage(profile, spellId) &&
            !(HelpersRequested && Practice::DevelopmentMastery::IsFrostSigil(*profile) &&
                receipt->SpellId == 805381 && spellId == 807825)) ||
        profile->Definition.Kind != Practice::AbilityKind::Mastery ||
        profile->Outcome != Practice::OutcomeKind::Damage ||
        !QualifiesDevelopmentOutcome(Practice::OutcomeKind::Damage, player, target, damage, 0))
        return damage;
    std::lock_guard lock(Mutex);
    auto const session = Sessions.find(player->GetGUID().GetRawValue());
    if (!Affects(player) || session == Sessions.end() || !ReceiptOwnerMatches(player, session->second, *receipt) ||
        !player->HasSpell(receipt->SpellId) || !AcquisitionAllowed(player, profile->Definition, receipt->SpellId))
        return damage;
    auto const loaded = Practice::ReadPlayerProgress(*player, profile->Definition.ClassId,
        profile->Definition.AbilityId, profile->Policy, profile->DefinitionVersion);
    if (loaded.Status != Practice::LoadStatus::Loaded ||
        loaded.Record.MigrationVersion != Practice::LearnedRankMigrationVersion)
        return damage;
    std::uint32_t const bonus = Practice::DamageMasteryBonus(profile->Definition, profile->Rewards,
        loaded.Record.State, player->GetLevel(), true, true);
    return Practice::ApplyDamageMastery(damage, bonus);
}

class PracticeSpell : public AllSpellScript
{
public:
    PracticeSpell() : AllSpellScript("AbilityPracticeSpell",
        { ALLSPELLHOOK_CAN_PREPARE, ALLSPELLHOOK_ON_HIT_RESULT, ALLSPELLHOOK_ON_SUCCESSFUL_INTERRUPT,
            ALLSPELLHOOK_ON_SUCCESSFUL_DISPEL, ALLSPELLHOOK_ON_SUCCESSFUL_STEAL }) { }

    bool CanPrepare(Spell* spell, SpellCastTargets const* targets, AuraEffect const* triggeredByAura) override
    {
        if (!Active.load() || !spell || !spell->GetCaster() || !spell->GetSpellInfo())
            return true;
        Player* player = spell->GetCaster()->ToPlayer();
        if (!IsProfiledPlayer(player))
            return true;
        auto const* profile = FindProfile(player, spell->GetSpellInfo()->Id);
        auto const helperId = spell->GetSpellInfo()->Id;
        bool const scriptedDamage = HelpersRequested && player->getClass() == 14 &&
            ((MasteryRequested && helperId == 807554) ||
                Practice::DevelopmentHelpers::IsTwinDamageHelper(helperId));
        bool const palmDamage = HelpersRequested && player->getClass() == 32 &&
            (helperId == 807012 || (MasteryRequested && helperId == 807825));
        if (!profile && !IsBuffObserver(player) && !scriptedDamage && !palmDamage)
            return true;
        std::lock_guard lock(Mutex);
        spell->SetPracticeCast({});
        spell->SetScriptValue(PracticeBuffEligibilityKey, 0);
        if (scriptedDamage && targets && spell->IsTriggered() && !triggeredByAura && !spell->m_CastItem &&
            spell->m_castItemGUID.IsEmpty() && spell->GetOriginalCasterGUID() == player->GetGUID())
        {
            auto const receipt = CoAAbilityPractice::ScopedScriptedDamageCast::Take(
                player->GetGUID().GetRawValue(), targets->GetUnitTargetGUID().GetRawValue(), helperId);
            auto const* origin = receipt ? FindProfile(player, receipt->SpellId) : nullptr;
            auto const session = Sessions.find(player->GetGUID().GetRawValue());
            if (receipt && IsScriptedDamage(origin, receipt->SpellId, helperId) &&
                Affects(player) && !player->isBeingLoaded() &&
                session != Sessions.end() && ReceiptMatches(player, session->second, *receipt) &&
                AcquisitionAllowed(player, origin->Definition, receipt->SpellId))
            {
                spell->SetPracticeCast(receipt);
                spell->SetScriptValue(PracticeCastSourceKey,
                    (static_cast<std::uint64_t>(receipt->ClassId) << 32) | receipt->SpellId);
                return true;
            }
        }
        if (palmDamage && targets && spell->IsTriggered() && triggeredByAura && !spell->m_CastItem &&
            spell->m_castItemGUID.IsEmpty() && spell->GetOriginalCasterGUID() == player->GetGUID() &&
            triggeredByAura->GetEffIndex() == EFFECT_0 && triggeredByAura->GetAuraType() == 354 &&
            triggeredByAura->GetSpellInfo()->Effects[EFFECT_0].TriggerSpell == helperId &&
            triggeredByAura->GetCasterGUID() == player->GetGUID() && !triggeredByAura->GetBase()->IsRemoved())
        {
            auto const receipt = triggeredByAura->GetBase()->GetPracticeCast();
            auto const* origin = receipt ? FindProfile(player, receipt->SpellId) : nullptr;
            auto const session = Sessions.find(player->GetGUID().GetRawValue());
            if (receipt && !receipt->IsConsumed() && receipt->SpellId == triggeredByAura->GetId() &&
                origin && IsDamagePalmSigil(*origin, receipt->SpellId, helperId) &&
                Affects(player) && !player->isBeingLoaded() && session != Sessions.end() &&
                ReceiptMatches(player, session->second, *receipt) &&
                AcquisitionAllowed(player, origin->Definition, receipt->SpellId))
            {
                spell->SetPracticeCast(receipt);
                spell->SetScriptValue(PracticeCastSourceKey,
                    (static_cast<std::uint64_t>(receipt->ClassId) << 32) | receipt->SpellId);
                return true;
            }
        }
        std::uint64_t const request = (static_cast<std::uint64_t>(player->getClass()) << 32) |
            spell->GetSpellInfo()->Id;
        bool const direct = spell->GetScriptValue(PracticeClientRequestKey) == request && !triggeredByAura &&
            !spell->IsTriggered() && !spell->m_CastItem && spell->m_castItemGUID.IsEmpty() &&
            spell->GetOriginalCasterGUID() == player->GetGUID() &&
            (profile ? AcquisitionAllowed(player, profile->Definition, spell->GetSpellInfo()->Id) :
                player->HasSpell(spell->GetSpellInfo()->Id) &&
                player->IsSpellFitByClassAndRace(spell->GetSpellInfo()->Id) &&
                AscensionAcquisition::CanLearnRacialSpell(player, spell->GetSpellInfo()->Id));
        std::uint64_t const source = direct ? request : std::numeric_limits<std::uint64_t>::max();
        spell->SetScriptValue(PracticeCastSourceKey, source);
        if (direct && Affects(player) && !player->isBeingLoaded() &&
            (IsBuffObserver(player) || (profile && profile->Outcome != Practice::OutcomeKind::None)))
        {
            auto& session = Sessions[player->GetGUID().GetRawValue()];
            RefreshOwnerState(player, session, CachedCustomSpecialization(player));
            if (session.ActionSession)
            {
                spell->SetPracticeCast(std::make_shared<CoAAbilityPractice::CastReceipt>(
                    player->GetGUID().GetRawValue(), session.ActionSession, player->getClass(), spell->GetSpellInfo()->Id,
                    player->getRace(), player->GetActiveSpec(), session.LastCustomSpecialization));
                std::uint64_t eligible = 0;
                if (IsBuffObserver(player))
                    for (auto const* buff : ProfilesForClass(player->getClass()))
                        if (Practice::DevelopmentBuffs::IsSupportedStatBuff(*buff) &&
                            AcceptedBuffSpell(player, session, *buff) &&
                            (!Practice::DevelopmentBuffs::IsPairedAttackPower(*buff) ||
                                IsMeleeOrRangedAbility(spell->GetSpellInfo())))
                            eligible |= Practice::DevelopmentBuffs::ContributionBit(*buff);
                spell->SetScriptValue(PracticeBuffEligibilityKey, eligible);
                if (PeriodicRequested && eligible &&
                    (HasSupportedPeriodicOutcome(spell->GetSpellInfo(), Practice::OutcomeKind::Damage) ||
                        HasSupportedPeriodicOutcome(spell->GetSpellInfo(), Practice::OutcomeKind::Healing)))
                {
                    std::vector<Practice::CapturedBuffOrigin> origins;
                    for (auto const* buff : ProfilesForClass(player->getClass()))
                    {
                        std::uint64_t const bit = Practice::DevelopmentBuffs::ContributionBit(*buff);
                        auto const origin = session.Buffs.find(buff->Definition.AbilityId);
                        if (bit && (eligible & bit) && origin != session.Buffs.end())
                            origins.push_back({ bit, origin->second.Origin });
                    }
                    session.PeriodicBuffCasts.Capture(spell->GetPracticeCast(), std::move(origins));
                }
            }
        }
        return true;
    }

    void OnSpellHitResult(Spell* spell, Unit* target, uint8 miss, uint32 damage, uint32 healing, bool) override
    {
        if (!Active.load())
            return;
        if (!spell || !spell->GetCaster() || !target || miss != SPELL_MISS_NONE)
            return;
        Player* player = spell->GetCaster()->ToPlayer();
        if (!IsProfiledPlayer(player))
            return;
        auto const* scriptedProfile = FindProfile(player, spell->GetSpellInfo()->Id);
        auto const scriptedHealing = spell->GetScriptValue(CoAAbilityPractice::ScriptedHealingAmountKey);
        if (target == player && HelpersRequested && MasteryRequested && scriptedProfile &&
            Practice::DevelopmentMastery::IsFelBargain(*scriptedProfile) && spell->GetPracticeCast() &&
            scriptedHealing <= std::numeric_limits<std::uint32_t>::max())
            healing = std::max(healing, static_cast<std::uint32_t>(scriptedHealing));
        BindBuffOrigin(player, spell, target);
        auto const receipt = spell->GetPracticeCast();
        auto const* corpseProfile = FindProfile(player, spell->GetSpellInfo()->Id);
        bool const corpseRecovery = target == player && corpseProfile && receipt &&
            Practice::DevelopmentMastery::IsSoulCapture(*corpseProfile) && HasCapturedCorpse(player, *receipt) &&
            (healing || receipt->HasCapturedResourceGain());
        if (corpseRecovery)
            AwardOutcome(player, spell, *corpseProfile);
        if (!damage && !healing && !corpseRecovery)
            return;
        AwardScriptedDamage(player, spell, target, damage);
        AwardBuffContribution(player, spell, target, damage, healing);
        auto const* profile = FindProfile(player, spell->GetSpellInfo()->Id);
        if (profile && !Practice::DevelopmentBuffs::IsSupportedStatBuff(*profile) &&
            QualifiesDevelopmentOutcome(profile->Outcome, player, target, damage, healing))
            AwardOutcome(player, spell, *profile);
        std::lock_guard lock(Mutex);
        auto const found = Sessions.find(player->GetGUID().GetRawValue());
        if (found != Sessions.end() && found->second.Dirty)
            Refresh(player, found->second, Clock::now());
    }

    void OnSpellSuccessfulInterrupt(Spell* spell, Unit* target) override
    {
        AwardUtilityOutcome(spell, target, Practice::OutcomeKind::Interrupt, 1);
    }

    void OnSpellSuccessfulDispel(Spell* spell, Unit* target, SpellEffIndex, uint32 count) override
    {
        AwardUtilityOutcome(spell, target, Practice::OutcomeKind::Dispel, count);
    }

    void OnSpellSuccessfulSteal(Spell* spell, Unit* target, uint32 count) override
    {
        AwardUtilityOutcome(spell, target, Practice::OutcomeKind::Steal, count);
    }
};
}

void AddSC_ability_practice()
{
    CoAAbilityPractice::SetRankProvider(EvaluateRank);
    CoAAbilityPractice::SetPurchaseProvider(CanPurchaseSpell);
    CoAAbilityPractice::SetReplacementChangedProvider(ReplacementChanged);
    CoAAbilityPractice::SetPeriodicOutcomeProvider(AwardPeriodicOutcome);
    CoAAbilityPractice::SetControlOutcomeProvider(AwardControlOutcome);
    CoAAbilityPractice::SetHealingMasteryProvider(ModifyMasteryHealing);
    CoAAbilityPractice::SetDamageMasteryProvider(ModifyMasteryDamage);
    CoAAbilityPractice::SetCorpseCaptureProvider(BindCorpseRecovery);
    new PracticeWorld();
    new PracticePlayer();
    new PracticeClientCast();
    new PracticeSpell();
}
