#ifndef COA_REALM_DAY_CYCLE_H
#define COA_REALM_DAY_CYCLE_H

#include "GameTime.h"
#include "Timer.h"
#include <ctime>

namespace AscensionRealmClock
{
inline constexpr uint32 RealDaySeconds = 2 * HOUR;
inline constexpr float GameSpeed = 0.2f;

inline uint32 TimeOfDaySeconds()
{
    int64 const now = GameTime::GetGameTime().count();
    return uint32((now % RealDaySeconds + RealDaySeconds) % RealDaySeconds) * 12;
}

inline uint32 Hour()
{
    return TimeOfDaySeconds() / HOUR;
}

inline time_t ClientTime()
{
    time_t const now = GameTime::GetGameTime().count();
    std::tm local = Acore::Time::TimeBreakdown(now);
    local.tm_hour = 0;
    local.tm_min = 0;
    local.tm_sec = 0;
    return std::mktime(&local) + TimeOfDaySeconds();
}

inline bool IsNight()
{
    uint32 const hour = Hour();
    return hour < 6 || hour >= 18;
}

inline bool IsDark()
{
    uint32 const hour = Hour();
    return hour < 6 || hour >= 20;
}
}

#endif
