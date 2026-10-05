// SPDX-License-Identifier: GPL-2.0-or-later

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeCatchup.h"
#include "AbilityPracticeDevelopmentSamples.h"
#include "AbilityPracticeDevelopmentPeriodic.h"
#include "AbilityPracticeDevelopmentRanked.h"
#include "AbilityPracticeDevelopmentMastery.h"
#include "AbilityPracticeDevelopmentHelpers.h"
#include "AbilityPracticeDevelopmentFixed.h"
#include "AbilityPracticeProfiles.h"
#include "AbilityPracticeRankPolicy.h"
#include "AbilityPracticeMasteryPolicy.h"
#include "AbilityPracticeCastReceipt.h"
#include "AbilityPracticeOutcome.h"
#include "AbilityPracticeWire.h"
#include "AscensionCustomClassData.h"
#include "AscensionSpellProgressionData.h"
#include "AscensionSpellEligibility.h"
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
#include "SpellMgr.h"
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
                    lhs.HealingBonusBasisPoints == rhs.HealingBonusBasisPoints;
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
std::vector<Practice::AbilityProfile> RuntimeProfiles;
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
Practice::CatchupSettings Catchup;
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
constexpr std::size_t MaxQueuedMessages = 512 * 8 + 2048 + Practice::MaximumSessionLearns +
    Practice::MaximumSessionMasteries + 4;
constexpr std::uint32_t PracticeCastSourceKey = 0x41504353;
constexpr std::uint32_t PracticeClientRequestKey = 0x41504352;
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
    }
    return Practice::PracticeRoute::Unknown;
}

bool HasSupportedOutcome(SpellInfo const* info, Practice::OutcomeKind outcome)
{
    if (!info)
        return false;
    if (outcome == Practice::OutcomeKind::Damage)
        return info->HasEffect(SPELL_EFFECT_SCHOOL_DAMAGE) || info->HasEffect(SPELL_EFFECT_WEAPON_DAMAGE) ||
            info->HasEffect(SPELL_EFFECT_WEAPON_DAMAGE_NOSCHOOL) || info->HasEffect(SPELL_EFFECT_NORMALIZED_WEAPON_DMG) ||
            info->HasEffect(SPELL_EFFECT_WEAPON_PERCENT_DAMAGE) || (PeriodicRequested &&
                (info->HasAura(SPELL_AURA_PERIODIC_DAMAGE) || info->HasAura(SPELL_AURA_PERIODIC_DAMAGE_PERCENT) ||
                    info->HasAura(SPELL_AURA_PERIODIC_LEECH)));
    if (outcome == Practice::OutcomeKind::Healing)
        return info->HasEffect(SPELL_EFFECT_HEAL) || info->HasEffect(SPELL_EFFECT_HEAL_PCT) ||
            info->HasEffect(SPELL_EFFECT_HEAL_MAX_HEALTH) ||
            (PeriodicRequested && info->HasAura(SPELL_AURA_PERIODIC_HEAL));
    if (outcome == Practice::OutcomeKind::Interrupt)
        return info->HasEffect(SPELL_EFFECT_INTERRUPT_CAST);
    if (outcome == Practice::OutcomeKind::Dispel)
        return info->HasEffect(SPELL_EFFECT_DISPEL);
    if (outcome == Practice::OutcomeKind::Steal)
        return info->HasEffect(SPELL_EFFECT_STEAL_BENEFICIAL_BUFF);
    return false;
}

bool HasSupportedHelperOutcome(SpellInfo const* info, Practice::AbilityProfile const& profile)
{
    return HelpersRequested && info && Practice::DevelopmentHelpers::IsManafeed(profile) &&
        info->Effects[EFFECT_0].Effect == SPELL_EFFECT_APPLY_AURA &&
        info->Effects[EFFECT_0].ApplyAuraName == SPELL_AURA_PERIODIC_DUMMY;
}

bool MatchesNativeClassGrant(Practice::AbilityProfile const& profile)
{
    Practice::AbilityDefinition const& ability = profile.Definition;
    if (profile.Acquisition != Practice::AcquisitionSource::ClassGrant || ability.Ranks.empty())
        return false;
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

bool AcquisitionAllowed(Player const* player, Practice::AbilityDefinition const& ability, std::uint32_t spellId)
{
    return player && player->getClass() == ability.ClassId && !ability.Ranks.empty() &&
        AscensionAcquisition::CanLearnRacialSpell(player, ability.Ranks.front().SpellId) &&
        AscensionAcquisition::CanLearnRacialSpell(player, spellId);
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

bool ReceiptMatches(Player const* player, MenuSession const& session, CoAAbilityPractice::CastReceipt const& receipt)
{
    return session.Initialized && receipt.Session && receipt.Session == session.ActionSession &&
        receipt.CasterGUID == player->GetGUID().GetRawValue() && receipt.ClassId == player->getClass() &&
        receipt.RaceId == player->getRace() && receipt.TalentSet == player->GetActiveSpec() &&
        receipt.Specialization == CachedCustomSpecialization(player) && !receipt.IsConsumed();
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
    if (outcome == Practice::OutcomeKind::Damage)
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
    if (!profile || spellId == profile->Definition.Ranks.front().SpellId)
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
            if (ability.Kind == Practice::AbilityKind::Mastery && session.Protocol != Practice::TypedMenuSchemaVersion)
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
                        ability.AbilityId, ability.Ranks.front().SpellId, ServerGeneration);
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
            view.Route = RouteFor(profile.Outcome);
            view.AcquisitionSourceId = static_cast<std::uint32_t>(profile.Acquisition);
            view.RuleSet = HelpersRequested && Practice::DevelopmentHelpers::IsManafeed(profile) ?
                Practice::HumanPvEScriptedHealRuleSet :
                PeriodicRequested ? Practice::HumanPvEPeriodicRuleSet : Practice::HumanPvERuleSet;
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

struct PeriodicCast
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
    if (!profile || (!scripted && (profile->Outcome == Practice::OutcomeKind::Damage ?
            auraType != SPELL_AURA_PERIODIC_DAMAGE && auraType != SPELL_AURA_PERIODIC_DAMAGE_PERCENT &&
                auraType != SPELL_AURA_PERIODIC_LEECH :
            profile->Outcome != Practice::OutcomeKind::Healing || auraType != SPELL_AURA_PERIODIC_HEAL)) ||
        std::none_of(profile->Definition.Ranks.begin(), profile->Definition.Ranks.end(),
            [auraSpellId](Practice::AbilityRank const& rank) { return rank.SpellId == auraSpellId; }) ||
        (scripted ? !healing || !target->IsAlive() || !IsDevelopmentOpponent(player, target) ||
            !HasDevelopmentEncounter(player, player) :
            !QualifiesDevelopmentOutcome(profile->Outcome, player, target, damage, healing)))
        return;
    std::lock_guard lock(Mutex);
    auto const found = Sessions.find(player->GetGUID().GetRawValue());
    if ((!scripted && !PeriodicRequested) || (scripted && !HelpersRequested) ||
        !Affects(player) || player->isBeingLoaded() || found == Sessions.end() ||
        !ReceiptMatches(player, found->second, *receipt) ||
        !AcquisitionAllowed(player, profile->Definition, receipt->SpellId))
        return;
    PeriodicCast cast{ player, sSpellMgr->GetSpellInfo(receipt->SpellId), *receipt };
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
    if (!profile || profile->Outcome != kind)
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
        if (learned.empty())
            continue;
        auto const loaded = Practice::ReadPlayerProgress(*player, ability.ClassId, ability.AbilityId,
            profile.Policy, profile.DefinitionVersion);
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
    session.Dirty = true;
    session.CheckRanks = true;
}

void MarkDirty(Player* player)
{
    if (!Active.load() || !IsProfiledPlayer(player))
        return;
    std::lock_guard lock(Mutex);
    auto const found = Sessions.find(player->GetGUID().GetRawValue());
    if (Affects(player) && found != Sessions.end())
    {
        ClearDelivery(found->second);
        found->second.NextRefresh = {};
        found->second.Dirty = true;
        found->second.CheckRanks = true;
    }
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
        std::span<Practice::AbilityProfile const> const selected =
            SelectProfiles(classSamples, rankedCatalog);
        RuntimeProfiles.assign(selected.begin(), selected.end());
        bool const periodicValid = !PeriodicRequested ||
            AppendProfiles(RuntimeProfiles, Practice::DevelopmentPeriodic::Profiles);
        bool const masteryValid = !MasteryRequested ||
            AppendProfiles(RuntimeProfiles, Practice::DevelopmentMastery::Profiles);
        bool const helpersValid = !HelpersRequested ||
            AppendProfiles(RuntimeProfiles, Practice::DevelopmentHelpers::Profiles);
        bool const fixedValid = !fixedCatalog || AppendProfiles(RuntimeProfiles, Practice::DevelopmentFixed::Profiles);
        std::span<Practice::AbilityProfile const> const profiles(RuntimeProfiles);
        ProfileLookup.emplace(profiles);
        Ready = ProfileLookup->IsValid() && periodicValid && masteryValid && helpersValid && fixedValid &&
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
            if (!MatchesNativeClassGrant(profile))
            {
                Ready = false;
                LOG_ERROR("module.ability_practice", "Rejected class-grant acquisition: class={}, ability={}",
                    profile.Definition.ClassId, profile.Definition.AbilityId);
            }
            if (!MatchesEffectiveRankChain(profile.Definition))
            {
                Ready = false;
                LOG_ERROR("module.ability_practice", "Rejected effective rank chain: class={}, ability={}",
                    profile.Definition.ClassId, profile.Definition.AbilityId);
            }
            for (Practice::AbilityRank const& rank : profile.Definition.Ranks)
            {
                SpellInfo const* info = sSpellMgr->GetSpellInfo(rank.SpellId);
                bool const fixed = profile.Definition.Kind == Practice::AbilityKind::Fixed;
                bool const expectedOutcome = info && (fixed || HasSupportedOutcome(info, profile.Outcome) ||
                    HasSupportedHelperOutcome(info, profile)) &&
                    (profile.Definition.Kind != Practice::AbilityKind::Mastery ||
                        (!info->HasAura(SPELL_AURA_PERIODIC_HEAL) && !info->HasAura(SPELL_AURA_PERIODIC_LEECH)));
                if (!info || info->IsDeprecatedForPlayers || (!fixed && info->IsPassive()) || !expectedOutcome)
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
            return;
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
        if (Active.load() && FindProfile(player, spellId))
            MarkDirty(player);
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
            !FindProfile(player, spell->GetSpellInfo()->Id))
            return;
        std::uint64_t const request = (static_cast<std::uint64_t>(player->getClass()) << 32) |
            spell->GetSpellInfo()->Id;
        spell->SetScriptValue(PracticeClientRequestKey, request);
    }
};

std::uint32_t ModifyMasteryHealing(Unit* healer, Unit* target, std::uint32_t spellId, std::uint32_t healing)
{
    if (!Active.load() || !MasteryRequested || !target || !healer || !spellId || !healing)
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
    if (!Affects(player) || !player->HasSpell(spellId) ||
        !AcquisitionAllowed(player, profile->Definition, spellId))
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
        if (!profile)
            return true;
        std::lock_guard lock(Mutex);
        spell->SetPracticeCast({});
        std::uint64_t const request = (static_cast<std::uint64_t>(player->getClass()) << 32) |
            spell->GetSpellInfo()->Id;
        bool const direct = spell->GetScriptValue(PracticeClientRequestKey) == request && !triggeredByAura &&
            !spell->IsTriggered() && !spell->m_CastItem && spell->m_castItemGUID.IsEmpty() &&
            spell->GetOriginalCasterGUID() == player->GetGUID() &&
            AcquisitionAllowed(player, profile->Definition, spell->GetSpellInfo()->Id);
        std::uint64_t const source = direct ? request : std::numeric_limits<std::uint64_t>::max();
        spell->SetScriptValue(PracticeCastSourceKey, source);
        if (direct && Affects(player) && !player->isBeingLoaded() && profile->Outcome != Practice::OutcomeKind::None)
        {
            auto& session = Sessions[player->GetGUID().GetRawValue()];
            RefreshOwnerState(player, session, CachedCustomSpecialization(player));
            if (session.ActionSession)
                spell->SetPracticeCast(std::make_shared<CoAAbilityPractice::CastReceipt>(
                    player->GetGUID().GetRawValue(), session.ActionSession, player->getClass(), spell->GetSpellInfo()->Id,
                    player->getRace(), player->GetActiveSpec(), session.LastCustomSpecialization));
        }
        return true;
    }

    void OnSpellHitResult(Spell* spell, Unit* target, uint8 miss, uint32 damage, uint32 healing, bool) override
    {
        if (!Active.load())
            return;
        if (!spell || !spell->GetCaster() || !target || miss != SPELL_MISS_NONE || (!damage && !healing))
            return;
        Player* player = spell->GetCaster()->ToPlayer();
        if (!IsProfiledPlayer(player))
            return;
        auto const* profile = FindProfile(player, spell->GetSpellInfo()->Id);
        if (!profile || (profile->Outcome != Practice::OutcomeKind::Damage &&
                profile->Outcome != Practice::OutcomeKind::Healing) ||
            (profile->Outcome == Practice::OutcomeKind::Damage ? !damage : !healing) ||
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
    CoAAbilityPractice::SetPeriodicOutcomeProvider(AwardPeriodicOutcome);
    CoAAbilityPractice::SetHealingMasteryProvider(ModifyMasteryHealing);
    new PracticeWorld();
    new PracticePlayer();
    new PracticeClientCast();
    new PracticeSpell();
}
