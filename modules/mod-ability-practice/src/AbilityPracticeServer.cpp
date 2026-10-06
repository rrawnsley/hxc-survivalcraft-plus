// SPDX-License-Identifier: GPL-2.0-or-later

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeCatchup.h"
#include "AbilityPracticeDevelopmentSamples.h"
#include "AbilityPracticeDevelopmentPeriodic.h"
#include "AbilityPracticeDevelopmentRanked.h"
#include "AbilityPracticeDevelopmentPacing.h"
#include "AbilityPracticeDevelopmentMastery.h"
#include "AbilityPracticeDevelopmentHelpers.h"
#include "AbilityPracticeDevelopmentLeech.h"
#include "AbilityPracticeDevelopmentBuffs.h"
#include "AbilityPracticeDevelopmentFixed.h"
#include "AbilityPracticeDevelopmentConjureFixed.h"
#include "AbilityPracticeDevelopmentPassiveFixed.h"
#include "AbilityPracticeDevelopmentUtilityFixed.h"
#include "AbilityPracticeDevelopmentTrainerFixed.h"
#include "AbilityPracticeDevelopmentTrainerRanks.h"
#include "AbilityPracticeDevelopmentBuffTrainerRanks.h"
#include "AbilityPracticeDevelopmentAbsorption.h"
#include "AbilityPracticeDevelopmentControl.h"
#include "AbilityPracticeDevelopmentControlFixed.h"
#include "AbilityPracticeDevelopmentMasteryPacing.h"
#include "AbilityPracticeProfiles.h"
#include "AbilityPracticeRankPolicy.h"
#include "AbilityPracticeMasteryPolicy.h"
#include "AbilityPracticeCastReceipt.h"
#include "AbilityPracticeOutcome.h"
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
#include "Formulas.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellAuras.h"
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
                    lhs.DamageBonusBasisPoints == rhs.DamageBonusBasisPoints;
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
    std::array<std::span<Practice::DevelopmentTrainerRanks::Entry const>, 2> const catalogs = {
        Practice::DevelopmentTrainerRanks::Entries, Practice::DevelopmentBuffTrainerRanks::Entries };
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

Practice::DevelopmentTrainerRanks::Entry const* TrainerRankExtensionEntry(Practice::AbilityProfile const& profile)
{
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
bool RankRequested = false;
bool PeriodicRequested = false;
bool MasteryRequested = false;
bool HelpersRequested = false;
bool DirectLeechRequested = false;
bool BuffContributionRequested = false;
bool TrainerRanksRequested = false;
bool AbsorptionRequested = false;
bool PacingRequested = false;
bool MasteryPacingRequested = false;
bool ControlRequested = false;
Practice::CatchupSettings Catchup;

struct PreviousPacing
{
    Practice::TrainingPolicy Policy;
    std::uint32_t DefinitionVersion;
};

std::array<std::optional<PreviousPacing>, 2> PreviousPacingFor(Practice::AbilityProfile const& profile)
{
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
    std::shared_ptr<CoAAbilityPractice::CastReceipt> BuffOrigin;
    Clock::time_point NextBuffContribution{};
    Clock::time_point NextBuffStateRefresh{};
    std::optional<Practice::BuffPracticeState> LastBuffState;
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

bool HasSupportedSpecializedOutcome(SpellInfo const* info, Practice::AbilityProfile const& profile)
{
    if (!info)
        return false;
    if (BuffContributionRequested && Practice::DevelopmentBuffs::IsBrutalShout(profile))
    {
        for (std::size_t index = 0; index < 3; ++index)
        {
            auto const& slot = info->Effects[index];
            if (slot.Effect != (index == 0 ? SPELL_EFFECT_APPLY_AURA : 0u) ||
                slot.ApplyAuraName != (index == 0 ? SPELL_AURA_MOD_STAT : 0u) ||
                slot.TargetA.GetTarget() != (index == 0 ? TARGET_UNIT_CASTER_AREA_RAID : 0u) ||
                slot.TargetB.GetTarget() || slot.TriggerSpell)
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
    return HelpersRequested && Practice::DevelopmentHelpers::IsManafeed(profile) &&
        info->Effects[EFFECT_0].Effect == SPELL_EFFECT_APPLY_AURA &&
        info->Effects[EFFECT_0].ApplyAuraName == SPELL_AURA_PERIODIC_DUMMY;
}

bool MatchesAdditionalMasteryMechanic(SpellInfo const* info, Practice::AbilityProfile const& profile)
{
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
    for (std::size_t index = 0; index < mechanic->AuraIds.size(); ++index)
    {
        auto const& effect = info->Effects[index];
        if (effect.Effect != mechanic->EffectIds[index] || effect.ApplyAuraName != mechanic->AuraIds[index] ||
            effect.TriggerSpell != mechanic->TriggerSpellIds[index] ||
            effect.TargetA.GetTarget() != mechanic->TargetAIds[index] ||
            effect.TargetB.GetTarget())
            return false;
        if (effect.TriggerSpell && !sSpellMgr->GetSpellInfo(effect.TriggerSpell))
            return false;
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
    auto const& mechanics = Practice::DevelopmentUtilityFixed::Mechanics;
    auto const mechanic = std::find_if(mechanics.begin(), mechanics.end(),
        [&profile](Practice::DevelopmentUtilityFixed::Mechanic const& entry)
        {
            return entry.ClassId == profile.Definition.ClassId && entry.SpellId == profile.Definition.AbilityId;
        });
    SpellInfo const* info = sSpellMgr->GetSpellInfo(profile.Definition.AbilityId);
    if (mechanic == mechanics.end() || !info || info->IsPassive())
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
            if (slot.Effect != spec->EffectIds[helperIndex] || slot.ApplyAuraName || slot.TriggerSpell ||
                slot.TargetA.GetTarget() != spec->TargetAIds[helperIndex] || slot.TargetB.GetTarget())
                return false;
        }
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

bool MatchesEffectiveRankChain(Practice::AbilityDefinition const& ability)
{
    std::size_t present = 0;
    for (std::size_t index = 0; index < ability.Ranks.size(); ++index)
    {
        Practice::AbilityRank const& rank = ability.Ranks[index];
        SpellChainNode const* node = sSpellMgr->GetSpellChainNode(rank.SpellId);
        if (!node)
            continue;
        ++present;
        std::uint32_t const previous = index ? ability.Ranks[index - 1].SpellId : 0;
        std::uint32_t const next = index + 1 < ability.Ranks.size() ? ability.Ranks[index + 1].SpellId : 0;
        if (!node->first || !node->last || node->first->Id != ability.Ranks.front().SpellId ||
            node->last->Id != ability.Ranks.back().SpellId || node->rank != rank.RankNumber ||
            (node->prev ? node->prev->Id : 0) != previous || (node->next ? node->next->Id : 0) != next)
            return false;
    }
    return !present || present == ability.Ranks.size();
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
    return selection && selection->contains(player->GetGUID().GetRawValue());
}

Practice::AbilityProfile const* FindProfile(Player const* player, std::uint32_t spellId)
{
    return player && ProfileLookup ? ProfileLookup->Find(player->getClass(), spellId) : nullptr;
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

bool IsBuffObserver(Player const* player)
{
    if (!BuffContributionRequested || !player || player->getClass() != Practice::DevelopmentBuffs::ClassId)
        return false;
    auto const* profile = FindProfile(player, Practice::DevelopmentBuffs::AbilityId);
    return profile && Practice::DevelopmentBuffs::IsBrutalShout(*profile);
}

SpellInfo const* AcceptedBuffSpell(Player* player, MenuSession const& session,
    Practice::AbilityProfile const& profile)
{
    auto const& origin = session.BuffOrigin;
    if (!origin || !player->HasSpell(origin->SpellId) ||
        !AcquisitionAllowed(player, profile.Definition, origin->SpellId) ||
        std::none_of(profile.Definition.Ranks.begin(), profile.Definition.Ranks.end(),
            [&origin](Practice::AbilityRank const& rank) { return rank.SpellId == origin->SpellId; }))
        return nullptr;
    Aura* aura = player->GetAura(origin->SpellId, player->GetGUID());
    return aura && !aura->IsRemoved() && aura->GetPracticeCast() == origin ?
        sSpellMgr->GetSpellInfo(origin->SpellId) : nullptr;
}

Practice::BuffPracticeState BuffStateFor(Player* player, MenuSession const& session,
    Practice::AbilityProfile const& profile)
{
    if (!AcquisitionAllowed(player, profile.Definition, profile.Definition.Ranks.front().SpellId) ||
        std::none_of(profile.Definition.Ranks.begin(), profile.Definition.Ranks.end(),
            [player](Practice::AbilityRank const& rank) { return player->HasSpell(rank.SpellId); }))
        return Practice::BuffPracticeState::Unavailable;
    if (AcceptedBuffSpell(player, session, profile))
        return Practice::BuffPracticeState::Ready;
    for (auto const& rank : profile.Definition.Ranks)
        if (Aura* aura = player->GetAura(rank.SpellId, player->GetGUID()); aura && !aura->IsRemoved())
            return Practice::BuffPracticeState::Reapply;
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

std::vector<std::uint32_t> Learned(Player const* player, Practice::AbilityDefinition const& ability)
{
    std::vector<std::uint32_t> spells;
    for (Practice::AbilityRank const& rank : ability.Ranks)
        if (player->HasSpell(rank.SpellId))
            spells.push_back(rank.SpellId);
    return spells;
}

CoAAbilityPractice::RankDecision EvaluateRank(Player const* player, std::uint32_t spellId)
{
    using Decision = CoAAbilityPractice::RankDecision;
    if (!RankActive.load() || !IsProfiledPlayer(player))
        return Decision::Unmanaged;
    auto const* profile = FindProfile(player, spellId);
    if (!profile || profile->Definition.Kind == Practice::AbilityKind::Fixed ||
        spellId == profile->Definition.Ranks.front().SpellId)
        return Decision::Unmanaged;
    auto const* ability = &profile->Definition;
    std::lock_guard lock(Mutex);
    if (!RankRequested || !Affects(player))
        return Decision::Unmanaged;
    auto const desired = std::find_if(ability->Ranks.begin(), ability->Ranks.end(),
        [spellId](Practice::AbilityRank const& rank) { return rank.SpellId == spellId; });
    if (desired == ability->Ranks.end())
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
    auto const view = Practice::DescribeRank(*ability, static_cast<std::size_t>(desired - ability->Ranks.begin()),
        profile->Policy, record->State, player->GetLevel(), learned, true);
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
            if (session.Protocol != Practice::TypedMenuSchemaVersion &&
                (ability.Kind == Practice::AbilityKind::Mastery ||
                    Practice::DevelopmentBuffs::IsBrutalShout(profile)))
                continue;
            auto const learned = Learned(player, ability);
            Practice::Progress state;
            if (ability.Kind != Practice::AbilityKind::Fixed)
            {
                auto const loaded = Practice::ReadPlayerProgress(*player, ability.ClassId, ability.AbilityId,
                    profile.Policy, profile.DefinitionVersion);
                auto const migrated = Practice::MigrateLearnedRanks(ability, profile.Policy, loaded, learned);
                if (!migrated)
                {
                    if (session.Protocol != Practice::TypedMenuSchemaVersion)
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
            view.Route = BuffContributionRequested && Practice::DevelopmentBuffs::IsBrutalShout(profile)
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
            view.RuleSet = HelpersRequested && Practice::DevelopmentHelpers::IsManafeed(profile) ?
                Practice::HumanPvEScriptedHealRuleSet :
                PeriodicPracticeAbilities.contains(ProfileKey(ability)) ?
                    Practice::HumanPvEPeriodicRuleSet : Practice::HumanPvERuleSet;
            if (Catchup.Enabled && ability.Kind != Practice::AbilityKind::Fixed)
            {
                view.RuleSet += 3;
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
            views.push_back(std::move(view));
        }
    auto const progress = !supported ? Practice::SessionPractice{ false, 0, 0 } :
        currentProgress == session.Progress.end() ? Practice::SessionPractice{} : currentProgress->second.Totals;
    auto messages = Practice::EncodeMenuSnapshot(player->getClass(), player->GetLevel(), ++Revision, views,
        session.Protocol >= Practice::SessionMenuSchemaVersion
            ? std::optional<Practice::SessionPractice>(progress) : std::nullopt,
        session.Protocol >= Practice::RoadmapMenuSchemaVersion, session.Protocol == Practice::TypedMenuSchemaVersion,
        ServerGeneration, sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL),
        session.Protocol == Practice::TypedMenuSchemaVersion
            ? std::optional<Practice::SessionLearningView>(!supported
                ? Practice::SessionLearningView{ false, 0, {} } : currentProgress == session.Progress.end()
                    ? Practice::SessionLearningView{ true, 0, {} } : currentProgress->second.Learning.View())
            : std::nullopt,
        session.Protocol == Practice::TypedMenuSchemaVersion
            ? std::optional<Practice::SessionMasteryView>(!supported
                ? Practice::SessionMasteryView{ false, 0, {} } : currentProgress == session.Progress.end()
                    ? Practice::SessionMasteryView{ true, 0, {} } : currentProgress->second.Mastery.View())
            : std::nullopt);
    if (!messages || messages->size() > MaxQueuedMessages)
        return false;
    if (session.Protocol == Practice::TypedMenuSchemaVersion)
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
        if (auto const* profile = FindProfile(player, Practice::DevelopmentBuffs::AbilityId))
        {
            auto const state = BuffStateFor(player, session, *profile);
            if (session.LastBuffState != state)
            {
                session.LastBuffState = state;
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
    Practice::OutcomeAward const& award)
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

void BindBuffOrigin(Player* player, Spell* spell, Unit* target)
{
    if (!IsBuffObserver(player) || target != player || !spell)
        return;
    auto const* profile = FindProfile(player, spell->GetSpellInfo()->Id);
    if (!profile || !Practice::DevelopmentBuffs::IsBrutalShout(*profile))
        return;
    std::lock_guard lock(Mutex);
    auto const session = Sessions.find(player->GetGUID().GetRawValue());
    auto const receipt = spell->GetPracticeCast();
    Aura* aura = player->GetAura(spell->GetSpellInfo()->Id, player->GetGUID());
    if (Affects(player) && session != Sessions.end() && receipt && aura &&
        ReceiptOwnerMatches(player, session->second, *receipt) && aura->GetPracticeCast() == receipt &&
        receipt->SpellId == spell->GetSpellInfo()->Id)
        session->second.BuffOrigin = receipt;
}

void AwardBuffContribution(Player* player, Spell* spell, Unit* target, std::uint32_t damage, std::uint32_t healing)
{
    if (!IsBuffObserver(player) || !spell || !spell->GetScriptValue(PracticeBuffEligibilityKey) ||
        spell->GetScriptValue(PracticeBuffContributionKey) ||
        (!QualifiesDevelopmentOutcome(Practice::OutcomeKind::Damage, player, target, damage, 0) &&
            !QualifiesDevelopmentOutcome(Practice::OutcomeKind::Healing, player, target, 0, healing)))
        return;
    std::lock_guard lock(Mutex);
    auto const found = Sessions.find(player->GetGUID().GetRawValue());
    auto const action = spell->GetPracticeCast();
    auto const* profile = FindProfile(player, Practice::DevelopmentBuffs::AbilityId);
    if (!Affects(player) || player->isBeingLoaded() || found == Sessions.end() || !action || !profile ||
        !ReceiptOwnerMatches(player, found->second, *action) || action->SpellId != spell->GetSpellInfo()->Id ||
        spell->IsTriggered() || spell->m_CastItem || !spell->m_castItemGUID.IsEmpty() ||
        spell->GetSpellInfo()->IsAutoRepeatRangedSpell() ||
        !player->HasSpell(action->SpellId) || !player->IsSpellFitByClassAndRace(action->SpellId))
        return;
    auto& session = found->second;
    auto const origin = session.BuffOrigin;
    auto const now = Clock::now();
    if (!origin || now < session.NextBuffContribution || !player->HasSpell(origin->SpellId) ||
        !AcquisitionAllowed(player, profile->Definition, origin->SpellId))
        return;
    SpellInfo const* info = AcceptedBuffSpell(player, session, *profile);
    if (!info)
        return;
    auto const effective = Practice::BuildCatchupPolicy(profile->Policy,
        Practice::CapAtLevel(profile->Definition, player->GetLevel()), Catchup);
    if (!effective)
        return;
    CoAAbilityPractice::CastReceipt contribution(player->GetGUID().GetRawValue(), session.ActionSession,
        player->getClass(), origin->SpellId, player->getRace(), player->GetActiveSpec(),
        session.LastCustomSpecialization);
    ReceiptCast cast{ player, info, contribution };
    Practice::OutcomeContext const context{ true, true, true, true, player->GetLevel() };
    auto const award = Practice::HandleOutcome(*player, cast, profile->Definition,
        effective->View(), profile->DefinitionVersion, context);
    if (award.Status == Practice::OutcomeStatus::Awarded || award.Status == Practice::OutcomeStatus::Capped)
    {
        spell->SetScriptValue(PracticeBuffContributionKey, 1);
        session.NextBuffContribution = now + std::chrono::seconds(5);
    }
    RecordAward(player, session, *profile, award);
}

void AwardPeriodicOutcome(Unit* caster, Unit* target, std::uint32_t auraSpellId, std::uint32_t auraType,
    std::uint32_t damage, std::uint32_t healing, std::shared_ptr<CoAAbilityPractice::CastReceipt> const& receipt)
{
    if (!Active.load() || !caster || !target || !receipt || receipt->IsConsumed())
        return;
    Player* player = caster->ToPlayer();
    if (!IsProfiledPlayer(player))
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
            std::uint32_t const minimum = TrainerRankExtensionEntry(profile)
                ? Practice::SeedLearnedRanks(ability, {}, learned).Proficiency : 0;
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
    session.BuffOrigin.reset();
    session.NextBuffContribution = {};
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
            found->second.ActionSession = NewActionSession();
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
        CharacterSelectionReady = selected && !selected->empty();
        if (!selected)
            LOG_ERROR("module.ability_practice", "Rejected invalid development character selection; effects disabled");
        LOG_INFO("module.ability_practice", "Development character selection: valid={}, selected count={}",
            static_cast<bool>(selected), selected ? selected->size() : 0);
        Active.store(Requested && DevelopmentAllowed && Ready && CharacterSelectionReady);
        RankActive.store(Requested && DevelopmentAllowed && Ready && CharacterSelectionReady && RankRequested);
        for (auto entry = Sessions.begin(); entry != Sessions.end();)
        {
            if (!selected || !selected->contains(entry->first))
            {
                entry = Sessions.erase(entry);
                continue;
            }
            ClearDelivery(entry->second);
            entry->second.ActionSession = NewActionSession();
            entry->second.BuffOrigin.reset();
            entry->second.NextBuffContribution = {};
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
        AbsorptionRequested = sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentAbsorption", false);
        PacingRequested = sConfigMgr->GetOption<bool>("AbilityPractice.AllowDevelopmentRankPacing", false);
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
        std::span<Practice::AbilityProfile const> const profiles(RuntimeProfiles);
        ProfileLookup.emplace(profiles);
        Ready = ProfileLookup->IsValid() && periodicValid && masteryValid && helpersValid && fixedValid &&
            absorptionValid && controlValid && pacingValid && masteryPacingValid && trainerFixedValid &&
            directLeechValid && conjureFixedValid && trainerRanksValid && passiveFixedValid && utilityFixedValid &&
            controlFixedValid && buffValid &&
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
            if (!acquisitionValid || !MatchesConjureFixedMechanic(profile) || !MatchesPassiveFixedMechanic(profile) ||
                !MatchesUtilityFixedMechanic(profile) || !MatchesControlFixedMechanic(profile))
            {
                Ready = false;
                LOG_ERROR("module.ability_practice", "Rejected native acquisition: class={}, ability={}",
                    profile.Definition.ClassId, profile.Definition.AbilityId);
            }
            if (!MatchesEffectiveRankChain(profile.Definition) || !MatchesTrainerRankBoundary(profile.Definition))
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
        session.BuffOrigin.reset();
        session.NextBuffContribution = {};
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
            message != "HXAP\tHELLO|3" && message != "HXAP\tHELLO|4"))
            return false;
        auto const now = Clock::now();
        auto& session = Sessions[player->GetGUID().GetRawValue()];
        if (now - session.LastRequest < RefreshInterval)
            return false;
        session.LastRequest = now;
        session.InterestedUntil = now + InterestDuration;
        std::uint32_t const protocol = message == "HXAP\tHELLO|4" ? Practice::TypedMenuSchemaVersion :
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
        !QualifiesDevelopmentOutcome(Practice::OutcomeKind::Healing, player, target, 0, healing))
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
    if (!Active.load() || !MasteryRequested || !target || !caster || !spellId || !damage || !receipt ||
        receipt->SpellId != spellId)
        return damage;
    Player* player = caster->ToPlayer();
    if (!IsProfiledPlayer(player) || player->isBeingLoaded())
        return damage;
    auto const* profile = FindProfile(player, spellId);
    if (!profile || profile->Definition.Kind != Practice::AbilityKind::Mastery ||
        profile->Outcome != Practice::OutcomeKind::Damage ||
        !QualifiesDevelopmentOutcome(Practice::OutcomeKind::Damage, player, target, damage, 0))
        return damage;
    std::lock_guard lock(Mutex);
    auto const session = Sessions.find(player->GetGUID().GetRawValue());
    if (!Affects(player) || session == Sessions.end() || !ReceiptOwnerMatches(player, session->second, *receipt) ||
        !player->HasSpell(spellId) || !AcquisitionAllowed(player, profile->Definition, spellId))
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

    bool CanPrepare(Spell* spell, SpellCastTargets const*, AuraEffect const* triggeredByAura) override
    {
        if (!Active.load() || !spell || !spell->GetCaster() || !spell->GetSpellInfo())
            return true;
        Player* player = spell->GetCaster()->ToPlayer();
        if (!IsProfiledPlayer(player))
            return true;
        auto const* profile = FindProfile(player, spell->GetSpellInfo()->Id);
        if (!profile && !IsBuffObserver(player))
            return true;
        std::lock_guard lock(Mutex);
        spell->SetPracticeCast({});
        spell->SetScriptValue(PracticeBuffEligibilityKey, 0);
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
                if (IsBuffObserver(player))
                    if (auto const* buff = FindProfile(player, Practice::DevelopmentBuffs::AbilityId))
                        spell->SetScriptValue(PracticeBuffEligibilityKey,
                            AcceptedBuffSpell(player, session, *buff) ? 1 : 0);
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
        BindBuffOrigin(player, spell, target);
        if (!damage && !healing)
            return;
        AwardBuffContribution(player, spell, target, damage, healing);
        auto const* profile = FindProfile(player, spell->GetSpellInfo()->Id);
        if (!profile || Practice::DevelopmentBuffs::IsBrutalShout(*profile) ||
            !QualifiesDevelopmentOutcome(profile->Outcome, player, target, damage, healing))
            return;
        AwardOutcome(player, spell, *profile);
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
    new PracticeWorld();
    new PracticePlayer();
    new PracticeClientCast();
    new PracticeSpell();
}
