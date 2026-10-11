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
inline constexpr std::array ShrinkingJinx = {
    AbilityRank{ 806285, 1, { 8, 1 } }, AbilityRank{ 807829, 2, { 18, 10 } },
    AbilityRank{ 807830, 3, { 28, 20 } }, AbilityRank{ 807831, 4, { 38, 40 } },
    AbilityRank{ 807832, 5, { 48, 60 } }, AbilityRank{ 807833, 6, { 58, 80 } }
};
inline constexpr auto ShrinkingJinxCaps = Development::RankCaps(ShrinkingJinx);
inline constexpr std::array SermonOfDread = {
    AbilityRank{ 620610, 1, { 16, 1 } }, AbilityRank{ 620611, 2, { 24, 10 } },
    AbilityRank{ 620612, 3, { 34, 20 } }, AbilityRank{ 620613, 4, { 46, 40 } },
    AbilityRank{ 620614, 5, { 56, 60 } }
};
inline constexpr auto SermonOfDreadCaps = Development::RankCaps(SermonOfDread);
inline constexpr std::array EclipseOfFury = {
    AbilityRank{ 570217, 1, { 14, 1 } }, AbilityRank{ 570218, 2, { 24, 10 } },
    AbilityRank{ 570219, 3, { 34, 20 } }, AbilityRank{ 570220, 4, { 44, 40 } },
    AbilityRank{ 570221, 5, { 54, 60 } }
};
inline constexpr auto EclipseOfFuryCaps = Development::RankCaps(EclipseOfFury);
inline constexpr std::uint32_t BellowPracticeIntervalSeconds = 30;
inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 31, 704101, AbilityKind::Ranked, UrsocBellow, UrsocBellowCaps }, Development::Policy,
        OutcomeKind::AttackPowerReduction },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 16, 707044, AbilityKind::Ranked, StormAlert, StormAlertCaps }, Development::Policy, OutcomeKind::Fear },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 13, 806285, AbilityKind::Ranked, ShrinkingJinx, ShrinkingJinxCaps }, Development::Policy,
        OutcomeKind::AttackPowerReduction },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 25, 620610, AbilityKind::Ranked, SermonOfDread, SermonOfDreadCaps }, Development::Policy,
        OutcomeKind::AttackPowerReduction },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 26, 570217, AbilityKind::Ranked, EclipseOfFury, EclipseOfFuryCaps }, Development::Policy,
        OutcomeKind::AttackPowerReduction }
};

inline bool IsUrsocBellow(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 31 && profile.Definition.AbilityId == 704101 &&
        profile.Definition.Kind == AbilityKind::Ranked && profile.Outcome == OutcomeKind::AttackPowerReduction;
}

inline bool IsAscensionAttackPowerReduction(AbilityProfile const& profile)
{
    return profile.Definition.Kind == AbilityKind::Ranked && profile.Outcome == OutcomeKind::AttackPowerReduction &&
        ((profile.Definition.ClassId == 13 && profile.Definition.AbilityId == 806285) ||
            (profile.Definition.ClassId == 25 && profile.Definition.AbilityId == 620610) ||
            (profile.Definition.ClassId == 26 && profile.Definition.AbilityId == 570217));
}

inline bool IsAttackPowerReduction(AbilityProfile const& profile)
{
    return IsUrsocBellow(profile) || IsAscensionAttackPowerReduction(profile);
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
