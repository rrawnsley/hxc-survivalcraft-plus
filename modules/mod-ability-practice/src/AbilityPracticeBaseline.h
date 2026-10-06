// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_BASELINE_H
#define ABILITY_PRACTICE_BASELINE_H

#include <algorithm>
#include <array>
#include <cstdint>

namespace AbilityPractice
{
inline constexpr std::array<std::uint32_t, 4> NativeBaselineSpells = { 81, 107, 674, 3124 };

inline bool IsNativeBaselineSpell(std::uint32_t spellId)
{
    return std::find(NativeBaselineSpells.begin(), NativeBaselineSpells.end(), spellId) != NativeBaselineSpells.end();
}
}

#endif
