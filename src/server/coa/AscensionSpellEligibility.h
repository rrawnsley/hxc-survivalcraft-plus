/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
#ifndef ASCENSION_SPELL_ELIGIBILITY_H
#define ASCENSION_SPELL_ELIGIBILITY_H

#include "AscensionFelsworn.h"
#include "AscensionRacialAbilities.h"
#include "Player.h"
#include "SpellMgr.h"

namespace AscensionAcquisition
{
inline bool CanLearnRacialSpell(Player const* player, uint32 spellId)
{
    if (!player || !spellId || !AscensionFelsworn::CanLearnRift(player, spellId))
        return false;
    bool racial = false;
    auto const bounds = sSpellMgr->GetSkillLineAbilityMapBounds(spellId);
    for (auto itr = bounds.first; itr != bounds.second; ++itr)
        if (AscensionRacialAbilities::GetRace(itr->second->SkillLine))
        {
            racial = true;
            if (AscensionRacialAbilities::CanLearn(*itr->second, player->getRace(), player->getClass()))
                return true;
        }
    return !racial;
}
}

#endif
