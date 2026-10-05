#include "AbilityPracticeRankPolicy.h"
#include "Player.h"

#include <atomic>

namespace
{
std::atomic<CoAAbilityPractice::RankProvider> Provider = nullptr;
std::atomic<CoAAbilityPractice::PurchaseProvider> PurchasePolicy = nullptr;
std::atomic<CoAAbilityPractice::ReplacementChangedProvider> ReplacementChanged = nullptr;
thread_local std::uint64_t RestoringPlayerGUID = 0;
thread_local std::uint32_t RestoringSpellId = 0;
}

void CoAAbilityPractice::SetRankProvider(RankProvider provider)
{
    Provider.store(provider);
}

void CoAAbilityPractice::SetReplacementChangedProvider(ReplacementChangedProvider provider)
{
    ReplacementChanged.store(provider);
}

void CoAAbilityPractice::NotifyReplacementChanged(Player* player, std::uint32_t originalSpellId)
{
    auto const provider = ReplacementChanged.load();
    if (provider)
        provider(player, originalSpellId);
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

void CoAAbilityPractice::SetPurchaseProvider(CoAAbilityPractice::PurchaseProvider provider)
{
    PurchasePolicy.store(provider);
}

bool CoAAbilityPractice::CanPurchaseSpell(Player const* player, std::uint32_t spellId)
{
    auto const provider = PurchasePolicy.load();
    return !provider || provider(player, spellId);
}

CoAAbilityPractice::SavedSpellRestoration::SavedSpellRestoration(Player const* player, std::uint32_t spellId)
    : PreviousPlayerGUID(RestoringPlayerGUID), PreviousSpellId(RestoringSpellId)
{
    RestoringPlayerGUID = player ? player->GetGUID().GetRawValue() : 0;
    RestoringSpellId = spellId;
}

CoAAbilityPractice::SavedSpellRestoration::~SavedSpellRestoration()
{
    RestoringPlayerGUID = PreviousPlayerGUID;
    RestoringSpellId = PreviousSpellId;
}

bool CoAAbilityPractice::IsRestoringSavedSpell(Player const* player, std::uint32_t spellId)
{
    return player && spellId && RestoringPlayerGUID && RestoringSpellId == spellId &&
        player->GetGUID().GetRawValue() == RestoringPlayerGUID;
}
