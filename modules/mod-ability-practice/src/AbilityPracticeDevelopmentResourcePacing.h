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
inline constexpr std::array EmberSpenders = { 800792U, 801915U, 805500U };

struct Entry
{
    AbilityProfile Previous;
    std::vector<TrainingBand> Bands;
};

inline bool Supports(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 24 &&
        std::find(EmberSpenders.begin(), EmberSpenders.end(), profile.Definition.AbilityId) != EmberSpenders.end();
}

inline std::optional<Entry> Build(AbilityProfile const& profile)
{
    if (!Supports(profile) || profile.DefinitionVersion != 4 ||
        profile.Definition.Kind != AbilityKind::Ranked || !ValidPolicy(profile.Policy))
        return std::nullopt;
    Entry result{ profile, { profile.Policy.Bands.begin(), profile.Policy.Bands.end() } };
    for (auto& band : result.Bands)
    {
        if (band.PointsPerUse > std::numeric_limits<std::uint32_t>::max() / 5)
            return std::nullopt;
        band.PointsPerUse *= 5;
    }
    if (!ValidPolicy({ result.Bands }))
        return std::nullopt;
    return result;
}
}

#endif
