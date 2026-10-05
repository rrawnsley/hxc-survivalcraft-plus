// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_MASTERY_H
#define ABILITY_PRACTICE_MASTERY_H

#include "AbilityPracticeCatalog.h"

#include <cstdint>
#include <limits>
#include <vector>

namespace AbilityPractice
{
inline constexpr std::uint32_t MaximumMasteryBasisPoints = 200;
inline constexpr std::uint32_t MaximumHealingMasteryBasisPoints = MaximumMasteryBasisPoints;
inline constexpr std::size_t MaximumMasteryRewards = 8;
inline constexpr std::size_t MaximumClassMasteryRewards = 512;

struct MasteryReward
{
    Milestone Requirement;
    std::uint32_t HealingBonusBasisPoints;
    std::uint32_t DamageBonusBasisPoints = 0;
};

inline std::uint32_t MasteryBonusAmount(MasteryReward const& reward)
{
    return std::max(reward.HealingBonusBasisPoints, reward.DamageBonusBasisPoints);
}

inline bool ValidMasteryEffect(MasteryReward const& reward, bool healing)
{
    return healing ? reward.HealingBonusBasisPoints && !reward.DamageBonusBasisPoints :
        reward.DamageBonusBasisPoints && !reward.HealingBonusBasisPoints;
}

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
    bool const healing = rewards.front().HealingBonusBasisPoints != 0;
    for (MasteryReward const& reward : rewards)
    {
        if (reward.Requirement.CharacterLevel < previousLevel || reward.Requirement.CharacterLevel > 255 ||
            reward.Requirement.Proficiency <= previousProficiency || !ValidMasteryEffect(reward, healing) ||
            MasteryBonusAmount(reward) <= previousBonus || MasteryBonusAmount(reward) > MaximumMasteryBasisPoints)
            return false;
        previousLevel = reward.Requirement.CharacterLevel;
        previousProficiency = reward.Requirement.Proficiency;
        previousBonus = MasteryBonusAmount(reward);
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

inline std::uint32_t MasteryBonus(AbilityDefinition const& ability, std::span<MasteryReward const> rewards,
    Progress progress, std::uint32_t characterLevel, bool learned, bool acquisitionPrerequisitesMet, bool healing)
{
    if (!learned || !acquisitionPrerequisitesMet || !ValidateMasteryRewards(ability, rewards) ||
        ability.Kind != AbilityKind::Mastery || !progress.Proficiency || !characterLevel)
        return 0;
    std::uint32_t bonus = 0;
    for (MasteryReward const& reward : rewards)
        if (progress.Proficiency >= reward.Requirement.Proficiency &&
            characterLevel >= reward.Requirement.CharacterLevel)
            bonus = healing ? reward.HealingBonusBasisPoints : reward.DamageBonusBasisPoints;
    return bonus;
}

inline std::uint32_t HealingMasteryBonus(AbilityDefinition const& ability, std::span<MasteryReward const> rewards,
    Progress progress, std::uint32_t characterLevel, bool learned, bool acquisitionPrerequisitesMet)
{
    return MasteryBonus(ability, rewards, progress, characterLevel, learned, acquisitionPrerequisitesMet, true);
}

inline std::uint32_t DamageMasteryBonus(AbilityDefinition const& ability, std::span<MasteryReward const> rewards,
    Progress progress, std::uint32_t characterLevel, bool learned, bool acquisitionPrerequisitesMet)
{
    return MasteryBonus(ability, rewards, progress, characterLevel, learned, acquisitionPrerequisitesMet, false);
}

inline std::uint32_t ApplyHealingMastery(std::uint32_t healing, std::uint32_t basisPoints)
{
    if (basisPoints > MaximumHealingMasteryBasisPoints)
        return healing;
    std::uint64_t const result = healing + static_cast<std::uint64_t>(healing) * basisPoints / 10000;
    return static_cast<std::uint32_t>(std::min(result,
        static_cast<std::uint64_t>(std::numeric_limits<std::uint32_t>::max())));
}

inline std::uint32_t ApplyDamageMastery(std::uint32_t damage, std::uint32_t basisPoints)
{
    if (basisPoints > MaximumMasteryBasisPoints ||
        damage > static_cast<std::uint32_t>(std::numeric_limits<std::int32_t>::max()))
        return damage;
    std::uint64_t const result = damage + static_cast<std::uint64_t>(damage) * basisPoints / 10000;
    return static_cast<std::uint32_t>(std::min(result,
        static_cast<std::uint64_t>(std::numeric_limits<std::int32_t>::max())));
}
}

#endif
