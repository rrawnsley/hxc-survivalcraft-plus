// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_MASTERY_PACING_H
#define ABILITY_PRACTICE_DEVELOPMENT_MASTERY_PACING_H

#include "AbilityPracticeProfiles.h"

namespace AbilityPractice::DevelopmentMasteryPacing
{
inline constexpr std::uint32_t PreviousDefinitionVersion = 1;
inline constexpr std::uint32_t DefinitionVersion = 2;

struct Entry
{
    std::uint32_t ClassId;
    std::uint32_t AbilityId;
    OutcomeKind ExpectedOutcome;
    std::span<AbilityRank const> ExpectedRanks;
    std::span<MasteryReward const> ExpectedRewards;
    TrainingPolicy PreviousPolicy;
    TrainingPolicy Policy;
};

inline constexpr std::array RanksClass26Ability801990 = {
    AbilityRank{ 801990, 1, { 16, 1 } }
};
inline constexpr std::array RewardsClass26Ability801990 = {
    MasteryReward{ { 16, 40 }, 50, 0 },
    MasteryReward{ { 24, 70 }, 100, 0 },
    MasteryReward{ { 32, 100 }, 200, 0 }
};
inline constexpr std::array PreviousBandsClass26Ability801990 = {
    TrainingBand{ 1, 30, 2 },
    TrainingBand{ 20, 30, 1 }
};
inline constexpr std::array BandsClass26Ability801990 = {
    TrainingBand{ 1, 16200, 1170 },
    TrainingBand{ 40, 16200, 900 }
};

inline constexpr std::array RanksClass29Ability805097 = {
    AbilityRank{ 805097, 1, { 12, 1 } }
};
inline constexpr std::array RewardsClass29Ability805097 = {
    MasteryReward{ { 12, 40 }, 0, 50 },
    MasteryReward{ { 20, 70 }, 0, 100 },
    MasteryReward{ { 28, 100 }, 0, 200 }
};
inline constexpr std::array PreviousBandsClass29Ability805097 = {
    TrainingBand{ 1, 30, 2 },
    TrainingBand{ 20, 30, 1 }
};
inline constexpr std::array BandsClass29Ability805097 = {
    TrainingBand{ 1, 10140, 1170 },
    TrainingBand{ 40, 10140, 900 }
};

inline constexpr std::array RanksClass30Ability504014 = {
    AbilityRank{ 504014, 1, { 20, 1 } }
};
inline constexpr std::array RewardsClass30Ability504014 = {
    MasteryReward{ { 20, 40 }, 0, 50 },
    MasteryReward{ { 28, 70 }, 0, 100 },
    MasteryReward{ { 36, 100 }, 0, 200 }
};
inline constexpr std::array PreviousBandsClass30Ability504014 = {
    TrainingBand{ 1, 30, 2 },
    TrainingBand{ 20, 30, 1 }
};
inline constexpr std::array BandsClass30Ability504014 = {
    TrainingBand{ 1, 1800, 1170 },
    TrainingBand{ 40, 1800, 900 }
};

inline constexpr std::array Entries = {
    Entry{ 26, 801990, OutcomeKind::Healing, RanksClass26Ability801990,
        RewardsClass26Ability801990, { PreviousBandsClass26Ability801990 }, { BandsClass26Ability801990 } },
    Entry{ 29, 805097, OutcomeKind::Damage, RanksClass29Ability805097,
        RewardsClass29Ability805097, { PreviousBandsClass29Ability805097 }, { BandsClass29Ability805097 } },
    Entry{ 30, 504014, OutcomeKind::Damage, RanksClass30Ability504014,
        RewardsClass30Ability504014, { PreviousBandsClass30Ability504014 }, { BandsClass30Ability504014 } }
};
}

#endif
