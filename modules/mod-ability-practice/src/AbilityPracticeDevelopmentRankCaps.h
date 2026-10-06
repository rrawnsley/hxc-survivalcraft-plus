// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_RANK_CAPS_H
#define ABILITY_PRACTICE_DEVELOPMENT_RANK_CAPS_H

#include "AbilityPracticeProfiles.h"

#include <array>
#include <optional>

namespace AbilityPractice::DevelopmentRankCaps
{
inline constexpr std::uint32_t DefinitionVersion = 4;

struct Entry
{
    AbilityProfile Previous;
    std::array<ProficiencyCap, 80> Caps;
};

inline std::optional<Entry> Build(AbilityProfile const& profile)
{
    auto const& ability = profile.Definition;
    if (ability.Kind != AbilityKind::Ranked || ability.Ranks.size() < 2 ||
        (profile.DefinitionVersion != 2 && profile.DefinitionVersion != 3) ||
        ValidateDefinition(ability) != CatalogError::None || ability.Caps.size() != 80)
        return std::nullopt;
    Entry result{ profile, {} };
    for (std::size_t index = 0; index < result.Caps.size(); ++index)
    {
        std::uint32_t const level = static_cast<std::uint32_t>(index + 1);
        std::uint32_t const previousCap = std::min(level * 5, ability.Ranks.back().Requirement.Proficiency);
        if (ability.Caps[index].CharacterLevel != level || ability.Caps[index].Proficiency != previousCap)
            return std::nullopt;
        std::size_t qualified = 0;
        while (qualified + 1 < ability.Ranks.size() &&
            ability.Ranks[qualified + 1].Requirement.CharacterLevel <= level)
            ++qualified;
        std::size_t const upcoming = std::min(qualified + 1, ability.Ranks.size() - 1);
        result.Caps[index] = { level, std::min(previousCap, ability.Ranks[upcoming].Requirement.Proficiency) };
    }
    AbilityDefinition revised = ability;
    revised.Caps = result.Caps;
    return ValidateDefinition(revised) == CatalogError::None ? std::optional<Entry>{ result } : std::nullopt;
}
}

#endif
