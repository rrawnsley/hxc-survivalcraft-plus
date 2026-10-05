#ifndef ABILITY_PRACTICE_MENU_H
#define ABILITY_PRACTICE_MENU_H

#include "AbilityPracticeCatalog.h"
#include "AbilityPracticeMastery.h"

#include <cstdint>
#include <limits>
#include <optional>
#include <vector>

namespace AbilityPractice
{
inline constexpr std::uint32_t MenuSchemaVersion = 1;
inline constexpr std::uint32_t SessionMenuSchemaVersion = 2;
inline constexpr std::uint32_t RoadmapMenuSchemaVersion = 3;
inline constexpr std::uint32_t TypedMenuSchemaVersion = 4;
inline constexpr std::uint32_t HumanPvEPeriodicRuleSet = 2;

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

enum class PracticeRoute
{
    Unknown = 0,
    Damage = 1,
    Healing = 2,
    Interrupt = 3,
    Dispel = 4,
    Steal = 5,
    Fixed = 6
};

inline constexpr std::uint32_t HumanPvERuleSet = 1;

struct AbilityView
{
    std::uint32_t SchemaVersion = MenuSchemaVersion;
    std::uint32_t ClassId = 0;
    std::uint32_t AbilityId = 0;
    std::uint32_t DisplaySpellId = 0;
    std::uint32_t LearnedRank = 0;
    AbilityKind Kind = AbilityKind::Ranked;
    Progress State;
    std::uint32_t Cap = 0;
    std::uint32_t PointsPerLevel = 0;
    PracticeAvailability Availability = PracticeAvailability::Invalid;
    Forecast NextPoint;
    std::optional<RankView> NextRank;
    std::vector<RankView> Ranks;
    std::vector<MasteryRewardView> Rewards;
    SessionPractice Session{ false, 0, 0 };
    PracticeRoute Route = PracticeRoute::Unknown;
    std::uint32_t RuleSet = 0;
    std::optional<ProficiencyCap> NextTrainingCap;
};

inline std::optional<ProficiencyCap> FindNextTrainingCap(AbilityDefinition const& ability,
    std::uint32_t characterLevel, Progress state)
{
    if (ValidateDefinition(ability) != CatalogError::None || ability.Kind == AbilityKind::Fixed ||
        !characterLevel || !state.Proficiency)
        return std::nullopt;
    std::uint32_t const boundary = std::max(state.Proficiency, CapAtLevel(ability, characterLevel));
    auto const found = std::find_if(ability.Caps.begin(), ability.Caps.end(),
        [characterLevel, boundary](ProficiencyCap const& cap)
        {
            return cap.CharacterLevel > characterLevel && cap.Proficiency > boundary;
        });
    if (found == ability.Caps.end())
        return std::nullopt;
    std::uint32_t const level = std::max(found->CharacterLevel, ability.Ranks.front().Requirement.CharacterLevel);
    return ProficiencyCap{ level, CapAtLevel(ability, level) };
}

inline AbilityView BuildAbilityView(AbilityDefinition const& ability, TrainingPolicy policy,
    Progress progress, std::uint32_t characterLevel, std::span<std::uint32_t const> learnedSpells,
    bool acquisitionPrerequisitesMet)
{
    if (ValidateDefinition(ability) != CatalogError::None || !characterLevel ||
        (ability.Kind != AbilityKind::Fixed && !ValidProgress(policy, progress)))
        return {};

    AbilityView view;
    view.Kind = ability.Kind;
    view.ClassId = ability.ClassId;
    view.AbilityId = ability.AbilityId;
    view.DisplaySpellId = ability.Ranks.front().SpellId;
    view.State = ability.Kind == AbilityKind::Fixed ? Progress{} : progress;
    view.Cap = CapAtLevel(ability, characterLevel);
    view.NextTrainingCap = FindNextTrainingCap(ability, characterLevel, progress);

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
    for (std::size_t index = 0; index < ability.Ranks.size(); ++index)
    {
        if (ability.Kind == AbilityKind::Fixed)
        {
            AbilityRank const& rank = ability.Ranks[index];
            RankState const state = KnowsSpell(learnedSpells, rank.SpellId) ? RankState::Learned :
                !acquisitionPrerequisitesMet ? RankState::MissingPrerequisite :
                characterLevel < rank.Requirement.CharacterLevel ? RankState::NeedsCharacterLevel :
                RankState::AcquireIntroductoryAbility;
            view.Ranks.push_back({ rank.SpellId, rank.RankNumber, rank.Requirement, state, {} });
        }
        else
            view.Ranks.push_back(DescribeRank(ability, index, policy, progress, characterLevel,
                learnedSpells, acquisitionPrerequisitesMet));
    }
    if (nextRank < view.Ranks.size())
        view.NextRank = view.Ranks[nextRank];

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
