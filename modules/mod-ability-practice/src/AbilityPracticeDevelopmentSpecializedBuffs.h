// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_SPECIALIZED_BUFFS_H
#define ABILITY_PRACTICE_DEVELOPMENT_SPECIALIZED_BUFFS_H

#include <array>
#include <cstdint>

namespace AbilityPractice::DevelopmentSpecializedBuffs
{
struct Effect
{
    std::uint32_t Kind;
    std::uint32_t Aura;
    std::uint32_t Target;
    std::int32_t Selector;
    std::int32_t Points;
    std::int32_t DieSides;
    std::uint32_t Trigger;
    float PointsPerLevel = 0;
};
struct Spell
{
    std::uint32_t Id;
    std::uint32_t Level;
    std::uint32_t Family;
    std::array<std::uint32_t, 3> Flags;
    std::array<Effect, 3> Effects;
};
inline constexpr std::array Spells = {
    Spell{ 800212, 24, 20, { 512, 0, 0 },
        { Effect{ 6, 29, 21, 1, 19, 1, 0 }, Effect{ 0, 0, 0, 0, 19, 0, 0 }, Effect{ 0, 0, 0, 0, -1, 1, 0 } } },
    Spell{ 501326, 32, 20, { 512, 0, 0 },
        { Effect{ 6, 29, 21, 1, 27, 1, 0 }, Effect{ 0, 0, 0, 0, 32, 1, 0 }, Effect{ 0, 0, 0, 0, -1, 1, 0 } } },
    Spell{ 501327, 42, 20, { 512, 0, 0 },
        { Effect{ 6, 29, 21, 1, 35, 1, 0 }, Effect{ 0, 0, 0, 0, 53, 1, 0 }, Effect{ 0, 0, 0, 0, -1, 1, 0 } } },
    Spell{ 501328, 52, 20, { 512, 0, 0 },
        { Effect{ 6, 29, 21, 1, 60, 1, 0 }, Effect{ 0, 0, 0, 0, 60, 1, 0 }, Effect{ 0, 0, 0, 0, -1, 1, 0 } } },
    Spell{ 501329, 60, 20, { 512, 0, 0 },
        { Effect{ 6, 29, 21, 1, 76, 1, 0 }, Effect{ 0, 0, 0, 0, 76, 1, 0 }, Effect{ 0, 0, 0, 0, -1, 1, 0 } } },
    Spell{ 501330, 65, 20, { 512, 0, 0 },
        { Effect{ 6, 29, 21, 1, 85, 1, 0 }, Effect{ 0, 0, 0, 0, 184, 1, 0 }, Effect{ 0, 0, 0, 0, -1, 1, 0 } } },
    Spell{ 501331, 65, 20, { 512, 0, 0 },
        { Effect{ 6, 29, 21, 1, 85, 1, 0 }, Effect{ 0, 0, 0, 0, 231, 1, 0 }, Effect{ 0, 0, 0, 0, -1, 1, 0 } } },
    Spell{ 501332, 70, 20, { 512, 0, 0 },
        { Effect{ 6, 29, 21, 1, 85, 1, 0 }, Effect{ 0, 0, 0, 0, 305, 1, 0 }, Effect{ 0, 0, 0, 0, -1, 1, 0 } } },
    Spell{ 501333, 77, 20, { 512, 0, 0 },
        { Effect{ 6, 29, 21, 1, 114, 1, 0 }, Effect{ 0, 0, 0, 0, 409, 1, 0 }, Effect{ 0, 0, 0, 0, -1, 1, 0 } } },
    Spell{ 501334, 67, 20, { 512, 0, 0 },
        { Effect{ 6, 102, 21, 1, 551, 61, 0, 7.575f }, Effect{ 0, 0, 0, 0, 2, 1, 0 }, Effect{ 0, 0, 0, 0, -1, 1, 0 } } },
    Spell{ 501336, 74, 20, { 512, 0, 0 },
        { Effect{ 6, 102, 21, 1, 993, 87, 0, 8.89125f }, Effect{ 0, 0, 0, 0, 2, 1, 0 }, Effect{ 0, 0, 0, 0, -1, 1, 0 } } },
    Spell{ 680308, 60, 20, { 512, 0, 0 },
        { Effect{ 6, 29, 56, 1, 76, 1, 0 }, Effect{ 0, 0, 0, 0, 0, 0, 0 }, Effect{ 0, 0, 0, 0, -1, 1, 0 } } },
    Spell{ 801441, 4, 25, { 0, 0, 2048 },
        { Effect{ 6, 4, 1, 0, 99, 1, 0 }, Effect{ 6, 107, 1, 17, -1, 1, 0 }, Effect{ 0, 0, 0, 0, -1, 1, 0 } } },
    Spell{ 803890, 14, 25, { 0, 0, 2048 },
        { Effect{ 6, 4, 1, 0, 99, 1, 0 }, Effect{ 6, 107, 1, 17, 0, 1, 0 }, Effect{ 0, 0, 0, 0, -1, 1, 0 } } },
    Spell{ 803891, 24, 25, { 0, 0, 2048 },
        { Effect{ 6, 4, 1, 0, 99, 1, 0 }, Effect{ 6, 107, 1, 17, 1, 1, 0 }, Effect{ 0, 0, 0, 0, -1, 1, 0 } } },
    Spell{ 803892, 34, 25, { 0, 0, 2048 },
        { Effect{ 6, 4, 1, 0, 99, 1, 0 }, Effect{ 6, 107, 1, 17, 2, 1, 0 }, Effect{ 0, 0, 0, 0, -1, 1, 0 } } },
    Spell{ 803893, 44, 25, { 0, 0, 2048 },
        { Effect{ 6, 4, 1, 0, 99, 1, 0 }, Effect{ 6, 107, 1, 17, 3, 1, 0 }, Effect{ 0, 0, 0, 0, -1, 1, 0 } } },
    Spell{ 681527, 46, 27, { 0, 0, 0 },
        { Effect{ 6, 4, 56, 23, 4, 1, 0 }, Effect{ 6, 4, 56, 0, -1, 1, 0 }, Effect{ 6, 143, 56, 8, 44, 1, 0 } } },
    Spell{ 681538, 52, 27, { 0, 0, 0 },
        { Effect{ 6, 4, 56, 23, 4, 1, 0 }, Effect{ 6, 4, 56, 0, -1, 1, 0 }, Effect{ 6, 143, 56, 8, 49, 1, 0 } } },
    Spell{ 681539, 58, 27, { 0, 0, 0 },
        { Effect{ 6, 4, 56, 23, 4, 1, 0 }, Effect{ 6, 4, 56, 0, -1, 1, 0 }, Effect{ 6, 143, 56, 8, 61, 1, 0 } } }
};
inline Spell const* Find(std::uint32_t spellId)
{
    for (auto const& spell : Spells)
        if (spell.Id == spellId)
            return &spell;
    return nullptr;
}
}

#endif
