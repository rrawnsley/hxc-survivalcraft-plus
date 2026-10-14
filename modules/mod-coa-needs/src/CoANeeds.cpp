// SPDX-License-Identifier: GPL-2.0-or-later

#include "Chat.h"
#include "RealmDayCycle.h"
#include "Config.h"
#include "Creature.h"
#include "DatabaseEnv.h"
#include "DBCStores.h"
#include "GameObject.h"
#include "Item.h"
#include "Log.h"
#include "Map.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "NeedsChallengeBridge.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellAuras.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "Weather.h"
#include "World.h"

#include <algorithm>
#include <array>
#include <chrono>
#include <cmath>
#include <ctime>
#include <mutex>
#include <sstream>
#include <unordered_map>
#include <unordered_set>

namespace
{
constexpr char Storage[] = "core.coa.needs";
constexpr uint32 Starving = 996009;
constexpr uint32 Dehydrated = 996010;
constexpr uint32 Exhausted = 996011;
constexpr uint32 SprintAura = 996012;
constexpr uint32 DodgeAura = 996013;
constexpr uint32 WindAura = 996014;
constexpr uint32 SprintAbility = 996015;
constexpr uint32 DodgeAbility = 996016;
constexpr uint32 WindAbility = 996017;
constexpr uint32 CampRest = 996100;
constexpr uint32 CampExperienceAura = 996163;
constexpr uint32 OldSchoolRestedCapMs = 20 * 60 * 1000;
constexpr uint32 OldSchoolRestedStandingRate = 5;
constexpr uint32 OldSchoolRestedSittingRate = 10;
constexpr std::array<uint32, 3> OldSchoolCampLogs = { 8210210, 8210211, 8210212 };
constexpr uint32 Fellowship = 996103;
constexpr uint32 CampAbility = 996106;
constexpr uint32 PackAbility = 996109;
constexpr uint32 WeatherAura = 996110;
constexpr uint32 InjuryAura = 996115;
constexpr uint32 SplintAbility = 996119;
constexpr uint32 SplintRecipe = 996178;
constexpr uint32 ToolRecipe = 996120;
constexpr uint32 ProfessionAura = 996140;
constexpr uint32 SurvivalistSkill = 9200;
constexpr uint32 ScissorsRecipe = 996136;
constexpr uint32 ScissorsUse = 996137;
constexpr uint32 CampKitRecipe = 996170;
constexpr uint32 SurvivalistProfession = 996180;
constexpr uint32 CampKit = 996211;
constexpr uint32 TorchItem = 996214;
constexpr uint32 SplintItem = 996215;
constexpr uint32 TorchAura = 996181;
constexpr uint32 SurveyAbility = 996183;
constexpr uint32 SurveyAura = 996184;
constexpr uint32 SeatedRecoveryAura = 996185;
constexpr uint32 ResourceTrackingMask = (1u << 1) | (1u << 2) | (1u << 18) | (1u << 23);
std::unordered_set<uint32> BandageSpells;
std::unordered_set<uint32> PotionSpells;

uint32 RecipeSkill(uint32 spell)
{
    if (spell >= CampAbility && spell < PackAbility)
        return std::array<uint32, 3>{ 1, 75, 150 }[spell - CampAbility];
    if (spell >= ToolRecipe && spell < ToolRecipe + 8)
        return std::array<uint32, 8>{ 1, 1, 1, 1, 100, 150, 50, 1 }[spell - ToolRecipe];
    if (spell >= CampKitRecipe && spell < CampKitRecipe + 6)
        return std::array<uint32, 3>{ 1, 75, 150 }[(spell - CampKitRecipe) % 3];
    if (spell == 996176 || spell == 996177)
        return 1;
    if (spell == SplintRecipe)
        return 1;
    return spell == ScissorsRecipe ? 75 : 0;
}

struct Options
{
    bool enabled = false;
    bool bots = false;
    float foodDrain = 4.0f;
    float waterDrain = 5.4f;
    float meal = 45.0f;
    float drink = 55.0f;
    float regen = 8.0f;
    float sprintDrain = 10.0f;
    uint32 campLifetime = 3600;
    uint32 campRestFillSeconds = 300;
    bool weather = true;
    bool injuries = true;
    bool tools = true;
    bool professions = true;
    bool darkness = true;
    float rainyNightColdMultiplier = 1.5f;
    uint32 wetExposure = 300000;
    uint32 coldExposure = 420000;
    uint32 heatExposure = 180000;
};

struct Treatment
{
    uint32 item = 0;
    uint32 count = 0;
    uint32 spell = 0;
    uint64 started = 0;
    ObjectGuid target;
    bool bandage = false;
};

struct PendingMeal
{
    uint32 item = 0;
    uint32 count = 0;
    uint32 spell = 0;
    uint32 level = 0;
    uint32 elapsed = 0;
    bool food = false;
    bool water = false;
};

struct State
{
    float food = 100.0f;
    float water = 100.0f;
    float vigor = 100.0f;
    float displayFood = 100.0f;
    float displayWater = 100.0f;
    float cap = 100.0f;
    uint32 dodgeUntil = 0;
    uint32 windUntil = 0;
    uint32 exhaustedUntil = 0;
    uint32 attackLockUntil = 0;
    uint32 windBuffUntil = 0;
    uint32 tick = 0;
    uint32 unlockRetry = 0;
    uint32 dehydrationTick = 0;
    uint32 saveTick = 0;
    uint64 lastSpend = 0;
    uint64 lastAttack = 0;
    uint64 lastCombat = 0;
    bool sprint = false;
    bool sprintSyncPending = false;
    bool delegated = false;
    uint32 campReady = 0;
    uint32 socialTick = 0;
    uint32 oldSchoolRestedMs = 0;
    int32 restingCamp = -1;
    PendingMeal meal;
    Treatment treatment;
    std::array<uint32, 3> exposure = {};
    std::array<bool, 5> weather = {};
    uint32 coldTick = 0;
    uint32 stormTick = 0;
    uint32 injuries = 0;
    char condition = 'S';
    bool torchLit = false;
    uint32 lightMap = 0;
    uint32 lightZone = 0;
    uint32 lightId = 0;
    bool lightSent = false;
    bool surveying = false;
    float seatedHealth = 0.0f;
    float seatedMana = 0.0f;
};

struct Camp
{
    uint32 map = 0;
    uint32 expires = 0;
    uint32 tier = 0;
    ObjectGuid fire;
    ObjectGuid tent;
};

Options Config;
bool SpellsReady = false;
std::recursive_mutex Mutex;
std::unordered_map<ObjectGuid::LowType, State> States;
std::unordered_map<ObjectGuid::LowType, Camp> Camps;
std::unordered_map<uint32, WeatherState> ZoneWeather;

uint32 ReadOldSchoolRestedSeconds(uint32 guid)
{
    std::lock_guard<std::recursive_mutex> lock(Mutex);
    auto const found = States.find(guid);
    return found == States.end() ? 0 : found->second.oldSchoolRestedMs / 1000;
}

uint64 Milliseconds()
{
    return std::chrono::duration_cast<std::chrono::milliseconds>(
        std::chrono::steady_clock::now().time_since_epoch()).count();
}

bool Affects(Player const* player)
{
    return player && Config.enabled && SpellsReady && player->GetSession() &&
        (Config.bots || !player->GetSession()->IsBot());
}

float Clamp(float value)
{
    return std::clamp(value, 0.0f, 100.0f);
}

void SetAura(Player* player, uint32 spell, bool active)
{
    if (!active)
        player->RemoveAurasDueToSpell(spell);
    else if (!player->HasAura(spell))
        player->AddAura(spell, player);
}

bool IsNight()
{
    return AscensionRealmClock::IsDark();
}

uint32 NightLight(uint32 mapId, bool torch)
{
    uint32 index = 0;
    switch (mapId)
    {
        case 0: index = 0; break;
        case 1: index = 1; break;
        case 530: index = 2; break;
        case 571: index = 3; break;
        default: return 0;
    }
    return 101001 + index + (torch ? 4 : 0);
}

void RefreshNightLight(Player* player, State& state, int32 campTier = -1)
{
    Map* map = player->FindMap();
    bool outdoors = Config.darkness && map && !map->Instanceable() && player->IsOutdoors() &&
        !player->InBattleground() && !player->InArena();
    Item* equippedTorch = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
    if (state.torchLit && (!player->IsAlive() || !equippedTorch || equippedTorch->GetEntry() != TorchItem))
        state.torchLit = false;
    SetAura(player, TorchAura, state.torchLit);
    uint32 mapId = map ? map->GetId() : 0;
    uint32 lightId = outdoors && IsNight() ? NightLight(mapId, state.torchLit || campTier >= 0) : 0;
    uint32 zoneId = player->GetZoneId();
    if (state.lightSent && state.lightMap == mapId && state.lightZone == zoneId && state.lightId == lightId)
        return;
    if (!lightId && !state.lightId)
    {
        state.lightMap = mapId;
        state.lightZone = zoneId;
        state.lightSent = true;
        return;
    }
    if (map)
    {
        WorldPacket packet(SMSG_OVERRIDE_LIGHT, 12);
        packet << uint32(GetDefaultMapLight(mapId));
        packet << uint32(lightId);
        packet << uint32(state.lightSent && state.lightId != lightId && (!state.lightId || !lightId) ? 300000 :
            state.lightSent ? 3000 : 1000);
        player->SendDirectMessage(&packet);
        state.lightMap = mapId;
        state.lightZone = zoneId;
        state.lightId = lightId;
        state.lightSent = true;
    }
}

float SkillScale(Player const* player, uint32 skill)
{
    uint32 tier = std::min(6u, player->GetPureSkillValue(skill) / 75u);
    return tier / 6.0f;
}

void RefreshProfessions(Player* player)
{
    static std::array<uint32, 13> const skills = { SKILL_MINING, SKILL_BLACKSMITHING, SKILL_SKINNING,
        SKILL_INSCRIPTION, SKILL_TAILORING, SKILL_JEWELCRAFTING, SKILL_ENCHANTING, SKILL_LEATHERWORKING,
        SKILL_HERBALISM, SKILL_ALCHEMY, SKILL_FIRST_AID, SKILL_FISHING, SKILL_ENGINEERING };
    static std::array<float, 13> const bonuses = { 4, 3, 2, 2, 20, 2, 10, 5, 5, 15, 20, 50, 1 };
    for (uint32 index = 0; index < skills.size(); ++index)
    {
        float scale = SkillScale(player, skills[index]);
        int32 amount = scale > 0.0f ? std::max(1, int32(std::lround(bonuses[index] * scale))) : 0;
        bool active = Config.professions && Affects(player) && player->IsAlive() && player->GetLevel() > 1 && amount != 0;
        uint32 spell = ProfessionAura + index;
        SetAura(player, spell, active);
        if (!active)
            continue;
        for (uint8 effect = 0; effect < MAX_SPELL_EFFECTS; ++effect)
            if (AuraEffect* aura = player->GetAuraEffect(spell, effect))
                if (aura->GetAmount() != amount)
                    aura->ChangeAmount(amount);
    }
}

void StopSprint(Player* player, State& state)
{
    state.sprint = false;
    state.sprintSyncPending = false;
    player->RemoveAurasDueToSpell(SprintAura);
}

void RefreshSprint(Player* player, bool active)
{
    if (!active)
    {
        player->RemoveAurasDueToSpell(SprintAura);
        return;
    }
    Aura* aura = player->GetAura(SprintAura);
    if (!aura)
        aura = player->AddAura(SprintAura, player);
    if (!aura)
        return;
    aura->SetMaxDuration(-1);
    aura->SetDuration(-1);
    if (AuraEffect* effect = aura->GetEffect(EFFECT_0))
        if (effect->GetAmount() != 30)
            effect->ChangeAmount(30);
}

void RefreshResourceTracking(Player* player, State const& state)
{
    bool const active = state.surveying && player->IsAlive();
    SetAura(player, SurveyAura, active);
    if (active)
    {
        player->SetFlag(PLAYER_TRACK_RESOURCES, ResourceTrackingMask);
        return;
    }
    uint32 nativeTracking = 0;
    for (AuraEffect const* effect : player->GetAuraEffectsByType(SPELL_AURA_TRACK_RESOURCES))
        if (effect->GetMiscValue() > 0 && effect->GetMiscValue() <= 32)
            nativeTracking |= 1u << (effect->GetMiscValue() - 1);
    player->RemoveFlag(PLAYER_TRACK_RESOURCES, ResourceTrackingMask & ~nativeTracking);
}

float SeatedConsumableRecovery(Player const* player, AuraType type)
{
    float recovery = 0.0f;
    for (AuraEffect const* effect : player->GetAuraEffectsByType(type))
        if ((effect->GetSpellInfo()->AuraInterruptFlags & AURA_INTERRUPT_FLAG_NOT_SEATED) &&
            (type != SPELL_AURA_MOD_POWER_REGEN || effect->GetMiscValue() == POWER_MANA))
            recovery += std::max(0, effect->GetAmount()) / 5.0f;
    return recovery;
}

void RecoverWhileSeated(Player* player, State& state, uint32 elapsed)
{
    bool const resting = CoANeeds::IsOldSchoolTrial &&
        CoANeeds::IsOldSchoolTrial(player->GetGUID().GetCounter()) && player->IsAlive() &&
        player->IsSitState() && !player->isMoving() && !player->IsInCombat();
    SetAura(player, SeatedRecoveryAura, resting);
    if (!resting)
    {
        state.seatedHealth = 0.0f;
        state.seatedMana = 0.0f;
        return;
    }
    float const seconds = elapsed / 1000.0f;
    float const campRecovery = state.restingCamp >= 0 ? 0.005f + 0.0025f * state.restingCamp : 0.0f;
    float const recovery = 0.0025f + campRecovery;
    float const manaRecovery = 0.25f + 0.75f *
        std::min(state.displayFood, state.displayWater) / 100.0f;
    if (player->GetHealth() < player->GetMaxHealth() &&
        !player->HasAuraTypeWithMiscvalue(SPELL_AURA_PREVENT_REGENERATE_POWER, POWER_HEALTH))
    {
        state.seatedHealth += (player->GetMaxHealth() * recovery +
            SeatedConsumableRecovery(player, SPELL_AURA_MOD_REGEN)) * seconds;
        int32 const amount = int32(state.seatedHealth);
        state.seatedHealth -= amount;
        player->ModifyHealth(amount);
    }
    else
        state.seatedHealth = 0.0f;
    if (player->GetPower(POWER_MANA) < player->GetMaxPower(POWER_MANA) &&
        !player->HasAuraTypeWithMiscvalue(SPELL_AURA_PREVENT_REGENERATE_POWER, POWER_MANA + 1))
    {
        state.seatedMana += (player->GetMaxPower(POWER_MANA) * recovery +
            SeatedConsumableRecovery(player, SPELL_AURA_MOD_POWER_REGEN)) * manaRecovery * seconds;
        int32 const amount = int32(state.seatedMana);
        state.seatedMana -= amount;
        player->ModifyPower(POWER_MANA, amount);
    }
    else
        state.seatedMana = 0.0f;
}

void Save(Player* player, State const& state)
{
    std::array<uint32, 12> values = { 1, uint32(Clamp(state.food) * 1000.0f),
        uint32(Clamp(state.water) * 1000.0f), uint32(Clamp(state.vigor) * 1000.0f),
        state.dodgeUntil, state.windUntil, state.exhaustedUntil, state.attackLockUntil, state.windBuffUntil,
        state.campReady, state.injuries, state.oldSchoolRestedMs };
    for (uint32 index = 0; index < values.size(); ++index)
        player->UpdatePlayerSetting(Storage, index, values[index]);
}

void Send(Player* player, State const& state)
{
    if (player->GetSession()->IsBot())
        return;
    uint32 now = uint32(std::time(nullptr));
    auto remaining = [now](uint32 until) { return until > now ? until - now : 0; };
    std::ostringstream wire;
    wire << "HXN\tSTATE~" << uint32(state.displayFood) << '~' << uint32(state.displayWater)
         << '~' << uint32(state.vigor) << '~' << uint32(state.cap) << '~' << state.sprint
         << '~' << remaining(state.dodgeUntil) << '~' << remaining(state.windUntil)
         << '~' << remaining(state.exhaustedUntil) << '~' << state.delegated << '~' << state.restingCamp
         << '~' << remaining(state.campReady) << '~' << state.condition;
    std::array<uint32, 3> thresholds = { Config.wetExposure, Config.coldExposure, Config.heatExposure };
    for (uint32 index = 0; index < 3; ++index)
        wire << '~' << (thresholds[index] > state.exposure[index] ?
            (thresholds[index] - state.exposure[index] + 999) / 1000 : 0);
    uint32 flags = 0;
    for (uint32 index = 0; index < 5; ++index)
        if (state.weather[index])
            flags |= 1u << index;
    wire << '~' << flags << '~' << state.injuries;
    WorldPacket packet;
    ChatHandler::BuildChatPacket(packet, CHAT_MSG_WHISPER, LANG_ADDON, player, nullptr, wire.str());
    player->SendDirectMessage(&packet);
}

void Unlock(Player* player)
{
    if (!Affects(player))
        return;
    if (!player->HasSkill(SurvivalistSkill))
        player->SetSkill(SurvivalistSkill, 1, 1, 300);
    player->learnSpell(SurvivalistProfession);
    player->learnSpell(SprintAbility);
    player->learnSpell(SurveyAbility);
    if (player->HasSpell(SplintAbility))
        player->removeSpell(SplintAbility, SPEC_MASK_ALL, false);
    if (Config.tools)
    {
        for (uint32 index = 0; index < 8; ++index)
            if (player->GetPureSkillValue(SurvivalistSkill) >= RecipeSkill(ToolRecipe + index))
                player->learnSpell(ToolRecipe + index);
        if (player->GetPureSkillValue(SurvivalistSkill) >= RecipeSkill(ScissorsRecipe))
            player->learnSpell(ScissorsRecipe);
        for (uint32 index = 0; index < 6; ++index)
            if (player->GetPureSkillValue(SurvivalistSkill) >= RecipeSkill(CampKitRecipe + index))
                player->learnSpell(CampKitRecipe + index);
        player->learnSpell(996176);
        player->learnSpell(996177);
        player->learnSpell(SplintRecipe);
    }
    if (player->GetLevel() >= 30)
        player->learnSpell(DodgeAbility);
    if (player->GetLevel() >= 60)
        player->learnSpell(WindAbility);
    for (uint32 tier = 0; tier < 3; ++tier)
        if (player->GetPureSkillValue(SurvivalistSkill) >= RecipeSkill(CampAbility + tier))
            player->learnSpell(CampAbility + tier);
    player->learnSpell(PackAbility);
}

void PackCamp(Player* player)
{
    auto found = Camps.find(player->GetGUID().GetCounter());
    if (found == Camps.end())
        return;
    if (Map* map = player->FindMap(); map && map->GetId() == found->second.map)
    {
        if (GameObject* fire = map->GetGameObject(found->second.fire))
            fire->Delete();
        if (GameObject* tent = map->GetGameObject(found->second.tent))
            tent->Delete();
    }
    Camps.erase(found);
}

bool Precipitation(Player* player)
{
    Map* map = player->FindMap();
    if (!Config.weather || !map || !player->IsOutdoors())
        return false;
    map->GetOrGenerateZoneDefaultWeather(player->GetZoneId());
    auto current = ZoneWeather.find(player->GetZoneId());
    if (current == ZoneWeather.end())
        return false;
    switch (current->second)
    {
        case WEATHER_STATE_LIGHT_RAIN:
        case WEATHER_STATE_MEDIUM_RAIN:
        case WEATHER_STATE_HEAVY_RAIN:
        case WEATHER_STATE_THUNDERS:
        case WEATHER_STATE_BLACKRAIN:
        case WEATHER_STATE_LIGHT_SNOW:
        case WEATHER_STATE_MEDIUM_SNOW:
        case WEATHER_STATE_HEAVY_SNOW:
        case WEATHER_STATE_BLACKSNOW:
            return true;
        default:
            return false;
    }
}

int32 NearbyCamp(Player* player)
{
    Map* map = player->FindMap();
    if (!map)
        return -1;
    uint32 now = uint32(std::time(nullptr));
    int32 tier = -1;
    bool const precipitation = Precipitation(player);
    for (auto camp = Camps.begin(); camp != Camps.end();)
    {
        if (camp->second.expires <= now)
        {
            camp = Camps.erase(camp);
            continue;
        }
        if (camp->second.map == map->GetId())
        {
            GameObject* fire = map->GetGameObject(camp->second.fire);
            if (!fire)
            {
                camp = Camps.erase(camp);
                continue;
            }
            if ((!precipitation || camp->second.tier > 0) && player->InSamePhase(fire)
                && player->IsWithinDistInMap(fire, 15.0f + 5.0f * camp->second.tier))
                tier = std::max(tier, int32(camp->second.tier));
        }
        ++camp;
    }
    return tier;
}

void PlaceCamp(Player* player, State& state, uint32 tier)
{
    Map* map = player->FindMap();
    uint32 now = uint32(std::time(nullptr));
    if (!map || map->Instanceable() || !player->IsAlive() || player->IsInCombat() || player->isMoving() ||
        player->IsMounted() || player->IsInFlight() || player->IsInWater() || player->IsFalling() ||
        player->HasUnitState(UNIT_STATE_CONTROLLED))
    {
        ChatHandler(player->GetSession()).SendSysMessage("Place camps on dry land outside combat and instances.");
        return;
    }
    if (tier > 2 || player->GetPureSkillValue(SurvivalistSkill) < RecipeSkill(CampAbility + tier))
        return;
    bool const oldSchool = CoANeeds::IsOldSchoolTrial &&
        CoANeeds::IsOldSchoolTrial(player->GetGUID().GetCounter());
    uint32 const wood = oldSchool ? OldSchoolCampLogs[tier] : 4470;
    auto current = Camps.find(player->GetGUID().GetCounter());
    if (tier == 1 && current != Camps.end() && current->second.tier == 0
        && current->second.map == map->GetId() && current->second.expires > now)
    {
        GameObject* existingFire = map->GetGameObject(current->second.fire);
        if (existingFire && player->InSamePhase(existingFire)
            && player->IsWithinDistInMap(existingFire, 15.0f))
        {
            if (!player->HasItemCount(CampKit + tier, 1, false))
            {
                ChatHandler(player->GetSession()).SendSysMessage("Craft a Shelter Kit with Survivalist to cover this fire.");
                return;
            }
            float const orientation = existingFire->GetOrientation();
            GameObject* tent = player->SummonGameObject(184592, existingFire->GetPositionX(),
                existingFire->GetPositionY(), existingFire->GetPositionZ(), orientation,
                0, 0, std::sin(orientation / 2), std::cos(orientation / 2), Config.campLifetime);
            if (!tent)
                return;
            existingFire->SetRespawnTime(Config.campLifetime);
            current->second.tent = tent->GetGUID();
            current->second.tier = tier;
            current->second.expires = now + Config.campLifetime;
            player->DestroyItemCount(CampKit + tier, 1, true);
            ChatHandler(player->GetSession()).SendSysMessage("Shelter raised over your fire. It now protects camp recovery from rain and snow.");
            return;
        }
    }
    if (oldSchool && current != Camps.end() && current->second.tier == tier && current->second.map == map->GetId()
        && current->second.expires > now)
    {
        GameObject* existingFire = map->GetGameObject(current->second.fire);
        if (existingFire && player->InSamePhase(existingFire)
            && player->IsWithinDistInMap(existingFire, 15.0f + 5.0f * tier))
        {
            if (!player->HasItemCount(wood, 1, false))
            {
                ChatHandler(player->GetSession()).SendSysMessage("Rekindling your camp requires one harvested log of its wood tier.");
                return;
            }
            existingFire->SetRespawnTime(Config.campLifetime);
            if (current->second.tent)
                if (GameObject* existingTent = map->GetGameObject(current->second.tent))
                    existingTent->SetRespawnTime(Config.campLifetime);
            current->second.expires = now + Config.campLifetime;
            player->DestroyItemCount(wood, 1, true);
            ChatHandler(player->GetSession()).SendSysMessage("Camp rekindled with one harvested log.");
            return;
        }
    }
    if (state.campReady > now)
        return;
    if (!player->HasItemCount(CampKit + tier, 1, false))
    {
        ChatHandler(player->GetSession()).SendSysMessage("Craft a matching camp kit with Survivalist before placing your camp.");
        return;
    }
    float orientation = player->GetOrientation();
    GameObject* fire = player->SummonGameObject(tier == 2 ? 1831 : 1798,
        player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), orientation,
        0, 0, std::sin(orientation / 2), std::cos(orientation / 2), Config.campLifetime);
    if (!fire)
        return;
    GameObject* tent = nullptr;
    if (tier)
    {
        float x, y, z;
        player->GetNearPoint(nullptr, x, y, z, 0.0f, tier == 1 ? 1.5f : 2.0f, orientation + 1.5707963f);
        tent = player->SummonGameObject(tier == 1 ? 184592 : 184593, x, y, z, orientation,
            0, 0, std::sin(orientation / 2), std::cos(orientation / 2), Config.campLifetime);
        if (!tent)
        {
            fire->Delete();
            return;
        }
    }
    PackCamp(player);
    player->DestroyItemCount(CampKit + tier, 1, true);
    Camp camp;
    camp.map = map->GetId();
    camp.expires = now + Config.campLifetime;
    camp.tier = tier;
    camp.fire = fire->GetGUID();
    if (tent)
        camp.tent = tent->GetGUID();
    Camps[player->GetGUID().GetCounter()] = camp;
    state.campReady = now + 60;
    Unlock(player);
    Save(player, state);
    ChatHandler(player->GetSession()).SendSysMessage("Camp placed. Stay nearby to recover and renew your 20-minute camp XP buff; sit for faster recovery.");
}

void RestAtCamp(Player* player, State& state, int32 tier, uint32 elapsed)
{
    bool const oldSchool = CoANeeds::IsOldSchoolTrial &&
        CoANeeds::IsOldSchoolTrial(player->GetGUID().GetCounter());
    state.restingCamp = player->IsAlive() && !player->IsInCombat() ? tier : -1;
    for (uint32 index = 0; index < 3; ++index)
        SetAura(player, CampRest + index, state.restingCamp == int32(index));
    if (state.restingCamp >= 0 && !oldSchool)
    {
        float const tierRecovery = 0.005f + 0.0025f * state.restingCamp;
        float const recovery = tierRecovery * (player->IsSitState() ? 2.0f : 1.0f)
            * elapsed / 1000.0f;
        player->ModifyHealth(int32(std::max(1.0f, player->GetMaxHealth() * recovery)));
        if (player->GetMaxPower(POWER_MANA))
            player->ModifyPower(POWER_MANA,
                int32(std::max(1.0f, player->GetMaxPower(POWER_MANA) * recovery)));
    }
    if (oldSchool)
    {
        uint32 const previous = state.oldSchoolRestedMs;
        bool const inn = player->HasRestFlag(REST_FLAG_IN_TAVERN);
        bool exposed = false;
        Map* map = player->FindMap();
        if (Config.weather && map && player->IsOutdoors() && tier < 1 && !inn)
        {
            map->GetOrGenerateZoneDefaultWeather(player->GetZoneId());
            auto currentWeather = ZoneWeather.find(player->GetZoneId());
            WeatherState const sky = currentWeather != ZoneWeather.end() ? currentWeather->second : WEATHER_STATE_FINE;
            exposed = sky == WEATHER_STATE_LIGHT_RAIN || sky == WEATHER_STATE_MEDIUM_RAIN
                || sky == WEATHER_STATE_HEAVY_RAIN || sky == WEATHER_STATE_THUNDERS || sky == WEATHER_STATE_BLACKRAIN
                || sky == WEATHER_STATE_LIGHT_SNOW || sky == WEATHER_STATE_MEDIUM_SNOW
                || sky == WEATHER_STATE_HEAVY_SNOW || sky == WEATHER_STATE_BLACKSNOW;
        }
        if (player->IsAlive() && (state.restingCamp >= 0 || inn) && !exposed)
        {
            uint32 const tierRate = state.restingCamp > 0 ? 2u * uint32(state.restingCamp) : 0u;
            uint32 const fillRate = (player->IsSitState() ? OldSchoolRestedSittingRate : OldSchoolRestedStandingRate)
                + tierRate * (player->IsSitState() ? 2u : 1u);
            state.oldSchoolRestedMs = std::min(OldSchoolRestedCapMs,
                state.oldSchoolRestedMs + elapsed * fillRate);
        }
        else if (player->IsAlive())
            state.oldSchoolRestedMs = elapsed >= state.oldSchoolRestedMs ? 0 : state.oldSchoolRestedMs - elapsed;

        player->SetRestBonus(0);
        if (state.oldSchoolRestedMs)
        {
            if (Aura* aura = player->GetAura(CampExperienceAura))
                aura->SetDuration(state.oldSchoolRestedMs);
            else if (Aura* aura = player->AddAura(CampExperienceAura, player))
            {
                aura->SetMaxDuration(OldSchoolRestedCapMs);
                aura->SetDuration(state.oldSchoolRestedMs);
            }
        }
        else
            player->RemoveAurasDueToSpell(CampExperienceAura);

        if (previous < OldSchoolRestedCapMs && state.oldSchoolRestedMs == OldSchoolRestedCapMs)
            ChatHandler(player->GetSession()).SendSysMessage("Camp Rested is full: 20 minutes of 15% bonus kill experience.");
        else if (previous && !state.oldSchoolRestedMs)
            ChatHandler(player->GetSession()).SendSysMessage("Camp Rested expired. Return to a camp to renew it.");
    }
    else
        player->RemoveAurasDueToSpell(CampExperienceAura);

    if (state.restingCamp < 0)
    {
        state.socialTick = 0;
        return;
    }

    if (!oldSchool)
    {
        float seconds = elapsed / 1000.0f;
        float restedCap = player->GetUInt32Value(PLAYER_NEXT_LEVEL_XP) * sWorld->getRate(RATE_REST_MAX_BONUS) / 2.0f;
        float rested = restedCap * seconds / Config.campRestFillSeconds;
        player->SetRestBonus(player->GetRestBonus() + rested);
    }
    if (!player->IsSitState())
    {
        state.socialTick = 0;
        return;
    }
    state.socialTick += elapsed;
    if (state.socialTick < 30000)
        return;
    state.socialTick = 0;
    for (uint32 index = uint32(tier); index < 3; ++index)
        if (player->HasAura(Fellowship + index))
            return;
    for (uint32 index = 0; index < 3; ++index)
        player->RemoveAurasDueToSpell(Fellowship + index);
    if (Aura* aura = player->AddAura(Fellowship + uint32(tier), player))
    {
        aura->SetMaxDuration(3600000);
        aura->SetDuration(3600000);
    }
    ChatHandler(player->GetSession()).SendSysMessage("Campfire Fellowship: a lasting bonus to all primary attributes.");
}

void UpdateNeeds(Player* player, State& state)
{
    state.displayFood = state.food;
    state.displayWater = state.water;
    state.delegated = CoANeeds::ReadChallengeNeeds &&
        CoANeeds::ReadChallengeNeeds(player->GetGUID().GetCounter(), state.displayFood, state.displayWater);
    state.cap = 100.0f * (0.5f + state.displayFood / 200.0f) * (0.5f + state.displayWater / 200.0f);
    state.vigor = std::min(state.vigor, state.cap);
}

void Exhaust(Player* player, State& state)
{
    StopSprint(player, state);
    uint32 now = uint32(std::time(nullptr));
    state.exhaustedUntil = now + 15;
    state.attackLockUntil = now + 5;
}

void RefreshInjuries(Player* player, State const& state)
{
    bool active = Config.injuries && player->IsAlive() && !player->InBattleground() && !player->InArena();
    for (uint32 index = 0; index < 4; ++index)
        SetAura(player, InjuryAura + index, active && (state.injuries & (1u << index)));
}

void ChangeInjury(Player* player, State& state, uint32 index, bool active)
{
    uint32 mask = 1u << index;
    if (bool(state.injuries & mask) == active)
        return;
    if (active)
        state.injuries |= mask;
    else
        state.injuries &= ~mask;
    Save(player, state);
    static std::array<char const*, 4> const notices = {
        "Lingering Wound: complete a bandage to treat it.",
        "Lingering Venom: consume a healing potion or use a poison cure.",
        "Broken Leg: use Field Splint outside combat. Requires 4 Simple Wood and 2 Linen Cloth.",
        "Broken Arm: use Field Splint outside combat. Requires 4 Simple Wood and 2 Linen Cloth."
    };
    ChatHandler(player->GetSession()).SendSysMessage(active ? notices[index] : "Your injury has been treated.");
}

void TickWeather(Player* player, State& state, int32 campTier, uint32 elapsed)
{
    Map* map = player->FindMap();
    bool sheltered = !Config.weather || !map || !player->IsAlive() || !player->IsOutdoors() ||
        map->Instanceable() || player->InBattleground() || player->InArena() || campTier >= 0 ||
        player->HasPlayerFlag(PLAYER_FLAGS_RESTING);
    if (sheltered)
    {
        state.exposure = {};
        state.weather = {};
        state.coldTick = 0;
        state.stormTick = 0;
        state.condition = 'S';
    }
    else
    {
        map->GetOrGenerateZoneDefaultWeather(player->GetZoneId());
        auto current = ZoneWeather.find(player->GetZoneId());
        WeatherState sky = current != ZoneWeather.end() ? current->second : WEATHER_STATE_FINE;
        bool storm = sky == WEATHER_STATE_THUNDERS || sky == WEATHER_STATE_BLACKRAIN;
        bool rain = storm || sky == WEATHER_STATE_LIGHT_RAIN || sky == WEATHER_STATE_MEDIUM_RAIN ||
            sky == WEATHER_STATE_HEAVY_RAIN;
        bool snow = sky == WEATHER_STATE_LIGHT_SNOW || sky == WEATHER_STATE_MEDIUM_SNOW ||
            sky == WEATHER_STATE_HEAVY_SNOW || sky == WEATHER_STATE_BLACKSNOW;
        static std::array<uint32, 13> const hotZones = {
            14, 17, 25, 440, 405, 400, 490, 51, 46, 1377, 3483, 3520, 3535
        };
        static std::array<uint32, 9> const coldZones = { 1, 618, 2817, 65, 394, 495, 210, 67, 66 };
        bool hot = std::find(hotZones.begin(), hotZones.end(), player->GetZoneId()) != hotZones.end();
        bool cold = snow || (IsNight() && rain) ||
            (player->GetMapId() == 571 && player->GetZoneId() != 3711) ||
            std::find(coldZones.begin(), coldZones.end(), player->GetZoneId()) != coldZones.end();
        std::array<bool, 3> exposed = { rain || snow, cold, hot && !rain && !snow };
        std::array<uint32, 3> limits = { Config.wetExposure, Config.coldExposure, Config.heatExposure };
        for (uint32 index = 0; index < 3; ++index)
        {
            uint32 gain = index == 1 && IsNight() ?
                uint32(std::lround(elapsed * Config.rainyNightColdMultiplier)) : elapsed;
            uint64 amount = exposed[index] ? uint64(state.exposure[index]) + gain :
                (uint64(elapsed) * 2 >= state.exposure[index] ? 0 : state.exposure[index] - uint64(elapsed) * 2);
            state.exposure[index] = uint32(std::min<uint64>(amount, limits[index]));
            state.weather[index] = state.exposure[index] >= limits[index];
        }
        state.weather[3] = storm;
        state.weather[4] = sky == WEATHER_STATE_FINE && !cold && !hot &&
            !state.weather[0] && !state.weather[1] && !state.weather[2];
        state.condition = storm ? 'T' : snow ? 'N' : rain ? 'R' : hot ? 'H' : cold ? 'C' : 'F';
        if (state.weather[0] && state.weather[1])
        {
            state.coldTick += elapsed;
            if (state.coldTick >= 60000)
            {
                state.coldTick %= 60000;
                player->EnvironmentalDamage(DAMAGE_EXHAUSTED, std::max(1u, player->GetMaxHealth() / 100));
            }
        }
        else
            state.coldTick = 0;
        if (storm)
        {
            state.stormTick += elapsed;
            if (state.stormTick >= 60000)
            {
                state.stormTick %= 60000;
                state.vigor = std::max(0.0f, state.vigor - 5.0f);
                state.lastSpend = Milliseconds();
            }
        }
        else
            state.stormTick = 0;
    }
    for (uint32 index = 0; index < 5; ++index)
        SetAura(player, WeatherAura + index, state.weather[index]);
}

void TickTreatment(Player* player, State& state)
{
    Treatment& use = state.treatment;
    if (!use.item)
        return;
    bool consumed = player->GetItemCount(use.item, false) < use.count;
    if (Milliseconds() - use.started >= 30000)
        use = {};
    else if (!use.bandage && consumed)
    {
        Player* target = ObjectAccessor::FindPlayer(use.target);
        if (Affects(target) && target->GetMapId() == player->GetMapId())
        {
            auto found = States.find(target->GetGUID().GetCounter());
            if (found != States.end())
            {
                ChangeInjury(target, found->second, 1, false);
                RefreshInjuries(target, found->second);
                target->RemoveAppliedAuras([](AuraApplication const* application)
                {
                    return application->GetBase()->GetSpellInfo()->Dispel == DISPEL_POISON;
                });
            }
        }
        use = {};
    }
}

class NeedsWeather : public ALEScript
{
public:
    NeedsWeather() : ALEScript("CoANeedsWeather") { }

    void OnWeatherChange(Weather* weather, WeatherState state, float) override
    {
        if (!weather)
            return;
        std::lock_guard<std::recursive_mutex> lock(Mutex);
        ZoneWeather[weather->GetZone()] = state;
    }
};

class NeedsWorld : public WorldScript
{
public:
    NeedsWorld() : WorldScript("CoANeedsWorld", { WORLDHOOK_ON_AFTER_CONFIG_LOAD, WORLDHOOK_ON_STARTUP }) { }

    void OnAfterConfigLoad(bool) override
    {
        std::lock_guard<std::recursive_mutex> lock(Mutex);
        Config.enabled = sConfigMgr->GetOption<bool>("CoANeeds.Enable", true);
        Config.bots = sConfigMgr->GetOption<bool>("CoANeeds.IncludeBots", false);
        Config.foodDrain = std::max(0.0f, sConfigMgr->GetOption<float>("CoANeeds.HungerDrainPerMinute", 4.0f));
        Config.waterDrain = std::max(0.0f, sConfigMgr->GetOption<float>("CoANeeds.HydrationDrainPerMinute", 5.4f));
        Config.meal = std::max(0.0f, sConfigMgr->GetOption<float>("CoANeeds.MealFill", 45.0f));
        Config.drink = std::max(0.0f, sConfigMgr->GetOption<float>("CoANeeds.DrinkFill", 55.0f));
        Config.regen = std::max(0.0f, sConfigMgr->GetOption<float>("CoANeeds.VigorRegenPerSecond", 8.0f));
        Config.sprintDrain = std::max(0.0f, sConfigMgr->GetOption<float>("CoANeeds.SprintDrainPerSecond", 10.0f));
        Config.campLifetime = std::clamp(sConfigMgr->GetOption<uint32>("CoANeeds.CampLifetimeSeconds", 3600),
            60u, 86400u);
        Config.campRestFillSeconds = std::clamp(
            sConfigMgr->GetOption<uint32>("CoANeeds.CampRestFillSeconds", 300), 1u, 86400u);
        Config.weather = sConfigMgr->GetOption<bool>("CoANeeds.Weather.Enable", true);
        Config.darkness = sConfigMgr->GetOption<bool>("CoANeeds.Darkness.Enable", true);
        Config.rainyNightColdMultiplier = std::clamp(
            sConfigMgr->GetOption<float>("CoANeeds.Weather.NightColdExposureMultiplier", 1.5f), 1.0f, 4.0f);
        Config.injuries = sConfigMgr->GetOption<bool>("CoANeeds.Injuries.Enable", true);
        Config.tools = sConfigMgr->GetOption<bool>("CoANeeds.Tools.Enable", true);
        Config.professions = sConfigMgr->GetOption<bool>("CoANeeds.Professions.Enable", true);
        Config.wetExposure = std::clamp(sConfigMgr->GetOption<uint32>("CoANeeds.Weather.WetExposureMs", 300000),
            1000u, 3600000u);
        Config.coldExposure = std::clamp(sConfigMgr->GetOption<uint32>("CoANeeds.Weather.ColdExposureMs", 420000),
            1000u, 3600000u);
        Config.heatExposure = std::clamp(sConfigMgr->GetOption<uint32>("CoANeeds.Weather.HeatExposureMs", 180000),
            1000u, 3600000u);
    }

    void OnStartup() override
    {
        SpellsReady = true;
        for (uint32 id = Starving; id <= WindAbility; ++id)
            if (!sSpellMgr->GetSpellInfo(id))
            {
                SpellsReady = false;
                LOG_ERROR("module.coa_needs", "Missing client/server needs spell {}; module disabled", id);
            }
        for (uint32 id = CampRest; id <= PackAbility; ++id)
            if (!sSpellMgr->GetSpellInfo(id))
            {
                SpellsReady = false;
                LOG_ERROR("module.coa_needs", "Missing camp spell {}; module disabled", id);
            }
        for (uint32 id = WeatherAura; id <= ScissorsUse; ++id)
            if (!sSpellMgr->GetSpellInfo(id))
            {
                SpellsReady = false;
                LOG_ERROR("module.coa_needs", "Missing weather/injury spell {}; module disabled", id);
            }
        for (uint32 id = ProfessionAura; id <= ProfessionAura + 12; ++id)
            if (!sSpellMgr->GetSpellInfo(id))
            {
                SpellsReady = false;
                LOG_ERROR("module.coa_needs", "Missing profession spell {}; module disabled", id);
            }
        for (uint32 id : { 996176u, 996177u, TorchAura, CampExperienceAura,
            SurveyAbility, SurveyAura, SeatedRecoveryAura })
            if (!sSpellMgr->GetSpellInfo(id))
            {
                SpellsReady = false;
                LOG_ERROR("module.coa_needs", "Missing torch spell {}; module disabled", id);
            }
        BandageSpells.clear();
        PotionSpells.clear();
        for (auto const& [entry, item] : *sObjectMgr->GetItemTemplateStore())
            if (item.Class == ITEM_CLASS_CONSUMABLE)
                for (auto const& itemSpell : item.Spells)
                    if (itemSpell.SpellId > 0)
                    {
                        if (item.SubClass == ITEM_SUBCLASS_BANDAGE)
                            BandageSpells.insert(itemSpell.SpellId);
                        else if (item.SubClass == ITEM_SUBCLASS_POTION)
                            PotionSpells.insert(itemSpell.SpellId);
                    }
        LOG_INFO("module.coa_needs", "Hunger, hydration and vigor: enabled={}, spells ready={}, include bots={}",
            Config.enabled, SpellsReady, Config.bots);
    }
};

class NeedsPlayer : public PlayerScript
{
public:
    NeedsPlayer() : PlayerScript("CoANeedsPlayer", { PLAYERHOOK_ON_CREATE, PLAYERHOOK_ON_LOGIN, PLAYERHOOK_ON_BEFORE_LOGOUT,
        PLAYERHOOK_ON_SAVE, PLAYERHOOK_ON_UPDATE, PLAYERHOOK_ON_SPELL_CAST, PLAYERHOOK_ON_LEVEL_CHANGED,
        PLAYERHOOK_ON_PLAYER_ENTER_COMBAT, PLAYERHOOK_CAN_PLAYER_USE_PRIVATE_CHAT, PLAYERHOOK_ON_UPDATE_SKILL,
        PLAYERHOOK_ON_SET_SKILL, PLAYERHOOK_ON_CAN_REGENERATE }) { }

    bool OnPlayerCanRegenerate(Player* player, int32 power) override
    {
        if (!player || (power != POWER_HEALTH && power != POWER_MANA) || !Affects(player)
            || !CoANeeds::IsOldSchoolTrial || !CoANeeds::IsOldSchoolTrial(player->GetGUID().GetCounter()))
            return true;
        return false;
    }

    void OnPlayerCreate(Player* player) override
    {
        if (!player || (player->GetSession() && player->GetSession()->IsBot()))
            return;

        constexpr uint32 starterBag = 4496; // Small Brown Pouch (6 slots)
        ItemTemplate const* bagTemplate = sObjectMgr->GetItemTemplate(starterBag);
        if (!bagTemplate || bagTemplate->ContainerSlots != 6)
        {
            LOG_ERROR("module.coa_needs", "Starter bag {} is missing or does not have 6 slots", starterBag);
            return;
        }

        uint32 bagCount = player->GetItemCount(starterBag, true);
        bool changed = false;
        while (bagCount < 2)
        {
            Item* bag = nullptr;
            for (uint8 slot = INVENTORY_SLOT_BAG_START; slot < INVENTORY_SLOT_BAG_END; ++slot)
            {
                if (player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
                    continue;
                bag = player->EquipNewItem(slot, starterBag, true);
                if (bag)
                    break;
            }

            if (!bag && !player->AddItem(starterBag, 1))
            {
                LOG_ERROR("module.coa_needs", "Could not grant starter bag {} to new character {}", starterBag, player->GetName());
                break;
            }

            ++bagCount;
            changed = true;
        }

        if (changed)
            player->SaveToDB(false, false);
    }
    void OnPlayerLogin(Player* player) override
    {
        std::lock_guard<std::recursive_mutex> lock(Mutex);
        if (!Affects(player))
            return;
        State state;
        auto const* saved = player->FindPlayerSettings(Storage);
        if (saved && saved->size() >= 9 && (*saved)[0].value == 1)
        {
            state.food = Clamp((*saved)[1].value / 1000.0f);
            state.water = Clamp((*saved)[2].value / 1000.0f);
            state.vigor = Clamp((*saved)[3].value / 1000.0f);
            state.dodgeUntil = (*saved)[4].value;
            state.windUntil = (*saved)[5].value;
            state.exhaustedUntil = (*saved)[6].value;
            state.attackLockUntil = (*saved)[7].value;
            state.windBuffUntil = (*saved)[8].value;
            if (saved->size() >= 10)
                state.campReady = (*saved)[9].value;
            if (saved->size() >= 11)
                state.injuries = (*saved)[10].value & 15u;
            if (saved->size() >= 12)
                state.oldSchoolRestedMs = std::min((*saved)[11].value, OldSchoolRestedCapMs);
        }
        StopSprint(player, state);
        player->RemoveAurasDueToSpell(SeatedRecoveryAura);
        RefreshResourceTracking(player, state);
        player->RemoveAurasDueToSpell(TorchAura);
        for (uint32 index = 0; index < 3; ++index)
            player->RemoveAurasDueToSpell(CampRest + index);
        UpdateNeeds(player, state);
        States[player->GetGUID().GetCounter()] = state;
        for (uint32 index = 0; index < 5; ++index)
            player->RemoveAurasDueToSpell(WeatherAura + index);
        RefreshInjuries(player, state);
        Unlock(player);
        RefreshProfessions(player);
        Send(player, state);
    }

    void OnPlayerLevelChanged(Player* player, uint8) override
    {
        std::lock_guard<std::recursive_mutex> lock(Mutex);
        RefreshProfessions(player);
        Unlock(player);
    }

    void OnPlayerUpdateSkill(Player* player, uint32 skill, uint32, uint32, uint32, uint32) override
    {
        if (skill == SurvivalistSkill || skill == SKILL_FIRST_AID)
        {
            std::lock_guard<std::recursive_mutex> lock(Mutex);
            Unlock(player);
        }
    }

    void OnPlayerSetSkill(Player* player, uint32 skill, uint32 value, uint32 maximum, uint32 step,
        uint32 newValue) override
    {
        OnPlayerUpdateSkill(player, skill, value, maximum, step, newValue);
    }

    void OnPlayerSave(Player* player) override
    {
        std::lock_guard<std::recursive_mutex> lock(Mutex);
        auto const found = States.find(player->GetGUID().GetCounter());
        if (found != States.end())
            Save(player, found->second);
    }

    void OnPlayerBeforeLogout(Player* player) override
    {
        std::lock_guard<std::recursive_mutex> lock(Mutex);
        auto found = States.find(player->GetGUID().GetCounter());
        if (found == States.end())
            return;
        StopSprint(player, found->second);
        found->second.surveying = false;
        RefreshResourceTracking(player, found->second);
        player->RemoveAurasDueToSpell(SeatedRecoveryAura);
        PackCamp(player);
        for (uint32 index = 0; index < 3; ++index)
            player->RemoveAurasDueToSpell(CampRest + index);
        for (uint32 index = 0; index < 5; ++index)
            player->RemoveAurasDueToSpell(WeatherAura + index);
        Save(player, found->second);
        States.erase(found);
    }

    void OnPlayerEnterCombat(Player* player, Unit*) override
    {
        std::lock_guard<std::recursive_mutex> lock(Mutex);
        auto found = States.find(player->GetGUID().GetCounter());
        if (!Affects(player) || found == States.end())
            return;
        uint64 now = Milliseconds();
        if (now - found->second.lastCombat >= 10000)
        {
            found->second.vigor = std::max(0.0f, found->second.vigor - 8.0f);
            found->second.lastSpend = now;
        }
        found->second.lastCombat = now;
    }

    void OnPlayerSpellCast(Player* player, Spell* spell, bool) override
    {
        std::lock_guard<std::recursive_mutex> lock(Mutex);
        auto found = States.find(player->GetGUID().GetCounter());
        if (!Affects(player) || !spell || found == States.end())
            return;
        State& state = found->second;
        uint32 id = spell->GetSpellInfo()->Id;
        uint32 now = uint32(std::time(nullptr));
        if (id == SurveyAbility)
        {
            state.surveying = !state.surveying;
            RefreshResourceTracking(player, state);
            return;
        }
        if (id >= CampAbility && id <= PackAbility)
        {
            if (id == PackAbility)
            {
                if (!player->IsInCombat())
                    PackCamp(player);
            }
            else
                PlaceCamp(player, state, id - CampAbility);
            Send(player, state);
            return;
        }
        if (id >= SprintAbility && id <= WindAbility)
        {
            UpdateNeeds(player, state);
            if (!player->IsAlive() || player->IsMounted() || player->IsInFlight() || player->IsSitState() ||
                player->HasUnitState(UNIT_STATE_CONTROLLED))
            {
                if (id == SprintAbility)
                    ChatHandler(player->GetSession()).SendSysMessage(
                        "Vigor Sprint requires you to be alive, standing, unmounted and in control.");
                return;
            }
            if (id == SprintAbility)
            {
                if (state.sprint)
                {
                    StopSprint(player, state);
                    if (state.vigor <= 15.0f)
                        Exhaust(player, state);
                }
                else if (player->HasUnitMovementFlag(MOVEMENTFLAG_WALKING))
                    ChatHandler(player->GetSession()).SendSysMessage("Switch from walking to running before sprinting.");
                else if (state.vigor > 25.0f && state.displayFood > 5.0f && state.exhaustedUntil <= now)
                {
                    float const before = player->GetSpeedRate(MOVE_RUN);
                    RefreshSprint(player, true);
                    player->UpdateSpeed(MOVE_RUN, true);
                    float const after = player->GetSpeedRate(MOVE_RUN);
                    LOG_INFO("module.coa_needs", "Vigor Sprint player={} run before={} after={} aura={} slow={} cap={}",
                        player->GetName(), before, after, player->HasAura(SprintAura),
                        player->GetMaxNegativeAuraModifier(SPELL_AURA_MOD_DECREASE_SPEED),
                        player->GetMaxPositiveAuraModifier(SPELL_AURA_USE_NORMAL_MOVEMENT_SPEED));
                    if (!player->HasAura(SprintAura))
                        ChatHandler(player->GetSession()).SendSysMessage(
                            "Vigor Sprint could not start. Try again after your current effects end.");
                    else if (after <= before + 0.0001f)
                    {
                        StopSprint(player, state);
                        ChatHandler(player->GetSession()).SendSysMessage(
                            "Sprint cannot increase your current run speed. No vigor was spent.");
                    }
                    else
                    {
                        state.vigor -= 10.0f;
                        state.sprint = true;
                        state.sprintSyncPending = true;
                        state.lastSpend = Milliseconds();
                    }
                }
                else if (state.vigor <= 25.0f)
                    ChatHandler(player->GetSession()).SendSysMessage("Vigor Sprint requires more than 25 vigor.");
                else if (state.displayFood <= 5.0f)
                    ChatHandler(player->GetSession()).SendSysMessage("You are too hungry to sprint.");
                else
                    ChatHandler(player->GetSession()).SendSysMessage("You are exhausted and cannot sprint yet.");
            }
            else if (id == DodgeAbility && player->GetLevel() >= 30 && state.vigor >= 25.0f &&
                state.dodgeUntil <= now && state.attackLockUntil <= now)
            {
                state.vigor -= 25.0f;
                state.lastSpend = Milliseconds();
                state.dodgeUntil = now + 20;
                if (!state.delegated)
                {
                    state.food = Clamp(state.food - 0.25f);
                    state.water = Clamp(state.water - 0.5f);
                }
                if (Aura* aura = player->AddAura(DodgeAura, player))
                {
                    aura->SetMaxDuration(3000);
                    aura->SetDuration(3000);
                }
            }
            else if (id == WindAbility && player->GetLevel() >= 60 && state.windUntil <= now)
            {
                state.vigor = std::min(state.cap, state.vigor + 25.0f);
                state.windUntil = now + 120;
                state.windBuffUntil = now + 6;
            }
            Save(player, state);
            Send(player, state);
            return;
        }
        if (!spell->m_CastItem)
            return;
        ItemTemplate const* item = spell->m_CastItem->GetTemplate();
        bool bandage = item->Class == ITEM_CLASS_CONSUMABLE && item->SubClass == ITEM_SUBCLASS_BANDAGE;
        bool healingPotion = spell->m_CastItem->IsPotion() &&
            (spell->GetSpellInfo()->HasEffect(SPELL_EFFECT_HEAL) ||
                spell->GetSpellInfo()->HasEffect(SPELL_EFFECT_HEAL_PCT));
        if (Config.injuries && (bandage || healingPotion))
        {
            state.treatment = { item->ItemId, player->GetItemCount(item->ItemId, false), id,
                Milliseconds(), spell->m_targets.GetUnitTargetGUID(), bandage };
            if (state.treatment.target.IsEmpty())
                state.treatment.target = player->GetGUID();
        }
        uint32 category = spell->GetSpellInfo()->GetCategory();
        if (category != SPELL_CATEGORY_FOOD && category != SPELL_CATEGORY_DRINK)
            return;
        PendingMeal meal;
        meal.item = spell->m_CastItem->GetEntry();
        meal.count = player->GetItemCount(meal.item, false);
        meal.spell = id;
        meal.level = spell->m_CastItem->GetTemplate()->ItemLevel;
        meal.food = category == SPELL_CATEGORY_FOOD;
        meal.water = category == SPELL_CATEGORY_DRINK || spell->GetSpellInfo()->HasAura(SPELL_AURA_MOD_POWER_REGEN);
        state.meal = meal;
    }

    void OnPlayerUpdate(Player* player, uint32 diff) override
    {
        std::lock_guard<std::recursive_mutex> lock(Mutex);
        auto found = States.find(player->GetGUID().GetCounter());
        if (found == States.end())
        {
            if (!Affects(player))
                return;
            OnPlayerLogin(player);
            found = States.find(player->GetGUID().GetCounter());
            if (found == States.end())
                return;
        }
        State& state = found->second;
        if (!Affects(player))
        {
            StopSprint(player, state);
            state.surveying = false;
            RefreshResourceTracking(player, state);
            player->RemoveAurasDueToSpell(SeatedRecoveryAura);
            for (uint32 id : { Starving, Dehydrated, Exhausted, WindAura })
                player->RemoveAurasDueToSpell(id);
            for (uint32 index = 0; index < 3; ++index)
                player->RemoveAurasDueToSpell(CampRest + index);
            for (uint32 index = 0; index < 5; ++index)
                player->RemoveAurasDueToSpell(WeatherAura + index);
            for (uint32 index = 0; index < 4; ++index)
                player->RemoveAurasDueToSpell(InjuryAura + index);
            RefreshProfessions(player);
            PackCamp(player);
            return;
        }
        UpdateNeeds(player, state);
        TickTreatment(player, state);
        if (state.meal.item)
        {
            state.meal.elapsed += diff;
            if (!player->IsAlive() || player->IsInCombat() || player->isMoving() || state.meal.elapsed > 3000)
                state.meal = {};
            else if (player->GetItemCount(state.meal.item, false) < state.meal.count)
            {
                if (!state.delegated && player->HasAura(state.meal.spell))
                {
                    if (state.meal.food)
                        state.food = Clamp(state.food + Config.meal + player->GetSkillValue(SKILL_COOKING) / 90.0f);
                    if (state.meal.water)
                        state.water = Clamp(state.water + Config.drink + (state.meal.level >= 60 ? 20.0f :
                            state.meal.level >= 30 ? 10.0f : 0.0f));
                }
                state.meal = {};
            }
        }
        state.tick += diff;
        if (state.tick < 1000)
            return;
        uint32 elapsed = state.tick;
        float seconds = elapsed / 1000.0f;
        state.tick = 0;
        if (state.unlockRetry <= elapsed)
        {
            state.unlockRetry = 30000;
            if (!player->HasSkill(SurvivalistSkill) || !player->HasActiveSpell(SurvivalistProfession) ||
                !player->HasActiveSpell(SprintAbility) || !player->HasActiveSpell(SurveyAbility))
            {
                Unlock(player);
                if (!player->HasSkill(SurvivalistSkill) || !player->HasActiveSpell(SurvivalistProfession) ||
                    !player->HasActiveSpell(SprintAbility) || !player->HasActiveSpell(SurveyAbility))
                    LOG_ERROR("module.coa_needs", "Survivalist unlock still missing for character {} (class {})",
                        player->GetGUID().GetCounter(), player->getClass());
            }
        }
        else
            state.unlockRetry -= elapsed;
        uint32 now = uint32(std::time(nullptr));
        uint64 steady = Milliseconds();
        bool alive = player->IsAlive();
        bool pvp = player->InBattleground() || player->InArena();
        int32 campTier = NearbyCamp(player);
        RestAtCamp(player, state, campTier, elapsed);
        RecoverWhileSeated(player, state, elapsed);
        RefreshResourceTracking(player, state);
        TickWeather(player, state, campTier, elapsed);
        RefreshNightLight(player, state, campTier);
        RefreshInjuries(player, state);
        RefreshProfessions(player);
        if (alive && !pvp && !state.delegated && campTier < 0)
        {
            float cooking = player->GetSkillValue(SKILL_COOKING) / 450.0f;
            float foodDrain = Config.foodDrain * (1.0f - 0.05f * cooking) * (state.weather[2] ? 1.1f : 1.0f);
            float waterDrain = Config.waterDrain * (state.weather[2] ? 1.25f : 1.0f) *
                (state.weather[3] ? 1.1f : 1.0f) * (Config.injuries && (state.injuries & 2u) ? 1.15f : 1.0f);
            state.food = Clamp(state.food - foodDrain * seconds / 60.0f);
            state.water = Clamp(state.water - waterDrain * seconds / 60.0f);
        }
        UpdateNeeds(player, state);
        if (!alive || player->IsMounted() || player->IsInFlight() || player->IsSitState() ||
            state.displayFood <= 5.0f || player->HasUnitState(UNIT_STATE_CONTROLLED))
            StopSprint(player, state);
        if (state.exhaustedUntil > now && player->IsInWater())
        {
            state.exhaustedUntil = now;
            state.attackLockUntil = now;
        }
        if (state.sprint && player->HasUnitMovementFlag(MOVEMENTFLAG_WALKING))
        {
            StopSprint(player, state);
            ChatHandler(player->GetSession()).SendSysMessage("Sprint stopped because you switched to walking.");
        }
        if (alive && state.sprint && player->isMoving())
        {
            state.vigor = std::max(0.0f, state.vigor - Config.sprintDrain * seconds);
            state.lastSpend = steady;
            if (!state.delegated)
            {
                state.food = Clamp(state.food - 2.0f * seconds / 60.0f);
                state.water = Clamp(state.water - 3.0f * seconds / 60.0f);
            }
            if (state.vigor <= 15.0f)
                Exhaust(player, state);
        }
        else if (alive && player->IsInWater() && player->isMoving())
        {
            float fishing = Config.professions ? SkillScale(player, SKILL_FISHING) : 0.0f;
            state.vigor = std::max(0.0f, state.vigor - 4.0f * (1.0f - 0.5f * fishing) * seconds);
            state.lastSpend = steady;
        }
        else if (alive && steady - state.lastSpend >= 1500)
        {
            float regen = Config.regen;
            if (Config.professions)
                regen *= 1.0f + 0.05f * SkillScale(player, SKILL_HERBALISM);
            for (uint32 index = 0; index < 3; ++index)
                if (state.weather[index])
                    regen *= 0.9f;
            if (state.weather[3])
                regen *= 0.95f;
            if (state.weather[4])
                regen *= 1.05f;
            if (state.displayFood <= 35.0f)
                regen *= 0.65f;
            if (state.displayWater <= 30.0f)
                regen *= 0.65f;
            if (player->IsInCombat())
                regen *= 0.25f;
            else if (player->IsSitState())
                regen *= 2.0f;
            if (state.restingCamp >= 0)
                regen *= (player->IsSitState() ? 2.0f : 1.5f) + 0.5f * state.restingCamp;
            if (state.windBuffUntil > now)
                regen *= 2.5f;
            state.vigor = std::min(state.cap, state.vigor + regen * seconds);
        }
        RefreshSprint(player, alive && state.sprint);
        if (state.sprintSyncPending && alive && state.sprint && player->GetClientControlling() == player)
        {
            player->SendSpeedToController(MOVE_RUN, player);
            state.sprintSyncPending = false;
        }
        SetAura(player, Starving, alive && !state.delegated && state.displayFood <= 5.0f);
        SetAura(player, Dehydrated, alive && !state.delegated && state.displayWater <= 30.0f);
        SetAura(player, Exhausted, alive && state.exhaustedUntil > now);
        SetAura(player, WindAura, alive && state.windBuffUntil > now);
        state.dehydrationTick += elapsed;
        if (state.dehydrationTick >= 10000)
        {
            state.dehydrationTick = 0;
            if (alive && !pvp && !state.delegated && campTier < 0 && state.displayWater <= 10.0f &&
                !player->HasPlayerFlag(PLAYER_FLAGS_RESTING))
            {
                uint32 damage = std::max(1u, uint32(player->GetMaxHealth() * 0.02f));
                player->EnvironmentalDamage(DAMAGE_EXHAUSTED, damage);
            }
        }
        UpdateNeeds(player, state);
        Send(player, state);
        state.saveTick += elapsed;
        if (state.saveTick >= 30000)
        {
            state.saveTick = 0;
            Save(player, state);
        }
    }

    bool OnPlayerCanUseChat(Player* player, uint32, uint32 language, std::string& message, Player*) override
    {
        if (language != LANG_ADDON || message.rfind("HXN\t", 0) != 0)
            return true;
        std::lock_guard<std::recursive_mutex> lock(Mutex);
        auto const found = States.find(player->GetGUID().GetCounter());
        if (found != States.end())
            Send(player, found->second);
        return false;
    }
};

class NeedsUnit : public UnitScript
{
public:
    NeedsUnit() : UnitScript("CoANeedsUnit", true,
        { UNITHOOK_ON_DAMAGE, UNITHOOK_ON_BEFORE_HEAL_ABSORB, UNITHOOK_ON_AURA_APPLY, UNITHOOK_ON_AURA_REMOVE }) { }

    void OnBeforeHealAbsorb(HealInfo& heal) override
    {
        std::lock_guard<std::recursive_mutex> lock(Mutex);
        Player* player = heal.GetHealer() ? heal.GetHealer()->ToPlayer() : nullptr;
        SpellInfo const* info = heal.GetSpellInfo();
        if (!Config.professions || !Affects(player) || !info || !heal.GetHeal())
            return;
        float bonus = 0.0f;
        bool bandage = BandageSpells.count(info->Id) != 0;
        if (bandage)
            bonus = 0.2f * SkillScale(player, SKILL_FIRST_AID);
        else if (PotionSpells.count(info->Id))
            bonus = 0.15f * SkillScale(player, SKILL_ALCHEMY);
        uint32 amount = heal.GetHeal();
        uint32 improved = uint32(amount * (1.0f + bonus));
        if (bandage && bonus > 0.0f && improved == amount)
            ++improved;
        heal.SetHeal(improved);
    }

    void OnAuraApply(Unit* unit, Aura* aura) override
    {
        Player* player = unit ? unit->ToPlayer() : nullptr;
        std::lock_guard<std::recursive_mutex> lock(Mutex);
        if (!Config.injuries || !Affects(player) || !aura || !player->IsAlive() ||
            player->InBattleground() || player->InArena() || !player->FindMap())
            return;
        Unit* caster = aura->GetCaster();
        if (!caster || !caster->IsCreature() || caster->GetCharmerOrOwnerPlayerOrPlayerItself())
            return;
        auto found = States.find(player->GetGUID().GetCounter());
        if (found == States.end())
            return;
        SpellInfo const* info = aura->GetSpellInfo();
        if (info->HasEffectMechanic(MECHANIC_BLEED))
            ChangeInjury(player, found->second, 0, true);
        else if (info->Dispel == DISPEL_POISON)
            ChangeInjury(player, found->second, 1, true);
    }

    void OnAuraRemove(Unit* unit, AuraApplication* application, AuraRemoveMode mode) override
    {
        Player* player = unit ? unit->ToPlayer() : nullptr;
        std::lock_guard<std::recursive_mutex> lock(Mutex);
        if (!Config.injuries || !Affects(player) || !application)
            return;
        auto found = States.find(player->GetGUID().GetCounter());
        if (found == States.end())
            return;
        Aura* aura = application->GetBase();
        if (aura->GetId() == InjuryAura + 1 && mode == AURA_REMOVE_BY_ENEMY_SPELL)
            ChangeInjury(player, found->second, 1, false);
        if (mode != AURA_REMOVE_BY_EXPIRE || !aura->GetCasterGUID().IsPlayer())
            return;
        auto healer = States.find(aura->GetCasterGUID().GetCounter());
        if (healer == States.end())
            return;
        Treatment& use = healer->second.treatment;
        Player* caster = ObjectAccessor::FindPlayer(aura->GetCasterGUID());
        if (!caster || !use.bandage || use.spell != aura->GetId() || use.target != player->GetGUID() ||
            caster->GetItemCount(use.item, false) >= use.count)
            return;
        use = {};
        ChangeInjury(player, found->second, 0, false);
        player->RemoveAppliedAuras([](AuraApplication const* applied)
        {
            return applied->GetBase()->GetCasterGUID().IsCreature() &&
                applied->GetBase()->GetSpellInfo()->HasEffectMechanic(MECHANIC_BLEED);
        });
    }

    void OnDamage(Unit* attacker, Unit* victim, uint32& damage) override
    {
        Player* player = attacker ? attacker->ToPlayer() : nullptr;
        std::lock_guard<std::recursive_mutex> lock(Mutex);
        Player* injured = victim ? victim->ToPlayer() : nullptr;
        if (Config.injuries && Affects(injured) && attacker && attacker->IsCreature() && damage &&
            !attacker->GetCharmerOrOwnerPlayerOrPlayerItself() && attacker->IsHostileTo(injured) &&
            injured->IsAlive() && !injured->InBattleground() && !injured->InArena() && injured->FindMap() &&
            (injured->IsOutdoors() || injured->FindMap()->Instanceable()) && damage < injured->GetHealth())
        {
            auto target = States.find(injured->GetGUID().GetCounter());
            if (target != States.end())
            {
                uint64 hit = uint64(damage) * 100;
                uint64 health = injured->GetMaxHealth();
                if (hit >= health * 30)
                    ChangeInjury(injured, target->second, 2, true);
                else if (hit >= health * 20)
                    ChangeInjury(injured, target->second, 3, true);
            }
        }
        if (!Affects(player) || !damage || attacker == victim)
            return;
        auto found = States.find(player->GetGUID().GetCounter());
        if (found == States.end())
            return;
        State& state = found->second;
        float modifier = 1.0f;
        if (Config.professions && victim && victim->IsCreature() &&
            victim->ToCreature()->GetCreatureTemplate()->type == CREATURE_TYPE_BEAST)
            modifier *= 1.0f + 0.05f * SkillScale(player, SKILL_LEATHERWORKING);
        if (!state.delegated)
        {
            if (state.displayFood <= 35.0f)
                modifier *= 0.85f;
            if (state.displayWater <= 30.0f)
                modifier *= 0.9f;
        }
        if (state.vigor <= 0.0f)
            modifier *= 0.5f;
        if (state.attackLockUntil > uint32(std::time(nullptr)))
            modifier = 0.0f;
        damage = uint32(damage * modifier);
        uint64 now = Milliseconds();
        if (damage && now - state.lastAttack >= 1000)
        {
            state.vigor = std::max(0.0f, state.vigor - 3.0f);
            state.lastSpend = now;
            state.lastAttack = now;
        }
    }
};

class NeedsRecipeGate : public AllSpellScript
{
public:
    NeedsRecipeGate() : AllSpellScript("CoANeedsRecipeGate", { ALLSPELLHOOK_ON_SPELL_CHECK_CAST }) { }

    void OnSpellCheckCast(Spell* spell, bool, SpellCastResult& result) override
    {
        Player* player = spell->GetCaster() ? spell->GetCaster()->ToPlayer() : nullptr;
        if (!Affects(player) || result != SPELL_CAST_OK)
            return;
        uint32 id = spell->GetSpellInfo()->Id;
        if (id >= CampKitRecipe && id < CampKitRecipe + 6)
        {
            bool const oldSchool = CoANeeds::IsOldSchoolTrial &&
                CoANeeds::IsOldSchoolTrial(player->GetGUID().GetCounter());
            if ((id >= CampKitRecipe + 3) != oldSchool)
            {
                result = SPELL_FAILED_NOT_HERE;
                return;
            }
        }
        if (id == 996176 || id == 996177)
        {
            bool const oldSchool = CoANeeds::IsOldSchoolTrial &&
                CoANeeds::IsOldSchoolTrial(player->GetGUID().GetCounter());
            if ((id == 996177) != oldSchool)
            {
                result = SPELL_FAILED_NOT_HERE;
                return;
            }
        }
        uint32 requirement = RecipeSkill(id);
        if (requirement && player->GetPureSkillValue(SurvivalistSkill) < requirement)
            result = SPELL_FAILED_LOW_CASTLEVEL;
    }
};

class NeedsTool : public ItemScript
{
public:
    NeedsTool() : ItemScript("item_coa_survival_tool") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const&) override
    {
        std::lock_guard<std::recursive_mutex> lock(Mutex);
        Map* map = player ? player->FindMap() : nullptr;
        if (!Config.tools || !Affects(player) || !item || !map)
            return true;
        if (item->GetEntry() == TorchItem)
        {
            if (player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND) != item)
            {
                ChatHandler(player->GetSession()).SendSysMessage("Equip the torch in your off hand before lighting it.");
                return true;
            }
            auto found = States.find(player->GetGUID().GetCounter());
            if (found != States.end() && player->IsAlive())
            {
                found->second.torchLit = !found->second.torchLit;
                RefreshNightLight(player, found->second);
                ChatHandler(player->GetSession()).SendSysMessage(found->second.torchLit ?
                    "You light your torch." : "You put out your torch.");
            }
            return true;
        }
        if (!player->IsAlive() || player->IsInCombat() || player->IsMounted() || player->IsInFlight() ||
            player->HasUnitState(UNIT_STATE_CONTROLLED))
        {
            ChatHandler(player->GetSession()).SendSysMessage("Use survival tools alive, unmounted and outside combat.");
            return true;
        }
        uint32 entry = item->GetEntry();
        if (entry == SplintItem)
        {
            auto found = States.find(player->GetGUID().GetCounter());
            if (!Config.injuries || found == States.end() || player->isMoving() || player->InBattleground()
                || player->InArena())
                return true;
            State& state = found->second;
            if (!(state.injuries & 12u))
                ChatHandler(player->GetSession()).SendSysMessage("You have no broken arm or leg to splint.");
            else
            {
                ChangeInjury(player, state, (state.injuries & 4u) ? 2 : 3, false);
                RefreshInjuries(player, state);
                player->DestroyItemCount(SplintItem, 1, true);
                Send(player, state);
            }
            return true;
        }
        if (entry >= CampKit && entry < CampKit + 3)
        {
            if (auto state = States.find(player->GetGUID().GetCounter()); state != States.end())
                PlaceCamp(player, state->second, entry - CampKit);
            return true;
        }
        if (entry == 996210)
        {
            if (!player->IsOutdoors() || map->Instanceable())
            {
                ChatHandler(player->GetSession()).SendSysMessage("Use Barber Scissors outdoors outside instances.");
                return true;
            }
            float orientation = player->GetOrientation();
            float x = player->GetPositionX() + std::cos(orientation) * 2.5f;
            float y = player->GetPositionY() + std::sin(orientation) * 2.5f;
            float z = map->GetHeight(player->GetPhaseMask(), x, y, player->GetPositionZ());
            if (z > INVALID_HEIGHT)
                player->SummonGameObject(190683, x, y, z, orientation, 0, 0,
                    std::sin(orientation * 0.5f), std::cos(orientation * 0.5f), 60, false, GO_SUMMON_TIMED_DESPAWN);
            return true;
        }
        if (entry == 996200 || entry == 996202)
        {
            bool valid = player->IsInWater();
            if (entry == 996202)
            {
                map->GetOrGenerateZoneDefaultWeather(player->GetZoneId());
                auto weather = ZoneWeather.find(player->GetZoneId());
                valid = weather != ZoneWeather.end() && (weather->second == WEATHER_STATE_LIGHT_RAIN ||
                    weather->second == WEATHER_STATE_MEDIUM_RAIN || weather->second == WEATHER_STATE_HEAVY_RAIN ||
                    weather->second == WEATHER_STATE_THUNDERS || weather->second == WEATHER_STATE_BLACKRAIN);
                valid = valid && player->IsOutdoors() && !map->Instanceable();
            }
            if (!valid)
            {
                ChatHandler(player->GetSession()).SendSysMessage(entry == 996200 ?
                    "Stand in water to refill your flask." : "Collect rainwater outdoors while it is raining.");
                return true;
            }
            ItemPosCountVec destination;
            InventoryResult result = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, destination, entry + 1, 1);
            if (result != EQUIP_ERR_OK)
            {
                player->SendEquipError(result, nullptr, nullptr);
                return true;
            }
            if (Item* filled = player->StoreNewItem(destination, entry + 1, true))
            {
                player->DestroyItemCount(entry, 1, true);
                player->SendNewItem(filled, 1, true, false);
            }
        }
        else if (entry == 996204)
        {
            uint16 position = 0;
            uint32 loss = 0;
            for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
                if (Item* equipped = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
                {
                    uint32 maximum = equipped->GetUInt32Value(ITEM_FIELD_MAXDURABILITY);
                    uint32 current = equipped->GetUInt32Value(ITEM_FIELD_DURABILITY);
                    if (maximum > current && maximum - current > loss)
                    {
                        loss = maximum - current;
                        position = (INVENTORY_SLOT_BAG_0 << 8) | slot;
                    }
                }
            if (!loss)
                ChatHandler(player->GetSession()).SendSysMessage("No equipped item needs repair. The kit was kept.");
            else
            {
                player->DurabilityRepair(position, false, 0.0f, false);
                player->DestroyItemCount(entry, 1, true);
                ChatHandler(player->GetSession()).SendSysMessage("Repaired your most damaged equipped item.");
            }
        }
        else if (entry == 996208)
        {
            if (!player->IsOutdoors() || map->Instanceable() || player->isMoving() || player->IsFalling())
                return true;
            float orientation = player->GetOrientation();
            float x = player->GetPositionX() + std::cos(orientation) * 4.0f;
            float y = player->GetPositionY() + std::sin(orientation) * 4.0f;
            float ground = player->GetPositionZ();
            float water = map->GetWaterOrGroundLevel(player->GetPhaseMask(), x, y, ground, &ground, true);
            if (water <= ground + 0.5f || !map->IsInWater(player->GetPhaseMask(), x, y, water - 0.25f,
                player->GetCollisionHeight()))
                ChatHandler(player->GetSession()).SendSysMessage("Face open water to deploy your raft.");
            else if (player->SummonGameObject(996200, x, y, water, orientation, 0, 0,
                std::sin(orientation * 0.5f), std::cos(orientation * 0.5f), 1800, false, GO_SUMMON_TIMED_DESPAWN))
            {
                player->DestroyItemCount(entry, 1, true);
                ChatHandler(player->GetSession()).SendSysMessage("Your raft will remain here for 30 minutes.");
            }
        }
        return true;
    }
};
}

void AddSC_coa_needs()
{
    CoANeeds::ReadOldSchoolRestedSeconds = ReadOldSchoolRestedSeconds;
    new NeedsWorld();
    new NeedsWeather();
    new NeedsPlayer();
    new NeedsUnit();
    new NeedsTool();
    new NeedsRecipeGate();
}
