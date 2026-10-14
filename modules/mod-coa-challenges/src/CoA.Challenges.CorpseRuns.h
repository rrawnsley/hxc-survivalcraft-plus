#ifndef COA_CHALLENGES_CORPSE_RUNS_H
#define COA_CHALLENGES_CORPSE_RUNS_H

#include "Define.h"

class Player;

namespace CoAChallenges
{
    constexpr uint32 OldSchoolEquipmentCorpseEntry = 996900;

    bool PreserveOldSchoolCorpseEquipment(Player* player);
    bool RespawnOldSchoolAtBind(Player* player);
    bool IsOldSchoolBindRespawn(Player const* player);
    void RecoverOldSchoolEquipmentAtDeath(Player* player);
    void UpdateOldSchoolEquipmentCorpses(Player* player, uint32 diff, bool standardTrial);
    void RegisterOldSchoolEquipmentCorpses();
}

#endif
