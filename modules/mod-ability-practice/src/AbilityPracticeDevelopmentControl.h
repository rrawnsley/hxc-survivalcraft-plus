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
inline constexpr std::array UrsocBellow = {
    AbilityRank{ 704101, 1, { 20, 1 } }, AbilityRank{ 707732, 2, { 26, 10 } },
    AbilityRank{ 707733, 3, { 32, 20 } }, AbilityRank{ 707734, 4, { 40, 40 } },
    AbilityRank{ 707735, 5, { 48, 60 } }
};
inline constexpr auto UrsocBellowCaps = Development::RankCaps(UrsocBellow);
inline constexpr std::uint32_t BellowPracticeIntervalSeconds = 30;
inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 31, 704101, AbilityKind::Ranked, UrsocBellow, UrsocBellowCaps }, Development::Policy,
        OutcomeKind::AttackPowerReduction },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 16, 707044, AbilityKind::Ranked, StormAlert, StormAlertCaps }, Development::Policy, OutcomeKind::Fear }
};

inline bool IsUrsocBellow(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 31 && profile.Definition.AbilityId == 704101 &&
        profile.Definition.Kind == AbilityKind::Ranked && profile.Outcome == OutcomeKind::AttackPowerReduction;
}

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
