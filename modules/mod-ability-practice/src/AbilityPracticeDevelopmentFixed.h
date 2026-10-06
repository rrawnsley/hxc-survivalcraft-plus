// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_FIXED_H
#define ABILITY_PRACTICE_DEVELOPMENT_FIXED_H

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeProfiles.h"

namespace AbilityPractice::DevelopmentFixed
{
inline constexpr std::array SpiritualRecall = { AbilityRank{ 583092, 1, { 20, 1 } } };
inline constexpr std::array CavernsTeleport = { AbilityRank{ 804753, 1, { 40, 1 } } };
inline constexpr std::array SpiritualAscension = {
    AbilityRank{ 500688, 1, { 20, 1 } }, AbilityRank{ 500757, 2, { 50, 1 } },
    AbilityRank{ 500758, 3, { 60, 1 } }, AbilityRank{ 500759, 4, { 70, 1 } },
    AbilityRank{ 500760, 5, { 80, 1 } }
};
inline constexpr std::array ReclaimSoul = {
    AbilityRank{ 801796, 1, { 12, 1 } },
    AbilityRank{ 803620, 2, { 20, 1 } },
    AbilityRank{ 803621, 3, { 30, 1 } },
    AbilityRank{ 803622, 4, { 40, 1 } },
    AbilityRank{ 803623, 5, { 50, 1 } },
    AbilityRank{ 803624, 6, { 60, 1 } },
    AbilityRank{ 803625, 7, { 70, 1 } },
    AbilityRank{ 803626, 8, { 80, 1 } }
};
inline constexpr std::array DoOver = {
    AbilityRank{ 800669, 1, { 10, 1 } },
    AbilityRank{ 803574, 2, { 20, 1 } },
    AbilityRank{ 803575, 3, { 30, 1 } },
    AbilityRank{ 803576, 4, { 40, 1 } },
    AbilityRank{ 803577, 5, { 50, 1 } },
    AbilityRank{ 803578, 6, { 60, 1 } },
    AbilityRank{ 803579, 7, { 70, 1 } },
    AbilityRank{ 803580, 8, { 80, 1 } }
};
inline constexpr std::array Resynchronize = {
    AbilityRank{ 804495, 1, { 52, 1 } },
    AbilityRank{ 807949, 2, { 60, 1 } }
};
inline constexpr std::array CallOfTheScourge = {
    AbilityRank{ 801792, 1, { 18, 1 } },
    AbilityRank{ 803602, 2, { 26, 1 } },
    AbilityRank{ 803603, 3, { 36, 1 } },
    AbilityRank{ 803604, 4, { 46, 1 } },
    AbilityRank{ 803605, 5, { 56, 1 } }
};
inline constexpr std::array PhoenixRebirth = {
    AbilityRank{ 706867, 1, { 10, 1 } },
    AbilityRank{ 707641, 2, { 20, 1 } },
    AbilityRank{ 707642, 3, { 30, 1 } },
    AbilityRank{ 707643, 4, { 40, 1 } },
    AbilityRank{ 707644, 5, { 50, 1 } },
    AbilityRank{ 707645, 6, { 60, 1 } }
};
inline constexpr std::array RitualOfAwakening = {
    AbilityRank{ 801791, 1, { 10, 1 } },
    AbilityRank{ 803595, 2, { 20, 1 } },
    AbilityRank{ 803596, 3, { 30, 1 } },
    AbilityRank{ 803597, 4, { 40, 1 } },
    AbilityRank{ 803598, 5, { 50, 1 } },
    AbilityRank{ 803599, 6, { 60, 1 } },
    AbilityRank{ 803600, 7, { 70, 1 } },
    AbilityRank{ 803601, 8, { 80, 1 } }
};
inline constexpr std::array TidalRebirth = {
    AbilityRank{ 801793, 1, { 40, 1 } },
    AbilityRank{ 803634, 2, { 50, 1 } },
    AbilityRank{ 803635, 3, { 60, 1 } },
    AbilityRank{ 803636, 4, { 70, 1 } },
    AbilityRank{ 803637, 5, { 80, 1 } }
};
inline constexpr std::array Revivify = {
    AbilityRank{ 801790, 1, { 10, 1 } },
    AbilityRank{ 803588, 2, { 20, 1 } },
    AbilityRank{ 803589, 3, { 30, 1 } },
    AbilityRank{ 803590, 4, { 40, 1 } },
    AbilityRank{ 803591, 5, { 50, 1 } },
    AbilityRank{ 803592, 6, { 60, 1 } },
    AbilityRank{ 803593, 7, { 70, 1 } },
    AbilityRank{ 803594, 8, { 80, 1 } }
};
inline constexpr std::array Defibrillate = {
    AbilityRank{ 802175, 1, { 10, 1 } },
    AbilityRank{ 803627, 2, { 20, 1 } },
    AbilityRank{ 803628, 3, { 30, 1 } },
    AbilityRank{ 803629, 4, { 40, 1 } },
    AbilityRank{ 803630, 5, { 50, 1 } },
    AbilityRank{ 803631, 6, { 60, 1 } },
    AbilityRank{ 803632, 7, { 70, 1 } },
    AbilityRank{ 803633, 8, { 80, 1 } }
};
inline constexpr std::array PrayerBeads = {
    AbilityRank{ 520681, 1, { 10, 1 } },
    AbilityRank{ 520844, 2, { 20, 1 } },
    AbilityRank{ 520845, 3, { 30, 1 } },
    AbilityRank{ 520846, 4, { 40, 1 } },
    AbilityRank{ 520847, 5, { 50, 1 } },
    AbilityRank{ 520848, 6, { 60, 1 } }
};
inline constexpr std::array Spawn = {
    AbilityRank{ 805568, 1, { 40, 1 } },
    AbilityRank{ 807674, 2, { 50, 1 } },
    AbilityRank{ 807675, 3, { 60, 1 } },
    AbilityRank{ 807676, 4, { 70, 1 } },
    AbilityRank{ 807677, 5, { 80, 1 } }
};
inline constexpr std::array ReturnToLife = {
    AbilityRank{ 801794, 1, { 12, 1 } },
    AbilityRank{ 803606, 2, { 20, 1 } },
    AbilityRank{ 803607, 3, { 30, 1 } },
    AbilityRank{ 803608, 4, { 40, 1 } },
    AbilityRank{ 803609, 5, { 50, 1 } },
    AbilityRank{ 803610, 6, { 60, 1 } },
    AbilityRank{ 803611, 7, { 70, 1 } },
    AbilityRank{ 803612, 8, { 80, 1 } }
};
inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 13, 583092, AbilityKind::Fixed, SpiritualRecall, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 22, 804753, AbilityKind::Fixed, CavernsTeleport, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 19, 500688, AbilityKind::Fixed, SpiritualAscension, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 13, 801796, AbilityKind::Fixed, ReclaimSoul, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 22, 800669, AbilityKind::Fixed, DoOver, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 22, 804495, AbilityKind::Fixed, Resynchronize, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 23, 801792, AbilityKind::Fixed, CallOfTheScourge, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 24, 706867, AbilityKind::Fixed, PhoenixRebirth, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 25, 801791, AbilityKind::Fixed, RitualOfAwakening, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 26, 801793, AbilityKind::Fixed, TidalRebirth, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 27, 801790, AbilityKind::Fixed, Revivify, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 28, 802175, AbilityKind::Fixed, Defibrillate, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 29, 520681, AbilityKind::Fixed, PrayerBeads, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 29, 805568, AbilityKind::Fixed, Spawn, {} }, Development::Policy, OutcomeKind::None },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 31, 801794, AbilityKind::Fixed, ReturnToLife, {} }, Development::Policy, OutcomeKind::None }
};
}

#endif
