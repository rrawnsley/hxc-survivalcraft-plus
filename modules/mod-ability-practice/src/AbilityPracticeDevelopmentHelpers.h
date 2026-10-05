// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_HELPERS_H
#define ABILITY_PRACTICE_DEVELOPMENT_HELPERS_H

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeProfiles.h"

namespace AbilityPractice::DevelopmentHelpers
{
inline constexpr std::array Manafeed = {
    AbilityRank{ 552210, 1, { 24, 1 } },
    AbilityRank{ 552211, 2, { 36, 10 } },
    AbilityRank{ 552212, 3, { 44, 20 } },
    AbilityRank{ 552213, 4, { 56, 40 } }
};
inline constexpr auto Caps = Development::RankCaps(Manafeed);
inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 14, 552210, AbilityKind::Ranked, Manafeed, Caps }, Development::Policy, OutcomeKind::Healing }
};

inline bool IsManafeed(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 14 && profile.Definition.AbilityId == 552210 &&
        profile.Definition.Kind == AbilityKind::Ranked && profile.Outcome == OutcomeKind::Healing;
}
}

#endif
