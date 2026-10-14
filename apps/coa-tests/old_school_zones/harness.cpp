#include "AreaDefines.h"
#include "OldSchoolZoneProfiles.h"
#include <algorithm>
#include <cassert>
#include <cmath>
#include <cstdint>
#include <cstring>
#include <map>
#include <set>
#include <utility>
#include <vector>

using int32 = std::int32_t;
using uint8 = std::uint8_t;
constexpr uint8 XPSOURCE_QUEST = 1;
constexpr uint8 XPSOURCE_QUEST_DF = 2;
constexpr uint8 XPSOURCE_KILL = 3;

constexpr uint32 CREATURE_TYPE_CRITTER = 8;
constexpr uint32 CREATURE_ELITE_NORMAL = 0;
constexpr uint32 CREATURE_ELITE_ELITE = 1;
constexpr uint32 CREATURE_ELITE_RAREELITE = 2;
constexpr uint32 CREATURE_ELITE_WORLDBOSS = 3;
constexpr uint32 CREATURE_ELITE_RARE = 4;
constexpr uint32 OldSchoolEquipmentCorpseEntry = 996900;

struct Player;
struct Creature;
struct Map
{
    bool dungeon = false;
    bool raid = false;
    bool IsDungeon() const { return dungeon; }
    bool IsRaid() const { return raid; }
};

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

struct Group
{
    struct MemberSlot { ObjectGuid guid; };
    bool raid = false;
    bool battleground = false;
    bool battlefield = false;
    std::vector<MemberSlot> members;
    bool isRaidGroup() const { return raid; }
    bool isBGGroup() const { return battleground; }
    bool isBFGroup() const { return battlefield; }
    auto const& GetMemberSlots() const { return members; }
};

struct Player : Unit
{
    uint32 guid = 17;
    uint32 level = 25;
    Group* group = nullptr;
    bool alive = true;
    bool samePhase = true;
    bool rewardDistance = true;
    Player* GetCharmerOrOwnerPlayerOrPlayerItself() override { return this; }
    uint32 GetLevel() const { return level; }
    ObjectGuid GetGUID() const { return { guid }; }
    Group const* GetGroup() const { return group; }
    bool IsAlive() const { return alive; }
    bool InSamePhase(Creature const*) const { return samePhase; }
    bool IsAtGroupRewardDistance(Creature const*) const { return rewardDistance; }
};

namespace ObjectAccessor
{
    std::map<uint32, Player*> players;
    Player* FindPlayer(ObjectGuid guid) { return players[guid.value]; }
}

struct CreatureTemplate
{
    uint32 type = 1;
    uint32 rank = CREATURE_ELITE_NORMAL;
    uint32 maxlevel = 25;
    uint32 unit_class = 1;
    float BaseVariance = 1.0f;
};

struct CreatureBaseStats
{
    uint32 AttackPower = 0;
    uint32 GenerateHealth(CreatureTemplate const*) const { return 100; }
    float GenerateBaseDamage(CreatureTemplate const*) const { return 10.0f; }
    float GenerateArmor(CreatureTemplate const*) const { return 100.0f; }
};

struct ObjectMgr
{
    CreatureBaseStats stats;
    CreatureBaseStats const* GetCreatureBaseStats(uint32, uint32) const { return &stats; }
};
ObjectMgr objectMgr;
ObjectMgr* sObjectMgr = &objectMgr;
struct
{
    uint32 ordinaryHealthPercent = 600;
    float ordinaryDamageMultiplier = 1.0f;
} OldSchoolOptions;

struct Creature : Unit
{
    Map map;
    uint32 entry = 4015;
    uint32 zone = AREA_STONETALON_MOUNTAINS;
    uint32 spawn = 29981;
    uint32 level = 25;
    mutable CreatureTemplate data;
    bool owned = false;
    bool alive = true;
    Player* owner = nullptr;

    Creature* ToCreature() override { return this; }
    Player* GetCharmerOrOwnerPlayerOrPlayerItself() override { return owner; }
    uint32 GetEntry() const { return entry; }
    uint32 GetZoneId() const { return zone; }
    uint32 GetSpawnId() const { return spawn; }
    uint32 GetLevel() const { return level; }
    Map const* GetMap() const { return &map; }
    CreatureTemplate const* GetCreatureTemplate() const { data.maxlevel = level; return &data; }
    bool IsCharmedOwnedByPlayerOrPlayer() const { return owned; }
    bool IsAlive() const { return alive; }
};

Player const* ChallengeParticipant(Player const* player) { return player; }
bool challengesEnabled = true;
std::map<uint32, std::vector<std::pair<uint32, uint32>>> enrollment;
bool ChallengesEnabled() { return challengesEnabled; }
auto const& CachedCharChallenges(uint32 guid) { return enrollment[guid]; }
std::set<uint32> ActiveChallenges(uint32 guid)
{
    std::set<uint32> active;
    for (auto const& challenge : CachedCharChallenges(guid))
        active.insert(challenge.first);
    return active;
}
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
        assert(std::strcmp(profile.con, "Gold") == 0);
        if (creature.data.rank == CREATURE_ELITE_RAREELITE)
        {
            assert(profile.healthPercent >= 2100);
            assert(profile.damageMultiplier >= 3.5f);
            assert(profile.experienceMultiplierHundredths >= 350);
        }
        else
        {
            assert(profile.healthPercent >= 1050);
            assert(profile.damageMultiplier >= 1.75f);
            assert(profile.experienceMultiplierHundredths >= 175);
        }
        player.level = 35;
        profile = GetOldSchoolPowerProfile(&player, &creature);
        assert(std::strcmp(profile.con, "Green") == 0);
        assert(OldSchoolThreatLevel(&creature) == 29);
        player.level = 25;
        assert(creature.level == 25);
        assert(creature.data.rank == (entry == 5930 || entry == 5931 || entry == 5932
            ? CREATURE_ELITE_RAREELITE : CREATURE_ELITE_RARE));
        creature.spawn = 0;
        for (uint32 zone : { AREA_MULGORE, AREA_THE_BARRENS, AREA_ASHENVALE })
        {
            creature.zone = zone;
            assert(!IsOldSchoolStonetalonNamedThreat(&creature));
            assert(OldSchoolThreatOffset(&creature) == 0);
        }
        creature.spawn = 29981;
        creature.zone = AREA_STONETALON_MOUNTAINS;
    }
    creature.entry = 4000;
    creature.spawn = 0;
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
    for (uint32 entry : { 3394u, 3395u, 3396u, 3398u, 3474u, 5828u, 5829u, 5831u, 5834u, 5847u, 5865u })
    {
        creature.entry = entry;
        creature.zone = AREA_THE_BARRENS;
        assert(OldSchoolThreatOffset(&creature) == (entry == 3396 ? 10 : entry == 3394 || entry == 3395 ? 8 : 4));
    }
    creature.data.rank = CREATURE_ELITE_NORMAL;
    creature.level = 25;
    creature.entry = 3394;
    assert(GetOldSchoolPowerProfile(&player, &creature).experienceMultiplierHundredths >= 200);
    creature.entry = 3395;
    assert(GetOldSchoolPowerProfile(&player, &creature).experienceMultiplierHundredths >= 200);
    creature.entry = 3396;
    assert(GetOldSchoolPowerProfile(&player, &creature).experienceMultiplierHundredths >= 300);
    creature.entry = 3398;
    assert(GetOldSchoolPowerProfile(&player, &creature).experienceMultiplierHundredths >= 100);
}

void MoreDifficultProfiles()
{
    Player player;
    Creature creature;
    creature.entry = 5000;
    creature.spawn = 0;
    creature.level = player.level;
    creature.data.rank = CREATURE_ELITE_NORMAL;
    auto const profile = GetOldSchoolPowerProfile(&player, &creature);
    assert(std::strcmp(profile.con, "White") == 0);
    assert(profile.healthPercent == 750);
    assert(profile.damageMultiplier == 1.25f);
    assert(profile.experienceMultiplierHundredths == 125);
    assert(std::strcmp(OldSchoolConColor(profile.con), "|cffffffff") == 0);
    assert(std::strcmp(OldSchoolConColor("Purple boss"), "|cffa335ee") == 0);
    assert(std::strcmp(OldSchoolConColor("Red"), "|cffff0000") == 0);
}

void CreatureTypeThreatProfiles()
{
    assert(OldSchoolExperienceSourceMultiplier(XPSOURCE_QUEST) == 3);
    assert(OldSchoolExperienceSourceMultiplier(XPSOURCE_QUEST_DF) == 3);
    assert(OldSchoolExperienceSourceMultiplier(XPSOURCE_KILL) == 1);

    Player player;
    player.level = 1;
    Creature skeleton;
    skeleton.entry = 1890;
    skeleton.zone = AREA_TIRISFAL_GLADES;
    skeleton.level = 2;
    skeleton.spawn = 1001;
    assert(OldSchoolThreatOffset(&skeleton) == 0);
    assert(std::strcmp(GetOldSchoolPowerProfile(&player, &skeleton).con, "Yellow") == 0);

    Creature first;
    first.entry = 1512;
    first.level = 2;
    first.spawn = 1002;
    Creature second = first;
    second.spawn = 987654;
    assert(OldSchoolThreatOffset(&first) == OldSchoolThreatOffset(&second));

    player.level = 30;
    Creature scaled;
    scaled.entry = 5000;
    scaled.level = uint32(int32(player.level) - OldSchoolThreatOffset(&scaled));
    auto const white = GetOldSchoolPowerProfile(&player, &scaled);
    assert(std::strcmp(white.con, "White") == 0);
    scaled.level += 5;
    auto const purple = GetOldSchoolPowerProfile(&player, &scaled);
    assert(std::strcmp(purple.con, "Orange") == 0);
    assert(purple.experienceMultiplierHundredths > white.experienceMultiplierHundredths);
}

void MulgoreCampConsider()
{
    Creature shaman;
    shaman.entry = 2953;
    shaman.zone = AREA_MULGORE;
    Creature guard;
    guard.entry = 2952;
    guard.zone = AREA_MULGORE;
    Creature poacher;
    poacher.entry = 2951;
    poacher.zone = AREA_MULGORE;
    Creature skinner;
    skinner.entry = 2950;
    skinner.zone = AREA_MULGORE;
    Creature deadGuard = guard;
    deadGuard.alive = false;
    Creature ownedGuard = guard;
    ownedGuard.owned = true;
    std::vector<Creature const*> nearby{ &shaman, &guard, &poacher, &skinner, &deadGuard, &ownedGuard };
    assert(IsOldSchoolSameCamp(&shaman, &guard));
    assert(!IsOldSchoolSameCamp(&shaman, &poacher));
    assert(!IsOldSchoolSameCamp(&shaman, &deadGuard));
    assert(!IsOldSchoolSameCamp(&shaman, &ownedGuard));
    assert(CountOldSchoolCampmates(&shaman, nearby) == 1);
    assert(CountOldSchoolCampmates(&poacher, nearby) == 1);
    assert(CountOldSchoolCampmates(&poacher, {}) == 0);
}

void BarrensCampConsider()
{
    Creature geomancer;
    geomancer.entry = 3269;
    geomancer.zone = AREA_THE_BARRENS;
    geomancer.spawn = 0;
    Creature defender;
    defender.entry = 3266;
    defender.zone = AREA_THE_BARRENS;
    Creature stormer;
    stormer.entry = 3273;
    stormer.zone = AREA_THE_BARRENS;
    Creature mulgoreGuard;
    mulgoreGuard.entry = 2952;
    mulgoreGuard.zone = AREA_MULGORE;
    std::vector<Creature const*> nearby{ &defender, &stormer, &mulgoreGuard };
    assert(std::strcmp(GetOldSchoolCampThreat(&geomancer).camp, "Razormane camp") == 0);
    assert(IsOldSchoolSameCamp(&geomancer, &defender));
    assert(!IsOldSchoolSameCamp(&geomancer, &stormer));
    assert(!IsOldSchoolSameCamp(&geomancer, &mulgoreGuard));
    assert(CountOldSchoolCampmates(&geomancer, nearby) == 1);
    assert(OldSchoolThreatOffset(&geomancer) == 0);
    assert(OldSchoolThreatLevel(&geomancer) == 25);
    Player player;
    assert(std::strcmp(GetOldSchoolPowerProfile(&player, &geomancer).con, "White") == 0);
}

void ForestAndMountainProfiles()
{
    Player player;
    Creature creature;
    creature.spawn = 0;
    creature.zone = AREA_STONETALON_MOUNTAINS;
    creature.entry = 4003;
    assert(std::strcmp(GetOldSchoolCampThreat(&creature).camp, "Windshear mine") == 0);
    assert(OldSchoolThreatOffset(&creature) == 0);
    creature.entry = 4202;
    assert(IsOldSchoolStonetalonNamedThreat(&creature));
    assert(OldSchoolThreatOffset(&creature) == 8);
    assert(GetOldSchoolPowerProfile(&player, &creature).experienceMultiplierHundredths >= 200);
    creature.zone = AREA_ASHENVALE;
    assert(!IsOldSchoolStonetalonNamedThreat(&creature));
    assert(OldSchoolThreatOffset(&creature) == 0);
    creature.entry = 3924;
    assert(std::strcmp(GetOldSchoolCampThreat(&creature).role, "shaman") == 0);
    assert(OldSchoolThreatOffset(&creature) == 0);
    creature.entry = 3736;
    assert(IsOldSchoolAshenvaleNamedThreat(&creature));
    assert(OldSchoolThreatOffset(&creature) == 8);
    assert(GetOldSchoolPowerProfile(&player, &creature).experienceMultiplierHundredths >= 200);
    creature.entry = 10640;
    assert(IsOldSchoolAshenvaleNamedThreat(&creature));
    assert(OldSchoolThreatOffset(&creature) == 4);
    assert(GetOldSchoolPowerProfile(&player, &creature).experienceMultiplierHundredths >= 150);
    creature.zone = AREA_THE_BARRENS;
    assert(!IsOldSchoolAshenvaleNamedThreat(&creature));
    assert(OldSchoolThreatOffset(&creature) == 0);
    assert(OldSchoolNamedRewardHundredths(&creature) == 100);
    creature.zone = AREA_THOUSAND_NEEDLES;
    creature.entry = 10760;
    assert(std::strcmp(GetOldSchoolCampThreat(&creature).camp, "Grimtotem mesa") == 0);
    assert(OldSchoolThreatOffset(&creature) == 0);
    creature.entry = 4499;
    assert(IsOldSchoolSouthernNamedThreat(&creature));
    assert(OldSchoolNamedRewardHundredths(&creature) == 200);
    creature.zone = AREA_DESOLACE;
    creature.entry = 4719;
    assert(std::strcmp(GetOldSchoolCampThreat(&creature).camp, "Slitherblade shore") == 0);
    assert(OldSchoolThreatOffset(&creature) == 0);
    creature.entry = 5760;
    assert(IsOldSchoolSouthernNamedThreat(&creature));
    assert(OldSchoolThreatOffset(&creature) == 10);
    assert(OldSchoolNamedRewardHundredths(&creature) == 300);
    creature.zone = AREA_MULGORE;
    assert(!IsOldSchoolSouthernNamedThreat(&creature));
    assert(OldSchoolThreatOffset(&creature) == 0);
    creature.zone = AREA_DUSTWALLOW_MARSH;
    creature.entry = 4334;
    assert(std::strcmp(GetOldSchoolCampThreat(&creature).role, "flamecaller") == 0);
    assert(OldSchoolThreatOffset(&creature) == 0);
    creature.entry = 4841;
    assert(IsOldSchoolSouthernNamedThreat(&creature));
    assert(OldSchoolNamedRewardHundredths(&creature) == 200);
    creature.zone = AREA_FERALAS;
    creature.entry = 5258;
    assert(std::strcmp(GetOldSchoolCampThreat(&creature).camp, "Woodpaw camp") == 0);
    assert(OldSchoolThreatOffset(&creature) == 0);
    creature.entry = 5357;
    assert(IsOldSchoolSouthernNamedThreat(&creature));
    assert(OldSchoolNamedThreatOffset(&creature) == 8);
    assert(OldSchoolNamedRewardHundredths(&creature) == 200);
    creature.zone = AREA_MULGORE;
    assert(!IsOldSchoolSouthernNamedThreat(&creature));
    assert(OldSchoolNamedRewardHundredths(&creature) == 100);
}

void GroupRewards()
{
    Player player;
    Player companion;
    Player companion2;
    Player companion3;
    companion.guid = 18;
    companion2.guid = 19;
    companion3.guid = 20;
    Creature creature;
    Group group;
    Enroll(player, 9001);
    Enroll(companion, 9001);
    Enroll(companion2, 9001);
    Enroll(companion3, 9001);
    ObjectAccessor::players[player.guid] = &player;
    ObjectAccessor::players[companion.guid] = &companion;
    ObjectAccessor::players[companion2.guid] = &companion2;
    ObjectAccessor::players[companion3.guid] = &companion3;
    group.members = { { player.GetGUID() }, { companion.GetGUID() } };
    assert(OldSchoolGroupRewardSize(&player, &creature) == 1);
    player.group = &group;
    assert(OldSchoolGroupRewardSize(&player, &creature) == 2);
    group.members.push_back({ companion2.GetGUID() });
    assert(OldSchoolGroupRewardSize(&player, &creature) == 3);
    group.members.push_back({ companion3.GetGUID() });
    assert(OldSchoolGroupRewardSize(&player, &creature) == 4);
    group.members.pop_back();
    group.members.pop_back();
    companion.alive = false;
    assert(OldSchoolGroupRewardSize(&player, &creature) == 1);
    companion.alive = true;
    companion.rewardDistance = false;
    assert(OldSchoolGroupRewardSize(&player, &creature) == 1);
    companion.rewardDistance = true;
    companion.samePhase = false;
    assert(OldSchoolGroupRewardSize(&player, &creature) == 1);
    companion.samePhase = true;
    Enroll(companion, 9002);
    assert(OldSchoolGroupRewardSize(&player, &creature) == 1);
    Enroll(companion, 9001);
    group.raid = true;
    assert(OldSchoolGroupRewardSize(&player, &creature) == 1);
    group.raid = false;
    group.battleground = true;
    assert(OldSchoolGroupRewardSize(&player, &creature) == 1);
    group.battleground = false;
    group.battlefield = true;
    assert(OldSchoolGroupRewardSize(&player, &creature) == 1);
    group.battlefield = false;
    ObjectAccessor::players[companion.guid] = nullptr;
    ObjectAccessor::players[companion2.guid] = nullptr;
    ObjectAccessor::players[companion3.guid] = nullptr;
    assert(OldSchoolGroupRewardSize(&player, &creature) == 1);
    assert(OldSchoolGroupRewardSize(nullptr, &creature) == 1);
    assert(OldSchoolGroupRewardSize(&player, nullptr) == 1);
    ObjectAccessor::players.clear();
    enrollment.clear();
}

void DungeonProfiles()
{
    Player player;
    Creature creature;
    creature.entry = 999999;
    creature.zone = AREA_MULGORE;
    OldSchoolOptions.ordinaryDamageMultiplier = 2.0f;
    auto const outdoor = GetOldSchoolPowerProfile(&player, &creature);
    creature.map.dungeon = true;
    auto const dungeon = GetOldSchoolPowerProfile(&player, &creature);
    assert(dungeon.healthPercent < outdoor.healthPercent);
    assert(dungeon.damageMultiplier < outdoor.damageMultiplier);
    assert(dungeon.experienceMultiplierHundredths > outdoor.experienceMultiplierHundredths);
    creature.map.raid = true;
    auto const raid = GetOldSchoolPowerProfile(&player, &creature);
    assert(raid.healthPercent == outdoor.healthPercent);
    assert(raid.experienceMultiplierHundredths == outdoor.experienceMultiplierHundredths);
    OldSchoolOptions.ordinaryDamageMultiplier = 1.0f;
}

int main()
{
    DungeonProfiles();
    GroupRewards();
    NamedProfiles();
    MoreDifficultProfiles();
    CreatureTypeThreatProfiles();
    MulgoreCampConsider();
    BarrensCampConsider();
    ForestAndMountainProfiles();
}
