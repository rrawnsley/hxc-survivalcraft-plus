#ifndef ABILITY_PRACTICE_PROFILES_H
#define ABILITY_PRACTICE_PROFILES_H

#include "AbilityPracticeCatalog.h"
#include "AbilityPracticeMastery.h"

#include <unordered_map>
#include <vector>

namespace AbilityPractice
{
enum class AcquisitionSource
{
    Unreviewed = 0,
    ClassGrant = 1,
    Talent = 2,
    Specialization = 3,
    Item = 4
};

enum class OutcomeKind
{
    Damage,
    Healing,
    Interrupt,
    Dispel,
    Steal,
    None
};

struct AbilityProfile
{
    std::uint32_t DefinitionVersion;
    AcquisitionSource Acquisition;
    AbilityDefinition Definition;
    TrainingPolicy Policy;
    OutcomeKind Outcome;
    std::span<MasteryReward const> Rewards{};
};

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
            ValidateDefinition(ability) != CatalogError::None || !ValidateMasteryRewards(ability, profile.Rewards) ||
            (ability.Kind == AbilityKind::Mastery &&
                ((profile.Outcome != OutcomeKind::Healing && profile.Outcome != OutcomeKind::Damage) ||
                    !ValidMasteryEffect(profile.Rewards.front(), profile.Outcome == OutcomeKind::Healing))) ||
            !ValidPolicy(profile.Policy) ||
            (ability.Kind == AbilityKind::Fixed ? profile.Outcome != OutcomeKind::None :
                profile.Outcome != OutcomeKind::Damage && profile.Outcome != OutcomeKind::Healing &&
                    profile.Outcome != OutcomeKind::Interrupt && profile.Outcome != OutcomeKind::Dispel &&
                    profile.Outcome != OutcomeKind::Steal) ||
            ability.Ranks.size() > 64)
            return false;
        for (AbilityRank const& rank : ability.Ranks)
            if (rank.Requirement.CharacterLevel > 255)
                return false;
        for (ProficiencyCap const& cap : ability.Caps)
            if (cap.CharacterLevel > 255)
                return false;
        if (ability.Kind == AbilityKind::Ranked && (ability.Ranks.size() < 2 ||
            CapAtLevel(ability, 255) != ability.Ranks.back().Requirement.Proficiency))
            return false;
        std::size_t classAbilities = 0;
        std::size_t classRanks = 0;
        std::size_t classRewards = 0;
        for (std::size_t other = 0; other < profiles.size(); ++other)
        {
            AbilityDefinition const& existing = profiles[other].Definition;
            if (existing.ClassId != ability.ClassId)
                continue;
            ++classAbilities;
            classRanks += existing.Ranks.size();
            classRewards += profiles[other].Rewards.size();
            if (other >= index)
                continue;
            if (existing.AbilityId == ability.AbilityId)
                return false;
            for (AbilityRank const& rank : ability.Ranks)
                for (AbilityRank const& known : existing.Ranks)
                    if (rank.SpellId == known.SpellId)
                        return false;
        }
        if (classAbilities > 512 || classRanks > 2048 || classRewards > MaximumClassMasteryRewards)
            return false;
    }
    return true;
}

class ProfileIndex
{
public:
    explicit ProfileIndex(std::span<AbilityProfile const> profiles) : Valid(ValidateProfiles(profiles))
    {
        if (!Valid)
            return;
        for (AbilityProfile const& profile : profiles)
        {
            Classes[profile.Definition.ClassId].push_back(&profile);
            for (AbilityRank const& rank : profile.Definition.Ranks)
                Spells.emplace(Key(profile.Definition.ClassId, rank.SpellId), &profile);
        }
    }

    bool IsValid() const { return Valid; }

    bool HasClass(std::uint32_t classId) const { return Classes.contains(classId); }

    AbilityProfile const* Find(std::uint32_t classId, std::uint32_t spellId) const
    {
        auto const found = Spells.find(Key(classId, spellId));
        return found == Spells.end() ? nullptr : found->second;
    }

    std::span<AbilityProfile const* const> ForClass(std::uint32_t classId) const
    {
        auto const found = Classes.find(classId);
        if (found == Classes.end())
            return {};
        return found->second;
    }

private:
    static std::uint64_t Key(std::uint32_t classId, std::uint32_t spellId)
    {
        return (static_cast<std::uint64_t>(classId) << 32) | spellId;
    }

    bool Valid;
    std::unordered_map<std::uint64_t, AbilityProfile const*> Spells;
    std::unordered_map<std::uint32_t, std::vector<AbilityProfile const*>> Classes;
};
}

#endif
