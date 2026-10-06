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
inline constexpr std::array EnduringShout = {
    AbilityRank{ 680302, 1, { 24, 1 } },
    AbilityRank{ 681439, 2, { 36, 10 } },
    AbilityRank{ 681440, 3, { 48, 20 } },
    AbilityRank{ 681441, 4, { 58, 40 } }
};
inline constexpr auto EnduringShoutCaps = Development::RankCaps(EnduringShout);
inline constexpr std::array Profiles = {
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 12, 300857, AbilityKind::Ranked, BrutalShout, BrutalShoutCaps },
        Development::Policy, OutcomeKind::Damage },
    AbilityProfile{ Development::DefinitionVersion, AcquisitionSource::ClassGrant,
        { 12, 680302, AbilityKind::Ranked, EnduringShout, EnduringShoutCaps },
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

inline std::int32_t StatSelector(AbilityProfile const& profile)
{
    return profile.Definition.AbilityId == 300857 ? 1 : profile.Definition.AbilityId == 680302 ? 2 : -2;
}

inline bool IsBrutalShout(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == ClassId && profile.Definition.AbilityId == AbilityId &&
        profile.Definition.Kind == AbilityKind::Ranked && profile.Outcome == OutcomeKind::Damage;
}
}

#endif
