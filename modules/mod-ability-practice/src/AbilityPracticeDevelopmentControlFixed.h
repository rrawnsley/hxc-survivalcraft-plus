// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_CONTROL_FIXED_H
#define ABILITY_PRACTICE_DEVELOPMENT_CONTROL_FIXED_H

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeProfiles.h"

namespace AbilityPractice::DevelopmentControlFixed
{
inline constexpr std::uint32_t NativeUtilityDefinitionVersion = 3;
inline constexpr std::array SeismicGrasp = { AbilityRank{ 807432, 1, { 8, 1 } } };
inline constexpr std::array GazeOfTheradras = { AbilityRank{ 805919, 1, { 12, 1 } } };
inline constexpr std::array EnslaveElemental = { AbilityRank{ 954534, 1, { 20, 1 } } };
inline constexpr std::array ControlMechanical = { AbilityRank{ 807846, 1, { 24, 1 } } };
inline constexpr std::array VileSting = { AbilityRank{ 805097, 1, { 12, 1 } } };
inline constexpr std::array Class13Ability803325 = { AbilityRank{ 803325, 1, { 22, 1 } } };
inline constexpr std::array Class15Ability802826 = { AbilityRank{ 802826, 1, { 40, 1 } } };
inline constexpr std::array Class16Ability654545 = { AbilityRank{ 654545, 1, { 24, 1 } } };
inline constexpr std::array Class17Ability801067 = { AbilityRank{ 801067, 1, { 34, 1 } } };
inline constexpr std::array Class19Ability560963 = { AbilityRank{ 560963, 1, { 24, 1 } } };
inline constexpr std::array Class21Ability557333 = { AbilityRank{ 557333, 1, { 24, 1 } } };
inline constexpr std::array Class21Ability520568 = { AbilityRank{ 520568, 1, { 12, 1 } } };
inline constexpr std::array Class23Ability500341 = { AbilityRank{ 500341, 1, { 34, 1 } } };
inline constexpr std::array Class23Ability800706 = { AbilityRank{ 800706, 1, { 20, 1 } } };
inline constexpr std::array Class29Ability504335 = { AbilityRank{ 504335, 1, { 16, 1 } } };
inline constexpr std::array Class29Ability804970 = { AbilityRank{ 804970, 1, { 8, 1 } } };
inline constexpr std::array Class30Ability803989 = { AbilityRank{ 803989, 1, { 8, 1 } } };
inline constexpr std::array Class32Ability524930 = { AbilityRank{ 524930, 1, { 12, 1 } } };
inline constexpr std::array Class32Ability807822 = { AbilityRank{ 807822, 1, { 8, 1 } } };

inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 31, 807432, AbilityKind::Fixed, SeismicGrasp, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 31, 805919, AbilityKind::Fixed, GazeOfTheradras, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 14, 954534, AbilityKind::Fixed, EnslaveElemental, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 28, 807846, AbilityKind::Fixed, ControlMechanical, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ NativeUtilityDefinitionVersion, AcquisitionSource::ClassGrant,
        { 29, 805097, AbilityKind::Fixed, VileSting, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 13, 803325, AbilityKind::Fixed, Class13Ability803325, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 15, 802826, AbilityKind::Fixed, Class15Ability802826, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 16, 654545, AbilityKind::Fixed, Class16Ability654545, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 17, 801067, AbilityKind::Fixed, Class17Ability801067, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 19, 560963, AbilityKind::Fixed, Class19Ability560963, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 21, 557333, AbilityKind::Fixed, Class21Ability557333, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 21, 520568, AbilityKind::Fixed, Class21Ability520568, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 23, 500341, AbilityKind::Fixed, Class23Ability500341, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 23, 800706, AbilityKind::Fixed, Class23Ability800706, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 29, 504335, AbilityKind::Fixed, Class29Ability504335, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 29, 804970, AbilityKind::Fixed, Class29Ability804970, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 30, 803989, AbilityKind::Fixed, Class30Ability803989, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 32, 524930, AbilityKind::Fixed, Class32Ability524930, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 32, 807822, AbilityKind::Fixed, Class32Ability807822, {} }, Development::Policy, OutcomeKind::None }
};

struct Mechanic
{
    std::uint32_t ClassId;
    std::uint32_t SpellId;
    std::array<std::uint32_t, 3> EffectIds;
    std::array<std::uint32_t, 3> AuraIds;
    std::array<std::uint32_t, 3> TargetAIds;
    std::array<std::uint32_t, 3> TargetBIds;
    std::array<std::uint32_t, 3> TriggerSpellIds = {};
};

inline constexpr std::array Mechanics = {
    Mechanic{ 31, 807432, { 6, 6, 0 }, { 33, 77, 0 }, { 6, 6, 0 }, {} },
    Mechanic{ 31, 805919, { 114, 6, 0 }, { 0, 11, 0 }, { 6, 6, 0 }, {} },
    Mechanic{ 14, 954534, { 6, 0, 0 }, { 6, 0, 0 }, { 6, 0, 0 }, {} },
    Mechanic{ 28, 807846, { 6, 6, 6 }, { 6, 192, 89 }, { 6, 6, 6 }, { 0, 0, 0 } },
    Mechanic{ 29, 805097, { 114, 6, 2 }, { 0, 11, 0 }, { 6, 6, 6 }, { 0, 0, 0 } },
    Mechanic{ 13, 803325, { 6, 6, 0 }, { 7, 31, 0 }, { 6, 6, 0 }, { 0, 0, 0 } },
    Mechanic{ 15, 802826, { 6, 6, 0 }, { 12, 118, 0 }, { 22, 22, 0 }, { 15, 15, 0 } },
    Mechanic{ 16, 654545, { 6, 6, 0 }, { 12, 40, 0 }, { 6, 6, 0 }, { 0, 0, 0 } },
    Mechanic{ 17, 801067, { 6, 6, 6 }, { 12, 118, 39 }, { 6, 6, 6 }, { 0, 0, 0 } },
    Mechanic{ 19, 560963, { 6, 6, 0 }, { 12, 40, 0 }, { 6, 6, 0 }, { 0, 0, 0 } },
    Mechanic{ 21, 557333, { 5, 6, 0 }, { 0, 12, 0 }, { 1, 6, 0 }, { 65, 0, 0 } },
    Mechanic{ 21, 520568, { 3, 6, 0 }, { 0, 12, 0 }, { 6, 6, 0 }, { 0, 0, 0 } },
    Mechanic{ 23, 500341, { 6, 6, 6 }, { 12, 118, 40 }, { 6, 6, 6 }, { 0, 0, 0 } },
    Mechanic{ 23, 800706, { 6, 6, 0 }, { 7, 56, 0 }, { 6, 6, 0 }, { 0, 0, 0 } },
    Mechanic{ 29, 504335, { 6, 6, 0 }, { 12, 56, 0 }, { 6, 6, 0 }, { 0, 0, 0 } },
    Mechanic{ 29, 804970, { 6, 0, 0 }, { 7, 0, 0 }, { 22, 0, 0 }, { 15, 0, 0 } },
    Mechanic{ 30, 803989, { 6, 6, 6 }, { 12, 271, 4 }, { 6, 6, 6 }, { 0, 0, 0 }, { 0, 0, 801260 } },
    Mechanic{ 32, 524930, { 6, 6, 6 }, { 12, 271, 271 }, { 6, 6, 6 }, { 0, 0, 0 } },
    Mechanic{ 32, 807822, { 6, 0, 0 }, { 26, 0, 0 }, { 6, 0, 0 }, { 0, 0, 0 } }
};
}

#endif
