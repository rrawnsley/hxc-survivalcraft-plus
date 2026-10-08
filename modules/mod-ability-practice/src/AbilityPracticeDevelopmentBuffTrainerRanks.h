// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_BUFF_TRAINER_RANKS_H
#define ABILITY_PRACTICE_DEVELOPMENT_BUFF_TRAINER_RANKS_H

#include "AbilityPracticeDevelopmentTrainerRanks.h"

namespace AbilityPractice::DevelopmentBuffTrainerRanks
{
inline constexpr std::uint32_t DefinitionVersion = 3;

using TrainerRank = DevelopmentTrainerRanks::TrainerRank;
using Entry = DevelopmentTrainerRanks::Entry;

inline constexpr std::array PreviousRanksClass12Ability300857 = {
    AbilityRank{ 300857, 1, { 4, 1 } },
    AbilityRank{ 300882, 2, { 10, 10 } },
    AbilityRank{ 300883, 3, { 24, 20 } },
    AbilityRank{ 300884, 4, { 38, 40 } },
    AbilityRank{ 300885, 5, { 52, 60 } },
    AbilityRank{ 300886, 6, { 60, 80 } }
};

inline constexpr std::array RanksClass12Ability300857 = {
    AbilityRank{ 300857, 1, { 4, 1 } },
    AbilityRank{ 300882, 2, { 10, 10 } },
    AbilityRank{ 300883, 3, { 24, 20 } },
    AbilityRank{ 300884, 4, { 38, 40 } },
    AbilityRank{ 300885, 5, { 52, 60 } },
    AbilityRank{ 300886, 6, { 60, 80 } },
    AbilityRank{ 300887, 7, { 65, 100 } }
};

inline constexpr std::array PreviousBandsClass12Ability300857 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 }
};

inline constexpr std::array BandsClass12Ability300857 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 }
};

inline constexpr auto PreviousCapsClass12Ability300857 = Development::RankCaps(PreviousRanksClass12Ability300857);
inline constexpr auto CapsClass12Ability300857 = Development::RankCaps(RanksClass12Ability300857);
inline constexpr std::array TrainerRanksClass12Ability300857 = {
    TrainerRank{ 300887, 65, 900012, { 300886, 0, 0 } }
};

inline constexpr std::array PreviousRanksClass13Ability707671 = {
    AbilityRank{ 707671, 1, { 10, 1 } },
    AbilityRank{ 707672, 2, { 20, 10 } },
    AbilityRank{ 707673, 3, { 30, 20 } },
    AbilityRank{ 707674, 4, { 40, 40 } },
    AbilityRank{ 707675, 5, { 50, 60 } },
    AbilityRank{ 707676, 6, { 60, 80 } }
};

inline constexpr std::array RanksClass13Ability707671 = {
    AbilityRank{ 707671, 1, { 10, 1 } },
    AbilityRank{ 707672, 2, { 20, 10 } },
    AbilityRank{ 707673, 3, { 30, 20 } },
    AbilityRank{ 707674, 4, { 40, 40 } },
    AbilityRank{ 707675, 5, { 50, 60 } },
    AbilityRank{ 707676, 6, { 60, 80 } },
    AbilityRank{ 707677, 7, { 68, 100 } }
};

inline constexpr std::array PreviousBandsClass13Ability707671 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 }
};

inline constexpr std::array BandsClass13Ability707671 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 }
};

inline constexpr auto PreviousCapsClass13Ability707671 = Development::RankCaps(PreviousRanksClass13Ability707671);
inline constexpr auto CapsClass13Ability707671 = Development::RankCaps(RanksClass13Ability707671);
inline constexpr std::array TrainerRanksClass13Ability707671 = {
    TrainerRank{ 707677, 68, 900013, { 707676, 0, 0 } }
};

inline constexpr std::array PreviousRanksClass27Ability800852 = {
    AbilityRank{ 800852, 1, { 4, 1 } },
    AbilityRank{ 300858, 2, { 14, 10 } },
    AbilityRank{ 300859, 3, { 24, 20 } },
    AbilityRank{ 300862, 4, { 34, 40 } },
    AbilityRank{ 300863, 5, { 44, 60 } },
    AbilityRank{ 300864, 6, { 54, 80 } },
    AbilityRank{ 300865, 7, { 60, 100 } }
};

inline constexpr std::array RanksClass27Ability800852 = {
    AbilityRank{ 800852, 1, { 4, 1 } },
    AbilityRank{ 300858, 2, { 14, 10 } },
    AbilityRank{ 300859, 3, { 24, 20 } },
    AbilityRank{ 300862, 4, { 34, 40 } },
    AbilityRank{ 300863, 5, { 44, 60 } },
    AbilityRank{ 300864, 6, { 54, 80 } },
    AbilityRank{ 300865, 7, { 60, 100 } },
    AbilityRank{ 300866, 8, { 65, 120 } }
};

inline constexpr std::array PreviousBandsClass27Ability800852 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 }
};

inline constexpr std::array BandsClass27Ability800852 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr auto PreviousCapsClass27Ability800852 = Development::RankCaps(PreviousRanksClass27Ability800852);
inline constexpr auto CapsClass27Ability800852 = Development::RankCaps(RanksClass27Ability800852);
inline constexpr std::array TrainerRanksClass27Ability800852 = {
    TrainerRank{ 300866, 65, 900027, { 300865, 0, 0 } }
};

inline constexpr std::array PreviousRanksClass28Ability803658 = {
    AbilityRank{ 803658, 1, { 16, 1 } },
    AbilityRank{ 803659, 2, { 24, 10 } },
    AbilityRank{ 803660, 3, { 34, 20 } },
    AbilityRank{ 803661, 4, { 44, 40 } },
    AbilityRank{ 803662, 5, { 54, 60 } },
    AbilityRank{ 803663, 6, { 60, 80 } }
};

inline constexpr std::array RanksClass28Ability803658 = {
    AbilityRank{ 803658, 1, { 16, 1 } },
    AbilityRank{ 803659, 2, { 24, 10 } },
    AbilityRank{ 803660, 3, { 34, 20 } },
    AbilityRank{ 803661, 4, { 44, 40 } },
    AbilityRank{ 803662, 5, { 54, 60 } },
    AbilityRank{ 803663, 6, { 60, 80 } },
    AbilityRank{ 803664, 7, { 61, 100 } }
};

inline constexpr std::array PreviousBandsClass28Ability803658 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 }
};

inline constexpr std::array BandsClass28Ability803658 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 }
};

inline constexpr auto PreviousCapsClass28Ability803658 = Development::RankCaps(PreviousRanksClass28Ability803658);
inline constexpr auto CapsClass28Ability803658 = Development::RankCaps(RanksClass28Ability803658);
inline constexpr std::array TrainerRanksClass28Ability803658 = {
    TrainerRank{ 803664, 61, 900028, { 803663, 0, 0 } }
};

inline constexpr std::array Entries = {
    Entry{
        { DefinitionVersion, AcquisitionSource::ClassGrant,
            { 12, 300857, AbilityKind::Ranked, RanksClass12Ability300857, CapsClass12Ability300857 },
            { BandsClass12Ability300857 }, OutcomeKind::Damage },
        PreviousRanksClass12Ability300857, PreviousCapsClass12Ability300857,
        { PreviousBandsClass12Ability300857 }, TrainerRanksClass12Ability300857
    },
    Entry{
        { DefinitionVersion, AcquisitionSource::ClassGrant,
            { 13, 707671, AbilityKind::Ranked, RanksClass13Ability707671, CapsClass13Ability707671 },
            { BandsClass13Ability707671 }, OutcomeKind::Damage },
        PreviousRanksClass13Ability707671, PreviousCapsClass13Ability707671,
        { PreviousBandsClass13Ability707671 }, TrainerRanksClass13Ability707671
    },
    Entry{
        { DefinitionVersion, AcquisitionSource::ClassGrant,
            { 27, 800852, AbilityKind::Ranked, RanksClass27Ability800852, CapsClass27Ability800852 },
            { BandsClass27Ability800852 }, OutcomeKind::Damage },
        PreviousRanksClass27Ability800852, PreviousCapsClass27Ability800852,
        { PreviousBandsClass27Ability800852 }, TrainerRanksClass27Ability800852
    },
    Entry{
        { DefinitionVersion, AcquisitionSource::ClassGrant,
            { 28, 803658, AbilityKind::Ranked, RanksClass28Ability803658, CapsClass28Ability803658 },
            { BandsClass28Ability803658 }, OutcomeKind::Damage },
        PreviousRanksClass28Ability803658, PreviousCapsClass28Ability803658,
        { PreviousBandsClass28Ability803658 }, TrainerRanksClass28Ability803658
    }
};
}

#endif
