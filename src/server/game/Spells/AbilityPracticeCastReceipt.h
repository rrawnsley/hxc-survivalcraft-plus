// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef COA_ABILITY_PRACTICE_CAST_RECEIPT_H
#define COA_ABILITY_PRACTICE_CAST_RECEIPT_H

#include <atomic>
#include <cstdint>
#include <memory>
#include <utility>

class Unit;
class Spell;

namespace CoAAbilityPractice
{
inline constexpr std::uint32_t ScriptedHealingAmountKey = 0x41504841;

class CastReceipt
{
public:
    CastReceipt(std::uint64_t casterGUID, std::uint64_t session, std::uint32_t classId,
        std::uint32_t spellId, std::uint32_t raceId, std::uint32_t talentSet, std::uint32_t specialization)
        : CasterGUID(casterGUID), Session(session), ClassId(classId), SpellId(spellId), RaceId(raceId),
          TalentSet(talentSet), Specialization(specialization) { }

    bool IsConsumed() const { return Consumed.load(); }
    void MarkConsumed() { Consumed.store(true); }

    bool BindCapturedCorpse(std::uint64_t guid, bool resourceGain)
    {
        std::uint64_t expected = 0;
        if (!guid || IsConsumed() || !CapturedCorpse.compare_exchange_strong(expected, guid))
            return false;
        CapturedResourceGain.store(resourceGain);
        return true;
    }
    std::uint64_t GetCapturedCorpseGUID() const { return CapturedCorpse.load(); }
    bool HasCapturedResourceGain() const { return CapturedResourceGain.load(); }

    std::uint64_t const CasterGUID;
    std::uint64_t const Session;
    std::uint32_t const ClassId;
    std::uint32_t const SpellId;
    std::uint32_t const RaceId;
    std::uint32_t const TalentSet;
    std::uint32_t const Specialization;

private:
    std::atomic<bool> Consumed = false;
    std::atomic<std::uint64_t> CapturedCorpse = 0;
    std::atomic<bool> CapturedResourceGain = false;
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

using CorpseCaptureProvider = void (*)(Spell*, Unit*, bool);
inline std::atomic<CorpseCaptureProvider> CorpseCaptureHandler = nullptr;

inline void SetCorpseCaptureProvider(CorpseCaptureProvider provider)
{
    CorpseCaptureHandler.store(provider);
}

inline void ReportCorpseCapture(Spell* spell, Unit* corpse, bool resourceGain)
{
    auto const provider = CorpseCaptureHandler.load();
    if (spell && corpse && provider)
        provider(spell, corpse, resourceGain);
}

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
    if (!caster || !target || !receipt || (!damage && !healing))
        return;
    auto const provider = PeriodicOutcomeHandler.load();
    if (provider)
        provider(caster, target, spellId, auraType, damage, healing, receipt);
}
}

#endif
