// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_CONJURE_FIXED_H
#define ABILITY_PRACTICE_DEVELOPMENT_CONJURE_FIXED_H

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeProfiles.h"

namespace AbilityPractice::DevelopmentConjureFixed
{
inline constexpr std::array RejuvenatingMojo = {
    AbilityRank{ 572747, 1, { 12, 1 } },
    AbilityRank{ 572322, 2, { 22, 1 } },
    AbilityRank{ 572324, 3, { 34, 1 } },
    AbilityRank{ 572326, 4, { 46, 1 } },
    AbilityRank{ 572415, 5, { 58, 1 } }
};

inline constexpr std::array BrewStew = {
    AbilityRank{ 807050, 1, { 6, 1 } },
    AbilityRank{ 807051, 2, { 10, 1 } },
    AbilityRank{ 807052, 3, { 20, 1 } },
    AbilityRank{ 807053, 4, { 30, 1 } },
    AbilityRank{ 807054, 5, { 40, 1 } },
    AbilityRank{ 807055, 6, { 50, 1 } },
    AbilityRank{ 807056, 7, { 58, 1 } }
};

inline constexpr std::array BrewCocktail = {
    AbilityRank{ 807070, 1, { 4, 1 } },
    AbilityRank{ 807071, 2, { 10, 1 } },
    AbilityRank{ 807072, 3, { 16, 1 } },
    AbilityRank{ 807073, 4, { 26, 1 } },
    AbilityRank{ 807074, 5, { 36, 1 } },
    AbilityRank{ 807075, 6, { 46, 1 } },
    AbilityRank{ 807076, 7, { 56, 1 } }
};

inline constexpr std::array ThunderAle = {
    AbilityRank{ 804763, 1, { 8, 1 } },
    AbilityRank{ 808068, 2, { 12, 1 } },
    AbilityRank{ 808069, 3, { 22, 1 } },
    AbilityRank{ 808070, 4, { 32, 1 } },
    AbilityRank{ 808071, 5, { 42, 1 } },
    AbilityRank{ 808072, 6, { 52, 1 } },
    AbilityRank{ 808073, 7, { 60, 1 } }
};

inline constexpr std::array BoneReliquary = {
    AbilityRank{ 803766, 1, { 16, 1 } },
    AbilityRank{ 803768, 2, { 26, 1 } },
    AbilityRank{ 803769, 3, { 36, 1 } },
    AbilityRank{ 803770, 4, { 46, 1 } },
    AbilityRank{ 803771, 5, { 56, 1 } }
};

inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 13, 572747, AbilityKind::Fixed, RejuvenatingMojo, {} },
        Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 13, 807050, AbilityKind::Fixed, BrewStew, {} },
        Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 13, 807070, AbilityKind::Fixed, BrewCocktail, {} },
        Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 16, 804763, AbilityKind::Fixed, ThunderAle, {} },
        Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 23, 803766, AbilityKind::Fixed, BoneReliquary, {} },
        Development::Policy, OutcomeKind::None }
};
}

#endif
