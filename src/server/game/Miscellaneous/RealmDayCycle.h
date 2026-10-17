#ifndef COA_REALM_DAY_CYCLE_H
#define COA_REALM_DAY_CYCLE_H

#include "GameTime.h"
#include "Timer.h"
#include <ctime>

namespace AscensionRealmClock
{
inline constexpr uint32 RealDaylightSeconds = 96 * MINUTE;
inline constexpr uint32 RealNightSeconds = 24 * MINUTE;
inline constexpr uint32 RealDaySeconds = RealDaylightSeconds + RealNightSeconds;

inline uint32 CycleSeconds()
{
    int64 const now = GameTime::GetGameTime().count();
    return uint32((now % RealDaySeconds + RealDaySeconds) % RealDaySeconds);
}

inline bool IsDaylight()
{
    return CycleSeconds() < RealDaylightSeconds;
}

inline float GameSpeed(bool daylight)
{
    float const gameHoursInMinutes = float(12 * HOUR / MINUTE);
    return daylight ? gameHoursInMinutes / RealDaylightSeconds
        : gameHoursInMinutes / RealNightSeconds;
}

inline float GameSpeed()
{
    return GameSpeed(IsDaylight());
}

inline uint32 TimeOfDaySeconds(uint32 cycleSeconds)
{
    uint32 const seconds = cycleSeconds % RealDaySeconds;
    return seconds < RealDaylightSeconds
        ? 6 * HOUR + uint32(uint64(seconds) * 12 * HOUR / RealDaylightSeconds)
        : (18 * HOUR + uint32(uint64(seconds - RealDaylightSeconds) * 12 * HOUR / RealNightSeconds)) % DAY;
}

inline uint32 TimeOfDaySeconds()
{
    return TimeOfDaySeconds(CycleSeconds());
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
