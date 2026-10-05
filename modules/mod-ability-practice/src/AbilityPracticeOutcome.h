#ifndef ABILITY_PRACTICE_OUTCOME_H
#define ABILITY_PRACTICE_OUTCOME_H

#include "AbilityPracticePersistence.h"

#include <vector>

namespace AbilityPractice
{
inline constexpr std::uint32_t PracticeAwardScriptKey = 0x41505243;

struct OutcomeContext
{
    bool Enabled = false;
    bool ActorEligible = false;
    bool AcquisitionPrerequisitesMet = false;
    bool QualifiedOutcome = false;
    std::uint32_t CharacterLevel = 0;
};

enum class OutcomeStatus
{
    Disabled,
    Unqualified,
    Invalid,
    AlreadyAwarded,
    Capped,
    Awarded,
    StateConflict
};

struct OutcomeAward
{
    OutcomeStatus Status = OutcomeStatus::Invalid;
    StoredProgress Record;
    std::uint32_t AwardedPoints = 0;
};

template<typename PlayerType, typename SpellType>
OutcomeAward HandleOutcome(PlayerType& player, SpellType& spell, AbilityDefinition const& ability,
    TrainingPolicy policy, std::uint32_t definitionVersion, OutcomeContext context)
{
    if (!context.Enabled)
        return { OutcomeStatus::Disabled, {}, 0 };
    if (!context.ActorEligible || !context.AcquisitionPrerequisitesMet || !context.QualifiedOutcome ||
        ability.Kind == AbilityKind::Fixed || spell.IsTriggered() || spell.GetCaster() != &player)
        return { OutcomeStatus::Unqualified, {}, 0 };
    if (!context.CharacterLevel || !definitionVersion || ValidateDefinition(ability) != CatalogError::None ||
        !ValidPolicy(policy) || static_cast<std::uint32_t>(player.getClass()) != ability.ClassId ||
        context.CharacterLevel < ability.Ranks.front().Requirement.CharacterLevel)
        return {};
    auto const* info = spell.GetSpellInfo();
    if (!info || info->IsPassive() || !player.HasSpell(info->Id) ||
        std::none_of(ability.Ranks.begin(), ability.Ranks.end(),
            [info](AbilityRank const& rank) { return rank.SpellId == info->Id; }))
        return { OutcomeStatus::Unqualified, {}, 0 };
    if (spell.GetScriptValue(PracticeAwardScriptKey))
        return { OutcomeStatus::AlreadyAwarded, {}, 0 };

    LoadedProgress const loaded = ReadPlayerProgress(player, ability.ClassId, ability.AbilityId,
        policy, definitionVersion);
    std::vector<std::uint32_t> learned;
    for (AbilityRank const& rank : ability.Ranks)
        if (player.HasSpell(rank.SpellId))
            learned.push_back(rank.SpellId);
    auto const migrated = MigrateLearnedRanks(ability, policy, loaded, learned);
    if (!migrated)
        return { OutcomeStatus::StateConflict, {}, 0 };

    Award const award = ApplyQualifyingUse(policy, migrated->State, CapAtLevel(ability, context.CharacterLevel));
    if (award.Status == AwardStatus::Invalid)
        return {};
    StoredProgress record = *migrated;
    record.State = award.State;
    if (!CachePlayerProgress(player, ability.ClassId, ability.AbilityId, policy, record))
        return { OutcomeStatus::StateConflict, {}, 0 };
    spell.SetScriptValue(PracticeAwardScriptKey, 1);
    return { award.Status == AwardStatus::Applied ? OutcomeStatus::Awarded : OutcomeStatus::Capped,
        record, award.AwardedPoints };
}
}

#endif
