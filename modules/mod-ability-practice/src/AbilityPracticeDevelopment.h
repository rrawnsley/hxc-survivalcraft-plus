#ifndef ABILITY_PRACTICE_DEVELOPMENT_H
#define ABILITY_PRACTICE_DEVELOPMENT_H

#include "AbilityPracticeCatalog.h"

#include <array>

namespace AbilityPractice::Development
{
inline constexpr std::uint32_t DefinitionVersion = 1;
inline constexpr std::uint32_t ClassId = 24;
inline constexpr std::array Bands = { TrainingBand{ 1, 30, 2 }, TrainingBand{ 20, 30, 1 } };
inline constexpr TrainingPolicy Policy{ Bands };
inline constexpr auto Caps = []
{
    std::array<ProficiencyCap, 80> result{};
    for (std::uint32_t index = 0; index < result.size(); ++index)
        result[index] = { index + 1, (index + 1) * 5 };
    return result;
}();

inline constexpr std::array LavaShard = {
    AbilityRank{ 803950, 1, { 4, 1 } }, AbilityRank{ 503231, 2, { 10, 10 } },
    AbilityRank{ 503232, 3, { 16, 20 } }, AbilityRank{ 503233, 4, { 24, 40 } },
    AbilityRank{ 503234, 5, { 32, 60 } }, AbilityRank{ 503235, 6, { 40, 80 } },
    AbilityRank{ 503236, 7, { 48, 100 } }, AbilityRank{ 503237, 8, { 56, 120 } },
    AbilityRank{ 503238, 9, { 64, 140 } }, AbilityRank{ 503239, 10, { 72, 160 } }
};
inline constexpr std::array Cinderheart = {
    AbilityRank{ 800806, 1, { 2, 1 } }, AbilityRank{ 502044, 2, { 8, 10 } },
    AbilityRank{ 502045, 3, { 14, 20 } }, AbilityRank{ 502046, 4, { 20, 40 } },
    AbilityRank{ 502047, 5, { 26, 60 } }, AbilityRank{ 502048, 6, { 32, 80 } },
    AbilityRank{ 502049, 7, { 40, 100 } }, AbilityRank{ 502050, 8, { 48, 120 } },
    AbilityRank{ 502051, 9, { 56, 140 } }, AbilityRank{ 502052, 10, { 60, 160 } }
};
inline constexpr std::array Kindle = {
    AbilityRank{ 803819, 1, { 14, 1 } }, AbilityRank{ 803820, 2, { 20, 10 } },
    AbilityRank{ 803821, 3, { 28, 20 } }, AbilityRank{ 803822, 4, { 36, 40 } },
    AbilityRank{ 803823, 5, { 44, 60 } }, AbilityRank{ 803824, 6, { 52, 80 } },
    AbilityRank{ 803825, 7, { 60, 100 } }
};
inline constexpr std::array Abilities = {
    AbilityDefinition{ ClassId, 803950, AbilityKind::Ranked, LavaShard, Caps },
    AbilityDefinition{ ClassId, 800806, AbilityKind::Ranked, Cinderheart, Caps },
    AbilityDefinition{ ClassId, 803819, AbilityKind::Ranked, Kindle, Caps }
};

inline AbilityDefinition const* Find(std::uint32_t spellId)
{
    for (AbilityDefinition const& ability : Abilities)
        for (AbilityRank const& rank : ability.Ranks)
            if (rank.SpellId == spellId)
                return &ability;
    return nullptr;
}
}

#endif
