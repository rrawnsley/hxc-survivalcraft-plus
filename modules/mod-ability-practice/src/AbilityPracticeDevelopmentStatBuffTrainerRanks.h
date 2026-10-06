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

inline constexpr std::array Entries = {
    Entry{
        { DefinitionVersion, AcquisitionSource::ClassGrant,
            { 22, 801523, AbilityKind::Ranked, RanksClass22Ability801523, CapsClass22Ability801523 },
            { BandsClass22Ability801523 }, OutcomeKind::Damage },
        PreviousRanksClass22Ability801523, PreviousCapsClass22Ability801523,
        { PreviousBandsClass22Ability801523 }, TrainerRanksClass22Ability801523
    }
};
}

#endif
