// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_FIXED_H
#define ABILITY_PRACTICE_DEVELOPMENT_FIXED_H

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeProfiles.h"

namespace AbilityPractice::DevelopmentFixed
{
inline constexpr std::array SpiritualRecall = { AbilityRank{ 583092, 1, { 20, 1 } } };
inline constexpr std::array CavernsTeleport = { AbilityRank{ 804753, 1, { 40, 1 } } };
inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 13, 583092, AbilityKind::Fixed, SpiritualRecall, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 22, 804753, AbilityKind::Fixed, CavernsTeleport, {} }, Development::Policy, OutcomeKind::None }
};
}

#endif
