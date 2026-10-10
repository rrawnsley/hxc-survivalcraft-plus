// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_HELPERS_H
#define ABILITY_PRACTICE_DEVELOPMENT_HELPERS_H

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeProfiles.h"

namespace AbilityPractice::DevelopmentHelpers
{
inline constexpr std::array Manafeed = {
    AbilityRank{ 552210, 1, { 24, 1 } },
    AbilityRank{ 552211, 2, { 36, 10 } },
    AbilityRank{ 552212, 3, { 44, 20 } },
    AbilityRank{ 552213, 4, { 56, 40 } }
};
inline constexpr auto Caps = Development::RankCaps(Manafeed);
inline constexpr std::array TwinSlice = {
    AbilityRank{ 801901, 1, { 1, 1 } },
    AbilityRank{ 501257, 2, { 6, 10 } },
    AbilityRank{ 501258, 3, { 14, 20 } },
    AbilityRank{ 501259, 4, { 24, 40 } },
    AbilityRank{ 501260, 5, { 34, 60 } },
    AbilityRank{ 501261, 6, { 44, 80 } },
    AbilityRank{ 547210, 7, { 52, 100 } },
    AbilityRank{ 547211, 8, { 60, 120 } }
};
inline constexpr auto TwinCaps = Development::RankCaps(TwinSlice);
inline constexpr std::array TwinDamageHelpers = {
    std::array{ 808303u, 808304u }, std::array{ 808305u, 808306u },
    std::array{ 803462u, 520243u }, std::array{ 803462u, 520243u },
    std::array{ 803462u, 520243u }, std::array{ 803462u, 520243u },
    std::array{ 803462u, 520243u }, std::array{ 803462u, 520243u }
};
inline constexpr std::array FireSigil = {
    AbilityRank{ 534803, 1, { 4, 1 } },
    AbilityRank{ 534804, 2, { 26, 10 } },
    AbilityRank{ 534805, 3, { 34, 20 } },
    AbilityRank{ 534806, 4, { 42, 40 } },
    AbilityRank{ 534807, 5, { 50, 60 } }
};
inline constexpr auto FireCaps = Development::RankCaps(FireSigil);
inline constexpr std::uint32_t FirePracticeIntervalSeconds = 10;
inline constexpr std::array ArcaneSigil = {
    AbilityRank{ 805380, 1, { 20, 1 } },
    AbilityRank{ 807322, 2, { 34, 10 } },
    AbilityRank{ 807323, 3, { 50, 20 } }
};
inline constexpr auto ArcaneCaps = Development::RankCaps(ArcaneSigil);
inline constexpr std::uint32_t ArcanePracticeIntervalSeconds = 10;
inline constexpr std::array GeodeBarrage = {
    AbilityRank{ 500402, 1, { 1, 1 } }, AbilityRank{ 502769, 2, { 6, 10 } },
    AbilityRank{ 502770, 3, { 14, 20 } }, AbilityRank{ 502771, 4, { 22, 40 } },
    AbilityRank{ 502772, 5, { 30, 60 } }, AbilityRank{ 502773, 6, { 38, 80 } },
    AbilityRank{ 502774, 7, { 46, 100 } }, AbilityRank{ 502775, 8, { 54, 120 } },
    AbilityRank{ 502776, 9, { 60, 140 } }, AbilityRank{ 502777, 10, { 68, 160 } }
};
inline constexpr auto GeodeCaps = Development::RankCaps(GeodeBarrage);
inline constexpr std::uint32_t GeodePracticeIntervalSeconds = 5;
inline constexpr std::array ArcaneProfiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 32, 805380, AbilityKind::Ranked, ArcaneSigil, ArcaneCaps }, Development::Policy, OutcomeKind::Damage }
};
inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 14, 801901, AbilityKind::Ranked, TwinSlice, TwinCaps }, Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 14, 552210, AbilityKind::Ranked, Manafeed, Caps }, Development::Policy, OutcomeKind::Healing },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 32, 534803, AbilityKind::Ranked, FireSigil, FireCaps }, Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 31, 500402, AbilityKind::Ranked, GeodeBarrage, GeodeCaps }, Development::Policy, OutcomeKind::Damage }
};

inline bool IsGeodeBarrage(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 31 && profile.Definition.AbilityId == 500402 &&
        profile.Definition.Kind == AbilityKind::Ranked && profile.Outcome == OutcomeKind::Damage;
}

inline bool IsGeodeDamage(std::uint32_t originId, std::uint32_t helperId)
{
    if (helperId != 803138)
        return false;
    for (auto const& rank : GeodeBarrage)
        if (rank.SpellId == originId)
            return true;
    return false;
}

inline bool IsTwinSlice(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 14 && profile.Definition.AbilityId == 801901 &&
        profile.Definition.Kind == AbilityKind::Ranked && profile.Outcome == OutcomeKind::Damage;
}

inline bool IsTwinDamage(std::uint32_t originId, std::uint32_t helperId)
{
    for (std::size_t index = 0; index < TwinSlice.size(); ++index)
        if (TwinSlice[index].SpellId == originId)
            return TwinDamageHelpers[index][0] == helperId || TwinDamageHelpers[index][1] == helperId;
    return false;
}

inline bool IsTwinDamageHelper(std::uint32_t helperId)
{
    for (auto const& pair : TwinDamageHelpers)
        if (pair[0] == helperId || pair[1] == helperId)
            return true;
    return false;
}

inline bool IsFireSigil(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 32 && profile.Definition.AbilityId == 534803 &&
        profile.Definition.Kind == AbilityKind::Ranked && profile.Outcome == OutcomeKind::Damage;
}

inline bool IsFireSigilDamage(std::uint32_t originId, std::uint32_t helperId)
{
    if (helperId != 807012)
        return false;
    for (auto const& rank : FireSigil)
        if (rank.SpellId == originId)
            return true;
    return false;
}

inline bool IsArcaneSigil(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 32 && profile.Definition.AbilityId == 805380 &&
        profile.Definition.Kind == AbilityKind::Ranked && profile.Outcome == OutcomeKind::Damage;
}

inline bool IsArcaneSigilDamage(std::uint32_t originId, std::uint32_t helperId)
{
    if (helperId != 807819)
        return false;
    for (auto const& rank : ArcaneSigil)
        if (rank.SpellId == originId)
            return true;
    return false;
}

inline bool IsManafeed(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == 14 && profile.Definition.AbilityId == 552210 &&
        profile.Definition.Kind == AbilityKind::Ranked && profile.Outcome == OutcomeKind::Healing;
}
}

#endif
