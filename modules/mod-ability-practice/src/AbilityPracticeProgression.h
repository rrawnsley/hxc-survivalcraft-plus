#ifndef ABILITY_PRACTICE_PROGRESSION_H
#define ABILITY_PRACTICE_PROGRESSION_H

#include <algorithm>
#include <cstdint>
#include <limits>
#include <span>

namespace AbilityPractice
{
struct TrainingBand
{
    std::uint32_t FirstProficiency;
    std::uint32_t PointsPerLevel;
    std::uint32_t PointsPerUse;
};

struct TrainingPolicy
{
    std::span<TrainingBand const> Bands;
};

struct Progress
{
    std::uint32_t Proficiency = 1;
    std::uint64_t Points = 0;
};

enum class AwardStatus
{
    Invalid,
    Applied,
    Capped
};

struct Award
{
    AwardStatus Status = AwardStatus::Invalid;
    Progress State;
    std::uint32_t AwardedPoints = 0;
};

enum class ForecastStatus
{
    Invalid,
    Training,
    Complete,
    BeyondCap
};

struct Forecast
{
    ForecastStatus Status = ForecastStatus::Invalid;
    std::uint64_t Uses = 0;
};

struct Milestone
{
    std::uint32_t CharacterLevel;
    std::uint32_t Proficiency;
};

enum class MilestoneStatus
{
    Invalid,
    MissingPrerequisite,
    NeedsPractice,
    NeedsCharacterLevel,
    NeedsBoth,
    Ready
};

namespace Detail
{
inline std::size_t BandIndex(TrainingPolicy policy, std::uint32_t proficiency)
{
    auto const next = std::upper_bound(policy.Bands.begin(), policy.Bands.end(), proficiency,
        [](std::uint32_t value, TrainingBand const& band) { return value < band.FirstProficiency; });
    return static_cast<std::size_t>(next - policy.Bands.begin() - 1);
}

inline std::uint32_t BandEnd(TrainingPolicy policy, std::size_t index, std::uint32_t limit)
{
    return index + 1 < policy.Bands.size() ? std::min(limit, policy.Bands[index + 1].FirstProficiency) : limit;
}

inline void Normalize(TrainingPolicy policy, Progress& progress, std::uint32_t cap)
{
    while (progress.Proficiency < cap)
    {
        std::size_t const index = BandIndex(policy, progress.Proficiency);
        TrainingBand const& band = policy.Bands[index];
        std::uint64_t const available = progress.Points / band.PointsPerLevel;
        if (!available)
            return;

        std::uint32_t const end = BandEnd(policy, index, cap);
        std::uint32_t const levels = static_cast<std::uint32_t>(
            std::min(available, std::uint64_t(end - progress.Proficiency)));
        progress.Points -= std::uint64_t(levels) * band.PointsPerLevel;
        progress.Proficiency += levels;
    }
    progress.Points = 0;
}
}

inline bool ValidPolicy(TrainingPolicy policy)
{
    if (policy.Bands.empty() || policy.Bands.front().FirstProficiency != 1)
        return false;

    std::uint32_t previous = 0;
    for (TrainingBand const& band : policy.Bands)
    {
        if (band.FirstProficiency <= previous || !band.PointsPerLevel || !band.PointsPerUse)
            return false;
        previous = band.FirstProficiency;
    }
    return true;
}

inline bool ValidProgress(TrainingPolicy policy, Progress progress)
{
    return ValidPolicy(policy) && progress.Proficiency >= 1 &&
        progress.Points < policy.Bands[Detail::BandIndex(policy, progress.Proficiency)].PointsPerLevel;
}

inline Award ApplyQualifyingUse(TrainingPolicy policy, Progress progress, std::uint32_t cap)
{
    if (!cap || !ValidProgress(policy, progress))
        return { AwardStatus::Invalid, progress, 0 };
    if (progress.Proficiency >= cap)
        return { AwardStatus::Capped, progress, 0 };

    std::uint32_t const points = policy.Bands[Detail::BandIndex(policy, progress.Proficiency)].PointsPerUse;
    progress.Points += points;
    Detail::Normalize(policy, progress, cap);
    return { AwardStatus::Applied, progress, points };
}

inline Forecast UsesUntil(TrainingPolicy policy, Progress progress, std::uint32_t target, std::uint32_t cap)
{
    if (!cap || !target || !ValidProgress(policy, progress))
        return {};
    if (progress.Proficiency >= target)
        return { ForecastStatus::Complete, 0 };
    if (target > cap)
        return { ForecastStatus::BeyondCap, 0 };

    std::uint64_t uses = 0;
    while (progress.Proficiency < target)
    {
        std::size_t const index = Detail::BandIndex(policy, progress.Proficiency);
        TrainingBand const& band = policy.Bands[index];
        std::uint32_t const end = Detail::BandEnd(policy, index, target);
        std::uint64_t const remaining = std::uint64_t(end - progress.Proficiency) * band.PointsPerLevel -
            progress.Points;
        std::uint64_t const remainder = remaining % band.PointsPerUse;
        std::uint64_t const actions = remaining / band.PointsPerUse + (remainder != 0);
        if (actions > std::numeric_limits<std::uint64_t>::max() - uses)
            return {};

        uses += actions;
        progress.Proficiency = end;
        progress.Points = remainder ? band.PointsPerUse - remainder : 0;
        Detail::Normalize(policy, progress, cap);
    }
    return { ForecastStatus::Training, uses };
}

inline MilestoneStatus EvaluateMilestone(Milestone milestone, Progress progress, std::uint32_t characterLevel,
    bool prerequisitesMet)
{
    if (!milestone.CharacterLevel || !milestone.Proficiency || !progress.Proficiency || !characterLevel)
        return MilestoneStatus::Invalid;
    if (!prerequisitesMet)
        return MilestoneStatus::MissingPrerequisite;

    bool const levelMet = characterLevel >= milestone.CharacterLevel;
    bool const practiceMet = progress.Proficiency >= milestone.Proficiency;
    if (levelMet && practiceMet)
        return MilestoneStatus::Ready;
    if (practiceMet)
        return MilestoneStatus::NeedsCharacterLevel;
    return levelMet ? MilestoneStatus::NeedsPractice : MilestoneStatus::NeedsBoth;
}
}

#endif
