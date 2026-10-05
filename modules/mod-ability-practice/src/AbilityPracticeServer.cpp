// SPDX-License-Identifier: GPL-2.0-or-later

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeOutcome.h"
#include "AbilityPracticeWire.h"
#include "Chat.h"
#include "Config.h"
#include "Log.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellMgr.h"
#include "WorldPacket.h"
#include "WorldSession.h"

#include <atomic>
#include <chrono>
#include <mutex>
#include <unordered_map>

namespace
{
namespace Practice = AbilityPractice;
namespace Dev = AbilityPractice::Development;
std::recursive_mutex Mutex;
bool Requested = false;
bool DevelopmentAllowed = false;
bool Ready = false;
std::atomic<bool> Active = false;
std::uint32_t Revision = 0;
using Clock = std::chrono::steady_clock;
constexpr auto RefreshInterval = std::chrono::seconds(2);
struct MenuSession
{
    Clock::time_point LastRequest{};
    Clock::time_point NextRefresh{};
    bool Dirty = true;
    std::uint32_t Protocol = Practice::MenuSchemaVersion;
    Practice::SessionPractice Progress;
};
std::unordered_map<std::uint64_t, MenuSession> Sessions;

bool IsDevelopmentPlayer(Player const* player)
{
    return player && player->GetSession() && !player->GetSession()->IsBot() && player->getClass() == Dev::ClassId;
}

bool Affects(Player const* player)
{
    return Requested && DevelopmentAllowed && Ready && IsDevelopmentPlayer(player);
}

std::vector<std::uint32_t> Learned(Player const* player, Practice::AbilityDefinition const& ability)
{
    std::vector<std::uint32_t> spells;
    for (Practice::AbilityRank const& rank : ability.Ranks)
        if (player->HasSpell(rank.SpellId))
            spells.push_back(rank.SpellId);
    return spells;
}

bool Send(Player* player, MenuSession const& session)
{
    if (!Affects(player) || Revision == std::numeric_limits<std::uint32_t>::max())
        return false;
    std::vector<Practice::AbilityView> views;
    for (Practice::AbilityDefinition const& ability : Dev::Abilities)
    {
        auto const learned = Learned(player, ability);
        auto const loaded = Practice::ReadPlayerProgress(*player, ability.ClassId, ability.AbilityId,
            Dev::Policy, Dev::DefinitionVersion);
        auto const migrated = Practice::MigrateLearnedRanks(ability, Dev::Policy, loaded, learned);
        if (!migrated)
            return false;
        views.push_back(Practice::BuildAbilityView(ability, Dev::Policy, migrated->State,
            player->GetLevel(), learned, true));
    }
    auto const messages = Practice::EncodeMenuSnapshot(Dev::ClassId, player->GetLevel(), ++Revision, views,
        session.Protocol == Practice::SessionMenuSchemaVersion
            ? std::optional<Practice::SessionPractice>(session.Progress) : std::nullopt);
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
    if (!session.Dirty || now < session.NextRefresh)
        return;
    session.NextRefresh = now + RefreshInterval;
    if (Send(player, session))
        session.Dirty = false;
}

void MarkDirty(Player* player)
{
    if (!Active.load() || !IsDevelopmentPlayer(player))
        return;
    std::lock_guard lock(Mutex);
    auto const found = Sessions.find(player->GetGUID().GetRawValue());
    if (Affects(player) && found != Sessions.end())
        found->second.Dirty = true;
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
        Active.store(Requested && DevelopmentAllowed && Ready);
    }

    void OnStartup() override
    {
        std::lock_guard lock(Mutex);
        if (!Requested || !DevelopmentAllowed)
        {
            Active.store(false);
            LOG_INFO("module.ability_practice", "Development observation disabled");
            return;
        }
        Ready = Practice::ValidateCatalog(Dev::Abilities) == Practice::CatalogError::None &&
            Practice::ValidPolicy(Dev::Policy);
        for (Practice::AbilityDefinition const& ability : Dev::Abilities)
            for (Practice::AbilityRank const& rank : ability.Ranks)
            {
                SpellInfo const* info = sSpellMgr->GetSpellInfo(rank.SpellId);
                if (!info || info->IsPassive())
                    Ready = false;
            }
        Active.store(Requested && DevelopmentAllowed && Ready);
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
        if (!Active.load() || !IsDevelopmentPlayer(player))
            return;
        std::lock_guard lock(Mutex);
        if (!Affects(player))
            return;
        for (Practice::AbilityDefinition const& ability : Dev::Abilities)
        {
            auto const learned = Learned(player, ability);
            if (learned.empty())
                continue;
            auto const loaded = Practice::ReadPlayerProgress(*player, ability.ClassId, ability.AbilityId,
                Dev::Policy, Dev::DefinitionVersion);
            auto const record = Practice::MigrateLearnedRanks(ability, Dev::Policy, loaded, learned);
            if (record)
                Practice::CachePlayerProgress(*player, ability.ClassId, ability.AbilityId, Dev::Policy, *record);
        }
        auto& session = Sessions[player->GetGUID().GetRawValue()];
        session = {};
        Refresh(player, session, Clock::now());
    }

    void OnPlayerUpdate(Player* player, uint32) override
    {
        if (!Active.load() || !IsDevelopmentPlayer(player))
            return;
        std::lock_guard lock(Mutex);
        auto const found = Sessions.find(player->GetGUID().GetRawValue());
        if (Affects(player) && found != Sessions.end())
            Refresh(player, found->second, Clock::now());
    }

    void OnPlayerLevelChanged(Player* player, uint8) override
    {
        MarkDirty(player);
    }

    void OnPlayerLearnSpell(Player* player, uint32 spellId) override
    {
        if (Dev::Find(spellId))
            MarkDirty(player);
    }

    void OnPlayerForgotSpell(Player* player, uint32 spellId) override
    {
        if (Dev::Find(spellId))
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
        if (!Affects(player))
            return true;
        if (receiver != player || (message != "HXAP\tHELLO|1" && message != "HXAP\tHELLO|2"))
            return false;
        auto const now = Clock::now();
        auto& session = Sessions[player->GetGUID().GetRawValue()];
        if (now - session.LastRequest < RefreshInterval)
            return false;
        session.LastRequest = now;
        session.Protocol = message == "HXAP\tHELLO|2" ? Practice::SessionMenuSchemaVersion : Practice::MenuSchemaVersion;
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
        if (!IsDevelopmentPlayer(player) || (target->IsPlayer() && damage) || !player->IsInCombat() ||
            target->GetLevel() + 10 < player->GetLevel())
            return;
        auto const* ability = Dev::Find(spell->GetSpellInfo()->Id);
        if (!ability)
            return;
        std::lock_guard lock(Mutex);
        if (!Affects(player))
            return;
        auto const found = Sessions.find(player->GetGUID().GetRawValue());
        if (found == Sessions.end())
            return;
        Practice::OutcomeContext const context{ true, true, true,
            (damage && player->IsHostileTo(target)) || (healing && player->IsFriendlyTo(target)), player->GetLevel() };
        auto const award = Practice::HandleOutcome(*player, *spell, *ability, Dev::Policy, Dev::DefinitionVersion, context);
        if (award.Status == Practice::OutcomeStatus::Awarded)
        {
            found->second.Progress.RecordAward(award.ProficiencyGained);
            found->second.Dirty = true;
            Refresh(player, found->second, Clock::now());
        }
    }
};
}

void AddSC_ability_practice()
{
    new PracticeWorld();
    new PracticePlayer();
    new PracticeSpell();
}
