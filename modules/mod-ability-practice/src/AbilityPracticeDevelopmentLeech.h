// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_LEECH_H
#define ABILITY_PRACTICE_DEVELOPMENT_LEECH_H

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeProfiles.h"

namespace AbilityPractice::DevelopmentLeech
{
inline constexpr std::array Bloodbolt = {
    AbilityRank{ 804685, 1, { 8, 1 } },
    AbilityRank{ 806928, 2, { 14, 10 } },
    AbilityRank{ 806929, 3, { 20, 20 } },
    AbilityRank{ 806930, 4, { 28, 40 } },
    AbilityRank{ 806931, 5, { 36, 60 } },
    AbilityRank{ 806932, 6, { 44, 80 } },
    AbilityRank{ 578304, 7, { 52, 100 } },
    AbilityRank{ 578305, 8, { 60, 120 } }
};
inline constexpr auto BloodboltCaps = Development::RankCaps(Bloodbolt);
inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 20, 804685, AbilityKind::Ranked, Bloodbolt, BloodboltCaps }, Development::Policy, OutcomeKind::Damage }
};

inline bool IsBloodbolt(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 20 && profile.Definition.AbilityId == 804685 &&
        profile.Definition.Kind == AbilityKind::Ranked && profile.Outcome == OutcomeKind::Damage;
}
}

#endif
