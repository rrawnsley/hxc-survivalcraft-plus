// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef COA_ABILITY_PRACTICE_CAST_RECEIPT_H
#define COA_ABILITY_PRACTICE_CAST_RECEIPT_H

#include <atomic>
#include <cstdint>
#include <memory>

class Unit;

namespace CoAAbilityPractice
{
class CastReceipt
{
public:
    CastReceipt(std::uint64_t casterGUID, std::uint64_t session, std::uint32_t classId,
        std::uint32_t spellId, std::uint32_t raceId, std::uint32_t talentSet, std::uint32_t specialization)
        : CasterGUID(casterGUID), Session(session), ClassId(classId), SpellId(spellId), RaceId(raceId),
          TalentSet(talentSet), Specialization(specialization) { }

    bool IsConsumed() const { return Consumed.load(); }
    void MarkConsumed() { Consumed.store(true); }

    std::uint64_t const CasterGUID;
    std::uint64_t const Session;
    std::uint32_t const ClassId;
    std::uint32_t const SpellId;
    std::uint32_t const RaceId;
    std::uint32_t const TalentSet;
    std::uint32_t const Specialization;

private:
    std::atomic<bool> Consumed = false;
};

using PeriodicOutcomeProvider = void (*)(Unit*, Unit*, std::uint32_t, std::uint32_t,
    std::uint32_t, std::uint32_t, std::shared_ptr<CastReceipt> const&);
inline std::atomic<PeriodicOutcomeProvider> PeriodicOutcomeHandler = nullptr;

inline void SetPeriodicOutcomeProvider(PeriodicOutcomeProvider provider)
{
    PeriodicOutcomeHandler.store(provider);
}

inline void ReportPeriodicOutcome(Unit* caster, Unit* target, std::uint32_t spellId, std::uint32_t auraType,
    std::uint32_t damage, std::uint32_t healing, std::shared_ptr<CastReceipt> const& receipt)
{
    if (!receipt || receipt->IsConsumed() || (!damage && !healing))
        return;
    auto const provider = PeriodicOutcomeHandler.load();
    if (provider)
        provider(caster, target, spellId, auraType, damage, healing, receipt);
}
}

#endif
