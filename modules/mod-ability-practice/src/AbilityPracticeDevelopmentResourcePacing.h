#ifndef ABILITY_PRACTICE_DEVELOPMENT_RESOURCE_PACING_H
#define ABILITY_PRACTICE_DEVELOPMENT_RESOURCE_PACING_H

#include "AbilityPracticeProfiles.h"

#include <algorithm>
#include <array>
#include <limits>
#include <optional>
#include <vector>

namespace AbilityPractice::DevelopmentResourcePacing
{
inline constexpr std::uint32_t DefinitionVersion = 5;
struct Adjustment
{
    std::uint32_t ClassId;
    std::uint32_t AbilityId;
    std::uint32_t Multiplier;
};
inline constexpr std::array Adjustments = {
    Adjustment{ 24, 800792, 5 },
    Adjustment{ 24, 801915, 5 },
    Adjustment{ 24, 805500, 5 },
    Adjustment{ 16, 500038, 2 },
    Adjustment{ 16, 500040, 3 },
    Adjustment{ 16, 800227, 3 },
    Adjustment{ 14, 802060, 2 },
    Adjustment{ 17, 800168, 2 },
    Adjustment{ 17, 801059, 2 },
    Adjustment{ 19, 801448, 2 },
    Adjustment{ 19, 803157, 2 },
    Adjustment{ 21, 500073, 2 },
    Adjustment{ 21, 802036, 2 },
    Adjustment{ 30, 573316, 9 },
    Adjustment{ 25, 804152, 4 },
    Adjustment{ 25, 805116, 4 }
};

struct Entry
{
    AbilityProfile Previous;
    std::vector<TrainingBand> Bands;
};

inline std::uint32_t Multiplier(AbilityProfile const& profile)
{
    for (auto const& value : Adjustments)
        if (value.ClassId == profile.Definition.ClassId && value.AbilityId == profile.Definition.AbilityId)
            return value.Multiplier;
    return 0;
}

inline bool Supports(AbilityProfile const& profile)
{
    return Multiplier(profile) != 0;
}

inline std::optional<Entry> Build(AbilityProfile const& profile)
{
    if (!Supports(profile) || profile.DefinitionVersion != 4 ||
        profile.Definition.Kind != AbilityKind::Ranked || !ValidPolicy(profile.Policy))
        return std::nullopt;
    auto const multiplier = Multiplier(profile);
    Entry result{ profile, { profile.Policy.Bands.begin(), profile.Policy.Bands.end() } };
    for (auto& band : result.Bands)
    {
        if (band.PointsPerUse > std::numeric_limits<std::uint32_t>::max() / multiplier)
            return std::nullopt;
        band.PointsPerUse *= multiplier;
    }
    if (!ValidPolicy({ result.Bands }))
        return std::nullopt;
    return result;
}
}

#endif
