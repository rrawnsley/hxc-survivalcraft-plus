// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_MASTERY_H
#define ABILITY_PRACTICE_DEVELOPMENT_MASTERY_H

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeProfiles.h"

namespace AbilityPractice::DevelopmentMastery
{
inline constexpr std::array PommelSmash = { AbilityRank{ 680515, 1, { 12, 1 } } };
inline constexpr std::array Lunge = { AbilityRank{ 500126, 1, { 8, 1 } } };
inline constexpr std::array PommelSmashBands = {
    TrainingBand{ 1, 16200, 1170 }, TrainingBand{ 40, 16200, 900 }
};
inline constexpr TrainingPolicy PommelSmashPolicy{ PommelSmashBands };
inline constexpr std::array LungeBands = {
    TrainingBand{ 1, 3240, 1170 }, TrainingBand{ 40, 3240, 900 }
};
inline constexpr TrainingPolicy LungePolicy{ LungeBands };
inline constexpr std::array HandOfElune = { AbilityRank{ 801990, 1, { 16, 1 } } };
inline constexpr std::array VileSting = { AbilityRank{ 805097, 1, { 12, 1 } } };
inline constexpr std::array Soulslam = { AbilityRank{ 504014, 1, { 20, 1 } } };
inline constexpr std::array DreadridersStomp = { AbilityRank{ 804702, 1, { 20, 1 } } };
inline constexpr std::array HellfireTrample = { AbilityRank{ 804704, 1, { 20, 1 } } };
inline constexpr std::array DreadridersStompBands = {
    TrainingBand{ 1, 16200, 1170 }, TrainingBand{ 40, 16200, 900 }
};
inline constexpr TrainingPolicy DreadridersStompPolicy{ DreadridersStompBands };
inline constexpr std::array HellfireTrampleBands = {
    TrainingBand{ 1, 1350, 1170 }, TrainingBand{ 40, 1350, 900 }
};
inline constexpr TrainingPolicy HellfireTramplePolicy{ HellfireTrampleBands };
inline constexpr auto Caps = []
{
    auto result = Development::Caps;
    for (ProficiencyCap& cap : result)
        cap.Proficiency = std::min(cap.Proficiency, std::uint32_t{ 100 });
    return result;
}();
inline constexpr std::array Rewards = {
    MasteryReward{ { 16, 40 }, 50 },
    MasteryReward{ { 24, 70 }, 100 },
    MasteryReward{ { 32, 100 }, 200 }
};
inline constexpr std::array VileStingRewards = {
    MasteryReward{ { 12, 40 }, 0, 50 },
    MasteryReward{ { 20, 70 }, 0, 100 },
    MasteryReward{ { 28, 100 }, 0, 200 }
};
inline constexpr std::array SoulslamRewards = {
    MasteryReward{ { 20, 40 }, 0, 50 },
    MasteryReward{ { 28, 70 }, 0, 100 },
    MasteryReward{ { 36, 100 }, 0, 200 }
};
inline constexpr std::array DreadridersStompRewards = {
    MasteryReward{ { 20, 40 }, 0, 50 },
    MasteryReward{ { 28, 70 }, 0, 100 },
    MasteryReward{ { 36, 100 }, 0, 200 }
};
inline constexpr std::array HellfireTrampleRewards = {
    MasteryReward{ { 20, 40 }, 0, 50 },
    MasteryReward{ { 28, 70 }, 0, 100 },
    MasteryReward{ { 36, 100 }, 0, 200 }
};
inline constexpr std::array PommelSmashRewards = {
    MasteryReward{ { 12, 40 }, 0, 50 },
    MasteryReward{ { 20, 70 }, 0, 100 },
    MasteryReward{ { 28, 100 }, 0, 200 }
};
inline constexpr std::array LungeRewards = {
    MasteryReward{ { 8, 40 }, 0, 50 },
    MasteryReward{ { 16, 70 }, 0, 100 },
    MasteryReward{ { 24, 100 }, 0, 200 }
};
inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 15, 680515, AbilityKind::Mastery, PommelSmash, Caps }, PommelSmashPolicy, OutcomeKind::Damage,
        PommelSmashRewards },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 20, 500126, AbilityKind::Mastery, Lunge, Caps }, LungePolicy, OutcomeKind::Damage, LungeRewards },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 17, 804702, AbilityKind::Mastery, DreadridersStomp, Caps }, DreadridersStompPolicy, OutcomeKind::Damage,
        DreadridersStompRewards },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 17, 804704, AbilityKind::Mastery, HellfireTrample, Caps }, HellfireTramplePolicy, OutcomeKind::Damage,
        HellfireTrampleRewards },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 26, 801990, AbilityKind::Mastery, HandOfElune, Caps }, Development::Policy, OutcomeKind::Healing, Rewards },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 29, 805097, AbilityKind::Mastery, VileSting, Caps }, Development::Policy, OutcomeKind::Damage,
        VileStingRewards },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 30, 504014, AbilityKind::Mastery, Soulslam, Caps }, Development::Policy, OutcomeKind::Damage, SoulslamRewards }
};
}

#endif
