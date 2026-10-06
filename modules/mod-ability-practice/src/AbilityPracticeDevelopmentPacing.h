// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_PACING_H
#define ABILITY_PRACTICE_DEVELOPMENT_PACING_H

#include "AbilityPracticeProfiles.h"

namespace AbilityPractice::DevelopmentPacing
{
inline constexpr std::uint32_t PreviousDefinitionVersion = 1;
inline constexpr std::uint32_t DefinitionVersion = 2;
inline constexpr std::array PreviousBands = { TrainingBand{ 1, 30, 2 }, TrainingBand{ 20, 30, 1 } };
inline constexpr TrainingPolicy PreviousPolicy{ PreviousBands };

struct Entry
{
    std::uint32_t ClassId;
    std::uint32_t AbilityId;
    std::span<AbilityRank const> ExpectedRanks;
    TrainingPolicy Policy;
};

inline constexpr std::array RanksClass12Ability500002 = {
    AbilityRank{ 500002, 1, { 14, 1 } },
    AbilityRank{ 500450, 2, { 22, 10 } },
    AbilityRank{ 500451, 3, { 30, 20 } },
    AbilityRank{ 500452, 4, { 42, 40 } },
    AbilityRank{ 500453, 5, { 54, 60 } }
};
inline constexpr std::array BandsClass12Ability500002 = {
    TrainingBand{ 1, 13500, 270 },
    TrainingBand{ 10, 13500, 300 },
    TrainingBand{ 20, 13500, 600 },
    TrainingBand{ 40, 13500, 600 }
};

inline constexpr std::array RanksClass12Ability500919 = {
    AbilityRank{ 500919, 1, { 6, 1 } },
    AbilityRank{ 504912, 2, { 14, 10 } },
    AbilityRank{ 504913, 3, { 22, 20 } },
    AbilityRank{ 504914, 4, { 30, 40 } },
    AbilityRank{ 504915, 5, { 40, 60 } },
    AbilityRank{ 504916, 6, { 50, 80 } }
};
inline constexpr std::array BandsClass12Ability500919 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 }
};

inline constexpr std::array RanksClass12Ability520523 = {
    AbilityRank{ 520523, 1, { 8, 1 } },
    AbilityRank{ 520710, 2, { 32, 10 } },
    AbilityRank{ 520711, 3, { 48, 20 } }
};
inline constexpr std::array BandsClass12Ability520523 = {
    TrainingBand{ 1, 2040, 270 },
    TrainingBand{ 10, 2040, 300 }
};

inline constexpr std::array RanksClass12Ability801576 = {
    AbilityRank{ 801576, 1, { 1, 1 } },
    AbilityRank{ 802444, 2, { 8, 10 } },
    AbilityRank{ 802445, 3, { 16, 20 } },
    AbilityRank{ 802446, 4, { 24, 40 } },
    AbilityRank{ 802447, 5, { 32, 60 } },
    AbilityRank{ 802448, 6, { 40, 80 } },
    AbilityRank{ 802449, 7, { 48, 100 } },
    AbilityRank{ 802450, 8, { 56, 120 } }
};
inline constexpr std::array BandsClass12Ability801576 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array RanksClass12Ability801755 = {
    AbilityRank{ 801755, 1, { 2, 1 } },
    AbilityRank{ 501027, 2, { 10, 10 } },
    AbilityRank{ 501028, 3, { 18, 20 } },
    AbilityRank{ 501029, 4, { 26, 40 } },
    AbilityRank{ 501030, 5, { 34, 60 } },
    AbilityRank{ 501031, 6, { 42, 80 } },
    AbilityRank{ 501032, 7, { 50, 100 } },
    AbilityRank{ 501033, 8, { 58, 120 } },
    AbilityRank{ 501034, 9, { 60, 140 } },
    AbilityRank{ 501035, 10, { 66, 160 } }
};
inline constexpr std::array BandsClass12Ability801755 = {
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

inline constexpr std::array RanksClass12Ability804136 = {
    AbilityRank{ 804136, 1, { 1, 1 } },
    AbilityRank{ 806876, 2, { 12, 10 } },
    AbilityRank{ 806877, 3, { 20, 20 } },
    AbilityRank{ 806878, 4, { 28, 40 } },
    AbilityRank{ 806879, 5, { 36, 60 } },
    AbilityRank{ 806880, 6, { 44, 80 } },
    AbilityRank{ 806881, 7, { 52, 100 } },
    AbilityRank{ 572614, 8, { 60, 120 } }
};
inline constexpr std::array BandsClass12Ability804136 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array RanksClass13Ability801670 = {
    AbilityRank{ 801670, 1, { 1, 1 } },
    AbilityRank{ 501198, 2, { 8, 10 } },
    AbilityRank{ 501199, 3, { 18, 20 } },
    AbilityRank{ 501200, 4, { 26, 40 } },
    AbilityRank{ 501201, 5, { 34, 60 } },
    AbilityRank{ 501202, 6, { 42, 80 } },
    AbilityRank{ 501203, 7, { 50, 100 } },
    AbilityRank{ 501204, 8, { 58, 120 } },
    AbilityRank{ 501205, 9, { 60, 140 } },
    AbilityRank{ 501206, 10, { 76, 160 } }
};
inline constexpr std::array BandsClass13Ability801670 = {
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

inline constexpr std::array RanksClass13Ability801693 = {
    AbilityRank{ 801693, 1, { 4, 1 } },
    AbilityRank{ 501153, 2, { 12, 10 } },
    AbilityRank{ 501154, 3, { 18, 20 } },
    AbilityRank{ 501155, 4, { 26, 40 } },
    AbilityRank{ 501156, 5, { 34, 60 } },
    AbilityRank{ 501157, 6, { 42, 80 } },
    AbilityRank{ 501158, 7, { 50, 100 } },
    AbilityRank{ 504608, 8, { 58, 120 } }
};
inline constexpr std::array BandsClass13Ability801693 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array RanksClass13Ability801696 = {
    AbilityRank{ 801696, 1, { 16, 1 } },
    AbilityRank{ 501207, 2, { 24, 10 } },
    AbilityRank{ 501208, 3, { 32, 20 } },
    AbilityRank{ 501209, 4, { 40, 40 } },
    AbilityRank{ 501210, 5, { 48, 60 } },
    AbilityRank{ 501211, 6, { 56, 80 } },
    AbilityRank{ 501212, 7, { 60, 100 } },
    AbilityRank{ 501213, 8, { 68, 120 } }
};
inline constexpr std::array BandsClass13Ability801696 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
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
    AbilityRank{ 572336, 9, { 60, 140 } }
};
inline constexpr std::array BandsClass13Ability807037 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 }
};

inline constexpr std::array RanksClass14Ability552210 = {
    AbilityRank{ 552210, 1, { 24, 1 } },
    AbilityRank{ 552211, 2, { 36, 10 } },
    AbilityRank{ 552212, 3, { 44, 20 } },
    AbilityRank{ 552213, 4, { 56, 40 } }
};
inline constexpr std::array BandsClass14Ability552210 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 }
};

inline constexpr std::array RanksClass14Ability801312 = {
    AbilityRank{ 801312, 1, { 2, 1 } },
    AbilityRank{ 501281, 2, { 6, 10 } },
    AbilityRank{ 501282, 3, { 12, 20 } },
    AbilityRank{ 501283, 4, { 20, 40 } },
    AbilityRank{ 501284, 5, { 28, 60 } },
    AbilityRank{ 501285, 6, { 36, 80 } },
    AbilityRank{ 501286, 7, { 44, 100 } },
    AbilityRank{ 501287, 8, { 52, 120 } },
    AbilityRank{ 501288, 9, { 60, 140 } },
    AbilityRank{ 501289, 10, { 68, 160 } },
    AbilityRank{ 501290, 11, { 76, 180 } },
    AbilityRank{ 501291, 12, { 80, 200 } }
};
inline constexpr std::array BandsClass14Ability801312 = {
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

inline constexpr std::array RanksClass14Ability802060 = {
    AbilityRank{ 802060, 1, { 1, 1 } },
    AbilityRank{ 501314, 2, { 10, 10 } },
    AbilityRank{ 501315, 3, { 16, 20 } },
    AbilityRank{ 501316, 4, { 26, 40 } },
    AbilityRank{ 501317, 5, { 34, 60 } },
    AbilityRank{ 501318, 6, { 42, 80 } },
    AbilityRank{ 501319, 7, { 50, 100 } },
    AbilityRank{ 501320, 8, { 56, 120 } },
    AbilityRank{ 501321, 9, { 60, 140 } }
};
inline constexpr std::array BandsClass14Ability802060 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 }
};

inline constexpr std::array RanksClass15Ability500093 = {
    AbilityRank{ 500093, 1, { 6, 1 } },
    AbilityRank{ 501337, 2, { 20, 10 } },
    AbilityRank{ 501338, 3, { 28, 20 } },
    AbilityRank{ 501339, 4, { 36, 40 } },
    AbilityRank{ 501340, 5, { 44, 60 } },
    AbilityRank{ 501341, 6, { 52, 80 } },
    AbilityRank{ 501342, 7, { 60, 100 } },
    AbilityRank{ 501343, 8, { 68, 120 } }
};
inline constexpr std::array BandsClass15Ability500093 = {
    TrainingBand{ 1, 5400, 270 },
    TrainingBand{ 10, 5400, 300 },
    TrainingBand{ 20, 5400, 600 },
    TrainingBand{ 40, 5400, 600 },
    TrainingBand{ 60, 5400, 600 },
    TrainingBand{ 80, 5400, 600 },
    TrainingBand{ 100, 5400, 600 }
};

inline constexpr std::array RanksClass15Ability680491 = {
    AbilityRank{ 680491, 1, { 4, 1 } },
    AbilityRank{ 572295, 2, { 26, 10 } },
    AbilityRank{ 572296, 3, { 36, 20 } },
    AbilityRank{ 572297, 4, { 46, 40 } },
    AbilityRank{ 572298, 5, { 56, 60 } }
};
inline constexpr std::array BandsClass15Ability680491 = {
    TrainingBand{ 1, 690, 270 },
    TrainingBand{ 10, 690, 300 },
    TrainingBand{ 20, 690, 600 },
    TrainingBand{ 40, 690, 600 }
};

inline constexpr std::array RanksClass15Ability802024 = {
    AbilityRank{ 802024, 1, { 1, 1 } },
    AbilityRank{ 802248, 2, { 8, 10 } },
    AbilityRank{ 802249, 3, { 18, 20 } },
    AbilityRank{ 802250, 4, { 28, 40 } },
    AbilityRank{ 802251, 5, { 38, 60 } },
    AbilityRank{ 802252, 6, { 48, 80 } },
    AbilityRank{ 574342, 7, { 58, 100 } },
    AbilityRank{ 574343, 8, { 60, 120 } }
};
inline constexpr std::array BandsClass15Ability802024 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array RanksClass15Ability804179 = {
    AbilityRank{ 804179, 1, { 1, 1 } },
    AbilityRank{ 680256, 2, { 6, 10 } },
    AbilityRank{ 680257, 3, { 14, 20 } },
    AbilityRank{ 680258, 4, { 22, 40 } },
    AbilityRank{ 680259, 5, { 30, 60 } },
    AbilityRank{ 680260, 6, { 38, 80 } },
    AbilityRank{ 680261, 7, { 46, 100 } },
    AbilityRank{ 680262, 8, { 54, 120 } },
    AbilityRank{ 681203, 9, { 60, 140 } }
};
inline constexpr std::array BandsClass15Ability804179 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 }
};

inline constexpr std::array RanksClass15Ability804191 = {
    AbilityRank{ 804191, 1, { 2, 1 } },
    AbilityRank{ 680264, 2, { 8, 10 } },
    AbilityRank{ 680265, 3, { 20, 20 } },
    AbilityRank{ 680266, 4, { 30, 40 } },
    AbilityRank{ 680267, 5, { 40, 60 } },
    AbilityRank{ 680268, 6, { 50, 80 } },
    AbilityRank{ 680269, 7, { 60, 100 } }
};
inline constexpr std::array BandsClass15Ability804191 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 }
};

inline constexpr std::array RanksClass16Ability500038 = {
    AbilityRank{ 500038, 1, { 6, 1 } },
    AbilityRank{ 501469, 2, { 12, 10 } },
    AbilityRank{ 501470, 3, { 20, 20 } },
    AbilityRank{ 501471, 4, { 28, 40 } },
    AbilityRank{ 501472, 5, { 36, 60 } },
    AbilityRank{ 501473, 6, { 44, 80 } },
    AbilityRank{ 501474, 7, { 52, 100 } },
    AbilityRank{ 501475, 8, { 58, 120 } }
};
inline constexpr std::array BandsClass16Ability500038 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array RanksClass16Ability500040 = {
    AbilityRank{ 500040, 1, { 1, 1 } },
    AbilityRank{ 501388, 2, { 6, 10 } },
    AbilityRank{ 501389, 3, { 12, 20 } },
    AbilityRank{ 501390, 4, { 20, 40 } },
    AbilityRank{ 501391, 5, { 28, 60 } },
    AbilityRank{ 501392, 6, { 36, 80 } },
    AbilityRank{ 501393, 7, { 44, 100 } },
    AbilityRank{ 501394, 8, { 52, 120 } },
    AbilityRank{ 501395, 9, { 60, 140 } },
    AbilityRank{ 501396, 10, { 69, 160 } },
    AbilityRank{ 501397, 11, { 74, 180 } },
    AbilityRank{ 501398, 12, { 79, 200 } },
    AbilityRank{ 501399, 13, { 84, 220 } }
};
inline constexpr std::array BandsClass16Ability500040 = {
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

inline constexpr std::array RanksClass16Ability707044 = {
    AbilityRank{ 707044, 1, { 8, 1 } },
    AbilityRank{ 707905, 2, { 32, 10 } }
};
inline constexpr std::array BandsClass16Ability707044 = {
    TrainingBand{ 1, 5400, 270 }
};

inline constexpr std::array RanksClass16Ability800227 = {
    AbilityRank{ 800227, 1, { 8, 1 } },
    AbilityRank{ 501415, 2, { 18, 10 } },
    AbilityRank{ 501416, 3, { 26, 20 } },
    AbilityRank{ 501417, 4, { 34, 40 } },
    AbilityRank{ 501418, 5, { 42, 60 } },
    AbilityRank{ 501419, 6, { 50, 80 } },
    AbilityRank{ 501420, 7, { 58, 100 } }
};
inline constexpr std::array BandsClass16Ability800227 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 }
};

inline constexpr std::array RanksClass16Ability801844 = {
    AbilityRank{ 801844, 1, { 4, 1 } },
    AbilityRank{ 501421, 2, { 10, 10 } },
    AbilityRank{ 501422, 3, { 18, 20 } },
    AbilityRank{ 501423, 4, { 26, 40 } },
    AbilityRank{ 501424, 5, { 34, 60 } },
    AbilityRank{ 501425, 6, { 42, 80 } },
    AbilityRank{ 501426, 7, { 50, 100 } },
    AbilityRank{ 501427, 8, { 56, 120 } },
    AbilityRank{ 501428, 9, { 60, 140 } },
    AbilityRank{ 501429, 10, { 68, 160 } },
    AbilityRank{ 501430, 11, { 74, 180 } },
    AbilityRank{ 501431, 12, { 78, 200 } },
    AbilityRank{ 501432, 13, { 80, 220 } }
};
inline constexpr std::array BandsClass16Ability801844 = {
    TrainingBand{ 1, 13500, 270 },
    TrainingBand{ 10, 13500, 300 },
    TrainingBand{ 20, 13500, 600 },
    TrainingBand{ 40, 13500, 600 },
    TrainingBand{ 60, 13500, 600 },
    TrainingBand{ 80, 13500, 600 },
    TrainingBand{ 100, 13500, 600 },
    TrainingBand{ 120, 13500, 600 },
    TrainingBand{ 140, 13500, 600 },
    TrainingBand{ 160, 13500, 600 },
    TrainingBand{ 180, 13500, 600 },
    TrainingBand{ 200, 13500, 600 }
};

inline constexpr std::array RanksClass16Ability804020 = {
    AbilityRank{ 804020, 1, { 1, 1 } },
    AbilityRank{ 503326, 2, { 6, 10 } },
    AbilityRank{ 503327, 3, { 14, 20 } },
    AbilityRank{ 503328, 4, { 22, 40 } },
    AbilityRank{ 503329, 5, { 30, 60 } },
    AbilityRank{ 503330, 6, { 38, 80 } },
    AbilityRank{ 503331, 7, { 46, 100 } },
    AbilityRank{ 503332, 8, { 54, 120 } },
    AbilityRank{ 504634, 9, { 60, 140 } }
};
inline constexpr std::array BandsClass16Ability804020 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 }
};

inline constexpr std::array RanksClass16Ability805288 = {
    AbilityRank{ 805288, 1, { 2, 1 } },
    AbilityRank{ 807254, 2, { 10, 10 } },
    AbilityRank{ 807255, 3, { 20, 20 } },
    AbilityRank{ 807256, 4, { 30, 40 } },
    AbilityRank{ 807257, 5, { 40, 60 } },
    AbilityRank{ 807258, 6, { 50, 80 } },
    AbilityRank{ 807259, 7, { 60, 100 } }
};
inline constexpr std::array BandsClass16Ability805288 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 }
};

inline constexpr std::array RanksClass17Ability500020 = {
    AbilityRank{ 500020, 1, { 6, 1 } },
    AbilityRank{ 501488, 2, { 22, 10 } },
    AbilityRank{ 501489, 3, { 38, 20 } },
    AbilityRank{ 501490, 4, { 54, 40 } }
};
inline constexpr std::array BandsClass17Ability500020 = {
    TrainingBand{ 1, 2310, 270 },
    TrainingBand{ 10, 2310, 300 },
    TrainingBand{ 20, 2310, 600 }
};

inline constexpr std::array RanksClass17Ability500904 = {
    AbilityRank{ 500904, 1, { 1, 1 } },
    AbilityRank{ 501499, 2, { 10, 10 } },
    AbilityRank{ 501500, 3, { 18, 20 } },
    AbilityRank{ 501501, 4, { 26, 40 } },
    AbilityRank{ 501502, 5, { 34, 60 } },
    AbilityRank{ 501503, 6, { 42, 80 } },
    AbilityRank{ 501504, 7, { 50, 100 } },
    AbilityRank{ 501505, 8, { 58, 120 } },
    AbilityRank{ 501506, 9, { 66, 140 } },
    AbilityRank{ 501507, 10, { 76, 160 } }
};
inline constexpr std::array BandsClass17Ability500904 = {
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

inline constexpr std::array RanksClass17Ability800168 = {
    AbilityRank{ 800168, 1, { 1, 1 } },
    AbilityRank{ 802416, 2, { 8, 10 } },
    AbilityRank{ 802417, 3, { 16, 20 } },
    AbilityRank{ 802418, 4, { 24, 40 } },
    AbilityRank{ 802419, 5, { 32, 60 } },
    AbilityRank{ 802420, 6, { 40, 80 } },
    AbilityRank{ 802421, 7, { 48, 100 } },
    AbilityRank{ 803899, 8, { 54, 120 } },
    AbilityRank{ 803900, 9, { 60, 140 } }
};
inline constexpr std::array BandsClass17Ability800168 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 }
};

inline constexpr std::array RanksClass17Ability800340 = {
    AbilityRank{ 800340, 1, { 12, 1 } },
    AbilityRank{ 501508, 2, { 24, 10 } },
    AbilityRank{ 501509, 3, { 36, 20 } },
    AbilityRank{ 501510, 4, { 48, 40 } },
    AbilityRank{ 578119, 5, { 58, 60 } }
};
inline constexpr std::array BandsClass17Ability800340 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 }
};

inline constexpr std::array RanksClass17Ability801016 = {
    AbilityRank{ 801016, 1, { 1, 1 } },
    AbilityRank{ 501511, 2, { 8, 10 } },
    AbilityRank{ 501512, 3, { 16, 20 } },
    AbilityRank{ 501513, 4, { 24, 40 } },
    AbilityRank{ 501514, 5, { 32, 60 } },
    AbilityRank{ 501515, 6, { 40, 80 } },
    AbilityRank{ 501516, 7, { 48, 100 } },
    AbilityRank{ 501517, 8, { 56, 120 } },
    AbilityRank{ 501518, 9, { 60, 140 } },
    AbilityRank{ 501519, 10, { 68, 160 } },
    AbilityRank{ 501520, 11, { 76, 180 } }
};
inline constexpr std::array BandsClass17Ability801016 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 },
    TrainingBand{ 140, 16200, 600 },
    TrainingBand{ 160, 16200, 600 }
};

inline constexpr std::array RanksClass17Ability801059 = {
    AbilityRank{ 801059, 1, { 8, 1 } },
    AbilityRank{ 802411, 2, { 16, 10 } },
    AbilityRank{ 802412, 3, { 24, 20 } },
    AbilityRank{ 802413, 4, { 32, 40 } },
    AbilityRank{ 802414, 5, { 40, 60 } },
    AbilityRank{ 802415, 6, { 48, 80 } },
    AbilityRank{ 573448, 7, { 56, 100 } }
};
inline constexpr std::array BandsClass17Ability801059 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 }
};

inline constexpr std::array RanksClass18Ability704159 = {
    AbilityRank{ 704159, 1, { 20, 1 } },
    AbilityRank{ 707701, 2, { 28, 10 } },
    AbilityRank{ 707702, 3, { 34, 20 } },
    AbilityRank{ 707703, 4, { 44, 40 } },
    AbilityRank{ 707704, 5, { 54, 60 } }
};
inline constexpr std::array BandsClass18Ability704159 = {
    TrainingBand{ 1, 2700, 270 },
    TrainingBand{ 10, 2700, 300 },
    TrainingBand{ 20, 2700, 600 },
    TrainingBand{ 40, 2700, 600 }
};

inline constexpr std::array RanksClass18Ability800311 = {
    AbilityRank{ 800311, 1, { 1, 1 } },
    AbilityRank{ 802439, 2, { 8, 10 } },
    AbilityRank{ 802440, 3, { 16, 20 } },
    AbilityRank{ 802441, 4, { 24, 40 } },
    AbilityRank{ 802442, 5, { 32, 60 } },
    AbilityRank{ 802443, 6, { 40, 80 } },
    AbilityRank{ 573286, 7, { 50, 100 } },
    AbilityRank{ 573292, 8, { 60, 120 } }
};
inline constexpr std::array BandsClass18Ability800311 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array RanksClass18Ability800316 = {
    AbilityRank{ 800316, 1, { 6, 1 } },
    AbilityRank{ 802739, 2, { 16, 10 } },
    AbilityRank{ 802740, 3, { 24, 20 } },
    AbilityRank{ 802741, 4, { 32, 40 } },
    AbilityRank{ 802742, 5, { 40, 60 } },
    AbilityRank{ 802743, 6, { 48, 80 } },
    AbilityRank{ 802744, 7, { 56, 100 } }
};
inline constexpr std::array BandsClass18Ability800316 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 }
};

inline constexpr std::array RanksClass18Ability802197 = {
    AbilityRank{ 802197, 1, { 1, 1 } },
    AbilityRank{ 501546, 2, { 24, 10 } },
    AbilityRank{ 501547, 3, { 40, 20 } },
    AbilityRank{ 501548, 4, { 56, 40 } }
};
inline constexpr std::array BandsClass18Ability802197 = {
    TrainingBand{ 1, 2700, 270 },
    TrainingBand{ 10, 2700, 300 },
    TrainingBand{ 20, 2700, 600 }
};

inline constexpr std::array RanksClass18Ability802284 = {
    AbilityRank{ 802284, 1, { 2, 1 } },
    AbilityRank{ 573204, 2, { 10, 10 } },
    AbilityRank{ 573205, 3, { 18, 20 } },
    AbilityRank{ 573206, 4, { 26, 40 } },
    AbilityRank{ 573207, 5, { 32, 60 } },
    AbilityRank{ 573208, 6, { 38, 80 } },
    AbilityRank{ 573209, 7, { 44, 100 } },
    AbilityRank{ 573210, 8, { 50, 120 } },
    AbilityRank{ 573211, 9, { 56, 140 } }
};
inline constexpr std::array BandsClass18Ability802284 = {
    TrainingBand{ 1, 8100, 270 },
    TrainingBand{ 10, 8100, 300 },
    TrainingBand{ 20, 8100, 600 },
    TrainingBand{ 40, 8100, 600 },
    TrainingBand{ 60, 8100, 600 },
    TrainingBand{ 80, 8100, 600 },
    TrainingBand{ 100, 8100, 600 },
    TrainingBand{ 120, 8100, 600 }
};

inline constexpr std::array RanksClass18Ability805150 = {
    AbilityRank{ 805150, 1, { 8, 1 } },
    AbilityRank{ 504177, 2, { 16, 10 } },
    AbilityRank{ 504178, 3, { 24, 20 } },
    AbilityRank{ 504179, 4, { 32, 40 } },
    AbilityRank{ 504180, 5, { 40, 60 } },
    AbilityRank{ 504181, 6, { 48, 80 } },
    AbilityRank{ 504182, 7, { 56, 100 } }
};
inline constexpr std::array BandsClass18Ability805150 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 }
};

inline constexpr std::array RanksClass19Ability801165 = {
    AbilityRank{ 801165, 1, { 22, 1 } },
    AbilityRank{ 803792, 2, { 30, 10 } }
};
inline constexpr std::array BandsClass19Ability801165 = {
    TrainingBand{ 1, 16200, 270 }
};

inline constexpr std::array RanksClass19Ability801443 = {
    AbilityRank{ 801443, 1, { 1, 1 } },
    AbilityRank{ 501570, 2, { 10, 10 } },
    AbilityRank{ 501571, 3, { 18, 20 } },
    AbilityRank{ 501572, 4, { 26, 40 } },
    AbilityRank{ 501573, 5, { 34, 60 } },
    AbilityRank{ 501574, 6, { 42, 80 } },
    AbilityRank{ 570232, 7, { 50, 100 } },
    AbilityRank{ 570233, 8, { 58, 120 } }
};
inline constexpr std::array BandsClass19Ability801443 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array RanksClass19Ability801445 = {
    AbilityRank{ 801445, 1, { 12, 1 } },
    AbilityRank{ 501582, 2, { 18, 10 } },
    AbilityRank{ 501583, 3, { 24, 20 } },
    AbilityRank{ 501584, 4, { 30, 40 } },
    AbilityRank{ 501585, 5, { 36, 60 } },
    AbilityRank{ 501586, 6, { 42, 80 } },
    AbilityRank{ 501587, 7, { 48, 100 } },
    AbilityRank{ 501588, 8, { 54, 120 } },
    AbilityRank{ 573049, 9, { 60, 140 } }
};
inline constexpr std::array BandsClass19Ability801445 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 }
};

inline constexpr std::array RanksClass19Ability801448 = {
    AbilityRank{ 801448, 1, { 2, 1 } },
    AbilityRank{ 803373, 2, { 10, 10 } },
    AbilityRank{ 803374, 3, { 18, 20 } },
    AbilityRank{ 803375, 4, { 26, 40 } },
    AbilityRank{ 803376, 5, { 34, 60 } },
    AbilityRank{ 803377, 6, { 42, 80 } },
    AbilityRank{ 803378, 7, { 50, 100 } },
    AbilityRank{ 578276, 8, { 58, 120 } }
};
inline constexpr std::array BandsClass19Ability801448 = {
    TrainingBand{ 1, 13500, 270 },
    TrainingBand{ 10, 13500, 300 },
    TrainingBand{ 20, 13500, 600 },
    TrainingBand{ 40, 13500, 600 },
    TrainingBand{ 60, 13500, 600 },
    TrainingBand{ 80, 13500, 600 },
    TrainingBand{ 100, 13500, 600 }
};

inline constexpr std::array RanksClass19Ability801478 = {
    AbilityRank{ 801478, 1, { 8, 1 } },
    AbilityRank{ 501601, 2, { 16, 10 } },
    AbilityRank{ 501602, 3, { 22, 20 } },
    AbilityRank{ 501603, 4, { 32, 40 } },
    AbilityRank{ 501604, 5, { 40, 60 } },
    AbilityRank{ 501605, 6, { 48, 80 } },
    AbilityRank{ 501606, 7, { 58, 100 } }
};
inline constexpr std::array BandsClass19Ability801478 = {
    TrainingBand{ 1, 450, 270 },
    TrainingBand{ 10, 450, 300 },
    TrainingBand{ 20, 450, 600 },
    TrainingBand{ 40, 450, 600 },
    TrainingBand{ 60, 450, 600 },
    TrainingBand{ 80, 450, 600 }
};

inline constexpr std::array RanksClass19Ability803157 = {
    AbilityRank{ 803157, 1, { 1, 1 } },
    AbilityRank{ 503135, 2, { 8, 10 } },
    AbilityRank{ 503136, 3, { 18, 20 } },
    AbilityRank{ 503137, 4, { 26, 40 } },
    AbilityRank{ 503138, 5, { 34, 60 } },
    AbilityRank{ 503139, 6, { 42, 80 } },
    AbilityRank{ 503140, 7, { 50, 100 } },
    AbilityRank{ 503141, 8, { 60, 120 } }
};
inline constexpr std::array BandsClass19Ability803157 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array RanksClass19Ability804906 = {
    AbilityRank{ 804906, 1, { 4, 1 } },
    AbilityRank{ 806864, 2, { 12, 10 } },
    AbilityRank{ 806865, 3, { 20, 20 } },
    AbilityRank{ 806866, 4, { 28, 40 } },
    AbilityRank{ 806867, 5, { 36, 60 } },
    AbilityRank{ 806868, 6, { 44, 80 } },
    AbilityRank{ 567538, 7, { 52, 100 } },
    AbilityRank{ 567539, 8, { 60, 120 } },
    AbilityRank{ 567540, 9, { 68, 140 } },
    AbilityRank{ 567541, 10, { 76, 160 } }
};
inline constexpr std::array BandsClass19Ability804906 = {
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

inline constexpr std::array RanksClass20Ability500125 = {
    AbilityRank{ 500125, 1, { 1, 1 } },
    AbilityRank{ 501607, 2, { 6, 10 } },
    AbilityRank{ 501608, 3, { 14, 20 } },
    AbilityRank{ 501609, 4, { 22, 40 } },
    AbilityRank{ 501610, 5, { 30, 60 } },
    AbilityRank{ 501611, 6, { 38, 80 } },
    AbilityRank{ 501612, 7, { 46, 100 } },
    AbilityRank{ 501613, 8, { 54, 120 } },
    AbilityRank{ 501614, 9, { 60, 140 } },
    AbilityRank{ 572332, 10, { 68, 160 } }
};
inline constexpr std::array BandsClass20Ability500125 = {
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

inline constexpr std::array RanksClass20Ability500169 = {
    AbilityRank{ 500169, 1, { 12, 1 } },
    AbilityRank{ 500436, 2, { 18, 10 } },
    AbilityRank{ 500437, 3, { 24, 20 } },
    AbilityRank{ 500438, 4, { 30, 40 } },
    AbilityRank{ 500439, 5, { 38, 60 } },
    AbilityRank{ 500440, 6, { 46, 80 } },
    AbilityRank{ 500441, 7, { 52, 100 } },
    AbilityRank{ 500444, 8, { 58, 120 } }
};
inline constexpr std::array BandsClass20Ability500169 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array RanksClass20Ability800156 = {
    AbilityRank{ 800156, 1, { 6, 1 } },
    AbilityRank{ 501695, 2, { 12, 10 } },
    AbilityRank{ 501696, 3, { 18, 20 } },
    AbilityRank{ 501697, 4, { 24, 40 } },
    AbilityRank{ 503613, 5, { 30, 60 } },
    AbilityRank{ 503614, 6, { 34, 80 } },
    AbilityRank{ 503615, 7, { 42, 100 } },
    AbilityRank{ 572549, 8, { 48, 120 } },
    AbilityRank{ 572550, 9, { 54, 140 } },
    AbilityRank{ 572551, 10, { 60, 160 } }
};
inline constexpr std::array BandsClass20Ability800156 = {
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

inline constexpr std::array RanksClass20Ability800772 = {
    AbilityRank{ 800772, 1, { 2, 1 } },
    AbilityRank{ 802568, 2, { 10, 10 } },
    AbilityRank{ 802569, 3, { 20, 20 } },
    AbilityRank{ 802570, 4, { 28, 40 } },
    AbilityRank{ 802571, 5, { 34, 60 } },
    AbilityRank{ 802572, 6, { 42, 80 } },
    AbilityRank{ 802573, 7, { 50, 100 } },
    AbilityRank{ 802580, 8, { 56, 120 } }
};
inline constexpr std::array BandsClass20Ability800772 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array RanksClass20Ability802310 = {
    AbilityRank{ 802310, 1, { 1, 1 } },
    AbilityRank{ 504079, 2, { 10, 10 } },
    AbilityRank{ 504080, 3, { 16, 20 } },
    AbilityRank{ 504081, 4, { 26, 40 } },
    AbilityRank{ 504082, 5, { 36, 60 } },
    AbilityRank{ 504083, 6, { 46, 80 } },
    AbilityRank{ 504084, 7, { 52, 100 } },
    AbilityRank{ 504085, 8, { 56, 120 } },
    AbilityRank{ 504086, 9, { 64, 140 } }
};
inline constexpr std::array BandsClass20Ability802310 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 }
};

inline constexpr std::array RanksClass20Ability804685 = {
    AbilityRank{ 804685, 1, { 8, 1 } },
    AbilityRank{ 806928, 2, { 14, 10 } },
    AbilityRank{ 806929, 3, { 20, 20 } },
    AbilityRank{ 806930, 4, { 28, 40 } },
    AbilityRank{ 806931, 5, { 36, 60 } },
    AbilityRank{ 806932, 6, { 44, 80 } },
    AbilityRank{ 578304, 7, { 52, 100 } },
    AbilityRank{ 578305, 8, { 60, 120 } }
};
inline constexpr std::array BandsClass20Ability804685 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array RanksClass21Ability500073 = {
    AbilityRank{ 500073, 1, { 16, 1 } },
    AbilityRank{ 501704, 2, { 24, 10 } },
    AbilityRank{ 501705, 3, { 30, 20 } },
    AbilityRank{ 501706, 4, { 38, 40 } },
    AbilityRank{ 501707, 5, { 46, 60 } },
    AbilityRank{ 575836, 6, { 54, 80 } },
    AbilityRank{ 575837, 7, { 62, 100 } }
};
inline constexpr std::array BandsClass21Ability500073 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 }
};

inline constexpr std::array RanksClass21Ability500074 = {
    AbilityRank{ 500074, 1, { 1, 1 } },
    AbilityRank{ 572727, 2, { 6, 10 } },
    AbilityRank{ 572728, 3, { 16, 20 } },
    AbilityRank{ 572729, 4, { 24, 40 } },
    AbilityRank{ 572730, 5, { 36, 60 } },
    AbilityRank{ 572731, 6, { 48, 80 } },
    AbilityRank{ 572732, 7, { 60, 100 } }
};
inline constexpr std::array BandsClass21Ability500074 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 }
};

inline constexpr std::array RanksClass21Ability800083 = {
    AbilityRank{ 800083, 1, { 1, 1 } },
    AbilityRank{ 501724, 2, { 8, 10 } },
    AbilityRank{ 501725, 3, { 14, 20 } },
    AbilityRank{ 501726, 4, { 22, 40 } },
    AbilityRank{ 501727, 5, { 28, 60 } },
    AbilityRank{ 501728, 6, { 34, 80 } },
    AbilityRank{ 501729, 7, { 42, 100 } },
    AbilityRank{ 501730, 8, { 48, 120 } },
    AbilityRank{ 501731, 9, { 54, 140 } },
    AbilityRank{ 501732, 10, { 60, 160 } },
    AbilityRank{ 501733, 11, { 68, 180 } },
    AbilityRank{ 501734, 12, { 74, 200 } }
};
inline constexpr std::array BandsClass21Ability800083 = {
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

inline constexpr std::array RanksClass21Ability802036 = {
    AbilityRank{ 802036, 1, { 1, 1 } },
    AbilityRank{ 501715, 2, { 10, 10 } },
    AbilityRank{ 501716, 3, { 18, 20 } },
    AbilityRank{ 501717, 4, { 26, 40 } },
    AbilityRank{ 501718, 5, { 34, 60 } },
    AbilityRank{ 501719, 6, { 42, 80 } },
    AbilityRank{ 501720, 7, { 50, 100 } },
    AbilityRank{ 501721, 8, { 58, 120 } },
    AbilityRank{ 501722, 9, { 66, 140 } },
    AbilityRank{ 501723, 10, { 74, 160 } }
};
inline constexpr std::array BandsClass21Ability802036 = {
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

inline constexpr std::array RanksClass21Ability804940 = {
    AbilityRank{ 804940, 1, { 4, 1 } },
    AbilityRank{ 805082, 2, { 10, 10 } },
    AbilityRank{ 805083, 3, { 18, 20 } },
    AbilityRank{ 805084, 4, { 26, 40 } },
    AbilityRank{ 805085, 5, { 34, 60 } },
    AbilityRank{ 805086, 6, { 40, 80 } },
    AbilityRank{ 805087, 7, { 46, 100 } },
    AbilityRank{ 805088, 8, { 52, 120 } },
    AbilityRank{ 582530, 9, { 58, 140 } },
    AbilityRank{ 582531, 10, { 66, 160 } }
};
inline constexpr std::array BandsClass21Ability804940 = {
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

inline constexpr std::array RanksClass21Ability807237 = {
    AbilityRank{ 807237, 1, { 4, 1 } },
    AbilityRank{ 807324, 2, { 10, 10 } },
    AbilityRank{ 807325, 3, { 18, 20 } },
    AbilityRank{ 807326, 4, { 26, 40 } },
    AbilityRank{ 807327, 5, { 34, 60 } },
    AbilityRank{ 807328, 6, { 42, 80 } },
    AbilityRank{ 807329, 7, { 50, 100 } },
    AbilityRank{ 807330, 8, { 58, 120 } }
};
inline constexpr std::array BandsClass21Ability807237 = {
    TrainingBand{ 1, 13500, 270 },
    TrainingBand{ 10, 13500, 300 },
    TrainingBand{ 20, 13500, 600 },
    TrainingBand{ 40, 13500, 600 },
    TrainingBand{ 60, 13500, 600 },
    TrainingBand{ 80, 13500, 600 },
    TrainingBand{ 100, 13500, 600 }
};

inline constexpr std::array RanksClass22Ability503875 = {
    AbilityRank{ 503875, 1, { 8, 1 } },
    AbilityRank{ 503876, 2, { 16, 10 } },
    AbilityRank{ 503877, 3, { 22, 20 } },
    AbilityRank{ 503878, 4, { 30, 40 } },
    AbilityRank{ 503879, 5, { 36, 60 } },
    AbilityRank{ 503880, 6, { 42, 80 } },
    AbilityRank{ 582758, 7, { 48, 100 } },
    AbilityRank{ 582759, 8, { 54, 120 } },
    AbilityRank{ 582760, 9, { 60, 140 } }
};
inline constexpr std::array BandsClass22Ability503875 = {
    TrainingBand{ 1, 7050, 270 },
    TrainingBand{ 10, 7050, 300 },
    TrainingBand{ 20, 7050, 600 },
    TrainingBand{ 40, 7050, 600 },
    TrainingBand{ 60, 7050, 600 },
    TrainingBand{ 80, 7050, 600 },
    TrainingBand{ 100, 7050, 600 },
    TrainingBand{ 120, 7050, 600 }
};

inline constexpr std::array RanksClass22Ability520175 = {
    AbilityRank{ 520175, 1, { 4, 1 } },
    AbilityRank{ 520702, 2, { 14, 10 } },
    AbilityRank{ 520703, 3, { 22, 20 } },
    AbilityRank{ 520704, 4, { 30, 40 } },
    AbilityRank{ 520705, 5, { 38, 60 } },
    AbilityRank{ 520706, 6, { 46, 80 } },
    AbilityRank{ 520707, 7, { 52, 100 } }
};
inline constexpr std::array BandsClass22Ability520175 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 }
};

inline constexpr std::array RanksClass22Ability800856 = {
    AbilityRank{ 800856, 1, { 2, 1 } },
    AbilityRank{ 801028, 2, { 8, 10 } },
    AbilityRank{ 801029, 3, { 18, 20 } },
    AbilityRank{ 801030, 4, { 28, 40 } },
    AbilityRank{ 801031, 5, { 34, 60 } },
    AbilityRank{ 801032, 6, { 42, 80 } },
    AbilityRank{ 801033, 7, { 48, 100 } },
    AbilityRank{ 802597, 8, { 56, 120 } }
};
inline constexpr std::array BandsClass22Ability800856 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array RanksClass22Ability801270 = {
    AbilityRank{ 801270, 1, { 8, 1 } },
    AbilityRank{ 501779, 2, { 18, 10 } },
    AbilityRank{ 501780, 3, { 26, 20 } },
    AbilityRank{ 501781, 4, { 36, 40 } },
    AbilityRank{ 501782, 5, { 44, 60 } },
    AbilityRank{ 501783, 6, { 52, 80 } },
    AbilityRank{ 501784, 7, { 58, 100 } },
    AbilityRank{ 504575, 8, { 60, 120 } }
};
inline constexpr std::array BandsClass22Ability801270 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array RanksClass22Ability801303 = {
    AbilityRank{ 801303, 1, { 1, 1 } },
    AbilityRank{ 501805, 2, { 6, 10 } },
    AbilityRank{ 501806, 3, { 14, 20 } },
    AbilityRank{ 501807, 4, { 22, 40 } },
    AbilityRank{ 501808, 5, { 32, 60 } },
    AbilityRank{ 501809, 6, { 38, 80 } },
    AbilityRank{ 501810, 7, { 46, 100 } },
    AbilityRank{ 501811, 8, { 54, 120 } },
    AbilityRank{ 572628, 9, { 60, 140 } }
};
inline constexpr std::array BandsClass22Ability801303 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 }
};

inline constexpr std::array RanksClass22Ability804418 = {
    AbilityRank{ 804418, 1, { 1, 1 } },
    AbilityRank{ 503784, 2, { 6, 10 } },
    AbilityRank{ 503785, 3, { 12, 20 } },
    AbilityRank{ 503786, 4, { 18, 40 } },
    AbilityRank{ 503787, 5, { 24, 60 } },
    AbilityRank{ 503788, 6, { 30, 80 } },
    AbilityRank{ 503789, 7, { 36, 100 } },
    AbilityRank{ 503790, 8, { 44, 120 } },
    AbilityRank{ 504574, 9, { 50, 140 } },
    AbilityRank{ 574344, 10, { 56, 160 } },
    AbilityRank{ 574345, 11, { 60, 180 } }
};
inline constexpr std::array BandsClass22Ability804418 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 },
    TrainingBand{ 140, 16200, 600 },
    TrainingBand{ 160, 16200, 600 }
};

inline constexpr std::array RanksClass23Ability500968 = {
    AbilityRank{ 500968, 1, { 16, 1 } },
    AbilityRank{ 501890, 2, { 24, 10 } },
    AbilityRank{ 501891, 3, { 32, 20 } },
    AbilityRank{ 501892, 4, { 40, 40 } },
    AbilityRank{ 583255, 5, { 48, 60 } },
    AbilityRank{ 583256, 6, { 56, 80 } }
};
inline constexpr std::array BandsClass23Ability500968 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 }
};

inline constexpr std::array RanksClass23Ability801722 = {
    AbilityRank{ 801722, 1, { 1, 1 } },
    AbilityRank{ 501969, 2, { 6, 10 } },
    AbilityRank{ 501970, 3, { 12, 20 } },
    AbilityRank{ 501971, 4, { 18, 40 } },
    AbilityRank{ 501972, 5, { 24, 60 } },
    AbilityRank{ 501973, 6, { 30, 80 } },
    AbilityRank{ 501974, 7, { 36, 100 } },
    AbilityRank{ 501975, 8, { 42, 120 } },
    AbilityRank{ 501976, 9, { 48, 140 } },
    AbilityRank{ 501977, 10, { 54, 160 } },
    AbilityRank{ 501978, 11, { 60, 180 } },
    AbilityRank{ 501979, 12, { 68, 200 } },
    AbilityRank{ 501980, 13, { 76, 220 } }
};
inline constexpr std::array BandsClass23Ability801722 = {
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

inline constexpr std::array RanksClass24Ability800790 = {
    AbilityRank{ 800790, 1, { 1, 1 } },
    AbilityRank{ 502011, 2, { 6, 10 } },
    AbilityRank{ 502012, 3, { 14, 20 } },
    AbilityRank{ 502013, 4, { 22, 40 } },
    AbilityRank{ 502014, 5, { 30, 60 } },
    AbilityRank{ 502015, 6, { 38, 80 } },
    AbilityRank{ 502016, 7, { 46, 100 } },
    AbilityRank{ 502017, 8, { 54, 120 } },
    AbilityRank{ 502018, 9, { 60, 140 } },
    AbilityRank{ 502019, 10, { 68, 160 } }
};
inline constexpr std::array BandsClass24Ability800790 = {
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

inline constexpr std::array RanksClass24Ability800792 = {
    AbilityRank{ 800792, 1, { 1, 1 } },
    AbilityRank{ 502057, 2, { 4, 10 } },
    AbilityRank{ 502058, 3, { 12, 20 } },
    AbilityRank{ 502059, 4, { 18, 40 } },
    AbilityRank{ 502060, 5, { 26, 60 } },
    AbilityRank{ 502061, 6, { 36, 80 } },
    AbilityRank{ 502062, 7, { 46, 100 } },
    AbilityRank{ 502063, 8, { 54, 120 } },
    AbilityRank{ 570750, 9, { 60, 140 } }
};
inline constexpr std::array BandsClass24Ability800792 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 }
};

inline constexpr std::array RanksClass24Ability800806 = {
    AbilityRank{ 800806, 1, { 2, 1 } },
    AbilityRank{ 502044, 2, { 8, 10 } },
    AbilityRank{ 502045, 3, { 14, 20 } },
    AbilityRank{ 502046, 4, { 20, 40 } },
    AbilityRank{ 502047, 5, { 26, 60 } },
    AbilityRank{ 502048, 6, { 32, 80 } },
    AbilityRank{ 502049, 7, { 40, 100 } },
    AbilityRank{ 502050, 8, { 48, 120 } },
    AbilityRank{ 502051, 9, { 56, 140 } },
    AbilityRank{ 502052, 10, { 60, 160 } }
};
inline constexpr std::array BandsClass24Ability800806 = {
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

inline constexpr std::array RanksClass24Ability801915 = {
    AbilityRank{ 801915, 1, { 12, 1 } },
    AbilityRank{ 535509, 2, { 18, 10 } },
    AbilityRank{ 535510, 3, { 26, 20 } },
    AbilityRank{ 535511, 4, { 32, 40 } },
    AbilityRank{ 535512, 5, { 38, 60 } },
    AbilityRank{ 572618, 6, { 44, 80 } },
    AbilityRank{ 572619, 7, { 48, 100 } },
    AbilityRank{ 572620, 8, { 52, 120 } },
    AbilityRank{ 572621, 9, { 56, 140 } },
    AbilityRank{ 572622, 10, { 60, 160 } },
    AbilityRank{ 572623, 11, { 76, 180 } }
};
inline constexpr std::array BandsClass24Ability801915 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 },
    TrainingBand{ 140, 16200, 600 },
    TrainingBand{ 160, 16200, 600 }
};

inline constexpr std::array RanksClass24Ability803819 = {
    AbilityRank{ 803819, 1, { 14, 1 } },
    AbilityRank{ 803820, 2, { 20, 10 } },
    AbilityRank{ 803821, 3, { 28, 20 } },
    AbilityRank{ 803822, 4, { 36, 40 } },
    AbilityRank{ 803823, 5, { 44, 60 } },
    AbilityRank{ 803824, 6, { 52, 80 } },
    AbilityRank{ 803825, 7, { 60, 100 } }
};
inline constexpr std::array BandsClass24Ability803819 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 }
};

inline constexpr std::array RanksClass24Ability803950 = {
    AbilityRank{ 803950, 1, { 4, 1 } },
    AbilityRank{ 503231, 2, { 10, 10 } },
    AbilityRank{ 503232, 3, { 16, 20 } },
    AbilityRank{ 503233, 4, { 24, 40 } },
    AbilityRank{ 503234, 5, { 32, 60 } },
    AbilityRank{ 503235, 6, { 40, 80 } },
    AbilityRank{ 503236, 7, { 48, 100 } },
    AbilityRank{ 503237, 8, { 56, 120 } },
    AbilityRank{ 503238, 9, { 64, 140 } },
    AbilityRank{ 503239, 10, { 72, 160 } }
};
inline constexpr std::array BandsClass24Ability803950 = {
    TrainingBand{ 1, 8100, 270 },
    TrainingBand{ 10, 8100, 300 },
    TrainingBand{ 20, 8100, 600 },
    TrainingBand{ 40, 8100, 600 },
    TrainingBand{ 60, 8100, 600 },
    TrainingBand{ 80, 8100, 600 },
    TrainingBand{ 100, 8100, 600 },
    TrainingBand{ 120, 8100, 600 },
    TrainingBand{ 140, 8100, 600 }
};

inline constexpr std::array RanksClass24Ability805476 = {
    AbilityRank{ 805476, 1, { 6, 1 } },
    AbilityRank{ 535505, 2, { 22, 10 } },
    AbilityRank{ 535506, 3, { 32, 20 } },
    AbilityRank{ 535507, 4, { 42, 40 } },
    AbilityRank{ 535508, 5, { 54, 60 } }
};
inline constexpr std::array BandsClass24Ability805476 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 }
};

inline constexpr std::array RanksClass24Ability805500 = {
    AbilityRank{ 805500, 1, { 8, 1 } },
    AbilityRank{ 534600, 2, { 14, 10 } },
    AbilityRank{ 534601, 3, { 22, 20 } },
    AbilityRank{ 534602, 4, { 28, 40 } },
    AbilityRank{ 534603, 5, { 34, 60 } },
    AbilityRank{ 534604, 6, { 42, 80 } },
    AbilityRank{ 572159, 7, { 50, 100 } },
    AbilityRank{ 572160, 8, { 58, 120 } }
};
inline constexpr std::array BandsClass24Ability805500 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array RanksClass25Ability500711 = {
    AbilityRank{ 500711, 1, { 2, 1 } },
    AbilityRank{ 502226, 2, { 8, 10 } },
    AbilityRank{ 502227, 3, { 12, 20 } },
    AbilityRank{ 502228, 4, { 18, 40 } },
    AbilityRank{ 502229, 5, { 24, 60 } },
    AbilityRank{ 502230, 6, { 30, 80 } },
    AbilityRank{ 502231, 7, { 36, 100 } },
    AbilityRank{ 502232, 8, { 42, 120 } },
    AbilityRank{ 502233, 9, { 48, 140 } },
    AbilityRank{ 502234, 10, { 54, 160 } },
    AbilityRank{ 574325, 11, { 60, 180 } }
};
inline constexpr std::array BandsClass25Ability500711 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 },
    TrainingBand{ 140, 16200, 600 },
    TrainingBand{ 160, 16200, 600 }
};

inline constexpr std::array RanksClass25Ability500720 = {
    AbilityRank{ 500720, 1, { 1, 1 } },
    AbilityRank{ 502114, 2, { 6, 10 } },
    AbilityRank{ 502115, 3, { 14, 20 } },
    AbilityRank{ 502116, 4, { 22, 40 } },
    AbilityRank{ 502117, 5, { 30, 60 } },
    AbilityRank{ 502118, 6, { 38, 80 } },
    AbilityRank{ 502119, 7, { 44, 100 } },
    AbilityRank{ 502120, 8, { 50, 120 } },
    AbilityRank{ 502121, 9, { 56, 140 } },
    AbilityRank{ 502122, 10, { 60, 160 } },
    AbilityRank{ 502123, 11, { 68, 180 } },
    AbilityRank{ 502124, 12, { 76, 200 } }
};
inline constexpr std::array BandsClass25Ability500720 = {
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
    TrainingBand{ 180, 13500, 600 }
};

inline constexpr std::array RanksClass25Ability800413 = {
    AbilityRank{ 800413, 1, { 1, 1 } },
    AbilityRank{ 502166, 2, { 6, 10 } },
    AbilityRank{ 502167, 3, { 12, 20 } },
    AbilityRank{ 502168, 4, { 20, 40 } },
    AbilityRank{ 502169, 5, { 32, 60 } },
    AbilityRank{ 502170, 6, { 40, 80 } },
    AbilityRank{ 502171, 7, { 48, 100 } },
    AbilityRank{ 502172, 8, { 56, 120 } },
    AbilityRank{ 504904, 9, { 60, 140 } }
};
inline constexpr std::array BandsClass25Ability800413 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 }
};

inline constexpr std::array RanksClass25Ability800416 = {
    AbilityRank{ 800416, 1, { 2, 1 } },
    AbilityRank{ 502173, 2, { 8, 10 } },
    AbilityRank{ 502174, 3, { 14, 20 } },
    AbilityRank{ 502175, 4, { 22, 40 } },
    AbilityRank{ 502176, 5, { 28, 60 } },
    AbilityRank{ 502177, 6, { 32, 80 } },
    AbilityRank{ 502178, 7, { 38, 100 } },
    AbilityRank{ 502179, 8, { 44, 120 } },
    AbilityRank{ 502180, 9, { 50, 140 } },
    AbilityRank{ 502181, 10, { 56, 160 } },
    AbilityRank{ 502182, 11, { 60, 180 } },
    AbilityRank{ 502183, 12, { 68, 200 } },
    AbilityRank{ 502184, 13, { 76, 220 } }
};
inline constexpr std::array BandsClass25Ability800416 = {
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

inline constexpr std::array RanksClass25Ability804152 = {
    AbilityRank{ 804152, 1, { 12, 1 } },
    AbilityRank{ 555351, 2, { 20, 10 } },
    AbilityRank{ 555352, 3, { 28, 20 } },
    AbilityRank{ 555353, 4, { 36, 40 } },
    AbilityRank{ 555354, 5, { 42, 60 } },
    AbilityRank{ 572846, 6, { 52, 80 } }
};
inline constexpr std::array BandsClass25Ability804152 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 }
};

inline constexpr std::array RanksClass25Ability805116 = {
    AbilityRank{ 805116, 1, { 6, 1 } },
    AbilityRank{ 806498, 2, { 14, 10 } },
    AbilityRank{ 806499, 3, { 22, 20 } },
    AbilityRank{ 806831, 4, { 30, 40 } },
    AbilityRank{ 806832, 5, { 38, 60 } },
    AbilityRank{ 806833, 6, { 46, 80 } },
    AbilityRank{ 806829, 7, { 54, 100 } },
    AbilityRank{ 806830, 8, { 60, 120 } }
};
inline constexpr std::array BandsClass25Ability805116 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array RanksClass26Ability575039 = {
    AbilityRank{ 575039, 1, { 32, 1 } },
    AbilityRank{ 575048, 2, { 38, 10 } },
    AbilityRank{ 575049, 3, { 44, 20 } },
    AbilityRank{ 575050, 4, { 50, 40 } },
    AbilityRank{ 575051, 5, { 56, 60 } }
};
inline constexpr std::array BandsClass26Ability575039 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 }
};

inline constexpr std::array RanksClass26Ability680220 = {
    AbilityRank{ 680220, 1, { 2, 1 } },
    AbilityRank{ 680586, 2, { 12, 10 } },
    AbilityRank{ 680587, 3, { 22, 20 } },
    AbilityRank{ 680588, 4, { 32, 40 } },
    AbilityRank{ 680589, 5, { 42, 60 } }
};
inline constexpr std::array BandsClass26Ability680220 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 }
};

inline constexpr std::array RanksClass26Ability800370 = {
    AbilityRank{ 800370, 1, { 8, 1 } },
    AbilityRank{ 503019, 2, { 14, 10 } },
    AbilityRank{ 503020, 3, { 20, 20 } },
    AbilityRank{ 503021, 4, { 26, 40 } },
    AbilityRank{ 503022, 5, { 32, 60 } },
    AbilityRank{ 503023, 6, { 38, 80 } },
    AbilityRank{ 503024, 7, { 44, 100 } },
    AbilityRank{ 503025, 8, { 50, 120 } },
    AbilityRank{ 503026, 9, { 56, 140 } },
    AbilityRank{ 503027, 10, { 60, 160 } },
    AbilityRank{ 503028, 11, { 68, 180 } },
    AbilityRank{ 503029, 12, { 76, 200 } }
};
inline constexpr std::array BandsClass26Ability800370 = {
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

inline constexpr std::array RanksClass26Ability800496 = {
    AbilityRank{ 800496, 1, { 1, 1 } },
    AbilityRank{ 502286, 2, { 6, 10 } },
    AbilityRank{ 502287, 3, { 16, 20 } },
    AbilityRank{ 502288, 4, { 24, 40 } },
    AbilityRank{ 502289, 5, { 32, 60 } },
    AbilityRank{ 502290, 6, { 40, 80 } },
    AbilityRank{ 502291, 7, { 50, 100 } },
    AbilityRank{ 502292, 8, { 60, 120 } },
    AbilityRank{ 502293, 9, { 68, 140 } },
    AbilityRank{ 502294, 10, { 76, 160 } }
};
inline constexpr std::array BandsClass26Ability800496 = {
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

inline constexpr std::array RanksClass26Ability801127 = {
    AbilityRank{ 801127, 1, { 1, 1 } },
    AbilityRank{ 802470, 2, { 12, 10 } },
    AbilityRank{ 802471, 3, { 22, 20 } },
    AbilityRank{ 802472, 4, { 32, 40 } },
    AbilityRank{ 802473, 5, { 42, 60 } }
};
inline constexpr std::array BandsClass26Ability801127 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 }
};

inline constexpr std::array RanksClass26Ability801132 = {
    AbilityRank{ 801132, 1, { 1, 1 } },
    AbilityRank{ 502333, 2, { 8, 10 } },
    AbilityRank{ 502334, 3, { 18, 20 } },
    AbilityRank{ 502335, 4, { 26, 40 } },
    AbilityRank{ 502336, 5, { 34, 60 } },
    AbilityRank{ 502337, 6, { 42, 80 } },
    AbilityRank{ 502338, 7, { 52, 100 } },
    AbilityRank{ 502339, 8, { 60, 120 } },
    AbilityRank{ 502340, 9, { 68, 140 } }
};
inline constexpr std::array BandsClass26Ability801132 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 }
};

inline constexpr std::array RanksClass26Ability801181 = {
    AbilityRank{ 801181, 1, { 12, 1 } },
    AbilityRank{ 802435, 2, { 22, 10 } },
    AbilityRank{ 802436, 3, { 32, 20 } },
    AbilityRank{ 802437, 4, { 42, 40 } }
};
inline constexpr std::array BandsClass26Ability801181 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 }
};

inline constexpr std::array RanksClass26Ability801972 = {
    AbilityRank{ 801972, 1, { 2, 1 } },
    AbilityRank{ 803918, 2, { 8, 10 } },
    AbilityRank{ 803919, 3, { 14, 20 } },
    AbilityRank{ 803920, 4, { 22, 40 } },
    AbilityRank{ 803921, 5, { 30, 60 } },
    AbilityRank{ 803922, 6, { 38, 80 } },
    AbilityRank{ 803923, 7, { 46, 100 } },
    AbilityRank{ 803924, 8, { 54, 120 } },
    AbilityRank{ 803925, 9, { 60, 140 } }
};
inline constexpr std::array BandsClass26Ability801972 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 }
};

inline constexpr std::array RanksClass27Ability500141 = {
    AbilityRank{ 500141, 1, { 30, 1 } },
    AbilityRank{ 502407, 2, { 36, 10 } },
    AbilityRank{ 502408, 3, { 42, 20 } },
    AbilityRank{ 502409, 4, { 48, 40 } },
    AbilityRank{ 502410, 5, { 54, 60 } },
    AbilityRank{ 502411, 6, { 58, 80 } }
};
inline constexpr std::array BandsClass27Ability500141 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 }
};

inline constexpr std::array RanksClass27Ability500143 = {
    AbilityRank{ 500143, 1, { 1, 1 } },
    AbilityRank{ 502421, 2, { 6, 10 } },
    AbilityRank{ 502422, 3, { 12, 20 } },
    AbilityRank{ 502423, 4, { 18, 40 } },
    AbilityRank{ 502424, 5, { 24, 60 } },
    AbilityRank{ 502425, 6, { 32, 80 } },
    AbilityRank{ 502426, 7, { 40, 100 } },
    AbilityRank{ 502427, 8, { 48, 120 } },
    AbilityRank{ 502428, 9, { 56, 140 } },
    AbilityRank{ 502429, 10, { 60, 160 } },
    AbilityRank{ 502430, 11, { 63, 180 } },
    AbilityRank{ 502431, 12, { 70, 200 } }
};
inline constexpr std::array BandsClass27Ability500143 = {
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

inline constexpr std::array RanksClass27Ability500152 = {
    AbilityRank{ 500152, 1, { 30, 1 } },
    AbilityRank{ 502440, 2, { 38, 10 } },
    AbilityRank{ 502441, 3, { 48, 20 } },
    AbilityRank{ 572157, 4, { 56, 40 } }
};
inline constexpr std::array BandsClass27Ability500152 = {
    TrainingBand{ 1, 2490, 270 },
    TrainingBand{ 10, 2490, 300 },
    TrainingBand{ 20, 2490, 600 }
};

inline constexpr std::array RanksClass27Ability800231 = {
    AbilityRank{ 800231, 1, { 1, 1 } },
    AbilityRank{ 502386, 2, { 6, 10 } },
    AbilityRank{ 502387, 3, { 12, 20 } },
    AbilityRank{ 502388, 4, { 18, 40 } },
    AbilityRank{ 502389, 5, { 24, 60 } },
    AbilityRank{ 502390, 6, { 30, 80 } },
    AbilityRank{ 502391, 7, { 36, 100 } },
    AbilityRank{ 502392, 8, { 40, 120 } },
    AbilityRank{ 502393, 9, { 44, 140 } },
    AbilityRank{ 502394, 10, { 50, 160 } },
    AbilityRank{ 502395, 11, { 56, 180 } },
    AbilityRank{ 502396, 12, { 60, 200 } },
    AbilityRank{ 502397, 13, { 74, 220 } }
};
inline constexpr std::array BandsClass27Ability800231 = {
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

inline constexpr std::array RanksClass27Ability800357 = {
    AbilityRank{ 800357, 1, { 16, 1 } },
    AbilityRank{ 502449, 2, { 22, 10 } },
    AbilityRank{ 502450, 3, { 28, 20 } },
    AbilityRank{ 502451, 4, { 34, 40 } },
    AbilityRank{ 502452, 5, { 40, 60 } },
    AbilityRank{ 502453, 6, { 46, 80 } },
    AbilityRank{ 502454, 7, { 52, 100 } },
    AbilityRank{ 502455, 8, { 58, 120 } },
    AbilityRank{ 502456, 9, { 64, 140 } }
};
inline constexpr std::array BandsClass27Ability800357 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 }
};

inline constexpr std::array RanksClass27Ability800611 = {
    AbilityRank{ 800611, 1, { 4, 1 } },
    AbilityRank{ 502467, 2, { 10, 10 } },
    AbilityRank{ 502468, 3, { 14, 20 } },
    AbilityRank{ 502469, 4, { 20, 40 } },
    AbilityRank{ 502470, 5, { 26, 60 } },
    AbilityRank{ 502471, 6, { 32, 80 } },
    AbilityRank{ 502472, 7, { 38, 100 } },
    AbilityRank{ 502473, 8, { 44, 120 } },
    AbilityRank{ 502474, 9, { 50, 140 } },
    AbilityRank{ 502475, 10, { 56, 160 } },
    AbilityRank{ 502476, 11, { 60, 180 } },
    AbilityRank{ 502477, 12, { 68, 200 } },
    AbilityRank{ 502478, 13, { 74, 220 } }
};
inline constexpr std::array BandsClass27Ability800611 = {
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

inline constexpr std::array RanksClass27Ability800614 = {
    AbilityRank{ 800614, 1, { 12, 1 } },
    AbilityRank{ 807981, 2, { 20, 10 } },
    AbilityRank{ 807982, 3, { 28, 20 } },
    AbilityRank{ 807983, 4, { 36, 40 } },
    AbilityRank{ 807984, 5, { 42, 60 } },
    AbilityRank{ 807985, 6, { 50, 80 } },
    AbilityRank{ 807986, 7, { 58, 100 } },
    AbilityRank{ 807987, 8, { 60, 120 } }
};
inline constexpr std::array BandsClass27Ability800614 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array RanksClass27Ability800617 = {
    AbilityRank{ 800617, 1, { 26, 1 } },
    AbilityRank{ 802558, 2, { 34, 10 } },
    AbilityRank{ 802559, 3, { 42, 20 } },
    AbilityRank{ 802560, 4, { 50, 40 } },
    AbilityRank{ 802561, 5, { 58, 60 } }
};
inline constexpr std::array BandsClass27Ability800617 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 }
};

inline constexpr std::array RanksClass28Ability500549 = {
    AbilityRank{ 500549, 1, { 1, 1 } },
    AbilityRank{ 500556, 2, { 10, 10 } },
    AbilityRank{ 500557, 3, { 20, 20 } },
    AbilityRank{ 500558, 4, { 30, 40 } },
    AbilityRank{ 500559, 5, { 40, 60 } },
    AbilityRank{ 500560, 6, { 50, 80 } },
    AbilityRank{ 500561, 7, { 60, 100 } }
};
inline constexpr std::array BandsClass28Ability500549 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 }
};

inline constexpr std::array RanksClass28Ability801707 = {
    AbilityRank{ 801707, 1, { 2, 1 } },
    AbilityRank{ 502573, 2, { 8, 10 } },
    AbilityRank{ 502574, 3, { 12, 20 } },
    AbilityRank{ 502575, 4, { 18, 40 } },
    AbilityRank{ 502576, 5, { 24, 60 } },
    AbilityRank{ 502577, 6, { 30, 80 } },
    AbilityRank{ 502578, 7, { 36, 100 } },
    AbilityRank{ 502579, 8, { 42, 120 } },
    AbilityRank{ 502580, 9, { 48, 140 } },
    AbilityRank{ 502581, 10, { 54, 160 } },
    AbilityRank{ 574152, 11, { 60, 180 } }
};
inline constexpr std::array BandsClass28Ability801707 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 },
    TrainingBand{ 140, 16200, 600 },
    TrainingBand{ 160, 16200, 600 }
};

inline constexpr std::array RanksClass28Ability802684 = {
    AbilityRank{ 802684, 1, { 20, 1 } },
    AbilityRank{ 802685, 2, { 26, 10 } },
    AbilityRank{ 802686, 3, { 32, 20 } },
    AbilityRank{ 802687, 4, { 38, 40 } },
    AbilityRank{ 802688, 5, { 44, 60 } },
    AbilityRank{ 802689, 6, { 50, 80 } },
    AbilityRank{ 802690, 7, { 54, 100 } },
    AbilityRank{ 802691, 8, { 60, 120 } }
};
inline constexpr std::array BandsClass28Ability802684 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array RanksClass28Ability805351 = {
    AbilityRank{ 805351, 1, { 1, 1 } },
    AbilityRank{ 805651, 2, { 12, 10 } },
    AbilityRank{ 805652, 3, { 28, 20 } },
    AbilityRank{ 805653, 4, { 34, 40 } },
    AbilityRank{ 805654, 5, { 42, 60 } },
    AbilityRank{ 805655, 6, { 50, 80 } },
    AbilityRank{ 805656, 7, { 58, 100 } }
};
inline constexpr std::array BandsClass28Ability805351 = {
    TrainingBand{ 1, 13500, 270 },
    TrainingBand{ 10, 13500, 300 },
    TrainingBand{ 20, 13500, 600 },
    TrainingBand{ 40, 13500, 600 },
    TrainingBand{ 60, 13500, 600 },
    TrainingBand{ 80, 13500, 600 }
};

inline constexpr std::array RanksClass29Ability800869 = {
    AbilityRank{ 800869, 1, { 1, 1 } },
    AbilityRank{ 502870, 2, { 8, 10 } },
    AbilityRank{ 502871, 3, { 14, 20 } },
    AbilityRank{ 502872, 4, { 20, 40 } },
    AbilityRank{ 502873, 5, { 26, 60 } },
    AbilityRank{ 502874, 6, { 32, 80 } },
    AbilityRank{ 502875, 7, { 38, 100 } },
    AbilityRank{ 502876, 8, { 44, 120 } },
    AbilityRank{ 573333, 9, { 50, 140 } },
    AbilityRank{ 573334, 10, { 56, 160 } },
    AbilityRank{ 573335, 11, { 62, 180 } }
};
inline constexpr std::array BandsClass29Ability800869 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 },
    TrainingBand{ 140, 16200, 600 },
    TrainingBand{ 160, 16200, 600 }
};

inline constexpr std::array RanksClass29Ability800870 = {
    AbilityRank{ 800870, 1, { 2, 1 } },
    AbilityRank{ 502939, 2, { 10, 10 } },
    AbilityRank{ 502940, 3, { 16, 20 } },
    AbilityRank{ 502941, 4, { 22, 40 } },
    AbilityRank{ 502942, 5, { 28, 60 } },
    AbilityRank{ 502943, 6, { 34, 80 } },
    AbilityRank{ 502944, 7, { 40, 100 } },
    AbilityRank{ 502945, 8, { 46, 120 } },
    AbilityRank{ 502946, 9, { 52, 140 } },
    AbilityRank{ 502947, 10, { 58, 160 } }
};
inline constexpr std::array BandsClass29Ability800870 = {
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

inline constexpr std::array RanksClass29Ability800880 = {
    AbilityRank{ 800880, 1, { 4, 1 } },
    AbilityRank{ 502896, 2, { 10, 10 } },
    AbilityRank{ 502897, 3, { 18, 20 } },
    AbilityRank{ 502898, 4, { 24, 40 } },
    AbilityRank{ 502899, 5, { 32, 60 } },
    AbilityRank{ 502900, 6, { 38, 80 } },
    AbilityRank{ 502901, 7, { 46, 100 } },
    AbilityRank{ 502902, 8, { 52, 120 } },
    AbilityRank{ 502903, 9, { 60, 140 } },
    AbilityRank{ 502904, 10, { 66, 160 } }
};
inline constexpr std::array BandsClass29Ability800880 = {
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

inline constexpr std::array RanksClass29Ability800926 = {
    AbilityRank{ 800926, 1, { 14, 1 } },
    AbilityRank{ 800939, 2, { 22, 10 } },
    AbilityRank{ 800959, 3, { 30, 20 } },
    AbilityRank{ 801110, 4, { 38, 40 } },
    AbilityRank{ 801115, 5, { 46, 60 } },
    AbilityRank{ 801152, 6, { 54, 80 } }
};
inline constexpr std::array BandsClass29Ability800926 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 }
};

inline constexpr std::array RanksClass29Ability800946 = {
    AbilityRank{ 800946, 1, { 2, 1 } },
    AbilityRank{ 503931, 2, { 12, 10 } },
    AbilityRank{ 503932, 3, { 20, 20 } },
    AbilityRank{ 503933, 4, { 28, 40 } },
    AbilityRank{ 503934, 5, { 36, 60 } },
    AbilityRank{ 503935, 6, { 44, 80 } },
    AbilityRank{ 552781, 7, { 52, 100 } },
    AbilityRank{ 552783, 8, { 60, 120 } }
};
inline constexpr std::array BandsClass29Ability800946 = {
    TrainingBand{ 1, 10140, 270 },
    TrainingBand{ 10, 10140, 300 },
    TrainingBand{ 20, 10140, 600 },
    TrainingBand{ 40, 10140, 600 },
    TrainingBand{ 60, 10140, 600 },
    TrainingBand{ 80, 10140, 600 },
    TrainingBand{ 100, 10140, 600 }
};

inline constexpr std::array RanksClass29Ability803193 = {
    AbilityRank{ 803193, 1, { 10, 1 } },
    AbilityRank{ 503149, 2, { 16, 10 } },
    AbilityRank{ 503150, 3, { 22, 20 } },
    AbilityRank{ 503151, 4, { 28, 40 } },
    AbilityRank{ 503152, 5, { 34, 60 } },
    AbilityRank{ 503153, 6, { 40, 80 } },
    AbilityRank{ 503154, 7, { 46, 100 } },
    AbilityRank{ 503155, 8, { 52, 120 } },
    AbilityRank{ 572037, 9, { 56, 140 } },
    AbilityRank{ 572038, 10, { 60, 160 } },
    AbilityRank{ 572039, 11, { 66, 180 } }
};
inline constexpr std::array BandsClass29Ability803193 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 },
    TrainingBand{ 140, 16200, 600 },
    TrainingBand{ 160, 16200, 600 }
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
    AbilityRank{ 503172, 9, { 60, 140 } }
};
inline constexpr std::array BandsClass29Ability803198 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 }
};

inline constexpr std::array RanksClass29Ability803199 = {
    AbilityRank{ 803199, 1, { 10, 1 } },
    AbilityRank{ 803231, 2, { 16, 10 } },
    AbilityRank{ 803232, 3, { 22, 20 } },
    AbilityRank{ 803233, 4, { 28, 40 } },
    AbilityRank{ 803234, 5, { 34, 60 } },
    AbilityRank{ 803235, 6, { 40, 80 } },
    AbilityRank{ 573061, 7, { 46, 100 } },
    AbilityRank{ 573062, 8, { 52, 120 } },
    AbilityRank{ 573063, 9, { 58, 140 } }
};
inline constexpr std::array BandsClass29Ability803199 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 }
};

inline constexpr std::array RanksClass29Ability803570 = {
    AbilityRank{ 803570, 1, { 28, 1 } },
    AbilityRank{ 803641, 2, { 36, 10 } },
    AbilityRank{ 803642, 3, { 42, 20 } },
    AbilityRank{ 803643, 4, { 50, 40 } },
    AbilityRank{ 803644, 5, { 58, 60 } }
};
inline constexpr std::array BandsClass29Ability803570 = {
    TrainingBand{ 1, 5400, 270 },
    TrainingBand{ 10, 5400, 300 },
    TrainingBand{ 20, 5400, 600 },
    TrainingBand{ 40, 5400, 600 }
};

inline constexpr std::array RanksClass30Ability500357 = {
    AbilityRank{ 500357, 1, { 1, 1 } },
    AbilityRank{ 504056, 2, { 6, 10 } },
    AbilityRank{ 504057, 3, { 16, 20 } },
    AbilityRank{ 504058, 4, { 24, 40 } },
    AbilityRank{ 504557, 5, { 32, 60 } },
    AbilityRank{ 505151, 6, { 40, 80 } },
    AbilityRank{ 573302, 7, { 50, 100 } },
    AbilityRank{ 573303, 8, { 60, 120 } }
};
inline constexpr std::array BandsClass30Ability500357 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array RanksClass30Ability500376 = {
    AbilityRank{ 500376, 1, { 1, 1 } },
    AbilityRank{ 502679, 2, { 8, 10 } },
    AbilityRank{ 502680, 3, { 20, 20 } },
    AbilityRank{ 502681, 4, { 28, 40 } },
    AbilityRank{ 502682, 5, { 36, 60 } },
    AbilityRank{ 502683, 6, { 44, 80 } },
    AbilityRank{ 502684, 7, { 52, 100 } },
    AbilityRank{ 504622, 8, { 60, 120 } }
};
inline constexpr std::array BandsClass30Ability500376 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array RanksClass30Ability500517 = {
    AbilityRank{ 500517, 1, { 6, 1 } },
    AbilityRank{ 500518, 2, { 14, 10 } },
    AbilityRank{ 500519, 3, { 21, 20 } },
    AbilityRank{ 500520, 4, { 31, 40 } },
    AbilityRank{ 500521, 5, { 41, 60 } },
    AbilityRank{ 500646, 6, { 51, 80 } }
};
inline constexpr std::array BandsClass30Ability500517 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 }
};

inline constexpr std::array RanksClass30Ability573316 = {
    AbilityRank{ 573316, 1, { 1, 1 } },
    AbilityRank{ 573317, 2, { 8, 10 } },
    AbilityRank{ 573318, 3, { 18, 20 } },
    AbilityRank{ 573319, 4, { 24, 40 } },
    AbilityRank{ 573321, 5, { 34, 60 } },
    AbilityRank{ 573322, 6, { 44, 80 } },
    AbilityRank{ 572341, 7, { 52, 100 } },
    AbilityRank{ 572342, 8, { 60, 120 } }
};
inline constexpr std::array BandsClass30Ability573316 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array RanksClass30Ability800174 = {
    AbilityRank{ 800174, 1, { 16, 1 } },
    AbilityRank{ 502989, 2, { 24, 10 } },
    AbilityRank{ 502990, 3, { 31, 20 } },
    AbilityRank{ 502991, 4, { 38, 40 } },
    AbilityRank{ 502992, 5, { 45, 60 } },
    AbilityRank{ 502993, 6, { 52, 80 } },
    AbilityRank{ 502994, 7, { 59, 100 } }
};
inline constexpr std::array BandsClass30Ability800174 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 }
};

inline constexpr std::array RanksClass31Ability680448 = {
    AbilityRank{ 680448, 1, { 4, 1 } },
    AbilityRank{ 681113, 2, { 10, 10 } },
    AbilityRank{ 681112, 3, { 18, 20 } },
    AbilityRank{ 573235, 4, { 24, 40 } },
    AbilityRank{ 573236, 5, { 30, 60 } },
    AbilityRank{ 573237, 6, { 40, 80 } },
    AbilityRank{ 573238, 7, { 48, 100 } },
    AbilityRank{ 681535, 8, { 56, 120 } },
    AbilityRank{ 681536, 9, { 60, 140 } }
};
inline constexpr std::array BandsClass31Ability680448 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 }
};

inline constexpr std::array RanksClass31Ability800135 = {
    AbilityRank{ 800135, 1, { 6, 1 } },
    AbilityRank{ 502802, 2, { 14, 10 } },
    AbilityRank{ 502803, 3, { 22, 20 } },
    AbilityRank{ 502804, 4, { 30, 40 } },
    AbilityRank{ 502805, 5, { 38, 60 } },
    AbilityRank{ 502806, 6, { 46, 80 } },
    AbilityRank{ 502807, 7, { 54, 100 } },
    AbilityRank{ 502808, 8, { 58, 120 } }
};
inline constexpr std::array BandsClass31Ability800135 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array RanksClass31Ability800140 = {
    AbilityRank{ 800140, 1, { 1, 1 } },
    AbilityRank{ 520560, 2, { 8, 10 } },
    AbilityRank{ 520561, 3, { 16, 20 } },
    AbilityRank{ 520562, 4, { 24, 40 } },
    AbilityRank{ 520563, 5, { 32, 60 } },
    AbilityRank{ 520564, 6, { 40, 80 } },
    AbilityRank{ 520565, 7, { 48, 100 } },
    AbilityRank{ 520566, 8, { 56, 120 } }
};
inline constexpr std::array BandsClass31Ability800140 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 }
};

inline constexpr std::array RanksClass31Ability803981 = {
    AbilityRank{ 803981, 1, { 2, 1 } },
    AbilityRank{ 503258, 2, { 16, 10 } },
    AbilityRank{ 503259, 3, { 24, 20 } },
    AbilityRank{ 503260, 4, { 30, 40 } },
    AbilityRank{ 503261, 5, { 38, 60 } },
    AbilityRank{ 503262, 6, { 46, 80 } },
    AbilityRank{ 503263, 7, { 52, 100 } },
    AbilityRank{ 503264, 8, { 60, 120 } }
};
inline constexpr std::array BandsClass31Ability803981 = {
    TrainingBand{ 1, 10140, 270 },
    TrainingBand{ 10, 10140, 300 },
    TrainingBand{ 20, 10140, 600 },
    TrainingBand{ 40, 10140, 600 },
    TrainingBand{ 60, 10140, 600 },
    TrainingBand{ 80, 10140, 600 },
    TrainingBand{ 100, 10140, 600 }
};

inline constexpr std::array RanksClass31Ability804433 = {
    AbilityRank{ 804433, 1, { 12, 1 } },
    AbilityRank{ 560171, 2, { 18, 10 } },
    AbilityRank{ 560172, 3, { 24, 20 } },
    AbilityRank{ 560173, 4, { 32, 40 } },
    AbilityRank{ 560174, 5, { 40, 60 } },
    AbilityRank{ 560175, 6, { 48, 80 } },
    AbilityRank{ 582532, 7, { 56, 100 } }
};
inline constexpr std::array BandsClass31Ability804433 = {
    TrainingBand{ 1, 10140, 270 },
    TrainingBand{ 10, 10140, 300 },
    TrainingBand{ 20, 10140, 600 },
    TrainingBand{ 40, 10140, 600 },
    TrainingBand{ 60, 10140, 600 },
    TrainingBand{ 80, 10140, 600 }
};

inline constexpr std::array RanksClass32Ability707141 = {
    AbilityRank{ 707141, 1, { 1, 1 } },
    AbilityRank{ 707143, 2, { 6, 10 } },
    AbilityRank{ 707144, 3, { 12, 20 } },
    AbilityRank{ 707145, 4, { 18, 40 } },
    AbilityRank{ 707146, 5, { 24, 60 } },
    AbilityRank{ 707147, 6, { 30, 80 } },
    AbilityRank{ 707148, 7, { 36, 100 } },
    AbilityRank{ 573444, 8, { 42, 120 } },
    AbilityRank{ 573445, 9, { 48, 140 } },
    AbilityRank{ 573446, 10, { 54, 160 } },
    AbilityRank{ 573447, 11, { 60, 180 } }
};
inline constexpr std::array BandsClass32Ability707141 = {
    TrainingBand{ 1, 16200, 270 },
    TrainingBand{ 10, 16200, 300 },
    TrainingBand{ 20, 16200, 600 },
    TrainingBand{ 40, 16200, 600 },
    TrainingBand{ 60, 16200, 600 },
    TrainingBand{ 80, 16200, 600 },
    TrainingBand{ 100, 16200, 600 },
    TrainingBand{ 120, 16200, 600 },
    TrainingBand{ 140, 16200, 600 },
    TrainingBand{ 160, 16200, 600 }
};

inline constexpr std::array RanksClass32Ability800732 = {
    AbilityRank{ 800732, 1, { 2, 1 } },
    AbilityRank{ 502823, 2, { 8, 10 } },
    AbilityRank{ 502824, 3, { 20, 20 } },
    AbilityRank{ 502825, 4, { 32, 40 } },
    AbilityRank{ 502826, 5, { 44, 60 } },
    AbilityRank{ 502827, 6, { 56, 80 } }
};
inline constexpr std::array BandsClass32Ability800732 = {
    TrainingBand{ 1, 10140, 270 },
    TrainingBand{ 10, 10140, 300 },
    TrainingBand{ 20, 10140, 600 },
    TrainingBand{ 40, 10140, 600 },
    TrainingBand{ 60, 10140, 600 }
};

inline constexpr std::array RanksClass32Ability802202 = {
    AbilityRank{ 802202, 1, { 6, 1 } },
    AbilityRank{ 502828, 2, { 14, 10 } },
    AbilityRank{ 502829, 3, { 22, 20 } },
    AbilityRank{ 502830, 4, { 30, 40 } },
    AbilityRank{ 502831, 5, { 38, 60 } },
    AbilityRank{ 502832, 6, { 46, 80 } },
    AbilityRank{ 502833, 7, { 54, 100 } },
    AbilityRank{ 502834, 8, { 60, 120 } },
    AbilityRank{ 502835, 9, { 68, 140 } },
    AbilityRank{ 502836, 10, { 74, 160 } },
    AbilityRank{ 502837, 11, { 78, 180 } },
    AbilityRank{ 502838, 12, { 80, 200 } }
};
inline constexpr std::array BandsClass32Ability802202 = {
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

inline constexpr std::array Entries = {
    Entry{ 12, 500002, RanksClass12Ability500002, { BandsClass12Ability500002 } },
    Entry{ 12, 500919, RanksClass12Ability500919, { BandsClass12Ability500919 } },
    Entry{ 12, 520523, RanksClass12Ability520523, { BandsClass12Ability520523 } },
    Entry{ 12, 801576, RanksClass12Ability801576, { BandsClass12Ability801576 } },
    Entry{ 12, 801755, RanksClass12Ability801755, { BandsClass12Ability801755 } },
    Entry{ 12, 804136, RanksClass12Ability804136, { BandsClass12Ability804136 } },
    Entry{ 13, 801670, RanksClass13Ability801670, { BandsClass13Ability801670 } },
    Entry{ 13, 801693, RanksClass13Ability801693, { BandsClass13Ability801693 } },
    Entry{ 13, 801696, RanksClass13Ability801696, { BandsClass13Ability801696 } },
    Entry{ 13, 807037, RanksClass13Ability807037, { BandsClass13Ability807037 } },
    Entry{ 14, 552210, RanksClass14Ability552210, { BandsClass14Ability552210 } },
    Entry{ 14, 801312, RanksClass14Ability801312, { BandsClass14Ability801312 } },
    Entry{ 14, 802060, RanksClass14Ability802060, { BandsClass14Ability802060 } },
    Entry{ 15, 500093, RanksClass15Ability500093, { BandsClass15Ability500093 } },
    Entry{ 15, 680491, RanksClass15Ability680491, { BandsClass15Ability680491 } },
    Entry{ 15, 802024, RanksClass15Ability802024, { BandsClass15Ability802024 } },
    Entry{ 15, 804179, RanksClass15Ability804179, { BandsClass15Ability804179 } },
    Entry{ 15, 804191, RanksClass15Ability804191, { BandsClass15Ability804191 } },
    Entry{ 16, 500038, RanksClass16Ability500038, { BandsClass16Ability500038 } },
    Entry{ 16, 500040, RanksClass16Ability500040, { BandsClass16Ability500040 } },
    Entry{ 16, 707044, RanksClass16Ability707044, { BandsClass16Ability707044 } },
    Entry{ 16, 800227, RanksClass16Ability800227, { BandsClass16Ability800227 } },
    Entry{ 16, 801844, RanksClass16Ability801844, { BandsClass16Ability801844 } },
    Entry{ 16, 804020, RanksClass16Ability804020, { BandsClass16Ability804020 } },
    Entry{ 16, 805288, RanksClass16Ability805288, { BandsClass16Ability805288 } },
    Entry{ 17, 500020, RanksClass17Ability500020, { BandsClass17Ability500020 } },
    Entry{ 17, 500904, RanksClass17Ability500904, { BandsClass17Ability500904 } },
    Entry{ 17, 800168, RanksClass17Ability800168, { BandsClass17Ability800168 } },
    Entry{ 17, 800340, RanksClass17Ability800340, { BandsClass17Ability800340 } },
    Entry{ 17, 801016, RanksClass17Ability801016, { BandsClass17Ability801016 } },
    Entry{ 17, 801059, RanksClass17Ability801059, { BandsClass17Ability801059 } },
    Entry{ 18, 704159, RanksClass18Ability704159, { BandsClass18Ability704159 } },
    Entry{ 18, 800311, RanksClass18Ability800311, { BandsClass18Ability800311 } },
    Entry{ 18, 800316, RanksClass18Ability800316, { BandsClass18Ability800316 } },
    Entry{ 18, 802197, RanksClass18Ability802197, { BandsClass18Ability802197 } },
    Entry{ 18, 802284, RanksClass18Ability802284, { BandsClass18Ability802284 } },
    Entry{ 18, 805150, RanksClass18Ability805150, { BandsClass18Ability805150 } },
    Entry{ 19, 801165, RanksClass19Ability801165, { BandsClass19Ability801165 } },
    Entry{ 19, 801443, RanksClass19Ability801443, { BandsClass19Ability801443 } },
    Entry{ 19, 801445, RanksClass19Ability801445, { BandsClass19Ability801445 } },
    Entry{ 19, 801448, RanksClass19Ability801448, { BandsClass19Ability801448 } },
    Entry{ 19, 801478, RanksClass19Ability801478, { BandsClass19Ability801478 } },
    Entry{ 19, 803157, RanksClass19Ability803157, { BandsClass19Ability803157 } },
    Entry{ 19, 804906, RanksClass19Ability804906, { BandsClass19Ability804906 } },
    Entry{ 20, 500125, RanksClass20Ability500125, { BandsClass20Ability500125 } },
    Entry{ 20, 500169, RanksClass20Ability500169, { BandsClass20Ability500169 } },
    Entry{ 20, 800156, RanksClass20Ability800156, { BandsClass20Ability800156 } },
    Entry{ 20, 800772, RanksClass20Ability800772, { BandsClass20Ability800772 } },
    Entry{ 20, 802310, RanksClass20Ability802310, { BandsClass20Ability802310 } },
    Entry{ 20, 804685, RanksClass20Ability804685, { BandsClass20Ability804685 } },
    Entry{ 21, 500073, RanksClass21Ability500073, { BandsClass21Ability500073 } },
    Entry{ 21, 500074, RanksClass21Ability500074, { BandsClass21Ability500074 } },
    Entry{ 21, 800083, RanksClass21Ability800083, { BandsClass21Ability800083 } },
    Entry{ 21, 802036, RanksClass21Ability802036, { BandsClass21Ability802036 } },
    Entry{ 21, 804940, RanksClass21Ability804940, { BandsClass21Ability804940 } },
    Entry{ 21, 807237, RanksClass21Ability807237, { BandsClass21Ability807237 } },
    Entry{ 22, 503875, RanksClass22Ability503875, { BandsClass22Ability503875 } },
    Entry{ 22, 520175, RanksClass22Ability520175, { BandsClass22Ability520175 } },
    Entry{ 22, 800856, RanksClass22Ability800856, { BandsClass22Ability800856 } },
    Entry{ 22, 801270, RanksClass22Ability801270, { BandsClass22Ability801270 } },
    Entry{ 22, 801303, RanksClass22Ability801303, { BandsClass22Ability801303 } },
    Entry{ 22, 804418, RanksClass22Ability804418, { BandsClass22Ability804418 } },
    Entry{ 23, 500968, RanksClass23Ability500968, { BandsClass23Ability500968 } },
    Entry{ 23, 801722, RanksClass23Ability801722, { BandsClass23Ability801722 } },
    Entry{ 24, 800790, RanksClass24Ability800790, { BandsClass24Ability800790 } },
    Entry{ 24, 800792, RanksClass24Ability800792, { BandsClass24Ability800792 } },
    Entry{ 24, 800806, RanksClass24Ability800806, { BandsClass24Ability800806 } },
    Entry{ 24, 801915, RanksClass24Ability801915, { BandsClass24Ability801915 } },
    Entry{ 24, 803819, RanksClass24Ability803819, { BandsClass24Ability803819 } },
    Entry{ 24, 803950, RanksClass24Ability803950, { BandsClass24Ability803950 } },
    Entry{ 24, 805476, RanksClass24Ability805476, { BandsClass24Ability805476 } },
    Entry{ 24, 805500, RanksClass24Ability805500, { BandsClass24Ability805500 } },
    Entry{ 25, 500711, RanksClass25Ability500711, { BandsClass25Ability500711 } },
    Entry{ 25, 500720, RanksClass25Ability500720, { BandsClass25Ability500720 } },
    Entry{ 25, 800413, RanksClass25Ability800413, { BandsClass25Ability800413 } },
    Entry{ 25, 800416, RanksClass25Ability800416, { BandsClass25Ability800416 } },
    Entry{ 25, 804152, RanksClass25Ability804152, { BandsClass25Ability804152 } },
    Entry{ 25, 805116, RanksClass25Ability805116, { BandsClass25Ability805116 } },
    Entry{ 26, 575039, RanksClass26Ability575039, { BandsClass26Ability575039 } },
    Entry{ 26, 680220, RanksClass26Ability680220, { BandsClass26Ability680220 } },
    Entry{ 26, 800370, RanksClass26Ability800370, { BandsClass26Ability800370 } },
    Entry{ 26, 800496, RanksClass26Ability800496, { BandsClass26Ability800496 } },
    Entry{ 26, 801127, RanksClass26Ability801127, { BandsClass26Ability801127 } },
    Entry{ 26, 801132, RanksClass26Ability801132, { BandsClass26Ability801132 } },
    Entry{ 26, 801181, RanksClass26Ability801181, { BandsClass26Ability801181 } },
    Entry{ 26, 801972, RanksClass26Ability801972, { BandsClass26Ability801972 } },
    Entry{ 27, 500141, RanksClass27Ability500141, { BandsClass27Ability500141 } },
    Entry{ 27, 500143, RanksClass27Ability500143, { BandsClass27Ability500143 } },
    Entry{ 27, 500152, RanksClass27Ability500152, { BandsClass27Ability500152 } },
    Entry{ 27, 800231, RanksClass27Ability800231, { BandsClass27Ability800231 } },
    Entry{ 27, 800357, RanksClass27Ability800357, { BandsClass27Ability800357 } },
    Entry{ 27, 800611, RanksClass27Ability800611, { BandsClass27Ability800611 } },
    Entry{ 27, 800614, RanksClass27Ability800614, { BandsClass27Ability800614 } },
    Entry{ 27, 800617, RanksClass27Ability800617, { BandsClass27Ability800617 } },
    Entry{ 28, 500549, RanksClass28Ability500549, { BandsClass28Ability500549 } },
    Entry{ 28, 801707, RanksClass28Ability801707, { BandsClass28Ability801707 } },
    Entry{ 28, 802684, RanksClass28Ability802684, { BandsClass28Ability802684 } },
    Entry{ 28, 805351, RanksClass28Ability805351, { BandsClass28Ability805351 } },
    Entry{ 29, 800869, RanksClass29Ability800869, { BandsClass29Ability800869 } },
    Entry{ 29, 800870, RanksClass29Ability800870, { BandsClass29Ability800870 } },
    Entry{ 29, 800880, RanksClass29Ability800880, { BandsClass29Ability800880 } },
    Entry{ 29, 800926, RanksClass29Ability800926, { BandsClass29Ability800926 } },
    Entry{ 29, 800946, RanksClass29Ability800946, { BandsClass29Ability800946 } },
    Entry{ 29, 803193, RanksClass29Ability803193, { BandsClass29Ability803193 } },
    Entry{ 29, 803198, RanksClass29Ability803198, { BandsClass29Ability803198 } },
    Entry{ 29, 803199, RanksClass29Ability803199, { BandsClass29Ability803199 } },
    Entry{ 29, 803570, RanksClass29Ability803570, { BandsClass29Ability803570 } },
    Entry{ 30, 500357, RanksClass30Ability500357, { BandsClass30Ability500357 } },
    Entry{ 30, 500376, RanksClass30Ability500376, { BandsClass30Ability500376 } },
    Entry{ 30, 500517, RanksClass30Ability500517, { BandsClass30Ability500517 } },
    Entry{ 30, 573316, RanksClass30Ability573316, { BandsClass30Ability573316 } },
    Entry{ 30, 800174, RanksClass30Ability800174, { BandsClass30Ability800174 } },
    Entry{ 31, 680448, RanksClass31Ability680448, { BandsClass31Ability680448 } },
    Entry{ 31, 800135, RanksClass31Ability800135, { BandsClass31Ability800135 } },
    Entry{ 31, 800140, RanksClass31Ability800140, { BandsClass31Ability800140 } },
    Entry{ 31, 803981, RanksClass31Ability803981, { BandsClass31Ability803981 } },
    Entry{ 31, 804433, RanksClass31Ability804433, { BandsClass31Ability804433 } },
    Entry{ 32, 707141, RanksClass32Ability707141, { BandsClass32Ability707141 } },
    Entry{ 32, 800732, RanksClass32Ability800732, { BandsClass32Ability800732 } },
    Entry{ 32, 802202, RanksClass32Ability802202, { BandsClass32Ability802202 } }
};
}

#endif
