// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_SPELL_POWER_BUFF_TRAINER_RANKS_H
#define ABILITY_PRACTICE_DEVELOPMENT_SPELL_POWER_BUFF_TRAINER_RANKS_H

#include "AbilityPracticeDevelopmentTrainerRanks.h"

namespace AbilityPractice::DevelopmentSpellPowerBuffTrainerRanks
{
inline constexpr std::uint32_t DefinitionVersion = 3;

using TrainerRank = DevelopmentTrainerRanks::TrainerRank;
using Entry = DevelopmentTrainerRanks::Entry;

inline constexpr std::array PreviousRanksClass27Ability575040 = {
    AbilityRank{ 575040, 1, { 28, 1 } },
    AbilityRank{ 575041, 2, { 38, 10 } },
    AbilityRank{ 575042, 3, { 48, 20 } },
    AbilityRank{ 575043, 4, { 58, 40 } }
};

inline constexpr std::array RanksClass27Ability575040 = {
    AbilityRank{ 575040, 1, { 28, 1 } },
    AbilityRank{ 575041, 2, { 38, 10 } },
    AbilityRank{ 575042, 3, { 48, 20 } },
    AbilityRank{ 575043, 4, { 58, 40 } },
    AbilityRank{ 575044, 5, { 68, 60 } }
};

inline constexpr std::array PreviousBandsClass27Ability575040 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 }
};

inline constexpr std::array BandsClass27Ability575040 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 }
};

inline constexpr auto PreviousCapsClass27Ability575040 = Development::RankCaps(PreviousRanksClass27Ability575040);
inline constexpr auto CapsClass27Ability575040 = Development::RankCaps(RanksClass27Ability575040);
inline constexpr std::array TrainerRanksClass27Ability575040 = {
    TrainerRank{ 575044, 68, 900027, { 575043, 0, 0 } }
};

inline constexpr std::array Entries = {
    Entry{
        { DefinitionVersion, AcquisitionSource::ClassGrant,
            { 27, 575040, AbilityKind::Ranked, RanksClass27Ability575040, CapsClass27Ability575040 },
            { BandsClass27Ability575040 }, OutcomeKind::Damage },
        PreviousRanksClass27Ability575040, PreviousCapsClass27Ability575040,
        { PreviousBandsClass27Ability575040 }, TrainerRanksClass27Ability575040
    }
};
}

#endif
