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

inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 24, 805476, AbilityKind::Ranked, Cindergrip, CindergripCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 29, 800870, AbilityKind::Ranked, ShadrasPrayer, ShadrasPrayerCaps },
        Development::Policy, OutcomeKind::Healing }
};
}

#endif
