// mod-coa-challenges (review split): CoA.Challenges.Professions.cpp
// Mechanical split of review-CoAChallenges.cpp; no logic changes.
#include "CoA.Challenges.Review.h"
#include "WorldState.h"
#include <mutex>

namespace CoAChallenges
{
    namespace
    {
        struct OldSchoolTownProject
        {
            uint32 questId;
            uint32 worldStateId;
            uint32 contributionGoal;
            char const* name;
        };

        constexpr std::array<OldSchoolTownProject, 14> OldSchoolTownProjects = {{
            { QUEST_OLD_SCHOOL_CROSSROADS_WORKSHOP, WORLD_STATE_OLD_SCHOOL_CROSSROADS_WORKSHOP,
                OLD_SCHOOL_CROSSROADS_WORKSHOP_GOAL, "Crossroads" },
            { QUEST_OLD_SCHOOL_BRILL_WORKSHOP, WORLD_STATE_OLD_SCHOOL_BRILL_WORKSHOP,
                OLD_SCHOOL_BRILL_WORKSHOP_GOAL, "Brill" },
            { QUEST_OLD_SCHOOL_ANVILMAR_WORKSHOP, WORLD_STATE_OLD_SCHOOL_ANVILMAR_WORKSHOP,
                OLD_SCHOOL_ANVILMAR_WORKSHOP_GOAL, "Anvilmar" },
            { QUEST_OLD_SCHOOL_RAZOR_HILL_WORKSHOP, WORLD_STATE_OLD_SCHOOL_RAZOR_HILL_WORKSHOP,
                OLD_SCHOOL_RAZOR_HILL_WORKSHOP_GOAL, "Razor Hill" },
            { QUEST_OLD_SCHOOL_GOLDSHIRE_WORKSHOP, WORLD_STATE_OLD_SCHOOL_GOLDSHIRE_WORKSHOP,
                OLD_SCHOOL_GOLDSHIRE_WORKSHOP_GOAL, "Goldshire" },
            { QUEST_OLD_SCHOOL_THELSAMAR_WORKSHOP, WORLD_STATE_OLD_SCHOOL_THELSAMAR_WORKSHOP,
                OLD_SCHOOL_THELSAMAR_WORKSHOP_GOAL, "Thelsamar" },
            { QUEST_OLD_SCHOOL_AUBERDINE_WORKSHOP, WORLD_STATE_OLD_SCHOOL_AUBERDINE_WORKSHOP,
                OLD_SCHOOL_AUBERDINE_WORKSHOP_GOAL, "Auberdine" },
            { QUEST_OLD_SCHOOL_AZURE_WATCH_WORKSHOP, WORLD_STATE_OLD_SCHOOL_AZURE_WATCH_WORKSHOP,
                OLD_SCHOOL_AZURE_WATCH_WORKSHOP_GOAL, "Azure Watch" },
            { QUEST_OLD_SCHOOL_SEPULCHER_WORKSHOP, WORLD_STATE_OLD_SCHOOL_SEPULCHER_WORKSHOP,
                OLD_SCHOOL_SEPULCHER_WORKSHOP_GOAL, "Sepulcher" },
            { QUEST_OLD_SCHOOL_DOLANAAR_WORKSHOP, WORLD_STATE_OLD_SCHOOL_DOLANAAR_WORKSHOP,
                OLD_SCHOOL_DOLANAAR_WORKSHOP_GOAL, "Dolanaar" },
            { QUEST_OLD_SCHOOL_CAMP_NARACHE_WORKSHOP, WORLD_STATE_OLD_SCHOOL_CAMP_NARACHE_WORKSHOP,
                OLD_SCHOOL_CAMP_NARACHE_WORKSHOP_GOAL, "Camp Narache" },
            { QUEST_OLD_SCHOOL_BLOODHOOF_WORKSHOP, WORLD_STATE_OLD_SCHOOL_BLOODHOOF_WORKSHOP,
                OLD_SCHOOL_BLOODHOOF_WORKSHOP_GOAL, "Bloodhoof Village" },
            { QUEST_OLD_SCHOOL_RATCHET_WORKSHOP, WORLD_STATE_OLD_SCHOOL_RATCHET_WORKSHOP,
                OLD_SCHOOL_RATCHET_WORKSHOP_GOAL, "Ratchet" },
            { QUEST_OLD_SCHOOL_BOOTY_BAY_WORKSHOP, WORLD_STATE_OLD_SCHOOL_BOOTY_BAY_WORKSHOP,
                OLD_SCHOOL_BOOTY_BAY_WORKSHOP_GOAL, "Booty Bay" }
        }};
        constexpr uint32 OldSchoolTownProjectExperienceBonus = 10;
        std::mutex OldSchoolWorkshopMutex;

        OldSchoolTownProject const* FindOldSchoolTownProject(uint32 questId)
        {
            auto const it = std::find_if(OldSchoolTownProjects.begin(), OldSchoolTownProjects.end(),
                [questId](OldSchoolTownProject const& project) { return project.questId == questId; });
            return it != OldSchoolTownProjects.end() ? &*it : nullptr;
        }

        uint32 OldSchoolTownProjectContributionCount(OldSchoolTownProject const& project)
        {
            return uint32(std::min<uint64>(sWorldState->getWorldState(project.worldStateId), project.contributionGoal));
        }
    }

    bool IsOldSchoolTownProjectQuest(uint32 questId)
    {
        return FindOldSchoolTownProject(questId) != nullptr;
    }

    uint32 OldSchoolTownProjectContributionCount(uint32 questId)
    {
        OldSchoolTownProject const* project = FindOldSchoolTownProject(questId);
        if (!project || !sWorldState)
            return 0;
        std::lock_guard<std::mutex> lock(OldSchoolWorkshopMutex);
        return OldSchoolTownProjectContributionCount(*project);
    }

    uint32 OldSchoolTownProjectContributionGoal(uint32 questId)
    {
        OldSchoolTownProject const* project = FindOldSchoolTownProject(questId);
        return project ? project->contributionGoal : 0;
    }

    char const* OldSchoolTownProjectName(uint32 questId)
    {
        OldSchoolTownProject const* project = FindOldSchoolTownProject(questId);
        return project ? project->name : "town";
    }

    bool AddOldSchoolTownProjectContribution(uint32 questId, uint32& progress)
    {
        OldSchoolTownProject const* project = FindOldSchoolTownProject(questId);
        if (!project || !sWorldState)
            return false;
        std::lock_guard<std::mutex> lock(OldSchoolWorkshopMutex);
        progress = OldSchoolTownProjectContributionCount(*project);
        if (progress >= project->contributionGoal)
            return false;
        ++progress;
        sWorldState->setWorldState(project->worldStateId, progress);
        return true;
    }

    uint32 OldSchoolTownProjectExperienceBonusPercent()
    {
        if (!sWorldState)
            return 0;
        std::lock_guard<std::mutex> lock(OldSchoolWorkshopMutex);
        uint32 bonus = 0;
        for (OldSchoolTownProject const& project : OldSchoolTownProjects)
            if (OldSchoolTownProjectContributionCount(project) >= project.contributionGoal)
                bonus += OldSchoolTownProjectExperienceBonus;
        return bonus;
    }

    // ---- Profession rules -------------------------------------------------
    // Craft rarity stash: OnPlayerUpdateCraftingSkill runs before the skill-up
    // roll, OnPlayerUpdateSkill after a success. The stash carries the crafted
    // item's rarity (1 + quality) between the two for the XP computation.
    std::mutex CraftRarityMutex;
    std::unordered_map<uint32, uint32> CraftRarity; // player guid -> rarity multiplier

    uint32 CraftedItemRarity(SkillLineAbilityEntry const* ability)
    {
        if (!ability)
            return 1;
        SpellInfo const* cast = sSpellMgr->GetSpellInfo(ability->Spell);
        if (!cast)
            return 1;
        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        {
            if (cast->Effects[i].Effect != SPELL_EFFECT_CREATE_ITEM || !cast->Effects[i].ItemType)
                continue;
            if (ItemTemplate const* proto = sObjectMgr->GetItemTemplate(cast->Effects[i].ItemType))
                return 1 + std::min<uint32>(proto->Quality, 5);
        }
        return 1;
    }

    void GrantProfessionXP(Player* member, uint32 rarityMult)
    {
        if (!member || !member->IsInWorld())
            return;
        uint32 perLevel = sConfigMgr->GetOption<uint32>("CoAChallenges.ProfessionXP.PointsPerLevel", 50);
        if (!perLevel)
            perLevel = 50;
        uint32 xp = sObjectMgr->GetXPForLevel(member->GetLevel()) / perLevel * rarityMult;
        sScriptMgr->OnPlayerGiveXP(member, xp, nullptr, XPSOURCE_PROFESSION_SKILL);
        member->GiveXP(xp, nullptr);
    }
} // namespace CoAChallenges
