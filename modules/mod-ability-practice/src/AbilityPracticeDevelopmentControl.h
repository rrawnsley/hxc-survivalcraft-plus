#ifndef ABILITY_PRACTICE_DEVELOPMENT_CONTROL_H
#define ABILITY_PRACTICE_DEVELOPMENT_CONTROL_H

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeProfiles.h"

namespace AbilityPractice::DevelopmentControl
{
inline constexpr std::array StormAlert = {
    AbilityRank{ 707044, 1, { 8, 1 } }, AbilityRank{ 707905, 2, { 32, 10 } }
};
inline constexpr auto StormAlertCaps = Development::RankCaps(StormAlert);
inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 16, 707044, AbilityKind::Ranked, StormAlert, StormAlertCaps }, Development::Policy, OutcomeKind::Fear }
};

inline bool SupportsStun(AbilityProfile const& profile)
{
    return profile.Definition.Kind == AbilityKind::Ranked && profile.Outcome == OutcomeKind::Damage &&
        ((profile.Definition.ClassId == 12 && profile.Definition.AbilityId == 520523) ||
            (profile.Definition.ClassId == 18 && profile.Definition.AbilityId == 802197));
}

inline bool SupportsRoot(AbilityProfile const& profile)
{
    return profile.Definition.Kind == AbilityKind::Ranked && profile.Outcome == OutcomeKind::Damage &&
        profile.Definition.ClassId == 24 && profile.Definition.AbilityId == 805476;
}
}

#endif
