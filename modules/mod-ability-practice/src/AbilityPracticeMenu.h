#ifndef ABILITY_PRACTICE_MENU_H
#define ABILITY_PRACTICE_MENU_H

#include "AbilityPracticeCatalog.h"

#include <cstdint>
#include <limits>
#include <optional>

namespace AbilityPractice
{
inline constexpr std::uint32_t MenuSchemaVersion = 1;
inline constexpr std::uint32_t SessionMenuSchemaVersion = 2;

struct SessionPractice
{
    bool Available = true;
    std::uint64_t Uses = 0;
    std::uint64_t ProficiencyGained = 0;

    void RecordAward(std::uint32_t proficiencyGained)
    {
        if (!Available)
            return;
        constexpr auto maximum = std::numeric_limits<std::uint64_t>::max();
        if (Uses == maximum || ProficiencyGained > maximum - proficiencyGained)
        {
            Available = false;
            Uses = ProficiencyGained = 0;
            return;
        }
        ++Uses;
        ProficiencyGained += proficiencyGained;
    }
};

enum class PracticeAvailability
{
    Invalid = 0,
    AcquireAbility = 1,
    MissingPrerequisite = 2,
    NeedsCharacterLevel = 3,
    Training = 4,
    Capped = 5,
    Fixed = 6
};

struct AbilityView
{
    std::uint32_t SchemaVersion = MenuSchemaVersion;
    std::uint32_t ClassId = 0;
    std::uint32_t AbilityId = 0;
    std::uint32_t DisplaySpellId = 0;
    std::uint32_t LearnedRank = 0;
    Progress State;
    std::uint32_t Cap = 0;
    std::uint32_t PointsPerLevel = 0;
    PracticeAvailability Availability = PracticeAvailability::Invalid;
    Forecast NextPoint;
    std::optional<RankView> NextRank;
};

inline AbilityView BuildAbilityView(AbilityDefinition const& ability, TrainingPolicy policy,
    Progress progress, std::uint32_t characterLevel, std::span<std::uint32_t const> learnedSpells,
    bool acquisitionPrerequisitesMet)
{
    if (ValidateDefinition(ability) != CatalogError::None || !characterLevel ||
        (ability.Kind != AbilityKind::Fixed && !ValidProgress(policy, progress)))
        return {};

    AbilityView view;
    view.ClassId = ability.ClassId;
    view.AbilityId = ability.AbilityId;
    view.DisplaySpellId = ability.Ranks.front().SpellId;
    view.State = ability.Kind == AbilityKind::Fixed ? Progress{} : progress;
    view.Cap = CapAtLevel(ability, characterLevel);

    std::size_t nextRank = 0;
    for (std::size_t index = 0; index < ability.Ranks.size(); ++index)
    {
        AbilityRank const& rank = ability.Ranks[index];
        if (!KnowsSpell(learnedSpells, rank.SpellId))
            continue;
        view.DisplaySpellId = rank.SpellId;
        view.LearnedRank = rank.RankNumber;
        nextRank = index + 1;
    }
    if (nextRank < ability.Ranks.size())
    {
        if (ability.Kind == AbilityKind::Fixed)
        {
            AbilityRank const& rank = ability.Ranks[nextRank];
            RankState const state = !acquisitionPrerequisitesMet ? RankState::MissingPrerequisite :
                characterLevel < rank.Requirement.CharacterLevel ? RankState::NeedsCharacterLevel :
                RankState::AcquireIntroductoryAbility;
            view.NextRank = RankView{ rank.SpellId, rank.RankNumber, rank.Requirement, state, {} };
        }
        else
            view.NextRank = DescribeRank(ability, nextRank, policy, progress, characterLevel,
                learnedSpells, acquisitionPrerequisitesMet);
    }

    if (ability.Kind != AbilityKind::Fixed && view.LearnedRank)
        view.PointsPerLevel = policy.Bands[Detail::BandIndex(policy, progress.Proficiency)].PointsPerLevel;

    if (!acquisitionPrerequisitesMet)
        view.Availability = PracticeAvailability::MissingPrerequisite;
    else if (characterLevel < ability.Ranks.front().Requirement.CharacterLevel)
        view.Availability = PracticeAvailability::NeedsCharacterLevel;
    else if (!view.LearnedRank)
        view.Availability = PracticeAvailability::AcquireAbility;
    else if (ability.Kind == AbilityKind::Fixed)
        view.Availability = PracticeAvailability::Fixed;
    else
    {
        view.Availability = progress.Proficiency >= view.Cap ? PracticeAvailability::Capped :
            PracticeAvailability::Training;
        view.NextPoint = progress.Proficiency == std::numeric_limits<std::uint32_t>::max() ?
            Forecast{ ForecastStatus::BeyondCap, 0 } :
            UsesUntil(policy, progress, progress.Proficiency + 1, view.Cap);
    }
    return view;
}
}

#endif
