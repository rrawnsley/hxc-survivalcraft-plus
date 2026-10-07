// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_PASSIVE_FIXED_H
#define ABILITY_PRACTICE_DEVELOPMENT_PASSIVE_FIXED_H

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeProfiles.h"

#include <optional>

namespace AbilityPractice::DevelopmentPassiveFixed
{
inline constexpr std::array BarbaricRage = { AbilityRank{ 804337, 1, { 2, 1 } } };
inline constexpr std::array FelFinesse = { AbilityRank{ 520591, 1, { 20, 1 } } };
inline constexpr std::array Bloodrider = { AbilityRank{ 704964, 1, { 50, 1 } } };
inline constexpr std::array DiscipleOfShadra = { AbilityRank{ 503907, 1, { 10, 1 } } };
inline constexpr std::array SpiritWalker = { AbilityRank{ 561082, 1, { 14, 1 } } };
inline constexpr std::array ImprovedGhostForm = { AbilityRank{ 807084, 1, { 40, 1 } } };
inline constexpr std::array DemonsBlood = { AbilityRank{ 804345, 1, { 6, 1 } } };
inline constexpr std::array Triumphant = { AbilityRank{ 707372, 1, { 12, 1 } } };
inline constexpr std::array ScourgeApprenticeTraining = { AbilityRank{ 680283, 1, { 10, 1 } } };
inline constexpr std::array Necromancy = { AbilityRank{ 804360, 1, { 1, 1 } } };
inline constexpr std::array MushasBlessing = { AbilityRank{ 800292, 1, { 12, 1 } } };
inline constexpr std::array ShadrasBoon = { AbilityRank{ 681443, 1, { 50, 1 } } };
inline constexpr std::array SoulCollector = { AbilityRank{ 706731, 1, { 1, 1 } } };

inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 12, 804337, AbilityKind::Fixed, BarbaricRage, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 14, 520591, AbilityKind::Fixed, FelFinesse, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 17, 704964, AbilityKind::Fixed, Bloodrider, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 29, 503907, AbilityKind::Fixed, DiscipleOfShadra, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 30, 561082, AbilityKind::Fixed, SpiritWalker, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 30, 807084, AbilityKind::Fixed, ImprovedGhostForm, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 17, 804345, AbilityKind::Fixed, DemonsBlood, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 18, 707372, AbilityKind::Fixed, Triumphant, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 23, 680283, AbilityKind::Fixed, ScourgeApprenticeTraining, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 23, 804360, AbilityKind::Fixed, Necromancy, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 26, 800292, AbilityKind::Fixed, MushasBlessing, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 29, 681443, AbilityKind::Fixed, ShadrasBoon, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 30, 706731, AbilityKind::Fixed, SoulCollector, {} }, Development::Policy, OutcomeKind::None }
};

struct Mechanic
{
    std::uint32_t ClassId;
    std::uint32_t SpellId;
    std::array<std::uint32_t, 3> AuraIds;
    std::array<std::uint32_t, 3> EffectIds = { 6, 0, 0 };
    std::array<std::uint32_t, 3> TriggerSpellIds = {};
    std::array<std::uint32_t, 3> TargetAIds = { 1, 0, 0 };
    std::uint32_t RequiredSpellFamily = 0;
    std::optional<std::array<std::uint32_t, 3>> EffectiveAuraIds{};
    std::optional<std::array<std::uint32_t, 3>> EffectiveTriggerSpellIds{};
};

inline constexpr std::array Mechanics = {
    Mechanic{ 12, 804337, { 107, 0, 0 } },
    Mechanic{ 14, 520591, { 144, 0, 0 } },
    Mechanic{ 17, 704964, { 108, 108, 0 }, { 6, 6, 0 }, {}, { 1, 1, 0 } },
    Mechanic{ 29, 503907, { 4, 0, 0 } },
    Mechanic{ 30, 561082, { 4, 0, 0 } },
    Mechanic{ 30, 807084, { 107, 0, 0 } },
    Mechanic{ 17, 804345, { 4, 42, 0 }, { 6, 6, 0 }, { 0, 800999, 0 }, { 1, 1, 0 }, 23,
        std::array<std::uint32_t, 3>{ 4, 4, 0 }, std::array<std::uint32_t, 3>{ 0, 0, 0 } },
    Mechanic{ 18, 707372, { 42, 0, 0 }, { 6, 0, 0 }, { 707373, 0, 0 } },
    Mechanic{ 23, 680283, { 107, 0, 0 }, { 6, 183, 0 }, { 0, 500524, 0 }, { 1, 1, 0 } },
    Mechanic{ 23, 804360, { 4, 107, 4 }, { 6, 6, 6 }, {}, { 1, 1, 1 }, 29 },
    Mechanic{ 26, 800292, { 0, 58, 82 }, { 3, 6, 6 }, {}, { 0, 1, 1 } },
    Mechanic{ 29, 681443, { 4, 4, 143 }, { 6, 6, 65 }, {}, { 1, 1, 1 } },
    Mechanic{ 30, 706731, { 42, 0, 0 }, { 6, 0, 0 }, { 805077, 0, 0 } }
};
}

#endif
