// SPDX-License-Identifier: GPL-2.0-or-later

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeProfiles.h"
#include "AbilityPracticeRankPolicy.h"
#include "AbilityPracticeOutcome.h"
#include "AbilityPracticeWire.h"
#include "Chat.h"
#include "Config.h"
#include "CombatManager.h"
#include "Creature.h"
#include "Formulas.h"
#include "Log.h"
#include "Player.h"
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
        Dev::Abilities[0], Dev::Policy, Practice::DirectOutcome::Damage },
    Practice::AbilityProfile{ Dev::DefinitionVersion, Practice::AcquisitionSource::ClassGrant,
        Dev::Abilities[1], Dev::Policy, Practice::DirectOutcome::Healing },
    Practice::AbilityProfile{ Dev::DefinitionVersion, Practice::AcquisitionSource::ClassGrant,
        Dev::Abilities[2], Dev::Policy, Practice::DirectOutcome::Healing }
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
using Clock = std::chrono::steady_clock;
constexpr auto RefreshInterval = std::chrono::seconds(2);
constexpr auto InterestDuration = std::chrono::seconds(30);
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
    std::unordered_map<std::uint32_t, Practice::SessionPractice> Progress;
};
std::unordered_map<std::uint64_t, MenuSession> Sessions;

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

bool QualifiesDevelopmentOutcome(Player const* player, Unit const* target, uint32 damage, uint32 healing)
{
    if (damage && IsDevelopmentOpponent(player, target))
        return true;
    return healing && player->IsFriendlyTo(target) && HasDevelopmentEncounter(player, target);
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

bool Send(Player* player, MenuSession const& session)
{
    if (!Requested || !DevelopmentAllowed || !Ready || !IsHumanPlayer(player) ||
        Revision == std::numeric_limits<std::uint32_t>::max())
        return false;
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
                    return false;
                state = migrated->State;
            }
            views.push_back(Practice::BuildAbilityView(ability, profile.Policy, state,
                player->GetLevel(), learned, true));
        }
    auto const currentProgress = session.Progress.find(player->getClass());
    auto const progress = !supported ? Practice::SessionPractice{ false, 0, 0 } :
        currentProgress == session.Progress.end() ? Practice::SessionPractice{} : currentProgress->second;
    auto const messages = Practice::EncodeMenuSnapshot(player->getClass(), player->GetLevel(), ++Revision, views,
        session.Protocol >= Practice::SessionMenuSchemaVersion
            ? std::optional<Practice::SessionPractice>(progress) : std::nullopt,
        session.Protocol == Practice::RoadmapMenuSchemaVersion);
    if (!messages)
        return false;
    for (std::string const& message : *messages)
    {
        WorldPacket packet;
        ChatHandler::BuildChatPacket(packet, CHAT_MSG_WHISPER, LANG_ADDON, player, nullptr, "HXAP\t" + message);
        player->SendDirectMessage(&packet);
    }
    return true;
}

void Refresh(Player* player, MenuSession& session, Clock::time_point now)
{
    if (!session.Dirty || now < session.NextRefresh || now >= session.InterestedUntil)
        return;
    session.NextRefresh = now + RefreshInterval;
    if (Send(player, session))
    {
        session.Dirty = false;
        session.LastClass = player->getClass();
    }
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
        ProfileLookup.emplace(Profiles);
        Ready = ProfileLookup->IsValid();
        for (Practice::AbilityProfile const& profile : Profiles)
            for (Practice::AbilityRank const& rank : profile.Definition.Ranks)
            {
                SpellInfo const* info = sSpellMgr->GetSpellInfo(rank.SpellId);
                bool const expectedOutcome = info && (profile.Outcome == Practice::DirectOutcome::Damage ?
                    info->HasEffect(SPELL_EFFECT_SCHOOL_DAMAGE) : info->HasEffect(SPELL_EFFECT_HEAL));
                if (!info || info->IsPassive() || !expectedOutcome)
                {
                    Ready = false;
                    LOG_ERROR("module.ability_practice", "Rejected development profile: class={}, ability={}, spell={}",
                        profile.Definition.ClassId, profile.Definition.AbilityId, rank.SpellId);
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
            message != "HXAP\tHELLO|3"))
            return false;
        auto const now = Clock::now();
        auto& session = Sessions[player->GetGUID().GetRawValue()];
        if (now - session.LastRequest < RefreshInterval)
            return false;
        session.LastRequest = now;
        session.InterestedUntil = now + InterestDuration;
        session.Protocol = message == "HXAP\tHELLO|3" ? Practice::RoadmapMenuSchemaVersion :
            message == "HXAP\tHELLO|2" ? Practice::SessionMenuSchemaVersion : Practice::MenuSchemaVersion;
        session.Dirty = true;
        Refresh(player, session, now);
        return false;
    }
};

class PracticeSpell : public AllSpellScript
{
public:
    PracticeSpell() : AllSpellScript("AbilityPracticeSpell", { ALLSPELLHOOK_ON_HIT_RESULT }) { }

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
        if (!profile || (profile->Outcome == Practice::DirectOutcome::Damage ? !damage : !healing) ||
            !QualifiesDevelopmentOutcome(player, target, damage, healing))
            return;
        std::lock_guard lock(Mutex);
        if (!Affects(player))
            return;
        if (player->isBeingLoaded())
            return;
        auto& session = Sessions[player->GetGUID().GetRawValue()];
        Practice::OutcomeContext const context{ true, true, true, true, player->GetLevel() };
        auto const award = Practice::HandleOutcome(*player, *spell, profile->Definition,
            profile->Policy, profile->DefinitionVersion, context);
        if (award.Status == Practice::OutcomeStatus::Awarded)
        {
            session.Progress[player->getClass()].RecordAward(award.ProficiencyGained);
            session.Dirty = true;
            session.CheckRanks = true;
            Refresh(player, session, Clock::now());
        }
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
