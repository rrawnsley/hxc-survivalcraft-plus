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
std::unordered_map<std::uint64_t, std::chrono::steady_clock::time_point> Requests;

bool Affects(Player const* player)
{
    return Requested && DevelopmentAllowed && Ready && player && player->GetSession() &&
        !player->GetSession()->IsBot() && player->getClass() == Dev::ClassId;
}

std::vector<std::uint32_t> Learned(Player const* player, Practice::AbilityDefinition const& ability)
{
    std::vector<std::uint32_t> spells;
    for (Practice::AbilityRank const& rank : ability.Ranks)
        if (player->HasSpell(rank.SpellId))
            spells.push_back(rank.SpellId);
    return spells;
}

void Send(Player* player)
{
    if (!Affects(player) || Revision == std::numeric_limits<std::uint32_t>::max())
        return;
    std::vector<Practice::AbilityView> views;
    for (Practice::AbilityDefinition const& ability : Dev::Abilities)
    {
        auto const learned = Learned(player, ability);
        auto const loaded = Practice::ReadPlayerProgress(*player, ability.ClassId, ability.AbilityId,
            Dev::Policy, Dev::DefinitionVersion);
        auto const migrated = Practice::MigrateLearnedRanks(ability, Dev::Policy, loaded, learned);
        if (!migrated)
            return;
        views.push_back(Practice::BuildAbilityView(ability, Dev::Policy, migrated->State,
            player->GetLevel(), learned, true));
    }
    auto const messages = Practice::EncodeMenuSnapshot(Dev::ClassId, player->GetLevel(), ++Revision, views);
    if (!messages)
        return;
    for (std::string const& message : *messages)
    {
        WorldPacket packet;
        ChatHandler::BuildChatPacket(packet, CHAT_MSG_WHISPER, LANG_ADDON, player, nullptr, "HXAP\t" + message);
        player->SendDirectMessage(&packet);
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
        { PLAYERHOOK_ON_LOGIN, PLAYERHOOK_ON_LOGOUT, PLAYERHOOK_CAN_PLAYER_USE_PRIVATE_CHAT }) { }

    void OnPlayerLogin(Player* player) override
    {
        if (!Active.load())
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
        Send(player);
    }

    void OnPlayerLogout(Player* player) override
    {
        std::lock_guard lock(Mutex);
        if (player)
            Requests.erase(player->GetGUID().GetRawValue());
    }

    bool OnPlayerCanUseChat(Player* player, uint32, uint32 language, std::string& message, Player* receiver) override
    {
        if (!Active.load())
            return true;
        std::lock_guard lock(Mutex);
        if (!Affects(player) || language != LANG_ADDON || message.rfind("HXAP\t", 0) != 0)
            return true;
        if (receiver != player || message != "HXAP\tHELLO|1")
            return false;
        auto const now = std::chrono::steady_clock::now();
        auto const key = player->GetGUID().GetRawValue();
        auto const found = Requests.find(key);
        if (found != Requests.end() && now - found->second < std::chrono::seconds(2))
            return false;
        Requests[key] = now;
        Send(player);
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
        std::lock_guard lock(Mutex);
        if (!spell || !spell->GetCaster() || !target || miss != SPELL_MISS_NONE || (!damage && !healing))
            return;
        Player* player = spell->GetCaster()->ToPlayer();
        if (!Affects(player) || (target->IsPlayer() && damage) || !player->IsInCombat() ||
            target->GetLevel() + 10 < player->GetLevel())
            return;
        auto const* ability = Dev::Find(spell->GetSpellInfo()->Id);
        if (!ability)
            return;
        Practice::OutcomeContext const context{ true, true, true,
            (damage && player->IsHostileTo(target)) || (healing && player->IsFriendlyTo(target)), player->GetLevel() };
        auto const award = Practice::HandleOutcome(*player, *spell, *ability, Dev::Policy, Dev::DefinitionVersion, context);
        if (award.Status == Practice::OutcomeStatus::Awarded)
            Send(player);
    }
};
}

void AddSC_ability_practice()
{
    new PracticeWorld();
    new PracticePlayer();
    new PracticeSpell();
}
