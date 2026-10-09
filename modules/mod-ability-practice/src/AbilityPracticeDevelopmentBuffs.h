// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_BUFFS_H
#define ABILITY_PRACTICE_DEVELOPMENT_BUFFS_H

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeProfiles.h"

namespace AbilityPractice::DevelopmentBuffs
{
inline constexpr std::array WhirlwindAegis = {
    AbilityRank{ 680282, 1, { 4, 1 } },
    AbilityRank{ 680590, 2, { 12, 10 } },
    AbilityRank{ 680591, 3, { 22, 20 } },
    AbilityRank{ 680592, 4, { 32, 40 } },
    AbilityRank{ 680593, 5, { 42, 60 } },
    AbilityRank{ 680594, 6, { 52, 80 } }
};
inline constexpr auto WhirlwindAegisCaps = Development::RankCaps(WhirlwindAegis);

inline constexpr std::array VoidResilience = {
    AbilityRank{ 1119881, 1, { 28, 1 } },
    AbilityRank{ 1119889, 2, { 38, 10 } },
    AbilityRank{ 1119892, 3, { 48, 20 } }
};
inline constexpr auto VoidResilienceCaps = Development::RankCaps(VoidResilience);

inline constexpr std::array WaterTattoo = {
    AbilityRank{ 801107, 1, { 12, 1 } },
    AbilityRank{ 803783, 2, { 24, 10 } },
    AbilityRank{ 803784, 3, { 36, 20 } },
    AbilityRank{ 803785, 4, { 48, 40 } }
};
inline constexpr auto WaterTattooCaps = Development::RankCaps(WaterTattoo);

inline constexpr std::array EarthTattoo = {
    AbilityRank{ 801094, 1, { 4, 1 } },
    AbilityRank{ 803754, 2, { 12, 10 } },
    AbilityRank{ 803755, 3, { 22, 20 } },
    AbilityRank{ 803756, 4, { 34, 40 } },
    AbilityRank{ 803757, 5, { 46, 60 } },
    AbilityRank{ 803758, 6, { 58, 80 } }
};
inline constexpr auto EarthTattooCaps = Development::RankCaps(EarthTattoo);

inline constexpr std::array ManariIntuition = {
    AbilityRank{ 523478, 1, { 8, 1 } },
    AbilityRank{ 523479, 2, { 20, 10 } },
    AbilityRank{ 523480, 3, { 30, 20 } },
    AbilityRank{ 523481, 4, { 40, 40 } },
    AbilityRank{ 523482, 5, { 50, 60 } },
    AbilityRank{ 523483, 6, { 60, 80 } }
};
inline constexpr auto ManariIntuitionCaps = Development::RankCaps(ManariIntuition);

inline constexpr std::array KnightsEdict = {
    AbilityRank{ 523485, 1, { 30, 1 } },
    AbilityRank{ 523486, 2, { 40, 10 } },
    AbilityRank{ 523487, 3, { 50, 20 } },
    AbilityRank{ 523488, 4, { 60, 40 } }
};
inline constexpr auto KnightsEdictCaps = Development::RankCaps(KnightsEdict);

inline constexpr std::array BeetlePheromones = {
    AbilityRank{ 803651, 1, { 20, 1 } },
    AbilityRank{ 803652, 2, { 30, 10 } },
    AbilityRank{ 803653, 3, { 40, 20 } },
    AbilityRank{ 803654, 4, { 50, 40 } },
    AbilityRank{ 803655, 5, { 60, 60 } }
};
inline constexpr auto BeetlePheromonesCaps = Development::RankCaps(BeetlePheromones);

inline constexpr std::array DevotionOfGrace = {
    AbilityRank{ 800852, 1, { 4, 1 } },
    AbilityRank{ 300858, 2, { 14, 10 } },
    AbilityRank{ 300859, 3, { 24, 20 } },
    AbilityRank{ 300862, 4, { 34, 40 } },
    AbilityRank{ 300863, 5, { 44, 60 } },
    AbilityRank{ 300864, 6, { 54, 80 } },
    AbilityRank{ 300865, 7, { 60, 100 } }
};
inline constexpr auto DevotionOfGraceCaps = Development::RankCaps(DevotionOfGrace);

inline constexpr std::array FootpadAdaptation = {
    AbilityRank{ 523489, 1, { 20, 1 } },
    AbilityRank{ 523490, 2, { 30, 10 } },
    AbilityRank{ 523491, 3, { 40, 20 } },
    AbilityRank{ 523492, 4, { 50, 40 } },
    AbilityRank{ 523493, 5, { 60, 60 } }
};
inline constexpr auto FootpadAdaptationCaps = Development::RankCaps(FootpadAdaptation);

inline constexpr std::array EarthenEndurance = {
    AbilityRank{ 570752, 1, { 30, 1 } },
    AbilityRank{ 570753, 2, { 40, 10 } },
    AbilityRank{ 570754, 3, { 50, 20 } },
    AbilityRank{ 570755, 4, { 60, 40 } }
};
inline constexpr auto EarthenEnduranceCaps = Development::RankCaps(EarthenEndurance);

inline constexpr std::array MarkOfBlaumeux = {
    AbilityRank{ 707693, 1, { 20, 1 } },
    AbilityRank{ 707694, 2, { 30, 10 } },
    AbilityRank{ 707695, 3, { 40, 20 } },
    AbilityRank{ 707696, 4, { 50, 40 } }
};
inline constexpr auto MarkOfBlaumeuxCaps = Development::RankCaps(MarkOfBlaumeux);

inline constexpr std::array MarkOfKorthazz = {
    AbilityRank{ 706589, 1, { 2, 1 } },
    AbilityRank{ 707341, 2, { 22, 10 } },
    AbilityRank{ 707342, 3, { 32, 20 } },
    AbilityRank{ 707343, 4, { 42, 40 } },
    AbilityRank{ 707344, 5, { 52, 60 } },
    AbilityRank{ 707345, 6, { 60, 80 } }
};
inline constexpr auto MarkOfKorthazzCaps = Development::RankCaps(MarkOfKorthazz);
inline constexpr std::array MarkOfRivendare = {
    AbilityRank{ 803667, 1, { 38, 1 } },
    AbilityRank{ 803668, 2, { 48, 10 } },
    AbilityRank{ 803669, 3, { 54, 20 } },
    AbilityRank{ 803670, 4, { 60, 40 } }
};
inline constexpr auto MarkOfRivendareCaps = Development::RankCaps(MarkOfRivendare);

inline constexpr std::array PowerWuju = {
    AbilityRank{ 707671, 1, { 10, 1 } },
    AbilityRank{ 707672, 2, { 20, 10 } },
    AbilityRank{ 707673, 3, { 30, 20 } },
    AbilityRank{ 707674, 4, { 40, 40 } },
    AbilityRank{ 707675, 5, { 50, 60 } },
    AbilityRank{ 707676, 6, { 60, 80 } }
};
inline constexpr auto PowerWujuCaps = Development::RankCaps(PowerWuju);

inline constexpr std::array SpiritWuju = {
    AbilityRank{ 560294, 1, { 2, 1 } },
    AbilityRank{ 561140, 2, { 28, 10 } },
    AbilityRank{ 561141, 3, { 42, 20 } },
    AbilityRank{ 561142, 4, { 56, 40 } }
};
inline constexpr auto SpiritWujuCaps = Development::RankCaps(SpiritWuju);

inline constexpr std::array ManaModule = {
    AbilityRank{ 803658, 1, { 16, 1 } },
    AbilityRank{ 803659, 2, { 24, 10 } },
    AbilityRank{ 803660, 3, { 34, 20 } },
    AbilityRank{ 803661, 4, { 44, 40 } },
    AbilityRank{ 803662, 5, { 54, 60 } },
    AbilityRank{ 803663, 6, { 60, 80 } }
};
inline constexpr auto ManaModuleCaps = Development::RankCaps(ManaModule);

inline constexpr std::array PowerModule = {
    AbilityRank{ 706742, 1, { 4, 1 } },
    AbilityRank{ 707346, 2, { 12, 10 } },
    AbilityRank{ 707347, 3, { 22, 20 } },
    AbilityRank{ 707348, 4, { 32, 40 } },
    AbilityRank{ 707349, 5, { 42, 60 } },
    AbilityRank{ 707350, 6, { 52, 80 } },
    AbilityRank{ 707688, 7, { 60, 100 } }
};
inline constexpr auto PowerModuleCaps = Development::RankCaps(PowerModule);

inline constexpr std::array SanguinaryOffering = {
    AbilityRank{ 706630, 1, { 16, 1 } },
    AbilityRank{ 707336, 2, { 26, 10 } },
    AbilityRank{ 707337, 3, { 36, 20 } },
    AbilityRank{ 707338, 4, { 48, 40 } },
    AbilityRank{ 707339, 5, { 60, 60 } }
};
inline constexpr auto SanguinaryOfferingCaps = Development::RankCaps(SanguinaryOffering);

inline constexpr std::array WoodsmanAdaptation = {
    AbilityRank{ 800266, 1, { 8, 1 } },
    AbilityRank{ 803320, 2, { 18, 10 } },
    AbilityRank{ 803321, 3, { 28, 20 } },
    AbilityRank{ 803322, 4, { 38, 40 } },
    AbilityRank{ 803323, 5, { 48, 60 } },
    AbilityRank{ 803324, 6, { 54, 80 } },
    AbilityRank{ 803666, 7, { 60, 100 } }
};
inline constexpr auto WoodsmanAdaptationCaps = Development::RankCaps(WoodsmanAdaptation);

inline constexpr std::array DevotionOfDawn = {
    AbilityRank{ 572384, 1, { 12, 1 } },
    AbilityRank{ 572385, 2, { 22, 10 } },
    AbilityRank{ 572386, 3, { 32, 20 } },
    AbilityRank{ 572387, 4, { 42, 40 } },
    AbilityRank{ 572388, 5, { 52, 60 } },
    AbilityRank{ 572389, 6, { 60, 80 } }
};
inline constexpr auto DevotionOfDawnCaps = Development::RankCaps(DevotionOfDawn);
inline constexpr std::array PrimalInstinct = {
    AbilityRank{ 800197, 1, { 8, 1 } },
    AbilityRank{ 803315, 2, { 18, 10 } },
    AbilityRank{ 803316, 3, { 28, 20 } },
    AbilityRank{ 803317, 4, { 38, 40 } },
    AbilityRank{ 803318, 5, { 48, 60 } },
    AbilityRank{ 803319, 6, { 54, 80 } },
    AbilityRank{ 573349, 7, { 60, 100 } }
};
inline constexpr auto PrimalInstinctCaps = Development::RankCaps(PrimalInstinct);

inline constexpr std::array GroveInstinct = {
    AbilityRank{ 572810, 1, { 2, 1 } },
    AbilityRank{ 572811, 2, { 14, 10 } },
    AbilityRank{ 572812, 3, { 24, 20 } },
    AbilityRank{ 572813, 4, { 38, 40 } },
    AbilityRank{ 572814, 5, { 52, 60 } },
    AbilityRank{ 572815, 6, { 60, 80 } }
};
inline constexpr auto GroveInstinctCaps = Development::RankCaps(GroveInstinct);

inline constexpr std::uint32_t ClassId = 12;
inline constexpr std::uint32_t AbilityId = 300857;
inline constexpr std::array BrutalShout = {
    AbilityRank{ 300857, 1, { 4, 1 } },
    AbilityRank{ 300882, 2, { 10, 10 } },
    AbilityRank{ 300883, 3, { 24, 20 } },
    AbilityRank{ 300884, 4, { 38, 40 } },
    AbilityRank{ 300885, 5, { 52, 60 } },
    AbilityRank{ 300886, 6, { 60, 80 } }
};
inline constexpr auto BrutalShoutCaps = Development::RankCaps(BrutalShout);
inline constexpr std::array EnduringShout = {
    AbilityRank{ 680302, 1, { 24, 1 } },
    AbilityRank{ 681439, 2, { 36, 10 } },
    AbilityRank{ 681440, 3, { 48, 20 } },
    AbilityRank{ 681441, 4, { 58, 40 } }
};
inline constexpr auto EnduringShoutCaps = Development::RankCaps(EnduringShout);
inline constexpr std::array Class15Ability706741 = {
    AbilityRank{ 706741, 1, { 4, 1 } },
    AbilityRank{ 707351, 2, { 12, 10 } },
    AbilityRank{ 707352, 3, { 24, 20 } },
    AbilityRank{ 707353, 4, { 38, 40 } },
    AbilityRank{ 707354, 5, { 52, 60 } },
    AbilityRank{ 707355, 6, { 60, 80 } }
};
inline constexpr auto Class15Ability706741Caps = Development::RankCaps(Class15Ability706741);

inline constexpr std::array Class16Ability578311 = {
    AbilityRank{ 578311, 1, { 4, 1 } },
    AbilityRank{ 578312, 2, { 14, 10 } },
    AbilityRank{ 578313, 3, { 28, 20 } },
    AbilityRank{ 578314, 4, { 42, 40 } },
    AbilityRank{ 578315, 5, { 56, 60 } }
};
inline constexpr auto Class16Ability578311Caps = Development::RankCaps(Class16Ability578311);

inline constexpr std::array Class19Ability706634 = {
    AbilityRank{ 706634, 1, { 2, 1 } },
    AbilityRank{ 300916, 2, { 12, 10 } },
    AbilityRank{ 300917, 3, { 24, 20 } },
    AbilityRank{ 300918, 4, { 38, 40 } },
    AbilityRank{ 300919, 5, { 52, 60 } },
    AbilityRank{ 300923, 6, { 60, 80 } }
};
inline constexpr auto Class19Ability706634Caps = Development::RankCaps(Class19Ability706634);

inline constexpr std::array Class20Ability572400 = {
    AbilityRank{ 572400, 1, { 32, 1 } },
    AbilityRank{ 572401, 2, { 42, 10 } },
    AbilityRank{ 572402, 3, { 52, 20 } },
    AbilityRank{ 572403, 4, { 60, 40 } }
};
inline constexpr auto Class20Ability572400Caps = Development::RankCaps(Class20Ability572400);

inline constexpr std::array Class22Ability572391 = {
    AbilityRank{ 572391, 1, { 1, 1 } },
    AbilityRank{ 572392, 2, { 14, 10 } },
    AbilityRank{ 572393, 3, { 28, 20 } },
    AbilityRank{ 572394, 4, { 44, 40 } },
    AbilityRank{ 572395, 5, { 56, 60 } }
};
inline constexpr auto Class22Ability572391Caps = Development::RankCaps(Class22Ability572391);

inline constexpr std::array Class23Ability800199 = {
    AbilityRank{ 800199, 1, { 12, 1 } },
    AbilityRank{ 573295, 2, { 24, 10 } },
    AbilityRank{ 573296, 3, { 36, 20 } },
    AbilityRank{ 573297, 4, { 48, 40 } },
    AbilityRank{ 573298, 5, { 58, 60 } }
};
inline constexpr auto Class23Ability800199Caps = Development::RankCaps(Class23Ability800199);

inline constexpr std::array Class24Ability800196 = {
    AbilityRank{ 800196, 1, { 5, 1 } },
    AbilityRank{ 802819, 2, { 14, 10 } },
    AbilityRank{ 802820, 3, { 28, 20 } },
    AbilityRank{ 802821, 4, { 42, 40 } },
    AbilityRank{ 802822, 5, { 56, 60 } }
};
inline constexpr auto Class24Ability800196Caps = Development::RankCaps(Class24Ability800196);

inline constexpr std::array Class26Ability300255 = {
    AbilityRank{ 300255, 1, { 4, 1 } },
    AbilityRank{ 301222, 2, { 14, 10 } },
    AbilityRank{ 301223, 3, { 28, 20 } },
    AbilityRank{ 301224, 4, { 42, 40 } },
    AbilityRank{ 301225, 5, { 56, 60 } }
};
inline constexpr auto Class26Ability300255Caps = Development::RankCaps(Class26Ability300255);

inline constexpr std::array Class29Ability803177 = {
    AbilityRank{ 803177, 1, { 10, 1 } },
    AbilityRank{ 803306, 2, { 22, 10 } },
    AbilityRank{ 803307, 3, { 32, 20 } },
    AbilityRank{ 803308, 4, { 42, 40 } },
    AbilityRank{ 803309, 5, { 52, 60 } },
    AbilityRank{ 803650, 6, { 60, 80 } }
};
inline constexpr auto Class29Ability803177Caps = Development::RankCaps(Class29Ability803177);

inline constexpr std::array Class30Ability800198 = {
    AbilityRank{ 800198, 1, { 4, 1 } },
    AbilityRank{ 803310, 2, { 14, 10 } },
    AbilityRank{ 803311, 3, { 24, 20 } },
    AbilityRank{ 803312, 4, { 36, 40 } },
    AbilityRank{ 803313, 5, { 42, 60 } },
    AbilityRank{ 803314, 6, { 58, 80 } }
};
inline constexpr auto Class30Ability800198Caps = Development::RankCaps(Class30Ability800198);

inline constexpr std::array Class32Ability561237 = {
    AbilityRank{ 561237, 1, { 18, 1 } },
    AbilityRank{ 561238, 2, { 32, 10 } },
    AbilityRank{ 561239, 3, { 46, 20 } },
    AbilityRank{ 561240, 4, { 60, 40 } }
};
inline constexpr auto Class32Ability561237Caps = Development::RankCaps(Class32Ability561237);

inline constexpr std::array ChromiesWisdom = {
    AbilityRank{ 801523, 1, { 12, 1 } }, AbilityRank{ 802827, 2, { 28, 10 } },
    AbilityRank{ 802828, 3, { 42, 20 } }, AbilityRank{ 802829, 4, { 56, 40 } }
};
inline constexpr auto ChromiesWisdomCaps = Development::RankCaps(ChromiesWisdom);

inline constexpr std::array Class15Ability707684 = {
    AbilityRank{ 707684, 1, { 20, 1 } },
    AbilityRank{ 707685, 2, { 38, 10 } },
    AbilityRank{ 707686, 3, { 48, 20 } },
    AbilityRank{ 707687, 4, { 58, 40 } }
};
inline constexpr auto Class15Ability707684Caps = Development::RankCaps(Class15Ability707684);
inline constexpr std::array Class23Ability572787 = {
    AbilityRank{ 572787, 1, { 38, 1 } },
    AbilityRank{ 572788, 2, { 46, 10 } },
    AbilityRank{ 572789, 3, { 52, 20 } }
};
inline constexpr auto Class23Ability572787Caps = Development::RankCaps(Class23Ability572787);
inline constexpr std::array Class27Ability575040 = {
    AbilityRank{ 575040, 1, { 28, 1 } },
    AbilityRank{ 575041, 2, { 38, 10 } },
    AbilityRank{ 575042, 3, { 48, 20 } },
    AbilityRank{ 575043, 4, { 58, 40 } }
};
inline constexpr auto Class27Ability575040Caps = Development::RankCaps(Class27Ability575040);
inline constexpr std::array Class29Ability707689 = {
    AbilityRank{ 707689, 1, { 28, 1 } },
    AbilityRank{ 707690, 2, { 38, 10 } },
    AbilityRank{ 707691, 3, { 48, 20 } },
    AbilityRank{ 707692, 4, { 58, 40 } }
};
inline constexpr auto Class29Ability707689Caps = Development::RankCaps(Class29Ability707689);

inline constexpr std::array Class16Ability804018 = {
    AbilityRank{ 804018, 1, { 14, 1 } },
    AbilityRank{ 503319, 2, { 24, 10 } },
    AbilityRank{ 503320, 3, { 34, 20 } },
    AbilityRank{ 503321, 4, { 44, 40 } },
    AbilityRank{ 503322, 5, { 54, 60 } },
    AbilityRank{ 503323, 6, { 60, 80 } }
};
inline constexpr auto Class16Ability804018Caps = Development::RankCaps(Class16Ability804018);
inline constexpr std::array Class24Ability803649 = {
    AbilityRank{ 803649, 1, { 16, 1 } },
    AbilityRank{ 803729, 2, { 26, 10 } },
    AbilityRank{ 807704, 3, { 36, 20 } },
    AbilityRank{ 807770, 4, { 46, 40 } },
    AbilityRank{ 808012, 5, { 56, 60 } }
};
inline constexpr auto Class24Ability803649Caps = Development::RankCaps(Class24Ability803649);

inline constexpr std::array Class18Ability582533 = {
    AbilityRank{ 582533, 1, { 36, 1 } },
    AbilityRank{ 582534, 2, { 48, 10 } },
    AbilityRank{ 582535, 3, { 60, 20 } }
};
inline constexpr auto Class18Ability582533Caps = Development::RankCaps(Class18Ability582533);
inline constexpr std::array Class23Ability572173 = {
    AbilityRank{ 572173, 1, { 26, 1 } },
    AbilityRank{ 572174, 2, { 32, 10 } },
    AbilityRank{ 572175, 3, { 44, 20 } },
    AbilityRank{ 572176, 4, { 50, 40 } }
};
inline constexpr auto Class23Ability572173Caps = Development::RankCaps(Class23Ability572173);

inline constexpr std::array Class26Ability573343 = {
    AbilityRank{ 573343, 1, { 30, 1 } },
    AbilityRank{ 573344, 2, { 42, 10 } },
    AbilityRank{ 573345, 3, { 56, 20 } }
};
inline constexpr auto Class26Ability573343Caps = Development::RankCaps(Class26Ability573343);

inline constexpr std::array Class25Ability561389 = {
    AbilityRank{ 561389, 1, { 14, 1 } },
    AbilityRank{ 561390, 2, { 25, 10 } },
    AbilityRank{ 561391, 3, { 50, 20 } }
};
inline constexpr auto Class25Ability561389Caps = Development::RankCaps(Class25Ability561389);
inline constexpr std::array Class25Ability572791 = {
    AbilityRank{ 572791, 1, { 38, 1 } },
    AbilityRank{ 572819, 2, { 46, 10 } },
    AbilityRank{ 572905, 3, { 54, 20 } }
};
inline constexpr auto Class25Ability572791Caps = Development::RankCaps(Class25Ability572791);

inline constexpr std::array Class16Ability575843 = {
    AbilityRank{ 575843, 1, { 40, 1 } },
    AbilityRank{ 575844, 2, { 50, 10 } },
    AbilityRank{ 575845, 3, { 60, 20 } }
};
inline constexpr auto Class16Ability575843Caps = Development::RankCaps(Class16Ability575843);
inline constexpr std::array Class30Ability575839 = {
    AbilityRank{ 575839, 1, { 40, 1 } },
    AbilityRank{ 575840, 2, { 50, 10 } },
    AbilityRank{ 575841, 3, { 60, 20 } }
};
inline constexpr auto Class30Ability575839Caps = Development::RankCaps(Class30Ability575839);

inline constexpr std::array Honor = {
    AbilityRank{ 300856, 1, { 6, 1 } }, AbilityRank{ 301228, 2, { 12, 10 } },
    AbilityRank{ 301229, 3, { 24, 20 } }, AbilityRank{ 301230, 4, { 38, 40 } },
    AbilityRank{ 301231, 5, { 52, 60 } }, AbilityRank{ 301232, 6, { 60, 80 } }
};
inline constexpr auto HonorCaps = Development::RankCaps(Honor);
inline constexpr std::array RiteOfPower = {
    AbilityRank{ 578126, 1, { 24, 1 } }, AbilityRank{ 578127, 2, { 38, 10 } },
    AbilityRank{ 578128, 3, { 52, 20 } }, AbilityRank{ 578129, 4, { 60, 40 } }
};
inline constexpr auto RiteOfPowerCaps = Development::RankCaps(RiteOfPower);

inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 16, 680282, AbilityKind::Ranked, WhirlwindAegis, WhirlwindAegisCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 25, 1119881, AbilityKind::Ranked, VoidResilience, VoidResilienceCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 28, 803658, AbilityKind::Ranked, ManaModule, ManaModuleCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 32, 801107, AbilityKind::Ranked, WaterTattoo, WaterTattooCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 32, 801094, AbilityKind::Ranked, EarthTattoo, EarthTattooCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 14, 523478, AbilityKind::Ranked, ManariIntuition, ManariIntuitionCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 15, 523485, AbilityKind::Ranked, KnightsEdict, KnightsEdictCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 29, 803651, AbilityKind::Ranked, BeetlePheromones, BeetlePheromonesCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 27, 800852, AbilityKind::Ranked, DevotionOfGrace, DevotionOfGraceCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 21, 523489, AbilityKind::Ranked, FootpadAdaptation, FootpadAdaptationCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 17, 707693, AbilityKind::Ranked, MarkOfBlaumeux, MarkOfBlaumeuxCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 13, 707671, AbilityKind::Ranked, PowerWuju, PowerWujuCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 31, 570752, AbilityKind::Ranked, EarthenEndurance, EarthenEnduranceCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 17, 706589, AbilityKind::Ranked, MarkOfKorthazz, MarkOfKorthazzCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 17, 803667, AbilityKind::Ranked, MarkOfRivendare, MarkOfRivendareCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 13, 560294, AbilityKind::Ranked, SpiritWuju, SpiritWujuCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 28, 706742, AbilityKind::Ranked, PowerModule, PowerModuleCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 20, 706630, AbilityKind::Ranked, SanguinaryOffering, SanguinaryOfferingCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 21, 800266, AbilityKind::Ranked, WoodsmanAdaptation, WoodsmanAdaptationCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 27, 572384, AbilityKind::Ranked, DevotionOfDawn, DevotionOfDawnCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 31, 800197, AbilityKind::Ranked, PrimalInstinct, PrimalInstinctCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 31, 572810, AbilityKind::Ranked, GroveInstinct, GroveInstinctCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 12, 300857, AbilityKind::Ranked, BrutalShout, BrutalShoutCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 12, 680302, AbilityKind::Ranked, EnduringShout, EnduringShoutCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 15, 706741, AbilityKind::Ranked, Class15Ability706741, Class15Ability706741Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 16, 578311, AbilityKind::Ranked, Class16Ability578311, Class16Ability578311Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 19, 706634, AbilityKind::Ranked, Class19Ability706634, Class19Ability706634Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 20, 572400, AbilityKind::Ranked, Class20Ability572400, Class20Ability572400Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 22, 572391, AbilityKind::Ranked, Class22Ability572391, Class22Ability572391Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 23, 800199, AbilityKind::Ranked, Class23Ability800199, Class23Ability800199Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 24, 800196, AbilityKind::Ranked, Class24Ability800196, Class24Ability800196Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 26, 300255, AbilityKind::Ranked, Class26Ability300255, Class26Ability300255Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 29, 803177, AbilityKind::Ranked, Class29Ability803177, Class29Ability803177Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 30, 800198, AbilityKind::Ranked, Class30Ability800198, Class30Ability800198Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 32, 561237, AbilityKind::Ranked, Class32Ability561237, Class32Ability561237Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 22, 801523, AbilityKind::Ranked, ChromiesWisdom, ChromiesWisdomCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 15, 707684, AbilityKind::Ranked, Class15Ability707684, Class15Ability707684Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 23, 572787, AbilityKind::Ranked, Class23Ability572787, Class23Ability572787Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 27, 575040, AbilityKind::Ranked, Class27Ability575040, Class27Ability575040Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 29, 707689, AbilityKind::Ranked, Class29Ability707689, Class29Ability707689Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 16, 804018, AbilityKind::Ranked, Class16Ability804018, Class16Ability804018Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 24, 803649, AbilityKind::Ranked, Class24Ability803649, Class24Ability803649Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 18, 582533, AbilityKind::Ranked, Class18Ability582533, Class18Ability582533Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 23, 572173, AbilityKind::Ranked, Class23Ability572173, Class23Ability572173Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 26, 573343, AbilityKind::Ranked, Class26Ability573343, Class26Ability573343Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 25, 561389, AbilityKind::Ranked, Class25Ability561389, Class25Ability561389Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 25, 572791, AbilityKind::Ranked, Class25Ability572791, Class25Ability572791Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 16, 575843, AbilityKind::Ranked, Class16Ability575843, Class16Ability575843Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 30, 575839, AbilityKind::Ranked, Class30Ability575839, Class30Ability575839Caps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 18, 300856, AbilityKind::Ranked, Honor, HonorCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 30, 578126, AbilityKind::Ranked, RiteOfPower, RiteOfPowerCaps },
        Development::Policy, OutcomeKind::Damage }
};

static_assert(Profiles.size() <= 64);

inline std::uint64_t ContributionBit(AbilityProfile const& profile)
{
    if (profile.Definition.Kind != AbilityKind::Ranked || profile.Outcome != OutcomeKind::Damage)
        return 0;
    for (std::size_t index = 0; index < Profiles.size(); ++index)
        if (Profiles[index].Definition.ClassId == profile.Definition.ClassId &&
            Profiles[index].Definition.AbilityId == profile.Definition.AbilityId)
            return std::uint64_t{ 1 } << index;
    return 0;
}

inline bool IsSupportedStatBuff(AbilityProfile const& profile)
{
    return ContributionBit(profile) != 0;
}

inline bool IsCultistWhispers(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 25 &&
        (profile.Definition.AbilityId == 561389 || profile.Definition.AbilityId == 572791) &&
        IsSupportedStatBuff(profile);
}

struct Mechanic
{
    std::uint32_t ClassId;
    std::uint32_t AbilityId;
    std::uint32_t TargetA;
    std::int32_t Stat;
    std::uint32_t Aura = 29;
    std::uint8_t EffectIndex = 0;
};

inline constexpr std::array Mechanics = {
    Mechanic{ 16, 680282, 1, 1, 22 },
    Mechanic{ 25, 1119881, 1, 32, 143 },
    Mechanic{ 28, 803658, 21, 0, 85 },
    Mechanic{ 32, 801107, 1, 0, 85 },
    Mechanic{ 32, 801094, 1, 1, 22 },
    Mechanic{ 14, 523478, 21, 1, 22 },
    Mechanic{ 15, 523485, 21, 1, 22 },
    Mechanic{ 29, 803651, 21, 1, 22 },
    Mechanic{ 27, 800852, 21, 0, 85 },
    Mechanic{ 21, 523489, 21, 1, 22 },
    Mechanic{ 17, 707693, 21, 127, 345 },
    Mechanic{ 31, 570752, 21, 1, 143 },
    Mechanic{ 17, 706589, 21, 4, 143 },
    Mechanic{ 17, 803667, 21, 2 },
    Mechanic{ 13, 560294, 21, 4 },
    Mechanic{ 13, 707671, 21, 0, 99 },
    Mechanic{ 28, 706742, 21, 0, 99 },
    Mechanic{ 20, 706630, 21, 2 },
    Mechanic{ 21, 800266, 21, 0, 99 },
    Mechanic{ 27, 572384, 21, 0, 99 },
    Mechanic{ 31, 800197, 21, 0, 99 },
    Mechanic{ 31, 572810, 21, 0, 85 },
    Mechanic{ 12, 300857, 56, 1 },
    Mechanic{ 12, 680302, 56, 2 },
    Mechanic{ 15, 706741, 21, 1 },
    Mechanic{ 16, 578311, 21, 3 },
    Mechanic{ 19, 706634, 21, 1 },
    Mechanic{ 20, 572400, 21, 4 },
    Mechanic{ 22, 572391, 21, 3 },
    Mechanic{ 23, 800199, 21, 2 },
    Mechanic{ 24, 800196, 21, 3 },
    Mechanic{ 26, 300255, 21, 3 },
    Mechanic{ 29, 803177, 21, 1 },
    Mechanic{ 30, 800198, 21, 2 },
    Mechanic{ 32, 561237, 21, 1 },
    Mechanic{ 22, 801523, 21, 4 },
    Mechanic{ 15, 707684, 21, 127, 345 },
    Mechanic{ 23, 572787, 21, 127, 345 },
    Mechanic{ 27, 575040, 21, 127, 345 },
    Mechanic{ 29, 707689, 21, 127, 345 },
    Mechanic{ 16, 804018, 21, 0, 85 },
    Mechanic{ 24, 803649, 21, 0, 85 },
    Mechanic{ 18, 582533, 21, 4, 143 },
    Mechanic{ 23, 572173, 21, 16, 143 },
    Mechanic{ 26, 573343, 21, 64, 143 },
    Mechanic{ 25, 561389, 21, 0, 85 },
    Mechanic{ 25, 572791, 21, 127, 345 },
    Mechanic{ 16, 575843, 21, 126, 143, 2 },
    Mechanic{ 30, 575839, 21, 126, 143, 2 },
    Mechanic{ 18, 300856, 21, 0, 29, 1 },
    Mechanic{ 30, 578126, 21, 0, 29, 1 }
};

static_assert(Mechanics.size() == Profiles.size());

inline constexpr std::array SecondaryMechanics = {
    Mechanic{ 16, 680282, 1, 0, 216, 1 },
    Mechanic{ 32, 801107, 1, 127, 72, 1 },
    Mechanic{ 32, 801094, 1, 8, 22, 1 },
    Mechanic{ 14, 523478, 21, -1, 29, 1 },
    Mechanic{ 15, 523485, 21, -1, 29, 1 },
    Mechanic{ 29, 803651, 21, -1, 29, 1 },
    Mechanic{ 27, 800852, 21, 127, 72, 1 },
    Mechanic{ 21, 523489, 21, -1, 29, 1 },
    Mechanic{ 17, 707693, 21, 32, 143, 1 },
    Mechanic{ 31, 570752, 21, -1, 29, 1 },
    Mechanic{ 31, 570752, 21, 126, 143, 2 },
    Mechanic{ 17, 706589, 21, 0, 29, 1 },
    Mechanic{ 17, 803667, 21, 16, 143, 1 },
    Mechanic{ 13, 560294, 21, 126, 143, 1 }
};

inline Mechanic const* SecondaryMechanicFor(AbilityProfile const& profile, std::uint8_t effectIndex)
{
    for (auto const& mechanic : SecondaryMechanics)
        if (mechanic.ClassId == profile.Definition.ClassId && mechanic.AbilityId == profile.Definition.AbilityId &&
            mechanic.EffectIndex == effectIndex)
            return &mechanic;
    return nullptr;
}

inline bool IsWhirlwindAegis(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 16 && profile.Definition.AbilityId == 680282 &&
        IsSupportedStatBuff(profile);
}

inline bool IsVoidResilience(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 25 && profile.Definition.AbilityId == 1119881 &&
        IsSupportedStatBuff(profile);
}

inline bool IsWaterTattoo(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 32 && profile.Definition.AbilityId == 801107 &&
        IsSupportedStatBuff(profile);
}

inline bool IsDevotionOfGrace(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 27 && profile.Definition.AbilityId == 800852 &&
        IsSupportedStatBuff(profile);
}

inline bool IsRangerAdaptation(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 21 &&
        (profile.Definition.AbilityId == 523489 || profile.Definition.AbilityId == 800266) &&
        IsSupportedStatBuff(profile);
}

inline bool IsEarthenEndurance(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 31 && profile.Definition.AbilityId == 570752 &&
        IsSupportedStatBuff(profile);
}

inline bool IsXorothMark(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 17 &&
        (profile.Definition.AbilityId == 706589 || profile.Definition.AbilityId == 803667 ||
            profile.Definition.AbilityId == 707693) &&
        IsSupportedStatBuff(profile);
}

inline bool IsSpiritWuju(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 13 && profile.Definition.AbilityId == 560294 &&
        IsSupportedStatBuff(profile);
}

inline Mechanic const* MechanicFor(AbilityProfile const& profile)
{
    Mechanic const* result = nullptr;
    for (auto const& mechanic : Mechanics)
        if (mechanic.ClassId == profile.Definition.ClassId && mechanic.AbilityId == profile.Definition.AbilityId)
        {
            if (result)
                return nullptr;
            result = &mechanic;
        }
    return result;
}

inline std::int32_t StatSelector(AbilityProfile const& profile)
{
    auto const* mechanic = MechanicFor(profile);
    return mechanic ? mechanic->Stat : -2;
}

inline std::uint32_t Aura(AbilityProfile const& profile)
{
    auto const* mechanic = MechanicFor(profile);
    return mechanic ? mechanic->Aura : 0;
}

inline std::uint8_t EffectIndex(AbilityProfile const& profile)
{
    auto const* mechanic = MechanicFor(profile);
    return mechanic ? mechanic->EffectIndex : 3;
}

inline std::uint32_t Target(AbilityProfile const& profile)
{
    auto const* mechanic = MechanicFor(profile);
    return mechanic ? mechanic->TargetA : 0;
}

inline bool IsPairedAttackPower(AbilityProfile const& profile)
{
    return IsSupportedStatBuff(profile) && Aura(profile) == 99 && EffectIndex(profile) == 0 &&
        Target(profile) == 21 && StatSelector(profile) == 0;
}

inline bool IsPowerWuju(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 13 && profile.Definition.AbilityId == 707671 &&
        IsPairedAttackPower(profile);
}

inline bool IsManaModule(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 28 && profile.Definition.AbilityId == 803658 &&
        IsSupportedStatBuff(profile);
}

inline bool IsPowerModule(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 28 && profile.Definition.AbilityId == 706742 &&
        IsPairedAttackPower(profile);
}

inline bool UsesPowerModuleVariant(AbilityProfile const& profile, std::uint32_t spellId)
{
    return IsPowerModule(profile) && spellId >= 707347 && spellId <= 707350;
}

inline std::int32_t StatSelector(AbilityProfile const& profile, std::uint32_t spellId)
{
    return UsesPowerModuleVariant(profile, spellId) ? 1 : StatSelector(profile);
}

inline std::uint32_t RangedTarget(AbilityProfile const& profile, std::uint32_t spellId)
{
    return UsesPowerModuleVariant(profile, spellId) ? 0u : Target(profile);
}

inline bool IsBrutalShout(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == ClassId && profile.Definition.AbilityId == AbilityId &&
        profile.Definition.Kind == AbilityKind::Ranked && profile.Outcome == OutcomeKind::Damage;
}
}

#endif
