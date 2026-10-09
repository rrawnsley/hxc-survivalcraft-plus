// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_STAT_BUFF_TRAINER_RANKS_H
#define ABILITY_PRACTICE_DEVELOPMENT_STAT_BUFF_TRAINER_RANKS_H

#include "AbilityPracticeDevelopmentTrainerRanks.h"

namespace AbilityPractice::DevelopmentStatBuffTrainerRanks
{
inline constexpr std::uint32_t DefinitionVersion = 3;

using TrainerRank = DevelopmentTrainerRanks::TrainerRank;
using Entry = DevelopmentTrainerRanks::Entry;

inline constexpr std::array PreviousRanksClass22Ability801523 = {
    AbilityRank{ 801523, 1, { 12, 1 } },
    AbilityRank{ 802827, 2, { 28, 10 } },
    AbilityRank{ 802828, 3, { 42, 20 } },
    AbilityRank{ 802829, 4, { 56, 40 } }
};

inline constexpr std::array RanksClass22Ability801523 = {
    AbilityRank{ 801523, 1, { 12, 1 } },
    AbilityRank{ 802827, 2, { 28, 10 } },
    AbilityRank{ 802828, 3, { 42, 20 } },
    AbilityRank{ 802829, 4, { 56, 40 } },
    AbilityRank{ 802830, 5, { 70, 60 } }
};

inline constexpr std::array PreviousBandsClass22Ability801523 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 }
};

inline constexpr std::array BandsClass22Ability801523 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 }
};

inline constexpr auto PreviousCapsClass22Ability801523 = Development::RankCaps(PreviousRanksClass22Ability801523);
inline constexpr auto CapsClass22Ability801523 = Development::RankCaps(RanksClass22Ability801523);
inline constexpr std::array TrainerRanksClass22Ability801523 = {
    TrainerRank{ 802830, 70, 900022, { 802829, 0, 0 } }
};

inline constexpr std::array PreviousRanksClass26Ability573343 = {
    AbilityRank{ 573343, 1, { 30, 1 } },
    AbilityRank{ 573344, 2, { 42, 10 } },
    AbilityRank{ 573345, 3, { 56, 20 } }
};

inline constexpr std::array RanksClass26Ability573343 = {
    AbilityRank{ 573343, 1, { 30, 1 } },
    AbilityRank{ 573344, 2, { 42, 10 } },
    AbilityRank{ 573345, 3, { 56, 20 } },
    AbilityRank{ 573346, 4, { 68, 40 } },
    AbilityRank{ 573347, 5, { 76, 60 } }
};

inline constexpr std::array PreviousBandsClass26Ability573343 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 }
};

inline constexpr std::array BandsClass26Ability573343 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 }
};

inline constexpr auto PreviousCapsClass26Ability573343 = Development::RankCaps(PreviousRanksClass26Ability573343);
inline constexpr auto CapsClass26Ability573343 = Development::RankCaps(RanksClass26Ability573343);
inline constexpr std::array TrainerRanksClass26Ability573343 = {
    TrainerRank{ 573346, 68, 900026, { 573345, 0, 0 } },
    TrainerRank{ 573347, 76, 900026, { 573346, 0, 0 } }
};

inline constexpr std::array PreviousRanksClass32Ability801106 = {
    AbilityRank{ 801106, 1, { 24, 1 } },
    AbilityRank{ 803749, 2, { 36, 10 } },
    AbilityRank{ 803750, 3, { 48, 20 } },
    AbilityRank{ 803751, 4, { 58, 40 } },
    AbilityRank{ 803752, 5, { 60, 60 } }
};

inline constexpr std::array RanksClass32Ability801106 = {
    AbilityRank{ 801106, 1, { 24, 1 } },
    AbilityRank{ 803749, 2, { 36, 10 } },
    AbilityRank{ 803750, 3, { 48, 20 } },
    AbilityRank{ 803751, 4, { 58, 40 } },
    AbilityRank{ 803752, 5, { 60, 60 } },
    AbilityRank{ 803753, 6, { 76, 80 } }
};

inline constexpr std::array PreviousBandsClass32Ability801106 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 }
};

inline constexpr std::array BandsClass32Ability801106 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 }
};

inline constexpr auto PreviousCapsClass32Ability801106 = Development::RankCaps(PreviousRanksClass32Ability801106);
inline constexpr auto CapsClass32Ability801106 = Development::RankCaps(RanksClass32Ability801106);
inline constexpr std::array TrainerRanksClass32Ability801106 = {
    TrainerRank{ 803753, 76, 900032, { 803752, 0, 0 } }
};

inline constexpr std::array PreviousRanksClass32Ability803748 = {
    AbilityRank{ 803748, 1, { 20, 1 } },
    AbilityRank{ 803759, 2, { 32, 10 } },
    AbilityRank{ 803760, 3, { 44, 20 } },
    AbilityRank{ 803761, 4, { 56, 40 } },
    AbilityRank{ 803762, 5, { 60, 60 } }
};

inline constexpr std::array RanksClass32Ability803748 = {
    AbilityRank{ 803748, 1, { 20, 1 } },
    AbilityRank{ 803759, 2, { 32, 10 } },
    AbilityRank{ 803760, 3, { 44, 20 } },
    AbilityRank{ 803761, 4, { 56, 40 } },
    AbilityRank{ 803762, 5, { 60, 60 } },
    AbilityRank{ 803763, 6, { 76, 80 } }
};

inline constexpr std::array PreviousBandsClass32Ability803748 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 }
};

inline constexpr std::array BandsClass32Ability803748 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 }
};

inline constexpr auto PreviousCapsClass32Ability803748 = Development::RankCaps(PreviousRanksClass32Ability803748);
inline constexpr auto CapsClass32Ability803748 = Development::RankCaps(RanksClass32Ability803748);
inline constexpr std::array TrainerRanksClass32Ability803748 = {
    TrainerRank{ 803763, 76, 900032, { 803762, 0, 0 } }
};

inline constexpr std::array Entries = {
    Entry{
        { DefinitionVersion, AcquisitionSource::ClassGrant,
            { 22, 801523, AbilityKind::Ranked, RanksClass22Ability801523, CapsClass22Ability801523 },
            { BandsClass22Ability801523 }, OutcomeKind::Damage },
        PreviousRanksClass22Ability801523, PreviousCapsClass22Ability801523,
        { PreviousBandsClass22Ability801523 }, TrainerRanksClass22Ability801523
    },
    Entry{
        { DefinitionVersion, AcquisitionSource::ClassGrant,
            { 26, 573343, AbilityKind::Ranked, RanksClass26Ability573343, CapsClass26Ability573343 },
            { BandsClass26Ability573343 }, OutcomeKind::Damage },
        PreviousRanksClass26Ability573343, PreviousCapsClass26Ability573343,
        { PreviousBandsClass26Ability573343 }, TrainerRanksClass26Ability573343
    },
    Entry{
        { DefinitionVersion, AcquisitionSource::ClassGrant,
            { 32, 801106, AbilityKind::Ranked, RanksClass32Ability801106, CapsClass32Ability801106 },
            { BandsClass32Ability801106 }, OutcomeKind::Damage },
        PreviousRanksClass32Ability801106, PreviousCapsClass32Ability801106,
        { PreviousBandsClass32Ability801106 }, TrainerRanksClass32Ability801106
    },
    Entry{
        { DefinitionVersion, AcquisitionSource::ClassGrant,
            { 32, 803748, AbilityKind::Ranked, RanksClass32Ability803748, CapsClass32Ability803748 },
            { BandsClass32Ability803748 }, OutcomeKind::Damage },
        PreviousRanksClass32Ability803748, PreviousCapsClass32Ability803748,
        { PreviousBandsClass32Ability803748 }, TrainerRanksClass32Ability803748
    }
};
}

#endif
