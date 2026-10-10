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
using DamageMasteryProvider = std::uint32_t (*)(Unit*, Unit*, std::uint32_t, std::uint32_t, CastReceipt const*);
inline std::atomic<DamageMasteryProvider> DamageMasteryHandler = nullptr;

using ResourceDrainMasteryProvider = std::uint32_t (*)(Unit*, Unit*, std::uint32_t, std::uint8_t,
    std::uint32_t, CastReceipt const*);
inline std::atomic<ResourceDrainMasteryProvider> ResourceDrainMasteryHandler = nullptr;

inline void SetResourceDrainMasteryProvider(ResourceDrainMasteryProvider provider)
{
    ResourceDrainMasteryHandler.store(provider);
}

inline std::uint32_t ModifyMasteryResourceDrain(Unit* caster, Unit* target, std::uint32_t spellId,
    std::uint8_t powerType, std::uint32_t amount, CastReceipt const* receipt)
{
    if (!receipt || !amount)
        return amount;
    auto const provider = ResourceDrainMasteryHandler.load();
    return provider ? provider(caster, target, spellId, powerType, amount, receipt) : amount;
}

inline void SetDamageMasteryProvider(DamageMasteryProvider provider)
{
    DamageMasteryHandler.store(provider);
}

inline std::uint32_t ModifyMasteryDamage(Unit* caster, Unit* target, std::uint32_t spellId,
    std::uint32_t damage, CastReceipt const* receipt)
{
    if (!receipt)
        return damage;
    auto const provider = DamageMasteryHandler.load();
    return provider ? provider(caster, target, spellId, damage, receipt) : damage;
}

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
