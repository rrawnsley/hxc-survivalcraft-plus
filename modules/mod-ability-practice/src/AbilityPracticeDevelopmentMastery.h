// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_MASTERY_H
#define ABILITY_PRACTICE_DEVELOPMENT_MASTERY_H

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeProfiles.h"

namespace AbilityPractice::DevelopmentMastery
{
inline constexpr std::array HandOfElune = { AbilityRank{ 801990, 1, { 16, 1 } } };
inline constexpr std::array VileSting = { AbilityRank{ 805097, 1, { 12, 1 } } };
inline constexpr std::array Soulslam = { AbilityRank{ 504014, 1, { 20, 1 } } };
inline constexpr auto Caps = []
{
    auto result = Development::Caps;
    for (ProficiencyCap& cap : result)
        cap.Proficiency = std::min(cap.Proficiency, std::uint32_t{ 100 });
    return result;
}();
inline constexpr std::array Rewards = {
    MasteryReward{ { 16, 40 }, 50 },
    MasteryReward{ { 24, 70 }, 100 },
    MasteryReward{ { 32, 100 }, 200 }
};
inline constexpr std::array VileStingRewards = {
    MasteryReward{ { 12, 40 }, 0, 50 },
    MasteryReward{ { 20, 70 }, 0, 100 },
    MasteryReward{ { 28, 100 }, 0, 200 }
};
inline constexpr std::array SoulslamRewards = {
    MasteryReward{ { 20, 40 }, 0, 50 },
    MasteryReward{ { 28, 70 }, 0, 100 },
    MasteryReward{ { 36, 100 }, 0, 200 }
};
inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 26, 801990, AbilityKind::Mastery, HandOfElune, Caps }, Development::Policy, OutcomeKind::Healing, Rewards },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 29, 805097, AbilityKind::Mastery, VileSting, Caps }, Development::Policy, OutcomeKind::Damage,
        VileStingRewards },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 30, 504014, AbilityKind::Mastery, Soulslam, Caps }, Development::Policy, OutcomeKind::Damage, SoulslamRewards }
};
}

#endif
