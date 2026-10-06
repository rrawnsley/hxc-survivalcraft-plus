// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_UTILITY_FIXED_H
#define ABILITY_PRACTICE_DEVELOPMENT_UTILITY_FIXED_H

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeProfiles.h"

namespace AbilityPractice::DevelopmentUtilityFixed
{
inline constexpr std::array Class13Ability806240 = { AbilityRank{ 806240, 1, { 16, 1 } } };
inline constexpr std::array Class14Ability800353 = { AbilityRank{ 800353, 1, { 22, 1 } } };
inline constexpr std::array Class14Ability804052 = { AbilityRank{ 804052, 1, { 16, 1 } } };
inline constexpr std::array Class15Ability572306 = { AbilityRank{ 572306, 1, { 40, 1 } } };
inline constexpr std::array Class15Ability804432 = { AbilityRank{ 804432, 1, { 18, 1 } } };
inline constexpr std::array Class16Ability500932 = { AbilityRank{ 500932, 1, { 16, 1 } } };
inline constexpr std::array Class16Ability572303 = { AbilityRank{ 572303, 1, { 40, 1 } } };
inline constexpr std::array Class16Ability705669 = { AbilityRank{ 705669, 1, { 20, 1 } } };
inline constexpr std::array Class19Ability525051 = { AbilityRank{ 525051, 1, { 16, 1 } } };
inline constexpr std::array Class22Ability510236 = { AbilityRank{ 510236, 1, { 26, 1 } } };
inline constexpr std::array Class24Ability800808 = { AbilityRank{ 800808, 1, { 24, 1 } } };
inline constexpr std::array Class25Ability520151 = { AbilityRank{ 520151, 1, { 26, 1 } } };
inline constexpr std::array Class26Ability520869 = { AbilityRank{ 520869, 1, { 16, 1 } } };
inline constexpr std::array Class27Ability524968 = { AbilityRank{ 524968, 1, { 14, 1 } } };
inline constexpr std::array Class29Ability805096 = { AbilityRank{ 805096, 1, { 22, 1 } } };
inline constexpr std::array Class30Ability520862 = { AbilityRank{ 520862, 1, { 14, 1 } } };
inline constexpr std::array Class31Ability520841 = { AbilityRank{ 520841, 1, { 22, 1 } } };
inline constexpr std::array Class32Ability520269 = { AbilityRank{ 520269, 1, { 22, 1 } } };
inline constexpr std::array Class32Ability800995 = { AbilityRank{ 800995, 1, { 18, 1 } } };
inline constexpr std::array Class32Ability803679 = { AbilityRank{ 803679, 1, { 28, 1 } } };

inline constexpr std::array Myotoxin = { AbilityRank{ 572304, 1, { 40, 1 } } };
inline constexpr std::array Antivenom = { AbilityRank{ 800905, 1, { 16, 1 } } };

inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 13, 806240, AbilityKind::Fixed, Class13Ability806240, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 14, 800353, AbilityKind::Fixed, Class14Ability800353, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 14, 804052, AbilityKind::Fixed, Class14Ability804052, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 15, 572306, AbilityKind::Fixed, Class15Ability572306, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 15, 804432, AbilityKind::Fixed, Class15Ability804432, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 16, 500932, AbilityKind::Fixed, Class16Ability500932, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 16, 572303, AbilityKind::Fixed, Class16Ability572303, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 16, 705669, AbilityKind::Fixed, Class16Ability705669, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 19, 525051, AbilityKind::Fixed, Class19Ability525051, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 22, 510236, AbilityKind::Fixed, Class22Ability510236, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 24, 800808, AbilityKind::Fixed, Class24Ability800808, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 25, 520151, AbilityKind::Fixed, Class25Ability520151, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 26, 520869, AbilityKind::Fixed, Class26Ability520869, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 27, 524968, AbilityKind::Fixed, Class27Ability524968, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 29, 805096, AbilityKind::Fixed, Class29Ability805096, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 30, 520862, AbilityKind::Fixed, Class30Ability520862, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 31, 520841, AbilityKind::Fixed, Class31Ability520841, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 32, 520269, AbilityKind::Fixed, Class32Ability520269, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 32, 800995, AbilityKind::Fixed, Class32Ability800995, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 32, 803679, AbilityKind::Fixed, Class32Ability803679, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 29, 572304, AbilityKind::Fixed, Myotoxin, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 29, 800905, AbilityKind::Fixed, Antivenom, {} }, Development::Policy, OutcomeKind::None }
};

struct Mechanic
{
    std::uint32_t ClassId;
    std::uint32_t SpellId;
    std::array<std::uint32_t, 3> EffectIds;
    std::array<std::uint32_t, 3> TargetAIds;
    std::array<std::uint32_t, 3> TargetBIds;
    std::array<std::uint32_t, 3> AuraIds = {};
    std::array<std::uint32_t, 3> TriggerSpellIds = {};
};

inline constexpr std::array Mechanics = {
    Mechanic{ 13, 806240, { 38, 0, 0 }, { 21, 0, 0 }, { 0, 0, 0 } },
    Mechanic{ 14, 800353, { 126, 0, 0 }, { 6, 0, 0 }, { 0, 0, 0 } },
    Mechanic{ 14, 804052, { 38, 38, 0 }, { 22, 22, 0 }, { 15, 15, 0 } },
    Mechanic{ 15, 572306, { 38, 0, 0 }, { 6, 0, 0 }, { 0, 0, 0 } },
    Mechanic{ 15, 804432, { 68, 0, 0 }, { 6, 0, 0 }, { 0, 0, 0 } },
    Mechanic{ 16, 500932, { 68, 98, 0 }, { 24, 24, 0 }, { 0, 0, 0 } },
    Mechanic{ 16, 572303, { 38, 0, 0 }, { 6, 0, 0 }, { 0, 0, 0 } },
    Mechanic{ 16, 705669, { 38, 0, 0 }, { 6, 0, 0 }, { 0, 0, 0 } },
    Mechanic{ 19, 525051, { 38, 38, 38 }, { 21, 21, 21 }, { 0, 0, 0 } },
    Mechanic{ 22, 510236, { 68, 0, 0 }, { 6, 0, 0 }, { 0, 0, 0 } },
    Mechanic{ 24, 800808, { 68, 0, 0 }, { 6, 0, 0 }, { 0, 0, 0 } },
    Mechanic{ 25, 520151, { 38, 0, 0 }, { 21, 0, 0 }, { 0, 0, 0 } },
    Mechanic{ 26, 520869, { 38, 38, 0 }, { 21, 21, 0 }, { 0, 0, 0 } },
    Mechanic{ 27, 524968, { 38, 38, 38 }, { 21, 21, 21 }, { 0, 0, 0 } },
    Mechanic{ 29, 805096, { 68, 0, 0 }, { 6, 0, 0 }, { 0, 0, 0 } },
    Mechanic{ 30, 520862, { 38, 0, 0 }, { 6, 0, 0 }, { 0, 0, 0 } },
    Mechanic{ 31, 520841, { 38, 38, 0 }, { 21, 21, 0 }, { 0, 0, 0 } },
    Mechanic{ 32, 520269, { 126, 0, 0 }, { 6, 0, 0 }, { 0, 0, 0 } },
    Mechanic{ 32, 800995, { 68, 0, 0 }, { 6, 0, 0 }, { 0, 0, 0 } },
    Mechanic{ 32, 803679, { 38, 38, 0 }, { 16, 31, 0 }, { 0, 0, 0 } },
    Mechanic{ 29, 572304, { 38, 6, 0 }, { 6, 6, 0 }, {}, { 0, 23, 0 }, { 0, 572407, 0 } },
    Mechanic{ 29, 800905, { 6, 38, 0 }, { 21, 21, 0 }, {}, { 23, 0, 0 }, { 803680, 0, 0 } }
};

struct HelperMechanic
{
    std::uint32_t SpellId;
    std::array<std::uint32_t, 3> EffectIds;
    std::array<std::uint32_t, 3> TargetAIds;
};

inline constexpr std::array Helpers = {
    HelperMechanic{ 572407, { 38, 0, 0 }, { 6, 0, 0 } },
    HelperMechanic{ 803680, { 38, 38, 0 }, { 21, 21, 0 } }
};
}

#endif
