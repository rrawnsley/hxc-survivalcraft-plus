#ifndef ABILITY_PRACTICE_DEVELOPMENT_TRAINER_FIXED_H
#define ABILITY_PRACTICE_DEVELOPMENT_TRAINER_FIXED_H

#include "AbilityPracticeDevelopment.h"

namespace AbilityPractice::DevelopmentTrainerFixed
{
inline constexpr std::array FelRiftOrgrimmar = { AbilityRank{ 535598, 1, { 26, 1 } } };
inline constexpr std::array FelRiftThunderBluff = { AbilityRank{ 535599, 1, { 30, 1 } } };
inline constexpr std::array FelRiftUndercity = { AbilityRank{ 535600, 1, { 36, 1 } } };

inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassTrainer,
        { 14, 535598, AbilityKind::Fixed, FelRiftOrgrimmar, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassTrainer,
        { 14, 535599, AbilityKind::Fixed, FelRiftThunderBluff, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassTrainer,
        { 14, 535600, AbilityKind::Fixed, FelRiftUndercity, {} }, Development::Policy, OutcomeKind::None }
};
}

#endif
