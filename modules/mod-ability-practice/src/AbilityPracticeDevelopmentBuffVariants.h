// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_BUFF_VARIANTS_H
#define ABILITY_PRACTICE_DEVELOPMENT_BUFF_VARIANTS_H

#include "AbilityPracticeProfiles.h"

#include <array>

namespace AbilityPractice::DevelopmentBuffVariants
{
struct Variant
{
    std::uint32_t ClassId;
    std::uint32_t SpellId;
    std::uint32_t AbilityId;
    std::uint32_t EquivalentSpellId;
    std::uint32_t CharacterLevel;
};

inline constexpr std::array Variants = {
    Variant{ 14, 523495, 523478, 523483, 60 },
    Variant{ 15, 523510, 523485, 523488, 60 },
    Variant{ 29, 803657, 803651, 803655, 60 },
    Variant{ 15, 680303, 706741, 707355, 60 },
    Variant{ 15, 681442, 707684, 707687, 58 },
    Variant{ 13, 712458, 707671, 707676, 60 },
    Variant{ 13, 680872, 560294, 561142, 56 },
    Variant{ 13, 800195, 578344, 578344, 32 },
    Variant{ 21, 523513, 523489, 523493, 60 },
    Variant{ 21, 680294, 800266, 803666, 60 }
};

inline Variant const* Find(std::uint32_t classId, std::uint32_t spellId)
{
    for (auto const& variant : Variants)
        if (variant.ClassId == classId && variant.SpellId == spellId)
            return &variant;
    return nullptr;
}

inline AbilityRank const* EquivalentRank(AbilityProfile const& profile, Variant const& variant)
{
    if (profile.Definition.ClassId != variant.ClassId || profile.Definition.AbilityId != variant.AbilityId)
        return nullptr;
    for (auto const& rank : profile.Definition.Ranks)
        if (rank.SpellId == variant.EquivalentSpellId && rank.Requirement.CharacterLevel <= variant.CharacterLevel)
            return &rank;
    return nullptr;
}
}

#endif
