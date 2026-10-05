// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_MASTERY_H
#define ABILITY_PRACTICE_MASTERY_H

#include "AbilityPracticeCatalog.h"

#include <cstdint>
#include <limits>
#include <vector>

namespace AbilityPractice
{
inline constexpr std::uint32_t MaximumHealingMasteryBasisPoints = 200;
inline constexpr std::size_t MaximumMasteryRewards = 8;
inline constexpr std::size_t MaximumClassMasteryRewards = 512;

struct MasteryReward
{
    Milestone Requirement;
    std::uint32_t HealingBonusBasisPoints;
};

struct MasteryRewardView
{
    MasteryReward Reward;
    RankState State;
    Forecast Practice;
};

inline bool ValidateMasteryRewards(AbilityDefinition const& ability, std::span<MasteryReward const> rewards)
{
    if (ability.Kind != AbilityKind::Mastery)
        return rewards.empty();
    if (ValidateDefinition(ability) != CatalogError::None || rewards.empty() || rewards.size() > MaximumMasteryRewards)
        return false;
    std::uint32_t previousLevel = ability.Ranks.front().Requirement.CharacterLevel;
    std::uint32_t previousProficiency = 1;
    std::uint32_t previousBonus = 0;
    for (MasteryReward const& reward : rewards)
    {
        if (reward.Requirement.CharacterLevel < previousLevel || reward.Requirement.CharacterLevel > 255 ||
            reward.Requirement.Proficiency <= previousProficiency || reward.HealingBonusBasisPoints <= previousBonus ||
            reward.HealingBonusBasisPoints > MaximumHealingMasteryBasisPoints)
            return false;
        previousLevel = reward.Requirement.CharacterLevel;
        previousProficiency = reward.Requirement.Proficiency;
        previousBonus = reward.HealingBonusBasisPoints;
    }
    return rewards.back().Requirement.Proficiency == CapAtLevel(ability, 255);
}

inline std::vector<MasteryRewardView> DescribeMasteryRewards(AbilityDefinition const& ability,
    std::span<MasteryReward const> rewards, TrainingPolicy policy, Progress progress, std::uint32_t characterLevel,
    bool learned, bool acquisitionPrerequisitesMet)
{
    if (!ValidateMasteryRewards(ability, rewards) || ability.Kind != AbilityKind::Mastery ||
        !ValidProgress(policy, progress) || !characterLevel)
        return {};
    std::vector<MasteryRewardView> result;
    result.reserve(rewards.size());
    for (MasteryReward const& reward : rewards)
    {
        Forecast const practice = UsesUntil(policy, progress, reward.Requirement.Proficiency,
            CapAtLevel(ability, characterLevel));
        bool const levelMet = characterLevel >= reward.Requirement.CharacterLevel;
        bool const practiceMet = progress.Proficiency >= reward.Requirement.Proficiency;
        RankState const state = !acquisitionPrerequisitesMet ? RankState::MissingPrerequisite :
            !learned ? RankState::AcquireIntroductoryAbility :
            levelMet && practiceMet ? RankState::Learned :
            levelMet ? RankState::NeedsPractice :
            practiceMet ? RankState::NeedsCharacterLevel : RankState::NeedsBoth;
        result.push_back({ reward, state, practice });
    }
    return result;
}

inline std::uint32_t HealingMasteryBonus(AbilityDefinition const& ability, std::span<MasteryReward const> rewards,
    Progress progress, std::uint32_t characterLevel, bool learned, bool acquisitionPrerequisitesMet)
{
    if (!learned || !acquisitionPrerequisitesMet || !ValidateMasteryRewards(ability, rewards) ||
        ability.Kind != AbilityKind::Mastery || !progress.Proficiency || !characterLevel)
        return 0;
    std::uint32_t bonus = 0;
    for (MasteryReward const& reward : rewards)
        if (progress.Proficiency >= reward.Requirement.Proficiency &&
            characterLevel >= reward.Requirement.CharacterLevel)
            bonus = reward.HealingBonusBasisPoints;
    return bonus;
}

inline std::uint32_t ApplyHealingMastery(std::uint32_t healing, std::uint32_t basisPoints)
{
    if (basisPoints > MaximumHealingMasteryBasisPoints)
        return healing;
    std::uint64_t const result = healing + static_cast<std::uint64_t>(healing) * basisPoints / 10000;
    return static_cast<std::uint32_t>(std::min(result,
        static_cast<std::uint64_t>(std::numeric_limits<std::uint32_t>::max())));
}
}

#endif
