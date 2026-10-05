#include "AbilityPracticeRankPolicy.h"

#include <atomic>

namespace
{
std::atomic<CoAAbilityPractice::RankProvider> Provider = nullptr;
}

void CoAAbilityPractice::SetRankProvider(RankProvider provider)
{
    Provider.store(provider);
}

CoAAbilityPractice::RankDecision CoAAbilityPractice::EvaluateRank(Player const* player, std::uint32_t spellId)
{
    auto const provider = Provider.load();
    return provider ? provider(player, spellId) : RankDecision::Unmanaged;
}

bool CoAAbilityPractice::CanLearnRank(Player const* player, std::uint32_t spellId)
{
    return EvaluateRank(player, spellId) != RankDecision::Blocked;
}

bool CoAAbilityPractice::ManagesRank(Player const* player, std::uint32_t spellId)
{
    return EvaluateRank(player, spellId) != RankDecision::Unmanaged;
}
