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

inline constexpr std::array TaldaramsTorment = {
    AbilityRank{ 800772, 1, { 2, 1 } },
    AbilityRank{ 802568, 2, { 10, 10 } },
    AbilityRank{ 802569, 3, { 20, 20 } },
    AbilityRank{ 802570, 4, { 28, 40 } },
    AbilityRank{ 802571, 5, { 34, 60 } },
    AbilityRank{ 802572, 6, { 42, 80 } },
    AbilityRank{ 802573, 7, { 50, 100 } },
    AbilityRank{ 802580, 8, { 56, 120 } }
};
inline constexpr auto TaldaramsTormentCaps = Development::RankCaps(TaldaramsTorment);

inline constexpr std::array Blaze = {
    AbilityRank{ 805500, 1, { 8, 1 } },
    AbilityRank{ 534600, 2, { 14, 10 } },
    AbilityRank{ 534601, 3, { 22, 20 } },
    AbilityRank{ 534602, 4, { 28, 40 } },
    AbilityRank{ 534603, 5, { 34, 60 } },
    AbilityRank{ 534604, 6, { 42, 80 } },
    AbilityRank{ 572159, 7, { 50, 100 } },
    AbilityRank{ 572160, 8, { 58, 120 } }
};
inline constexpr auto BlazeCaps = Development::RankCaps(Blaze);

inline constexpr std::array SeismicCrash = {
    AbilityRank{ 803981, 1, { 2, 1 } },
    AbilityRank{ 503258, 2, { 16, 10 } },
    AbilityRank{ 503259, 3, { 24, 20 } },
    AbilityRank{ 503260, 4, { 30, 40 } },
    AbilityRank{ 503261, 5, { 38, 60 } },
    AbilityRank{ 503262, 6, { 46, 80 } },
    AbilityRank{ 503263, 7, { 52, 100 } },
    AbilityRank{ 503264, 8, { 60, 120 } }
};
inline constexpr auto SeismicCrashCaps = Development::RankCaps(SeismicCrash);

inline constexpr std::array SerratedShot = {
    AbilityRank{ 500073, 1, { 16, 1 } },
    AbilityRank{ 501704, 2, { 24, 10 } },
    AbilityRank{ 501705, 3, { 30, 20 } },
    AbilityRank{ 501706, 4, { 38, 40 } },
    AbilityRank{ 501707, 5, { 46, 60 } },
    AbilityRank{ 575836, 6, { 54, 80 } },
    AbilityRank{ 575837, 7, { 62, 100 } }
};
inline constexpr auto SerratedShotCaps = Development::RankCaps(SerratedShot);

inline constexpr std::array ToxicDart = {
    AbilityRank{ 807237, 1, { 4, 1 } },
    AbilityRank{ 807324, 2, { 10, 10 } },
    AbilityRank{ 807325, 3, { 18, 20 } },
    AbilityRank{ 807326, 4, { 26, 40 } },
    AbilityRank{ 807327, 5, { 34, 60 } },
    AbilityRank{ 807328, 6, { 42, 80 } },
    AbilityRank{ 807329, 7, { 50, 100 } },
    AbilityRank{ 807330, 8, { 58, 120 } }
};
inline constexpr auto ToxicDartCaps = Development::RankCaps(ToxicDart);

inline constexpr std::array Unmake = {
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
inline constexpr auto UnmakeCaps = Development::RankCaps(Unmake);

inline constexpr std::array Earthquake = {
    AbilityRank{ 520412, 1, { 16, 1 } }, AbilityRank{ 520741, 2, { 24, 10 } },
    AbilityRank{ 520742, 3, { 32, 20 } }, AbilityRank{ 520743, 4, { 40, 40 } },
    AbilityRank{ 520744, 5, { 48, 60 } }, AbilityRank{ 520745, 6, { 56, 80 } }
};
inline constexpr auto EarthquakeCaps = Development::RankCaps(Earthquake);
inline constexpr std::uint32_t EarthquakePracticeIntervalSeconds = 10;

inline bool IsEarthquake(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 31 && profile.Definition.AbilityId == 520412 &&
        profile.Definition.Kind == AbilityKind::Ranked && profile.Outcome == OutcomeKind::Damage;
}

inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 31, 520412, AbilityKind::Ranked, Earthquake, EarthquakeCaps },
        Development::Policy, OutcomeKind::Damage },
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
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 20, 800772, AbilityKind::Ranked, TaldaramsTorment, TaldaramsTormentCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 24, 805500, AbilityKind::Ranked, Blaze, BlazeCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 31, 803981, AbilityKind::Ranked, SeismicCrash, SeismicCrashCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 21, 500073, AbilityKind::Ranked, SerratedShot, SerratedShotCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 21, 807237, AbilityKind::Ranked, ToxicDart, ToxicDartCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 22, 804418, AbilityKind::Ranked, Unmake, UnmakeCaps },
        Development::Policy, OutcomeKind::Damage }
};
}

#endif
