#include "AreaDefines.h"
#include <algorithm>
#include <cassert>
#include <cmath>
#include <cstdint>
#include <cstring>
#include <map>
#include <utility>
#include <vector>

using int32 = std::int32_t;

constexpr uint32 CREATURE_TYPE_CRITTER = 8;
constexpr uint32 CREATURE_ELITE_NORMAL = 0;
constexpr uint32 CREATURE_ELITE_ELITE = 1;
constexpr uint32 CREATURE_ELITE_RAREELITE = 2;
constexpr uint32 CREATURE_ELITE_WORLDBOSS = 3;
constexpr uint32 CREATURE_ELITE_RARE = 4;

struct Player;
struct Creature;

struct Unit
{
    virtual ~Unit() = default;
    virtual Creature* ToCreature() { return nullptr; }
    virtual Player* GetCharmerOrOwnerPlayerOrPlayerItself() { return nullptr; }
};

struct ObjectGuid
{
    uint32 value;
    uint32 GetCounter() const { return value; }
};

struct Player : Unit
{
    uint32 guid = 17;
    uint32 level = 25;
    Player* GetCharmerOrOwnerPlayerOrPlayerItself() override { return this; }
    uint32 GetLevel() const { return level; }
    ObjectGuid GetGUID() const { return { guid }; }
};

struct CreatureTemplate
{
    uint32 type = 1;
    uint32 rank = CREATURE_ELITE_NORMAL;
};

struct Creature : Unit
{
    uint32 entry = 4015;
    uint32 zone = AREA_STONETALON_MOUNTAINS;
    uint32 spawn = 29981;
    uint32 level = 25;
    CreatureTemplate data;
    bool owned = false;
    Player* owner = nullptr;
    uint32 helpCalls = 0;
    float helpRadius = 0;
    Unit* helpVictim = nullptr;

    Creature* ToCreature() override { return this; }
    Player* GetCharmerOrOwnerPlayerOrPlayerItself() override { return owner; }
    uint32 GetEntry() const { return entry; }
    uint32 GetZoneId() const { return zone; }
    uint32 GetSpawnId() const { return spawn; }
    uint32 GetLevel() const { return level; }
    CreatureTemplate const* GetCreatureTemplate() const { return &data; }
    bool IsCharmedOwnedByPlayerOrPlayer() const { return owned; }
    void CallForHelp(float radius, Unit* victim)
    {
        ++helpCalls;
        helpRadius = radius;
        helpVictim = victim;
    }
};

Player const* ChallengeParticipant(Player const* player) { return player; }
bool challengesEnabled = true;
std::map<uint32, std::vector<std::pair<uint32, uint32>>> enrollment;
bool ChallengesEnabled() { return challengesEnabled; }
auto const& CachedCharChallenges(uint32 guid) { return enrollment[guid]; }
void Enroll(Player const& player, uint32 challenge) { enrollment[player.guid] = { { challenge, 1 } }; }

// NATIVE_METHODS

void NamedProfiles()
{
    Player player;
    Creature creature;
    for (uint32 entry : { 4015u, 5928u, 5930u, 5931u, 5932u })
    {
        creature.entry = entry;
        creature.data.rank = entry == 5930 || entry == 5931 || entry == 5932
            ? CREATURE_ELITE_RAREELITE : CREATURE_ELITE_RARE;
        assert(OldSchoolThreatOffset(&creature) == 4);
        assert(OldSchoolThreatLevel(&creature) == 29);
        auto profile = GetOldSchoolPowerProfile(&player, &creature);
        assert(std::strcmp(profile.con, "Red") == 0);
        if (creature.data.rank == CREATURE_ELITE_RAREELITE)
        {
            assert(profile.healthPercent == 3576);
            assert(profile.damageMultiplier == 22);
            assert(profile.experienceMultiplier == 16);
        }
        else
        {
            assert(profile.healthPercent == 1788);
            assert(profile.damageMultiplier == 11);
            assert(profile.experienceMultiplier == 8);
        }
        player.level = 35;
        profile = GetOldSchoolPowerProfile(&player, &creature);
        assert(std::strcmp(profile.con, "Grey") == 0);
        assert(OldSchoolThreatLevel(&creature) == 29);
        player.level = 25;
        assert(creature.level == 25);
        assert(creature.data.rank == (entry == 5930 || entry == 5931 || entry == 5932
            ? CREATURE_ELITE_RAREELITE : CREATURE_ELITE_RARE));
        for (uint32 zone : { AREA_MULGORE, AREA_THE_BARRENS, AREA_ASHENVALE })
        {
            creature.zone = zone;
            assert(!IsOldSchoolStonetalonNamedThreat(&creature));
            assert(OldSchoolThreatOffset(&creature) == 0);
        }
        creature.zone = AREA_STONETALON_MOUNTAINS;
    }
    creature.entry = 4000;
    assert(!IsOldSchoolStonetalonNamedThreat(&creature));
    assert(OldSchoolThreatOffset(&creature) == 0);
    assert(!IsOldSchoolStonetalonNamedThreat(nullptr));
    assert(OldSchoolThreatOffset(nullptr) == 0);
    creature.data.rank = CREATURE_ELITE_NORMAL;
    int32 const offset = OldSchoolThreatOffset(&creature);
    assert(offset >= -8 && offset <= 65);
    assert(OldSchoolThreatOffset(&creature) == offset);
    creature.spawn = 0;
    assert(OldSchoolThreatOffset(&creature) == 0);
    for (uint32 entry : { 3056u, 3058u, 5807u })
    {
        creature.entry = entry;
        creature.zone = AREA_MULGORE;
        assert(OldSchoolThreatOffset(&creature) == 4);
    }
    for (uint32 entry : { 3398u, 3474u, 5828u, 5829u, 5831u, 5834u, 5847u, 5865u })
    {
        creature.entry = entry;
        creature.zone = AREA_THE_BARRENS;
        assert(OldSchoolThreatOffset(&creature) == 4);
    }
}

void SocialEligibility()
{
    Player player;
    for (uint32 challenge : { 9001u, 9002u })
    {
        Enroll(player, challenge);
        for (uint32 zone : { AREA_MULGORE, AREA_THE_BARRENS, AREA_STONETALON_MOUNTAINS })
        {
            Creature creature;
            creature.zone = zone;
            OnUnitEnterCombat(&creature, &player);
            assert(creature.helpCalls == 1);
            assert(creature.helpRadius == 35.0f);
            assert(creature.helpVictim == &player);
        }
    }
    for (uint32 challenge : { 0u, 211u, 425u })
    {
        Enroll(player, challenge);
        Creature creature;
        OnUnitEnterCombat(&creature, &player);
        assert(creature.helpCalls == 0);
    }
    Enroll(player, 9001);
    Creature creature;
    creature.zone = AREA_ASHENVALE;
    OnUnitEnterCombat(&creature, &player);
    assert(creature.helpCalls == 0);
    creature.zone = AREA_STONETALON_MOUNTAINS;
    creature.spawn = 0;
    OnUnitEnterCombat(&creature, &player);
    assert(creature.helpCalls == 0);
    creature.spawn = 29981;
    creature.data.type = CREATURE_TYPE_CRITTER;
    OnUnitEnterCombat(&creature, &player);
    assert(creature.helpCalls == 0);
    creature.data.type = 1;
    creature.owned = true;
    OnUnitEnterCombat(&creature, &player);
    assert(creature.helpCalls == 0);
    creature.owned = false;
    OnUnitEnterCombat(&creature, nullptr);
    OnUnitEnterCombat(nullptr, &player);
    OnUnitEnterCombat(&player, &creature);
    assert(creature.helpCalls == 0);
    challengesEnabled = false;
    OnUnitEnterCombat(&creature, &player);
    assert(creature.helpCalls == 0);
    challengesEnabled = true;
    Creature pet;
    pet.owner = &player;
    OnUnitEnterCombat(&creature, &pet);
    assert(creature.helpCalls == 1);
    assert(creature.helpVictim == &pet);
}

int main()
{
    NamedProfiles();
    SocialEligibility();
}
