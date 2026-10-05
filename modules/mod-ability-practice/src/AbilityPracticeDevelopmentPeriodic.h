#ifndef ABILITY_PRACTICE_DEVELOPMENT_PERIODIC_H
#define ABILITY_PRACTICE_DEVELOPMENT_PERIODIC_H

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeProfiles.h"

namespace AbilityPractice::DevelopmentPeriodic
{
inline constexpr std::array Cindergrip = {
    AbilityRank{ 805476, 1, { 6, 1 } },
    AbilityRank{ 535505, 2, { 22, 10 } },
    AbilityRank{ 535506, 3, { 32, 20 } },
    AbilityRank{ 535507, 4, { 42, 40 } },
    AbilityRank{ 535508, 5, { 54, 60 } }
};
inline constexpr auto CindergripCaps = Development::RankCaps(Cindergrip);

inline constexpr std::array ShadrasPrayer = {
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
inline constexpr auto ShadrasPrayerCaps = Development::RankCaps(ShadrasPrayer);

inline constexpr std::array HarvestPlague = {
    AbilityRank{ 500968, 1, { 16, 1 } },
    AbilityRank{ 501890, 2, { 24, 10 } },
    AbilityRank{ 501891, 3, { 32, 20 } },
    AbilityRank{ 501892, 4, { 40, 40 } },
    AbilityRank{ 583255, 5, { 48, 60 } },
    AbilityRank{ 583256, 6, { 56, 80 } }
};
inline constexpr auto HarvestPlagueCaps = Development::RankCaps(HarvestPlague);

inline constexpr std::array Deathwind = {
    AbilityRank{ 800174, 1, { 16, 1 } },
    AbilityRank{ 502989, 2, { 24, 10 } },
    AbilityRank{ 502990, 3, { 31, 20 } },
    AbilityRank{ 502991, 4, { 38, 40 } },
    AbilityRank{ 502992, 5, { 45, 60 } },
    AbilityRank{ 502993, 6, { 52, 80 } },
    AbilityRank{ 502994, 7, { 59, 100 } }
};
inline constexpr auto DeathwindCaps = Development::RankCaps(Deathwind);

inline constexpr std::array Condemn = {
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
inline constexpr auto CondemnCaps = Development::RankCaps(Condemn);

inline constexpr std::array Decomposition = {
    AbilityRank{ 800856, 1, { 2, 1 } },
    AbilityRank{ 801028, 2, { 8, 10 } },
    AbilityRank{ 801029, 3, { 18, 20 } },
    AbilityRank{ 801030, 4, { 28, 40 } },
    AbilityRank{ 801031, 5, { 34, 60 } },
    AbilityRank{ 801032, 6, { 42, 80 } },
    AbilityRank{ 801033, 7, { 48, 100 } },
    AbilityRank{ 802597, 8, { 56, 120 } }
};
inline constexpr auto DecompositionCaps = Development::RankCaps(Decomposition);

inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 24, 805476, AbilityKind::Ranked, Cindergrip, CindergripCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 29, 800870, AbilityKind::Ranked, ShadrasPrayer, ShadrasPrayerCaps },
        Development::Policy, OutcomeKind::Healing },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 23, 500968, AbilityKind::Ranked, HarvestPlague, HarvestPlagueCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 30, 800174, AbilityKind::Ranked, Deathwind, DeathwindCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 19, 804906, AbilityKind::Ranked, Condemn, CondemnCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 22, 800856, AbilityKind::Ranked, Decomposition, DecompositionCaps },
        Development::Policy, OutcomeKind::Damage }
};
}

#endif
