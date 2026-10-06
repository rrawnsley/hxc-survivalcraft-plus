// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_PASSIVE_FIXED_H
#define ABILITY_PRACTICE_DEVELOPMENT_PASSIVE_FIXED_H

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeProfiles.h"

namespace AbilityPractice::DevelopmentPassiveFixed
{
inline constexpr std::array BarbaricRage = { AbilityRank{ 804337, 1, { 2, 1 } } };
inline constexpr std::array FelFinesse = { AbilityRank{ 520591, 1, { 20, 1 } } };
inline constexpr std::array Bloodrider = { AbilityRank{ 704964, 1, { 50, 1 } } };
inline constexpr std::array DiscipleOfShadra = { AbilityRank{ 503907, 1, { 10, 1 } } };
inline constexpr std::array SpiritWalker = { AbilityRank{ 561082, 1, { 14, 1 } } };
inline constexpr std::array ImprovedGhostForm = { AbilityRank{ 807084, 1, { 40, 1 } } };

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
        { 30, 807084, AbilityKind::Fixed, ImprovedGhostForm, {} }, Development::Policy, OutcomeKind::None }
};

struct Mechanic
{
    std::uint32_t ClassId;
    std::uint32_t SpellId;
    std::array<std::uint32_t, 3> AuraIds;
};

inline constexpr std::array Mechanics = {
    Mechanic{ 12, 804337, { 107, 0, 0 } },
    Mechanic{ 14, 520591, { 144, 0, 0 } },
    Mechanic{ 17, 704964, { 108, 108, 0 } },
    Mechanic{ 29, 503907, { 4, 0, 0 } },
    Mechanic{ 30, 561082, { 4, 0, 0 } },
    Mechanic{ 30, 807084, { 107, 0, 0 } }
};
}

#endif
