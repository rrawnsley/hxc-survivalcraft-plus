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
inline constexpr std::array RavenousStrike = {
    AbilityRank{ 500123, 1, { 6, 1 } },
    AbilityRank{ 501671, 2, { 12, 10 } },
    AbilityRank{ 501672, 3, { 18, 20 } },
    AbilityRank{ 501673, 4, { 24, 40 } },
    AbilityRank{ 501674, 5, { 30, 60 } },
    AbilityRank{ 501675, 6, { 36, 80 } },
    AbilityRank{ 501676, 7, { 42, 100 } },
    AbilityRank{ 501677, 8, { 48, 120 } },
    AbilityRank{ 501678, 9, { 54, 140 } },
    AbilityRank{ 501679, 10, { 60, 160 } }
};
inline constexpr auto RavenousStrikeCaps = Development::RankCaps(RavenousStrike);
inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 20, 804685, AbilityKind::Ranked, Bloodbolt, BloodboltCaps }, Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 20, 500123, AbilityKind::Ranked, RavenousStrike, RavenousStrikeCaps },
        Development::Policy, OutcomeKind::Damage }
};

inline bool IsBloodbolt(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 20 && profile.Definition.AbilityId == 804685 &&
        profile.Definition.Kind == AbilityKind::Ranked && profile.Outcome == OutcomeKind::Damage;
}

inline bool IsRavenousStrike(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 20 && profile.Definition.AbilityId == 500123 &&
        profile.Definition.Kind == AbilityKind::Ranked && profile.Outcome == OutcomeKind::Damage;
}
}

#endif
