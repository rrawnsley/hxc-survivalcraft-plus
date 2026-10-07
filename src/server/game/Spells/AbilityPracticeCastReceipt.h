// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef COA_ABILITY_PRACTICE_CAST_RECEIPT_H
#define COA_ABILITY_PRACTICE_CAST_RECEIPT_H

#include <atomic>
#include <cstdint>
#include <memory>
#include <utility>

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

class ScopedScriptedDamageCast
{
public:
    ScopedScriptedDamageCast(std::shared_ptr<CastReceipt> origin, std::uint64_t anchorGUID,
        std::uint32_t helperId)
        : Origin(std::move(origin)), AnchorGUID(anchorGUID), HelperId(helperId), Previous(Active)
    {
        Active = this;
    }

    ~ScopedScriptedDamageCast() { Active = Previous; }
    ScopedScriptedDamageCast(ScopedScriptedDamageCast const&) = delete;
    ScopedScriptedDamageCast& operator=(ScopedScriptedDamageCast const&) = delete;

    static std::shared_ptr<CastReceipt> Take(std::uint64_t casterGUID, std::uint64_t anchorGUID,
        std::uint32_t helperId)
    {
        auto* scope = Active;
        if (!scope || scope->Bound || !scope->Origin || scope->Origin->IsConsumed() ||
            scope->Origin->CasterGUID != casterGUID || scope->AnchorGUID != anchorGUID ||
            scope->HelperId != helperId)
            return {};
        scope->Bound = true;
        return scope->Origin;
    }

private:
    std::shared_ptr<CastReceipt> const Origin;
    std::uint64_t const AnchorGUID;
    std::uint32_t const HelperId;
    ScopedScriptedDamageCast* const Previous;
    bool Bound = false;
    inline static thread_local ScopedScriptedDamageCast* Active = nullptr;
};

using PeriodicOutcomeProvider = void (*)(Unit*, Unit*, std::uint32_t, std::uint32_t,
    std::uint32_t, std::uint32_t, std::shared_ptr<CastReceipt> const&);
inline std::atomic<PeriodicOutcomeProvider> PeriodicOutcomeHandler = nullptr;

inline void SetPeriodicOutcomeProvider(PeriodicOutcomeProvider provider)
{
    PeriodicOutcomeHandler.store(provider);
}

using ControlOutcomeProvider = void (*)(Unit*, Unit*, std::uint32_t, std::uint32_t,
    std::shared_ptr<CastReceipt> const&);
inline std::atomic<ControlOutcomeProvider> ControlOutcomeHandler = nullptr;

inline void SetControlOutcomeProvider(ControlOutcomeProvider provider)
{
    ControlOutcomeHandler.store(provider);
}

inline void ReportControlOutcome(Unit* caster, Unit* target, std::uint32_t spellId, std::uint32_t auraType,
    std::shared_ptr<CastReceipt> const& receipt)
{
    if (!caster || !target || !receipt || receipt->IsConsumed())
        return;
    auto const provider = ControlOutcomeHandler.load();
    if (provider)
        provider(caster, target, spellId, auraType, receipt);
}

inline void ReportAuraOutcome(Unit* caster, Unit* target, std::uint32_t spellId, std::uint32_t auraType,
    std::uint32_t damage, std::uint32_t healing, std::shared_ptr<CastReceipt> const& receipt)
{
    if (!receipt || receipt->IsConsumed() || (!damage && !healing))
        return;
    auto const provider = PeriodicOutcomeHandler.load();
    if (provider)
        provider(caster, target, spellId, auraType, damage, healing, receipt);
}

inline void ReportPeriodicOutcome(Unit* caster, Unit* target, std::uint32_t spellId, std::uint32_t auraType,
    std::uint32_t damage, std::uint32_t healing, std::shared_ptr<CastReceipt> const& receipt)
{
    ReportAuraOutcome(caster, target, spellId, auraType, damage, healing, receipt);
}
}

#endif
