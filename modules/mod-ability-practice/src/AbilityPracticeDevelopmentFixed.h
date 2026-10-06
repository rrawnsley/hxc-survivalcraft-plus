// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_FIXED_H
#define ABILITY_PRACTICE_DEVELOPMENT_FIXED_H

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeProfiles.h"

namespace AbilityPractice::DevelopmentFixed
{
inline constexpr std::array SpiritualRecall = { AbilityRank{ 583092, 1, { 20, 1 } } };
inline constexpr std::array CavernsTeleport = { AbilityRank{ 804753, 1, { 40, 1 } } };
inline constexpr std::array SpiritualAscension = {
    AbilityRank{ 500688, 1, { 20, 1 } }, AbilityRank{ 500757, 2, { 50, 1 } },
    AbilityRank{ 500758, 3, { 60, 1 } }, AbilityRank{ 500759, 4, { 70, 1 } },
    AbilityRank{ 500760, 5, { 80, 1 } }
};
inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 13, 583092, AbilityKind::Fixed, SpiritualRecall, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 22, 804753, AbilityKind::Fixed, CavernsTeleport, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 19, 500688, AbilityKind::Fixed, SpiritualAscension, {} }, Development::Policy, OutcomeKind::None }
};
}

#endif
