// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_TRAINER_RANKS_H
#define ABILITY_PRACTICE_DEVELOPMENT_TRAINER_RANKS_H

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeProfiles.h"

namespace AbilityPractice::DevelopmentTrainerRanks
{
inline constexpr std::uint32_t DefinitionVersion = 3;

struct TrainerRank
{
    std::uint32_t SpellId;
    std::uint32_t CharacterLevel;
    std::uint32_t TrainerId;
    std::array<std::uint32_t, 3> RequiredAbilities;
};

struct Entry
{
    AbilityProfile Profile;
    std::span<AbilityRank const> PreviousRanks;
    std::span<ProficiencyCap const> PreviousCaps;
    TrainingPolicy PreviousPolicy;
    std::span<TrainerRank const> AdditionalTrainerRanks;
};

inline constexpr std::array PreviousRanksClass13Ability807037 = {
    AbilityRank{ 807037, 1, { 1, 1 } },
    AbilityRank{ 807211, 2, { 6, 10 } },
    AbilityRank{ 807477, 3, { 14, 20 } },
    AbilityRank{ 808002, 4, { 22, 40 } },
    AbilityRank{ 808057, 5, { 30, 60 } },
    AbilityRank{ 808648, 6, { 38, 80 } },
    AbilityRank{ 808876, 7, { 46, 100 } },
    AbilityRank{ 809365, 8, { 54, 120 } },
    AbilityRank{ 572336, 9, { 60, 140 } }
};

inline constexpr std::array RanksClass13Ability807037 = {
    AbilityRank{ 807037, 1, { 1, 1 } },
    AbilityRank{ 807211, 2, { 6, 10 } },
    AbilityRank{ 807477, 3, { 14, 20 } },
    AbilityRank{ 808002, 4, { 22, 40 } },
    AbilityRank{ 808057, 5, { 30, 60 } },
    AbilityRank{ 808648, 6, { 38, 80 } },
    AbilityRank{ 808876, 7, { 46, 100 } },
    AbilityRank{ 809365, 8, { 54, 120 } },
    AbilityRank{ 572336, 9, { 60, 140 } },
    AbilityRank{ 572337, 10, { 68, 160 } }
};

inline constexpr std::array PreviousBandsClass13Ability807037 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 }
};

inline constexpr std::array BandsClass13Ability807037 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 },
    TrainingBand{ 140, 16200, 600 }
};

inline constexpr auto PreviousCapsClass13Ability807037 = Development::RankCaps(PreviousRanksClass13Ability807037);
inline constexpr auto CapsClass13Ability807037 = Development::RankCaps(RanksClass13Ability807037);
inline constexpr std::array TrainerRanksClass13Ability807037 = {
    TrainerRank{ 572337, 68, 900013, { 572336, 0, 0 } }
};

inline constexpr std::array PreviousRanksClass16Ability707044 = {
    AbilityRank{ 707044, 1, { 8, 1 } },
    AbilityRank{ 707905, 2, { 32, 10 } }
};

inline constexpr std::array RanksClass16Ability707044 = {
    AbilityRank{ 707044, 1, { 8, 1 } },
    AbilityRank{ 707905, 2, { 32, 10 } },
    AbilityRank{ 707906, 3, { 56, 20 } }
};

inline constexpr std::array PreviousBandsClass16Ability707044 = {
    TrainingBand{ 1, 5400, 270 }
};

inline constexpr std::array BandsClass16Ability707044 = {
    TrainingBand{ 1, 5400, 270 },
    TrainingBand{ 10, 5400, 300 }
};

inline constexpr auto PreviousCapsClass16Ability707044 = Development::RankCaps(PreviousRanksClass16Ability707044);
inline constexpr auto CapsClass16Ability707044 = Development::RankCaps(RanksClass16Ability707044);
inline constexpr std::array TrainerRanksClass16Ability707044 = {
    TrainerRank{ 707906, 56, 900016, { 707905, 0, 0 } }
};

inline constexpr std::array PreviousRanksClass19Ability801165 = {
    AbilityRank{ 801165, 1, { 22, 1 } },
    AbilityRank{ 803792, 2, { 30, 10 } }
};

inline constexpr std::array RanksClass19Ability801165 = {
    AbilityRank{ 801165, 1, { 22, 1 } },
    AbilityRank{ 803792, 2, { 30, 10 } },
    AbilityRank{ 803793, 3, { 40, 20 } },
    AbilityRank{ 803794, 4, { 48, 40 } },
    AbilityRank{ 803795, 5, { 54, 60 } },
    AbilityRank{ 803796, 6, { 60, 80 } }
};

inline constexpr std::array PreviousBandsClass19Ability801165 = {
    TrainingBand{ 1, 16200, 270 }
};

inline constexpr std::array BandsClass19Ability801165 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 }
};

inline constexpr auto PreviousCapsClass19Ability801165 = Development::RankCaps(PreviousRanksClass19Ability801165);
inline constexpr auto CapsClass19Ability801165 = Development::RankCaps(RanksClass19Ability801165);
inline constexpr std::array TrainerRanksClass19Ability801165 = {
    TrainerRank{ 803793, 40, 900019, { 803792, 0, 0 } },
    TrainerRank{ 803794, 48, 900019, { 803793, 0, 0 } },
    TrainerRank{ 803795, 54, 900019, { 803794, 0, 0 } },
    TrainerRank{ 803796, 60, 900019, { 803795, 0, 0 } }
};

inline constexpr std::array PreviousRanksClass26Ability575039 = {
    AbilityRank{ 575039, 1, { 32, 1 } },
    AbilityRank{ 575048, 2, { 38, 10 } },
    AbilityRank{ 575049, 3, { 44, 20 } },
    AbilityRank{ 575050, 4, { 50, 40 } },
    AbilityRank{ 575051, 5, { 56, 60 } }
};

inline constexpr std::array RanksClass26Ability575039 = {
    AbilityRank{ 575039, 1, { 32, 1 } },
    AbilityRank{ 575048, 2, { 38, 10 } },
    AbilityRank{ 575049, 3, { 44, 20 } },
    AbilityRank{ 575050, 4, { 50, 40 } },
    AbilityRank{ 575051, 5, { 56, 60 } },
    AbilityRank{ 575052, 6, { 62, 80 } }
};

inline constexpr std::array PreviousBandsClass26Ability575039 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 }
};

inline constexpr std::array BandsClass26Ability575039 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 }
};

inline constexpr auto PreviousCapsClass26Ability575039 = Development::RankCaps(PreviousRanksClass26Ability575039);
inline constexpr auto CapsClass26Ability575039 = Development::RankCaps(RanksClass26Ability575039);
inline constexpr std::array TrainerRanksClass26Ability575039 = {
    TrainerRank{ 575052, 62, 900026, { 575051, 0, 0 } }
};

inline constexpr std::array PreviousRanksClass28Ability802684 = {
    AbilityRank{ 802684, 1, { 20, 1 } },
    AbilityRank{ 802685, 2, { 26, 10 } },
    AbilityRank{ 802686, 3, { 32, 20 } },
    AbilityRank{ 802687, 4, { 38, 40 } },
    AbilityRank{ 802688, 5, { 44, 60 } },
    AbilityRank{ 802689, 6, { 50, 80 } },
    AbilityRank{ 802690, 7, { 54, 100 } },
    AbilityRank{ 802691, 8, { 60, 120 } }
};

inline constexpr std::array RanksClass28Ability802684 = {
    AbilityRank{ 802684, 1, { 20, 1 } },
    AbilityRank{ 802685, 2, { 26, 10 } },
    AbilityRank{ 802686, 3, { 32, 20 } },
    AbilityRank{ 802687, 4, { 38, 40 } },
    AbilityRank{ 802688, 5, { 44, 60 } },
    AbilityRank{ 802689, 6, { 50, 80 } },
    AbilityRank{ 802690, 7, { 54, 100 } },
    AbilityRank{ 802691, 8, { 60, 120 } },
    AbilityRank{ 575027, 9, { 66, 140 } }
};

inline constexpr std::array PreviousBandsClass28Ability802684 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array BandsClass28Ability802684 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 }
};

inline constexpr auto PreviousCapsClass28Ability802684 = Development::RankCaps(PreviousRanksClass28Ability802684);
inline constexpr auto CapsClass28Ability802684 = Development::RankCaps(RanksClass28Ability802684);
inline constexpr std::array TrainerRanksClass28Ability802684 = {
    TrainerRank{ 575027, 66, 900028, { 802691, 0, 0 } }
};

inline constexpr std::array PreviousRanksClass29Ability803198 = {
    AbilityRank{ 803198, 1, { 12, 1 } },
    AbilityRank{ 503165, 2, { 18, 10 } },
    AbilityRank{ 503166, 3, { 24, 20 } },
    AbilityRank{ 503167, 4, { 30, 40 } },
    AbilityRank{ 503168, 5, { 36, 60 } },
    AbilityRank{ 503169, 6, { 42, 80 } },
    AbilityRank{ 503170, 7, { 48, 100 } },
    AbilityRank{ 503171, 8, { 54, 120 } },
    AbilityRank{ 503172, 9, { 60, 140 } }
};

inline constexpr std::array RanksClass29Ability803198 = {
    AbilityRank{ 803198, 1, { 12, 1 } },
    AbilityRank{ 503165, 2, { 18, 10 } },
    AbilityRank{ 503166, 3, { 24, 20 } },
    AbilityRank{ 503167, 4, { 30, 40 } },
    AbilityRank{ 503168, 5, { 36, 60 } },
    AbilityRank{ 503169, 6, { 42, 80 } },
    AbilityRank{ 503170, 7, { 48, 100 } },
    AbilityRank{ 503171, 8, { 54, 120 } },
    AbilityRank{ 503172, 9, { 60, 140 } },
    AbilityRank{ 503173, 10, { 62, 160 } },
    AbilityRank{ 503174, 11, { 68, 180 } },
    AbilityRank{ 503175, 12, { 74, 200 } },
    AbilityRank{ 503176, 13, { 80, 220 } }
};

inline constexpr std::array PreviousBandsClass29Ability803198 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 }
};

inline constexpr std::array BandsClass29Ability803198 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 },
    TrainingBand{ 140, 16200, 600 },
    TrainingBand{ 160, 16200, 600 },
    TrainingBand{ 180, 16200, 600 },
    TrainingBand{ 200, 16200, 600 }
};

inline constexpr auto PreviousCapsClass29Ability803198 = Development::RankCaps(PreviousRanksClass29Ability803198);
inline constexpr auto CapsClass29Ability803198 = Development::RankCaps(RanksClass29Ability803198);
inline constexpr std::array TrainerRanksClass29Ability803198 = {
    TrainerRank{ 503173, 62, 900029, { 503172, 0, 0 } },
    TrainerRank{ 503174, 68, 900029, { 503172, 0, 0 } },
    TrainerRank{ 503175, 74, 900029, { 503172, 0, 0 } },
    TrainerRank{ 503176, 80, 900029, { 503172, 0, 0 } }
};

inline constexpr std::array PreviousRanksClass30Ability800174 = {
    AbilityRank{ 800174, 1, { 16, 1 } },
    AbilityRank{ 502989, 2, { 24, 10 } },
    AbilityRank{ 502990, 3, { 31, 20 } },
    AbilityRank{ 502991, 4, { 38, 40 } },
    AbilityRank{ 502992, 5, { 45, 60 } },
    AbilityRank{ 502993, 6, { 52, 80 } },
    AbilityRank{ 502994, 7, { 59, 100 } }
};

inline constexpr std::array RanksClass30Ability800174 = {
    AbilityRank{ 800174, 1, { 16, 1 } },
    AbilityRank{ 502989, 2, { 24, 10 } },
    AbilityRank{ 502990, 3, { 31, 20 } },
    AbilityRank{ 502991, 4, { 38, 40 } },
    AbilityRank{ 502992, 5, { 45, 60 } },
    AbilityRank{ 502993, 6, { 52, 80 } },
    AbilityRank{ 502994, 7, { 59, 100 } },
    AbilityRank{ 502995, 8, { 66, 120 } },
    AbilityRank{ 502996, 9, { 69, 140 } },
    AbilityRank{ 502997, 10, { 72, 160 } },
    AbilityRank{ 502998, 11, { 75, 180 } },
    AbilityRank{ 502999, 12, { 78, 200 } }
};

inline constexpr std::array PreviousBandsClass30Ability800174 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 }
};

inline constexpr std::array BandsClass30Ability800174 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 },
    TrainingBand{ 140, 16200, 600 },
    TrainingBand{ 160, 16200, 600 },
    TrainingBand{ 180, 16200, 600 }
};

inline constexpr auto PreviousCapsClass30Ability800174 = Development::RankCaps(PreviousRanksClass30Ability800174);
inline constexpr auto CapsClass30Ability800174 = Development::RankCaps(RanksClass30Ability800174);
inline constexpr std::array TrainerRanksClass30Ability800174 = {
    TrainerRank{ 502995, 66, 900030, { 502994, 0, 0 } },
    TrainerRank{ 502996, 69, 900030, { 502994, 0, 0 } },
    TrainerRank{ 502997, 72, 900030, { 502994, 0, 0 } },
    TrainerRank{ 502998, 75, 900030, { 502994, 0, 0 } },
    TrainerRank{ 502999, 78, 900030, { 502994, 0, 0 } }
};

inline constexpr std::array PreviousRanksClass31Ability803981 = {
    AbilityRank{ 803981, 1, { 2, 1 } },
    AbilityRank{ 503258, 2, { 16, 10 } },
    AbilityRank{ 503259, 3, { 24, 20 } },
    AbilityRank{ 503260, 4, { 30, 40 } },
    AbilityRank{ 503261, 5, { 38, 60 } },
    AbilityRank{ 503262, 6, { 46, 80 } },
    AbilityRank{ 503263, 7, { 52, 100 } },
    AbilityRank{ 503264, 8, { 60, 120 } }
};

inline constexpr std::array RanksClass31Ability803981 = {
    AbilityRank{ 803981, 1, { 2, 1 } },
    AbilityRank{ 503258, 2, { 16, 10 } },
    AbilityRank{ 503259, 3, { 24, 20 } },
    AbilityRank{ 503260, 4, { 30, 40 } },
    AbilityRank{ 503261, 5, { 38, 60 } },
    AbilityRank{ 503262, 6, { 46, 80 } },
    AbilityRank{ 503263, 7, { 52, 100 } },
    AbilityRank{ 503264, 8, { 60, 120 } },
    AbilityRank{ 503265, 9, { 66, 140 } },
    AbilityRank{ 503266, 10, { 73, 160 } }
};

inline constexpr std::array PreviousBandsClass31Ability803981 = {
    TrainingBand{ 1, 10140, 270 },
    TrainingBand{ 10, 10140, 300 },
    TrainingBand{ 20, 10140, 600 },
    TrainingBand{ 40, 10140, 600 },
    TrainingBand{ 60, 10140, 600 },
    TrainingBand{ 80, 10140, 600 },
    TrainingBand{ 100, 10140, 600 }
};

inline constexpr std::array BandsClass31Ability803981 = {
    TrainingBand{ 1, 10140, 270 },
    TrainingBand{ 10, 10140, 300 },
    TrainingBand{ 20, 10140, 600 },
    TrainingBand{ 40, 10140, 600 },
    TrainingBand{ 60, 10140, 600 },
    TrainingBand{ 80, 10140, 600 },
    TrainingBand{ 100, 10140, 600 },
    TrainingBand{ 120, 10140, 600 },
    TrainingBand{ 140, 10140, 600 }
};

inline constexpr auto PreviousCapsClass31Ability803981 = Development::RankCaps(PreviousRanksClass31Ability803981);
inline constexpr auto CapsClass31Ability803981 = Development::RankCaps(RanksClass31Ability803981);
inline constexpr std::array TrainerRanksClass31Ability803981 = {
    TrainerRank{ 503265, 66, 900031, { 503264, 0, 0 } },
    TrainerRank{ 503266, 73, 900031, { 503264, 0, 0 } }
};

inline constexpr std::array Entries = {
    Entry{
        { DefinitionVersion, AcquisitionSource::ClassGrant,
            { 13, 807037, AbilityKind::Ranked, RanksClass13Ability807037, CapsClass13Ability807037 },
            { BandsClass13Ability807037 }, OutcomeKind::Damage },
        PreviousRanksClass13Ability807037, PreviousCapsClass13Ability807037,
        { PreviousBandsClass13Ability807037 }, TrainerRanksClass13Ability807037
    },
    Entry{
        { DefinitionVersion, AcquisitionSource::ClassGrant,
            { 16, 707044, AbilityKind::Ranked, RanksClass16Ability707044, CapsClass16Ability707044 },
            { BandsClass16Ability707044 }, OutcomeKind::Fear },
        PreviousRanksClass16Ability707044, PreviousCapsClass16Ability707044,
        { PreviousBandsClass16Ability707044 }, TrainerRanksClass16Ability707044
    },
    Entry{
        { DefinitionVersion, AcquisitionSource::ClassGrant,
            { 19, 801165, AbilityKind::Ranked, RanksClass19Ability801165, CapsClass19Ability801165 },
            { BandsClass19Ability801165 }, OutcomeKind::Healing },
        PreviousRanksClass19Ability801165, PreviousCapsClass19Ability801165,
        { PreviousBandsClass19Ability801165 }, TrainerRanksClass19Ability801165
    },
    Entry{
        { DefinitionVersion, AcquisitionSource::ClassGrant,
            { 26, 575039, AbilityKind::Ranked, RanksClass26Ability575039, CapsClass26Ability575039 },
            { BandsClass26Ability575039 }, OutcomeKind::Healing },
        PreviousRanksClass26Ability575039, PreviousCapsClass26Ability575039,
        { PreviousBandsClass26Ability575039 }, TrainerRanksClass26Ability575039
    },
    Entry{
        { DefinitionVersion, AcquisitionSource::ClassGrant,
            { 28, 802684, AbilityKind::Ranked, RanksClass28Ability802684, CapsClass28Ability802684 },
            { BandsClass28Ability802684 }, OutcomeKind::Healing },
        PreviousRanksClass28Ability802684, PreviousCapsClass28Ability802684,
        { PreviousBandsClass28Ability802684 }, TrainerRanksClass28Ability802684
    },
    Entry{
        { DefinitionVersion, AcquisitionSource::ClassGrant,
            { 29, 803198, AbilityKind::Ranked, RanksClass29Ability803198, CapsClass29Ability803198 },
            { BandsClass29Ability803198 }, OutcomeKind::Damage },
        PreviousRanksClass29Ability803198, PreviousCapsClass29Ability803198,
        { PreviousBandsClass29Ability803198 }, TrainerRanksClass29Ability803198
    },
    Entry{
        { DefinitionVersion, AcquisitionSource::ClassGrant,
            { 30, 800174, AbilityKind::Ranked, RanksClass30Ability800174, CapsClass30Ability800174 },
            { BandsClass30Ability800174 }, OutcomeKind::Damage },
        PreviousRanksClass30Ability800174, PreviousCapsClass30Ability800174,
        { PreviousBandsClass30Ability800174 }, TrainerRanksClass30Ability800174
    },
    Entry{
        { DefinitionVersion, AcquisitionSource::ClassGrant,
            { 31, 803981, AbilityKind::Ranked, RanksClass31Ability803981, CapsClass31Ability803981 },
            { BandsClass31Ability803981 }, OutcomeKind::Damage },
        PreviousRanksClass31Ability803981, PreviousCapsClass31Ability803981,
        { PreviousBandsClass31Ability803981 }, TrainerRanksClass31Ability803981
    }
};
}

#endif
