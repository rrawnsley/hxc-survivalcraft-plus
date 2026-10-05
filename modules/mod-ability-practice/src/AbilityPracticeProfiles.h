#ifndef ABILITY_PRACTICE_PROFILES_H
#define ABILITY_PRACTICE_PROFILES_H

#include "AbilityPracticeCatalog.h"

namespace AbilityPractice
{
enum class AcquisitionSource
{
    Unreviewed,
    ClassGrant,
    Talent,
    Specialization,
    Item
};

enum class DirectOutcome
{
    Damage,
    Healing
};

struct AbilityProfile
{
    std::uint32_t DefinitionVersion;
    AcquisitionSource Acquisition;
    AbilityDefinition Definition;
    TrainingPolicy Policy;
    DirectOutcome Outcome;
};

inline AbilityProfile const* FindProfile(std::span<AbilityProfile const> profiles,
    std::uint32_t classId, std::uint32_t spellId)
{
    for (AbilityProfile const& profile : profiles)
        if (profile.Definition.ClassId == classId)
            for (AbilityRank const& rank : profile.Definition.Ranks)
                if (rank.SpellId == spellId)
                    return &profile;
    return nullptr;
}

inline bool HasProfiles(std::span<AbilityProfile const> profiles, std::uint32_t classId)
{
    return std::any_of(profiles.begin(), profiles.end(), [classId](AbilityProfile const& profile)
        { return profile.Definition.ClassId == classId; });
}

inline bool ValidateProfiles(std::span<AbilityProfile const> profiles)
{
    if (profiles.empty())
        return false;
    for (std::size_t index = 0; index < profiles.size(); ++index)
    {
        AbilityProfile const& profile = profiles[index];
        AbilityDefinition const& ability = profile.Definition;
        if (!profile.DefinitionVersion || profile.Acquisition != AcquisitionSource::ClassGrant ||
            ability.ClassId > 255 ||
            ValidateDefinition(ability) != CatalogError::None || !ValidPolicy(profile.Policy) ||
            (profile.Outcome != DirectOutcome::Damage && profile.Outcome != DirectOutcome::Healing) ||
            ability.Ranks.size() > 64)
            return false;
        for (AbilityRank const& rank : ability.Ranks)
            if (rank.Requirement.CharacterLevel > 255)
                return false;
        for (ProficiencyCap const& cap : ability.Caps)
            if (cap.CharacterLevel > 255)
                return false;
        if (ability.Kind != AbilityKind::Fixed &&
            CapAtLevel(ability, 255) < ability.Ranks.back().Requirement.Proficiency)
            return false;
        std::size_t classAbilities = 0;
        std::size_t classRanks = 0;
        for (std::size_t other = 0; other < profiles.size(); ++other)
        {
            AbilityDefinition const& existing = profiles[other].Definition;
            if (existing.ClassId != ability.ClassId)
                continue;
            ++classAbilities;
            classRanks += existing.Ranks.size();
            if (other >= index)
                continue;
            if (existing.AbilityId == ability.AbilityId)
                return false;
            for (AbilityRank const& rank : ability.Ranks)
                for (AbilityRank const& known : existing.Ranks)
                    if (rank.SpellId == known.SpellId)
                        return false;
        }
        if (classAbilities > 512 || classRanks > 2048)
            return false;
    }
    return true;
}
}

#endif
