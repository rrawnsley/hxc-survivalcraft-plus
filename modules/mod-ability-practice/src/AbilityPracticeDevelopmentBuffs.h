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

inline constexpr std::array Profiles = {
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

struct Mechanic
{
    std::uint32_t ClassId;
    std::uint32_t AbilityId;
    std::uint32_t TargetA;
    std::int32_t Stat;
};

inline constexpr std::array Mechanics = {
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
    Mechanic{ 32, 561237, 21, 1 }
};

static_assert(Mechanics.size() == Profiles.size());

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

inline std::uint32_t Target(AbilityProfile const& profile)
{
    auto const* mechanic = MechanicFor(profile);
    return mechanic ? mechanic->TargetA : 0;
}

inline bool IsBrutalShout(AbilityProfile const& profile)
{
    return profile.Definition.ClassId == ClassId && profile.Definition.AbilityId == AbilityId &&
        profile.Definition.Kind == AbilityKind::Ranked && profile.Outcome == OutcomeKind::Damage;
}
}

#endif
