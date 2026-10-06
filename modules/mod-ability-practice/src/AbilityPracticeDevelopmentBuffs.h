// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ABILITY_PRACTICE_DEVELOPMENT_BUFFS_H
#define ABILITY_PRACTICE_DEVELOPMENT_BUFFS_H

#include "AbilityPracticeDevelopment.h"
#include "AbilityPracticeProfiles.h"

namespace AbilityPractice::DevelopmentBuffs
{
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
inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 12, 300857, AbilityKind::Ranked, BrutalShout, BrutalShoutCaps },
        Development::Policy, OutcomeKind::Damage }
};

inline bool IsBrutalShout(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == ClassId && profile.Definition.AbilityId == AbilityId &&
        profile.Definition.Kind == AbilityKind::Ranked && profile.Outcome == OutcomeKind::Damage;
}
}

#endif
