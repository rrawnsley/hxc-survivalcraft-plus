#ifndef ABILITY_PRACTICE_DEVELOPMENT_ABSORPTION_H
#define ABILITY_PRACTICE_DEVELOPMENT_ABSORPTION_H

#include "AbilityPracticeDevelopmentRanked.h"

namespace AbilityPractice::DevelopmentAbsorption
{
inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 29, 800926, AbilityKind::Ranked, DevelopmentRanked::RanksClass29Ability800926,
            DevelopmentRanked::CapsClass29Ability800926 }, Development::Policy, OutcomeKind::Healing }
};

inline bool IsEmeraldVeil(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 29 && profile.Definition.AbilityId == 800926 &&
        profile.Definition.Kind == AbilityKind::Ranked && profile.Outcome == OutcomeKind::Healing;
}
}

#endif
