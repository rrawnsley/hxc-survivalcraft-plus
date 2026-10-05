// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef COA_ABILITY_PRACTICE_MASTERY_POLICY_H
#define COA_ABILITY_PRACTICE_MASTERY_POLICY_H

#include <atomic>
#include <cstdint>

class Unit;

namespace CoAAbilityPractice
{
class CastReceipt;

using HealingMasteryProvider = std::uint32_t (*)(Unit*, Unit*, std::uint32_t, std::uint32_t, CastReceipt const*);
inline std::atomic<HealingMasteryProvider> HealingMasteryHandler = nullptr;

inline void SetHealingMasteryProvider(HealingMasteryProvider provider)
{
    HealingMasteryHandler.store(provider);
}

inline std::uint32_t ModifyMasteryHealing(Unit* healer, Unit* recipient, std::uint32_t spellId,
    std::uint32_t healing, CastReceipt const* receipt)
{
    if (!receipt)
        return healing;
    auto const provider = HealingMasteryHandler.load();
    return provider ? provider(healer, recipient, spellId, healing, receipt) : healing;
}
}

#endif
