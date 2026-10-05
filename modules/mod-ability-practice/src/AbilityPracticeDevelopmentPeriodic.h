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
        Development::Policy, OutcomeKind::Damage }
};
}

#endif
