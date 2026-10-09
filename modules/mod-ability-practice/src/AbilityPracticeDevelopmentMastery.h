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
inline constexpr std::array BaneOfBetrayal = { AbilityRank{ 712483, 1, { 30, 1 } } };
inline constexpr std::array BaneOfBetrayalBands = {
    TrainingBand{ 1, 2700, 1170 }, TrainingBand{ 40, 2700, 900 }
};
inline constexpr TrainingPolicy BaneOfBetrayalPolicy{ BaneOfBetrayalBands };
inline constexpr std::array BaneOfBetrayalRewards = {
    MasteryReward{ { 30, 40 }, 0, 50 },
    MasteryReward{ { 38, 70 }, 0, 100 },
    MasteryReward{ { 46, 100 }, 0, 200 }
};
inline constexpr std::array SoulCapture = { AbilityRank{ 561289, 1, { 4, 1 } } };
inline constexpr std::array SoulCaptureBands = {
    TrainingBand{ 1, 5400, 1170 }, TrainingBand{ 40, 5400, 900 }
};
inline constexpr TrainingPolicy SoulCapturePolicy{ SoulCaptureBands };
inline constexpr std::array SoulCaptureRewards = {
    MasteryReward{ { 8, 40 }, 50 },
    MasteryReward{ { 14, 70 }, 100 },
    MasteryReward{ { 20, 100 }, 200 }
};
inline constexpr std::array FelBargain = { AbilityRank{ 807942, 1, { 22, 1 } } };
inline constexpr std::array FelBargainCaps = {
    ProficiencyCap{ 1, 1 }, ProficiencyCap{ 22, 40 }, ProficiencyCap{ 30, 70 }, ProficiencyCap{ 38, 100 }
};
inline constexpr std::array FelBargainBands = {
    TrainingBand{ 1, 450, 1170 }, TrainingBand{ 40, 450, 900 }
};
inline constexpr TrainingPolicy FelBargainPolicy{ FelBargainBands };
inline constexpr std::array FelBargainRewards = {
    MasteryReward{ { 30, 40 }, 50 },
    MasteryReward{ { 38, 70 }, 100 },
    MasteryReward{ { 46, 100 }, 200 }
};
inline constexpr std::array FrostSigil = { AbilityRank{ 805381, 1, { 34, 1 } } };
inline constexpr std::array FrostSigilCaps = {
    ProficiencyCap{ 1, 1 }, ProficiencyCap{ 34, 40 }, ProficiencyCap{ 42, 70 }, ProficiencyCap{ 50, 100 }
};
inline constexpr std::array FrostSigilBands = {
    TrainingBand{ 1, 8100, 1170 }, TrainingBand{ 40, 8100, 900 }
};
inline constexpr TrainingPolicy FrostSigilPolicy{ FrostSigilBands };
inline constexpr std::array FrostSigilRewards = {
    MasteryReward{ { 42, 40 }, 0, 50 },
    MasteryReward{ { 50, 70 }, 0, 100 },
    MasteryReward{ { 58, 100 }, 0, 200 }
};
inline constexpr std::uint32_t FrostPracticeIntervalSeconds = 10;
inline constexpr std::array ScriptedProfiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 14, 807942, AbilityKind::Mastery, FelBargain, FelBargainCaps }, FelBargainPolicy, OutcomeKind::Healing,
        FelBargainRewards },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 30, 561289, AbilityKind::Mastery, SoulCapture, Caps }, SoulCapturePolicy, OutcomeKind::Healing,
        SoulCaptureRewards },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 14, 712483, AbilityKind::Mastery, BaneOfBetrayal, Caps }, BaneOfBetrayalPolicy, OutcomeKind::Damage,
        BaneOfBetrayalRewards },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 32, 805381, AbilityKind::Mastery, FrostSigil, FrostSigilCaps }, FrostSigilPolicy, OutcomeKind::Damage,
        FrostSigilRewards }
};
inline bool IsFrostSigil(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 32 && profile.Definition.AbilityId == 805381 &&
        profile.Definition.Kind == AbilityKind::Mastery && profile.Outcome == OutcomeKind::Damage;
}
inline bool IsBaneOfBetrayal(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 14 && profile.Definition.AbilityId == 712483 &&
        profile.Definition.Kind == AbilityKind::Mastery && profile.Outcome == OutcomeKind::Damage;
}
inline bool IsFelBargain(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 14 && profile.Definition.AbilityId == 807942 &&
        profile.Definition.Kind == AbilityKind::Mastery && profile.Outcome == OutcomeKind::Healing;
}
inline bool IsSoulCapture(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 30 && profile.Definition.AbilityId == 561289 &&
        profile.Definition.Kind == AbilityKind::Mastery && profile.Outcome == OutcomeKind::Healing;
}
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
        { 30, 504014, AbilityKind::Mastery, Soulslam, Caps }, Development::Policy, OutcomeKind::Damage, SoulslamRewards }
};
}

#endif
