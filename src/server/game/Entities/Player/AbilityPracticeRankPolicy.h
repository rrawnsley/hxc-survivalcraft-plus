#ifndef COA_ABILITY_PRACTICE_RANK_POLICY_H
#define COA_ABILITY_PRACTICE_RANK_POLICY_H

#include <cstdint>

class Player;

namespace CoAAbilityPractice
{
enum class RankDecision
{
    Unmanaged,
    Blocked,
    Allowed
};

using RankProvider = RankDecision (*)(Player const*, std::uint32_t);
using PurchaseProvider = bool (*)(Player const*, std::uint32_t);
void SetRankProvider(RankProvider provider);
void SetPurchaseProvider(PurchaseProvider provider);
bool CanPurchaseSpell(Player const* player, std::uint32_t spellId);
RankDecision EvaluateRank(Player const* player, std::uint32_t spellId);
bool CanLearnRank(Player const* player, std::uint32_t spellId);
bool ManagesRank(Player const* player, std::uint32_t spellId);
}

#endif
