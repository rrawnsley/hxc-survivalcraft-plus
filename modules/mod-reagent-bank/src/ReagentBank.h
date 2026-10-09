
#ifndef AZEROTHCORE_REAGENTBANK_H
#define AZEROTHCORE_REAGENTBANK_H
#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "Item.h"
#include "ItemTemplate.h"
#include <map>

#define MAX_OPTIONS 23
#define MAX_PAGE_NUMBER 700 // Values higher than this are considered Item IDs
#define NPC_TEXT_ID 4259 // Pre-existing NPC text

enum GossipItemType : uint8
{
    DEPOSIT_ALL_REAGENTS = 16,
    MAIN_MENU = 17,
    HOST_BACK = 18
};

namespace ReagentBank
{
    bool IsEnabled();
    void ShowMainMenu(Player* player, Creature* creature, bool nestedInHost = false);
    // Returns false when nestedInHost and the player chose Back to the host NPC.
    bool HandleSelect(Player* player, Creature* creature, uint32 sender, uint32 action, bool nestedInHost = false);
}

#endif //AZEROTHCORE_REAGENTBANK_H
