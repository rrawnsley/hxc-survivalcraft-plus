// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_MASTERY_H
#define ABILITY_PRACTICE_DEVELOPMENT_MASTERY_H

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeProfiles.h"

namespace AbilityPractice::DevelopmentMastery
{
inline constexpr std::array HandOfElune = { AbilityRank{ 801990, 1, { 16, 1 } } };
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
inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 26, 801990, AbilityKind::Mastery, HandOfElune, Caps }, Development::Policy, OutcomeKind::Healing, Rewards }
};
}

#endif
