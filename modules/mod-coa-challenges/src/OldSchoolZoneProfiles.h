#ifndef HXC_OLD_SCHOOL_ZONE_PROFILES_H
#define HXC_OLD_SCHOOL_ZONE_PROFILES_H

#include "Define.h"
#include <unordered_map>

namespace HxcOldSchool
{
inline uint32 NormalizeZone(uint32 zone)
{
    switch (zone)
    {
        case 10138: return 12;
        case 10139: return 1;
        case 10140: return 85;
        case 10141: return 3430;
        case 10142: return 3524;
        case 10143: return 141;
        case 10144: return 14;
        case 10146: return 215;
        default: return zone;
    }
}

struct ZoneProfile
{
    uint32 zone;
    uint32 entry;
    char const* camp;
    char const* role;
    int32 threat;
    uint32 reward;
    bool named;
    bool roaming;
    uint8 publicDungeonCategory = 0;
};

inline ZoneProfile const ZoneProfiles[] =
{
#include "old-school-zones/139.inc"
#include "old-school-zones/406.inc"
#include "old-school-zones/331.inc"
#include "old-school-zones/405.inc"
#include "old-school-zones/400.inc"
#include "old-school-zones/28.inc"
#include "old-school-zones/26.inc"
#include "old-school-zones/47.inc"
#include "old-school-zones/45.inc"
#include "old-school-zones/267.inc"
#include "old-school-zones/130.inc"
#include "old-school-zones/85.inc"
#include "old-school-zones/17.inc"
#include "old-school-zones/215.inc"
#include "old-school-zones/4298.inc"
#include "old-school-zones/493.inc"
#include "old-school-zones/1377.inc"
#include "old-school-zones/618.inc"
#include "old-school-zones/490.inc"
#include "old-school-zones/440.inc"
#include "old-school-zones/361.inc"
#include "old-school-zones/16.inc"
#include "old-school-zones/41.inc"
#include "old-school-zones/4.inc"
#include "old-school-zones/46.inc"
#include "old-school-zones/51.inc"
#include "old-school-zones/8.inc"
#include "old-school-zones/3.inc"
#include "old-school-zones/33.inc"
#include "old-school-zones/36.inc"
#include "old-school-zones/11.inc"
#include "old-school-zones/10.inc"
#include "old-school-zones/44.inc"
#include "old-school-zones/3525.inc"
#include "old-school-zones/3433.inc"
#include "old-school-zones/40.inc"
#include "old-school-zones/38.inc"
#include "old-school-zones/148.inc"
#include "old-school-zones/3524.inc"
#include "old-school-zones/3430.inc"
#include "old-school-zones/141.inc"
#include "old-school-zones/15.inc"
#include "old-school-zones/357.inc"
#include "old-school-zones/12.inc"
#include "old-school-zones/14.inc"
#include "old-school-zones/1.inc"
};

inline ZoneProfile const* FindZoneProfile(uint32 zone, uint32 entry)
{
    static auto const index = []
    {
        std::unordered_map<uint64, ZoneProfile const*> profiles;
        for (ZoneProfile const& profile : ZoneProfiles)
            profiles.emplace((uint64(profile.zone) << 32) | profile.entry, &profile);
        return profiles;
    }();
    auto const found = index.find((uint64(NormalizeZone(zone)) << 32) | entry);
    return found == index.end() ? nullptr : found->second;
}
}

#endif
