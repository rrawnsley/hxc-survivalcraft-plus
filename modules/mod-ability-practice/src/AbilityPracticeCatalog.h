#ifndef ABILITY_PRACTICE_CATALOG_H
#define ABILITY_PRACTICE_CATALOG_H

#include "AbilityPracticeProgression.h"

namespace AbilityPractice
{
enum class AbilityKind
{
    Ranked,
    Mastery,
    Fixed
};

struct AbilityRank
{
    std::uint32_t SpellId;
    std::uint32_t RankNumber;
    Milestone Requirement;
};

struct ProficiencyCap
{
    std::uint32_t CharacterLevel;
    std::uint32_t Proficiency;
};

struct AbilityDefinition
{
    std::uint32_t ClassId;
    std::uint32_t AbilityId;
    AbilityKind Kind;
    std::span<AbilityRank const> Ranks;
    std::span<ProficiencyCap const> Caps;
};

enum class CatalogError
{
    None,
    InvalidIdentity,
    InvalidKind,
    InvalidRank,
    InvalidCap,
    DuplicateAbility,
    DuplicateSpell
};

inline CatalogError ValidateDefinition(AbilityDefinition const& ability)
{
    if (!ability.ClassId || !ability.AbilityId || ability.Ranks.empty())
        return CatalogError::InvalidIdentity;
    if (ability.Kind != AbilityKind::Ranked && ability.Kind != AbilityKind::Mastery &&
        ability.Kind != AbilityKind::Fixed)
        return CatalogError::InvalidKind;
    if (ability.Kind == AbilityKind::Mastery && ability.Ranks.size() != 1)
        return CatalogError::InvalidRank;

    std::uint32_t previousLevel = 0;
    std::uint32_t previousProficiency = 0;
    std::uint32_t previousRank = 0;
    for (std::size_t index = 0; index < ability.Ranks.size(); ++index)
    {
        AbilityRank const& rank = ability.Ranks[index];
        if (!rank.SpellId || rank.RankNumber != previousRank + 1 || !rank.Requirement.CharacterLevel ||
            !rank.Requirement.Proficiency || rank.Requirement.CharacterLevel < previousLevel ||
            rank.Requirement.Proficiency < previousProficiency ||
            (!previousRank && rank.Requirement.Proficiency != 1) ||
            (ability.Kind == AbilityKind::Fixed && rank.Requirement.Proficiency != 1))
            return CatalogError::InvalidRank;
        for (std::size_t other = 0; other < index; ++other)
            if (ability.Ranks[other].SpellId == rank.SpellId)
                return CatalogError::DuplicateSpell;
        previousRank = rank.RankNumber;
        previousLevel = rank.Requirement.CharacterLevel;
        previousProficiency = rank.Requirement.Proficiency;
    }

    if (ability.Kind == AbilityKind::Fixed)
        return ability.Caps.empty() ? CatalogError::None : CatalogError::InvalidCap;
    if (ability.Caps.empty() || ability.Caps.front().CharacterLevel != 1)
        return CatalogError::InvalidCap;

    previousLevel = 0;
    previousProficiency = 0;
    for (ProficiencyCap const& cap : ability.Caps)
    {
        if (cap.CharacterLevel <= previousLevel || !cap.Proficiency || cap.Proficiency < previousProficiency)
            return CatalogError::InvalidCap;
        previousLevel = cap.CharacterLevel;
        previousProficiency = cap.Proficiency;
    }
    return ability.Ranks.back().Requirement.Proficiency <= ability.Caps.back().Proficiency ?
        CatalogError::None : CatalogError::InvalidCap;
}

inline CatalogError ValidateCatalog(std::span<AbilityDefinition const> abilities)
{
    for (std::size_t index = 0; index < abilities.size(); ++index)
    {
        AbilityDefinition const& ability = abilities[index];
        CatalogError const error = ValidateDefinition(ability);
        if (error != CatalogError::None)
            return error;
        for (std::size_t other = 0; other < index; ++other)
        {
            AbilityDefinition const& existing = abilities[other];
            if (existing.ClassId != ability.ClassId)
                continue;
            if (existing.AbilityId == ability.AbilityId)
                return CatalogError::DuplicateAbility;
            for (AbilityRank const& rank : ability.Ranks)
                for (AbilityRank const& known : existing.Ranks)
                    if (known.SpellId == rank.SpellId)
                        return CatalogError::DuplicateSpell;
        }
    }
    return CatalogError::None;
}

inline std::uint32_t CapAtLevel(AbilityDefinition const& ability, std::uint32_t characterLevel)
{
    if (!characterLevel || ValidateDefinition(ability) != CatalogError::None)
        return 0;
    if (ability.Kind == AbilityKind::Fixed)
        return 1;

    auto const next = std::upper_bound(ability.Caps.begin(), ability.Caps.end(), characterLevel,
        [](std::uint32_t value, ProficiencyCap const& cap) { return value < cap.CharacterLevel; });
    return (next - 1)->Proficiency;
}

inline bool KnowsSpell(std::span<std::uint32_t const> learnedSpells, std::uint32_t spellId)
{
    return std::find(learnedSpells.begin(), learnedSpells.end(), spellId) != learnedSpells.end();
}

inline Progress SeedLearnedRanks(AbilityDefinition const& ability, Progress existing,
    std::span<std::uint32_t const> learnedSpells)
{
    if (ValidateDefinition(ability) != CatalogError::None || !existing.Proficiency)
        return existing;
    std::uint32_t required = existing.Proficiency;
    for (AbilityRank const& rank : ability.Ranks)
        if (KnowsSpell(learnedSpells, rank.SpellId))
            required = std::max(required, rank.Requirement.Proficiency);
    return required > existing.Proficiency ? Progress{ required, 0 } : existing;
}

enum class RankState
{
    Invalid = 0,
    Learned = 1,
    AcquireIntroductoryAbility = 2,
    MissingPrerequisite = 3,
    NeedsPractice = 4,
    NeedsCharacterLevel = 5,
    NeedsBoth = 6,
    Ready = 7
};

struct RankView
{
    std::uint32_t SpellId = 0;
    std::uint32_t RankNumber = 0;
    Milestone Requirement{};
    RankState State = RankState::Invalid;
    Forecast Practice;
};

inline RankView DescribeRank(AbilityDefinition const& ability, std::size_t rankIndex,
    TrainingPolicy policy, Progress progress, std::uint32_t characterLevel,
    std::span<std::uint32_t const> learnedSpells, bool acquisitionPrerequisitesMet)
{
    if (ValidateDefinition(ability) != CatalogError::None || rankIndex >= ability.Ranks.size() ||
        !characterLevel || !ValidProgress(policy, progress))
        return {};

    AbilityRank const& rank = ability.Ranks[rankIndex];
    RankView view{ rank.SpellId, rank.RankNumber, rank.Requirement, RankState::Invalid, {} };
    if (KnowsSpell(learnedSpells, rank.SpellId))
    {
        view.State = RankState::Learned;
        view.Practice = { ForecastStatus::Complete, 0 };
        return view;
    }
    if (!rankIndex)
    {
        view.State = acquisitionPrerequisitesMet ? RankState::AcquireIntroductoryAbility :
            RankState::MissingPrerequisite;
        if (acquisitionPrerequisitesMet && characterLevel < rank.Requirement.CharacterLevel)
            view.State = RankState::NeedsCharacterLevel;
        return view;
    }

    bool const prerequisites = acquisitionPrerequisitesMet &&
        KnowsSpell(learnedSpells, ability.Ranks[rankIndex - 1].SpellId);
    switch (EvaluateMilestone(rank.Requirement, progress, characterLevel, prerequisites))
    {
        case MilestoneStatus::Invalid: view.State = RankState::Invalid; break;
        case MilestoneStatus::MissingPrerequisite: view.State = RankState::MissingPrerequisite; break;
        case MilestoneStatus::NeedsPractice: view.State = RankState::NeedsPractice; break;
        case MilestoneStatus::NeedsCharacterLevel: view.State = RankState::NeedsCharacterLevel; break;
        case MilestoneStatus::NeedsBoth: view.State = RankState::NeedsBoth; break;
        case MilestoneStatus::Ready: view.State = RankState::Ready; break;
    }
    view.Practice = UsesUntil(policy, progress, rank.Requirement.Proficiency, CapAtLevel(ability, characterLevel));
    return view;
}
}

#endif
