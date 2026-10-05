// SPDX-License-Identifier: GPL-2.0-or-later

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeProfiles.h"
#include "AbilityPracticeRankPolicy.h"
#include "AbilityPracticeOutcome.h"
#include "AbilityPracticeWire.h"
#include "AscensionCustomClassData.h"
#include "AscensionSpellProgressionData.h"
#include "Chat.h"
#include "Config.h"
#include "CombatManager.h"
#include "Creature.h"
#include "Formulas.h"
#include "Log.h"
#include "Player.h"
#include "Random.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellMgr.h"
#include "WorldPacket.h"
#include "WorldSession.h"

#include <array>
#include <atomic>
#include <chrono>
#include <mutex>
#include <unordered_map>

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
std::optional<Practice::ProfileIndex> ProfileLookup;
std::recursive_mutex Mutex;
bool Requested = false;
bool DevelopmentAllowed = false;
bool Ready = false;
bool RankRequested = false;
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
constexpr std::size_t MaxQueuedMessages = 512 * 6 + 2048 + 3;
constexpr std::uint32_t PracticeCastSourceKey = 0x41504353;
struct ClassSession
{
    Practice::SessionPractice Totals;
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
    std::uint32_t Protocol = Practice::MenuSchemaVersion;
    std::uint32_t LastClass = 0;
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
            info->HasEffect(SPELL_EFFECT_WEAPON_PERCENT_DAMAGE);
    if (outcome == Practice::OutcomeKind::Healing)
        return info->HasEffect(SPELL_EFFECT_HEAL) || info->HasEffect(SPELL_EFFECT_HEAL_PCT) ||
            info->HasEffect(SPELL_EFFECT_HEAL_MAX_HEALTH);
    if (outcome == Practice::OutcomeKind::Interrupt)
        return info->HasEffect(SPELL_EFFECT_INTERRUPT_CAST);
    if (outcome == Practice::OutcomeKind::Dispel)
        return info->HasEffect(SPELL_EFFECT_DISPEL);
    if (outcome == Practice::OutcomeKind::Steal)
        return info->HasEffect(SPELL_EFFECT_STEAL_BENEFICIAL_BUFF);
    return false;
}

bool MatchesNativeClassGrant(Practice::AbilityProfile const& profile)
{
    Practice::AbilityDefinition const& ability = profile.Definition;
    if (profile.Acquisition != Practice::AcquisitionSource::ClassGrant || ability.Ranks.empty())
        return false;
    Practice::AbilityRank const& first = ability.Ranks.front();
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

bool IsHumanPlayer(Player const* player)
{
    return player && player->GetSession() && !player->GetSession()->IsBot();
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
    return IsHumanPlayer(player) && ProfileLookup && ProfileLookup->HasClass(player->getClass());
}

bool Affects(Player const* player)
{
    return Requested && DevelopmentAllowed && Ready && IsProfiledPlayer(player);
}

bool IsDevelopmentOpponent(Player const* player, Unit const* opponent)
{
    if (!opponent || !opponent->IsCreature() || opponent->IsControlledByPlayer() || opponent->IsPet() ||
        opponent->IsTotem() || opponent->IsCritter() || player->IsFriendlyTo(opponent) ||
        opponent->getLevelForTarget(player) <= Acore::XP::GetGrayLevel(player->GetLevel()))
        return false;
    std::string const script = opponent->ToCreature()->GetScriptName();
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
    if (!Requested || !DevelopmentAllowed || !Ready || !IsHumanPlayer(player) ||
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
            auto view = Practice::BuildAbilityView(ability, profile.Policy, state, player->GetLevel(), learned, true);
            view.Route = RouteFor(profile.Outcome);
            view.RuleSet = Practice::HumanPvERuleSet;
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
        ServerGeneration);
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
        session.LastClass = player->getClass();
        Deliver(player, session, now);
    }
}

void AwardOutcome(Player* player, Spell* spell, Practice::AbilityProfile const& profile)
{
    std::lock_guard lock(Mutex);
    std::uint64_t const source = (static_cast<std::uint64_t>(profile.Definition.ClassId) << 32) |
        spell->GetSpellInfo()->Id;
    if (!Affects(player) || player->isBeingLoaded() || spell->GetScriptValue(PracticeCastSourceKey) != source)
        return;
    auto& session = Sessions[player->GetGUID().GetRawValue()];
    Practice::OutcomeContext const context{ true, true, true, true, player->GetLevel() };
    auto const award = Practice::HandleOutcome(*player, *spell, profile.Definition,
        profile.Policy, profile.DefinitionVersion, context);
    if (award.Status != Practice::OutcomeStatus::Awarded)
        return;
    ClassSession& progress = session.Progress[player->getClass()];
    progress.Totals.RecordAward(award.ProficiencyGained);
    progress.Abilities[profile.Definition.AbilityId].RecordAward(award.ProficiencyGained);
    session.Dirty = true;
    session.CheckRanks = true;
    Refresh(player, session, Clock::now());
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

void MarkDirty(Player* player)
{
    if (!Active.load() || !IsProfiledPlayer(player))
        return;
    std::lock_guard lock(Mutex);
    auto const found = Sessions.find(player->GetGUID().GetRawValue());
    if (Affects(player) && found != Sessions.end())
    {
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
        Active.store(Requested && DevelopmentAllowed && Ready);
        RankActive.store(Requested && DevelopmentAllowed && Ready && RankRequested);
        for (auto& entry : Sessions)
        {
            ClearDelivery(entry.second);
            entry.second.Dirty = true;
            entry.second.CheckRanks = true;
        }
    }

    void OnStartup() override
    {
        std::lock_guard lock(Mutex);
        if (!Requested || !DevelopmentAllowed)
        {
            Active.store(false);
            RankActive.store(false);
            LOG_INFO("module.ability_practice", "Development observation disabled");
            return;
        }
        if (!ServerGeneration)
            ServerGeneration = (static_cast<std::uint64_t>(urand(0, std::numeric_limits<std::uint32_t>::max())) << 32) |
                urand(1, std::numeric_limits<std::uint32_t>::max());
        ProfileLookup.emplace(Profiles);
        Ready = ProfileLookup->IsValid();
        for (Practice::AbilityProfile const& profile : Profiles)
        {
            if (!MatchesNativeClassGrant(profile))
            {
                Ready = false;
                LOG_ERROR("module.ability_practice", "Rejected class-grant acquisition: class={}, ability={}",
                    profile.Definition.ClassId, profile.Definition.AbilityId);
            }
            for (Practice::AbilityRank const& rank : profile.Definition.Ranks)
            {
                SpellInfo const* info = sSpellMgr->GetSpellInfo(rank.SpellId);
                bool const fixed = profile.Definition.Kind == Practice::AbilityKind::Fixed;
                bool const expectedOutcome = info && (fixed || HasSupportedOutcome(info, profile.Outcome));
                if (!info || (!fixed && info->IsPassive()) || !expectedOutcome)
                {
                    Ready = false;
                    LOG_ERROR("module.ability_practice", "Rejected development profile: class={}, ability={}, spell={}",
                        profile.Definition.ClassId, profile.Definition.AbilityId, rank.SpellId);
                }
            }
        }
        Active.store(Requested && DevelopmentAllowed && Ready);
        RankActive.store(Requested && DevelopmentAllowed && Ready && RankRequested);
        LOG_INFO("module.ability_practice", "Development observation: requested={}, allowed={}, data ready={}",
            Requested, DevelopmentAllowed, Ready);
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
        if (!Active.load() || !IsHumanPlayer(player))
            return;
        std::lock_guard lock(Mutex);
        if (!Requested || !DevelopmentAllowed || !Ready)
            return;
        InitializeProgress(player);
        auto& session = Sessions[player->GetGUID().GetRawValue()];
        session = {};
        session.LastClass = player->getClass();
        session.Initialized = true;
    }

    void OnPlayerUpdate(Player* player, uint32) override
    {
        if (!Active.load() || !IsHumanPlayer(player) || player->isBeingLoaded())
            return;
        bool checkRanks = false;
        {
            std::lock_guard lock(Mutex);
            if (!Requested || !DevelopmentAllowed || !Ready)
                return;
            MenuSession& session = Sessions[player->GetGUID().GetRawValue()];
            if (!session.Initialized || session.LastClass != player->getClass())
            {
                InitializeProgress(player);
                session.Initialized = true;
                session.LastClass = player->getClass();
                session.Dirty = true;
                session.CheckRanks = true;
            }
            checkRanks = session.CheckRanks;
            session.CheckRanks = false;
        }
        if (checkRanks)
            PromoteRanks(player);
        std::lock_guard lock(Mutex);
        auto const found = Sessions.find(player->GetGUID().GetRawValue());
        if (found != Sessions.end())
            Refresh(player, found->second, Clock::now());
    }

    void OnPlayerLevelChanged(Player* player, uint8) override
    {
        MarkDirty(player);
    }

    void OnPlayerLearnSpell(Player* player, uint32 spellId) override
    {
        if (Active.load() && FindProfile(player, spellId))
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
        if (!Active.load() || !IsHumanPlayer(player) || language != LANG_ADDON ||
            message.rfind("HXAP\t", 0) != 0)
            return true;
        std::lock_guard lock(Mutex);
        if (!Requested || !DevelopmentAllowed || !Ready)
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
        if (!IsProfiledPlayer(player) || !FindProfile(player, spell->GetSpellInfo()->Id))
            return true;
        bool const direct = !triggeredByAura && !spell->IsTriggered() && !spell->m_CastItem &&
            spell->m_castItemGUID.IsEmpty() && spell->GetOriginalCasterGUID() == player->GetGUID();
        std::uint64_t const source = direct ? (static_cast<std::uint64_t>(player->getClass()) << 32) |
            spell->GetSpellInfo()->Id : std::numeric_limits<std::uint64_t>::max();
        spell->SetScriptValue(PracticeCastSourceKey, source);
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
    new PracticeWorld();
    new PracticePlayer();
    new PracticeSpell();
}
