#ifndef ABILITY_PRACTICE_CATCHUP_H
#define ABILITY_PRACTICE_CATCHUP_H

#include "AbilityPracticeProgression.h"

#include <array>
#include <optional>

namespace AbilityPractice
{
struct CatchupSettings
{
    bool Enabled = false;
    std::uint32_t Gap = 40;
    std::uint32_t Multiplier = 2;
};

struct EffectiveTrainingPolicy
{
    TrainingPolicy Original;
    std::array<TrainingBand, 9> Bands{};
    std::size_t Count = 0;

    TrainingPolicy View() const & { return Count ? TrainingPolicy{ { Bands.data(), Count } } : Original; }
    TrainingPolicy View() const && = delete;
};

inline bool ValidCatchupSettings(CatchupSettings settings)
{
    return !settings.Enabled || (settings.Gap >= 1 && settings.Gap <= 500 &&
        settings.Multiplier >= 2 && settings.Multiplier <= 4);
}

inline std::optional<EffectiveTrainingPolicy> BuildCatchupPolicy(TrainingPolicy original,
    std::uint32_t cap, CatchupSettings settings)
{
    if (!ValidPolicy(original) || !ValidCatchupSettings(settings))
        return std::nullopt;
    EffectiveTrainingPolicy result{ original };
    if (!settings.Enabled || cap <= settings.Gap)
        return result;
    if (original.Bands.size() > result.Bands.size() - 1)
        return std::nullopt;
    std::uint32_t const cutoff = cap - settings.Gap + 1;
    for (std::size_t index = 0; index < original.Bands.size(); ++index)
    {
        TrainingBand band = original.Bands[index];
        if (band.FirstProficiency < cutoff)
        {
            std::uint64_t const points = std::uint64_t(band.PointsPerUse) * settings.Multiplier;
            if (points > std::numeric_limits<std::uint32_t>::max())
                return std::nullopt;
            band.PointsPerUse = static_cast<std::uint32_t>(points);
        }
        result.Bands[result.Count++] = band;
        if (band.FirstProficiency < cutoff && (index + 1 == original.Bands.size() ||
            cutoff < original.Bands[index + 1].FirstProficiency))
        {
            band = original.Bands[index];
            band.FirstProficiency = cutoff;
            result.Bands[result.Count++] = band;
        }
    }
    return result;
}
}

#endif
