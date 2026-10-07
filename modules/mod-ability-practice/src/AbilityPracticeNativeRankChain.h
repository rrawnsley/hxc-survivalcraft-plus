// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_NATIVE_RANK_CHAIN_H
#define ABILITY_PRACTICE_NATIVE_RANK_CHAIN_H

#include "AbilityPracticeCatalog.h"

#include <optional>

namespace AbilityPractice
{
struct NativeRankLink
{
    std::uint32_t First;
    std::uint32_t Last;
    std::uint32_t Previous;
    std::uint32_t Next;
    std::uint32_t Rank;
};

inline bool MatchesNativeRankChain(std::span<AbilityRank const> ranks,
    std::span<std::optional<NativeRankLink> const> links, std::size_t verifiedTrainerPrefix = 0)
{
    if (ranks.empty() || ranks.size() != links.size())
        return false;
    auto exact = [](std::span<AbilityRank const> expected, std::span<std::optional<NativeRankLink> const> observed)
    {
        std::size_t present = 0;
        for (std::size_t index = 0; index < expected.size(); ++index)
        {
            if (!observed[index])
                continue;
            ++present;
            auto const& link = *observed[index];
            if (link.First != expected.front().SpellId || link.Last != expected.back().SpellId ||
                link.Rank != expected[index].RankNumber ||
                link.Previous != (index ? expected[index - 1].SpellId : 0) ||
                link.Next != (index + 1 < expected.size() ? expected[index + 1].SpellId : 0))
                return false;
        }
        return !present || present == expected.size();
    };
    if (exact(ranks, links))
        return true;
    if (!verifiedTrainerPrefix || verifiedTrainerPrefix >= ranks.size() ||
        std::any_of(links.begin() + verifiedTrainerPrefix, links.end(),
            [](std::optional<NativeRankLink> const& link) { return link.has_value(); }))
        return false;
    return exact(ranks.first(verifiedTrainerPrefix), links.first(verifiedTrainerPrefix));
}
}

#endif
