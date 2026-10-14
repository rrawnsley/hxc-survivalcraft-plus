#include "CoA.Challenges.Review.h"
#include "CoA.Challenges.CorpseRuns.h"
#include "CreatureScript.h"
#include "Map.h"
#include "ObjectMgr.h"
#include "PassiveAI.h"
#include "ScriptedGossip.h"
#include "TemporarySummon.h"
#include "WorldScript.h"

namespace CoAChallenges
{
    namespace
    {
        constexpr char const* PlayerCorpseKey = "coa.old_school.equipment_corpses";
        constexpr char const* EquipmentCorpseKey = "coa.old_school.equipment_corpse";

        struct EquipmentCorpsePlayerState : DataMap::Base
        {
            uint32 scanRemaining = 0;
            bool bindRespawn = false;
        };

        struct EquipmentCorpseState : DataMap::Base
        {
            uint64 id = 0;
            uint32 owner = 0;
        };

        std::atomic<uint64> NextEquipmentCorpseId{ 1 };
        std::mutex EquipmentCorpseMutex;
        std::unordered_map<uint64, ObjectGuid> EquipmentCorpseGuids;

        CharacterDatabasePreparedStatement* SelectCorpseItems(uint64 id, uint32 owner)
        {
            auto* statement = CharacterDatabase.GetPreparedStatement(CHAR_SEL_COA_EQUIPMENT_CORPSE_ITEMS);
            statement->SetData(0, id);
            statement->SetData(1, owner);
            return statement;
        }

        void AppendCorpseHeader(CharacterDatabaseTransaction const& transaction, Player* player,
            uint64 id, WorldLocation const& location)
        {
            auto* statement = CharacterDatabase.GetPreparedStatement(CHAR_INS_COA_EQUIPMENT_CORPSE);
            statement->SetData(0, id);
            statement->SetData(1, player->GetGUID().GetCounter());
            statement->SetData(2, location.GetMapId());
            statement->SetData(3, player->GetInstanceId());
            statement->SetData(4, location.GetPositionX());
            statement->SetData(5, location.GetPositionY());
            statement->SetData(6, location.GetPositionZ());
            statement->SetData(7, location.GetOrientation());
            statement->SetData(8, player->GetNativeDisplayId());
            statement->SetData(9, uint32(std::time(nullptr)));
            transaction->Append(statement);
        }

        void DeleteEmptyCorpse(uint64 id, uint32 owner)
        {
            auto* statement = CharacterDatabase.GetPreparedStatement(CHAR_DEL_COA_EMPTY_EQUIPMENT_CORPSE);
            statement->SetData(0, id);
            statement->SetData(1, owner);
            CharacterDatabase.DirectExecute(statement);
        }

        void ImportLegacyCorpse(Player* player)
        {
            uint32 const owner = player->GetGUID().GetCounter();
            auto* select = CharacterDatabase.GetPreparedStatement(CHAR_SEL_COA_OLD_SCHOOL_CORPSE_ITEMS);
            select->SetData(0, owner);
            if (!CharacterDatabase.Query(select))
                return;

            WorldLocation location = player->GetCorpseLocation();
            if (!sMapStore.LookupEntry(location.GetMapId()))
                location = WorldLocation(player->GetMapId(), player->GetPositionX(), player->GetPositionY(),
                    player->GetPositionZ(), player->GetOrientation());

            uint64 const id = NextEquipmentCorpseId.fetch_add(1);
            CharacterDatabaseTransaction transaction = CharacterDatabase.BeginTransaction();
            AppendCorpseHeader(transaction, player, id, location);
            auto* import = CharacterDatabase.GetPreparedStatement(CHAR_INS_COA_EQUIPMENT_CORPSE_LEGACY);
            import->SetData(0, id);
            import->SetData(1, owner);
            transaction->Append(import);
            auto* cleanup = CharacterDatabase.GetPreparedStatement(CHAR_DEL_COA_EQUIPMENT_CORPSE_LEGACY);
            cleanup->SetData(0, id);
            cleanup->SetData(1, owner);
            transaction->Append(cleanup);
            CharacterDatabase.DirectCommitTransaction(transaction);
            DeleteEmptyCorpse(id, owner);
        }

        uint32 RecoverEquipmentCorpse(Player* player, uint64 id)
        {
            if (!player || !player->IsAlive() || player->IsInCombat() || player->GetSession()->IsBot())
                return 0;

            uint32 const owner = player->GetGUID().GetCounter();
            PreparedQueryResult rows = CharacterDatabase.Query(SelectCorpseItems(id, owner));
            if (!rows)
                return 0;

            uint32 recovered = 0;
            do
            {
                Field* fields = rows->Fetch();
                uint32 const itemGuid = fields[11].Get<uint32>();
                uint32 const entry = fields[12].Get<uint32>();
                uint8 const originalSlot = fields[13].Get<uint8>();
                ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(entry);
                if (!itemTemplate)
                    continue;

                std::unique_ptr<Item> item(NewItemOrBag(itemTemplate));
                if (!item->LoadFromDB(itemGuid, player->GetGUID(), fields, entry))
                    continue;

                uint16 destination = 0;
                bool const equip = originalSlot < EQUIPMENT_SLOT_END
                    && !player->GetItemByPos(INVENTORY_SLOT_BAG_0, originalSlot)
                    && player->CanEquipItem(originalSlot, destination, item.get(), false, false) == EQUIP_ERR_OK;
                ItemPosCountVec storage;
                if (!equip)
                {
                    if (player->CanStoreItem(NULL_BAG, NULL_SLOT, storage, item.get(), false) != EQUIP_ERR_OK
                        || storage.size() != 1 || storage.front().count != item->GetCount())
                        continue;
                    destination = storage.front().pos;
                    if (player->GetItemByPos(destination))
                        continue;
                }

                uint8 const bagSlot = uint8(destination >> 8);
                uint8 const itemSlot = uint8(destination);
                Bag* bag = bagSlot == INVENTORY_SLOT_BAG_0 ? nullptr : player->GetBagByPos(bagSlot);
                if (bagSlot != INVENTORY_SLOT_BAG_0 && !bag)
                    continue;
                uint32 const bagGuid = bag ? bag->GetGUID().GetCounter() : 0;

                CharacterDatabaseTransaction transaction = CharacterDatabase.BeginTransaction();
                auto* inventory = CharacterDatabase.GetPreparedStatement(CHAR_INS_COA_CORPSE_INVENTORY_ITEM);
                inventory->SetData(0, bagGuid);
                inventory->SetData(1, itemSlot);
                inventory->SetData(2, id);
                inventory->SetData(3, owner);
                inventory->SetData(4, itemGuid);
                transaction->Append(inventory);
                auto* remove = CharacterDatabase.GetPreparedStatement(CHAR_DEL_COA_RECOVERED_CORPSE_ITEM);
                remove->SetData(0, id);
                remove->SetData(1, itemGuid);
                remove->SetData(2, owner);
                transaction->Append(remove);
                CharacterDatabase.DirectCommitTransaction(transaction);

                auto* proof = CharacterDatabase.GetPreparedStatement(CHAR_SEL_COA_CORPSE_INVENTORY_ITEM);
                proof->SetData(0, owner);
                proof->SetData(1, itemGuid);
                proof->SetData(2, bagGuid);
                proof->SetData(3, itemSlot);
                if (!CharacterDatabase.Query(proof))
                    continue;

                Item* restored = item.release();
                if (equip)
                    player->EquipItem(destination, restored, true);
                else
                    player->MoveItemToInventory(storage, restored, true, true);
                ++recovered;
            }
            while (rows->NextRow());

            DeleteEmptyCorpse(id, owner);
            if (recovered)
                NotifyPlayer(player, "Old School: recovered {} item(s). Any remaining equipment stays on this corpse.",
                    recovered);
            else
                NotifyPlayer(player, "Old School: make room in your bags or finish combat before recovering equipment.");
            return recovered;
        }

        void ScanEquipmentCorpses(Player* player)
        {
            auto* select = CharacterDatabase.GetPreparedStatement(CHAR_SEL_COA_EQUIPMENT_CORPSES);
            select->SetData(0, player->GetGUID().GetCounter());
            select->SetData(1, player->GetMapId());
            select->SetData(2, player->GetInstanceId());
            PreparedQueryResult rows = CharacterDatabase.Query(select);
            if (!rows)
                return;

            do
            {
                Field* fields = rows->Fetch();
                uint64 const id = fields[0].Get<uint64>();
                Position location(fields[1].Get<float>(), fields[2].Get<float>(), fields[3].Get<float>(),
                    fields[4].Get<float>());
                if (player->GetDistance(location) > 120.0f)
                    continue;

                {
                    std::lock_guard<std::mutex> lock(EquipmentCorpseMutex);
                    if (auto it = EquipmentCorpseGuids.find(id); it != EquipmentCorpseGuids.end())
                        if (ObjectAccessor::GetCreature(*player, it->second))
                            continue;
                }

                TempSummon* body = player->SummonCreature(OldSchoolEquipmentCorpseEntry, location,
                    TEMPSUMMON_MANUAL_DESPAWN);
                if (!body)
                    continue;
                EquipmentCorpseState* state = body->CustomData.GetDefault<EquipmentCorpseState>(EquipmentCorpseKey);
                state->id = id;
                state->owner = player->GetGUID().GetCounter();
                body->SetOwnerGUID(ObjectGuid::Empty);
                body->SetPhaseMask(PHASEMASK_ANYWHERE, true);
                body->SetDisplayId(fields[5].Get<uint32>());
                body->SetNativeDisplayId(fields[5].Get<uint32>());
                body->SetStandState(UNIT_STAND_STATE_DEAD);
                body->SetReactState(REACT_PASSIVE);
                body->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
                body->SetNPCFlag(UNIT_NPC_FLAG_GOSSIP);
                std::lock_guard<std::mutex> lock(EquipmentCorpseMutex);
                EquipmentCorpseGuids[id] = body->GetGUID();
            }
            while (rows->NextRow());
        }

        class OldSchoolEquipmentCorpse : public CreatureScript
        {
        public:
            OldSchoolEquipmentCorpse() : CreatureScript("coa_old_school_equipment_corpse") { }

            CreatureAI* GetAI(Creature* creature) const override
            {
                return new PassiveAI(creature);
            }

            bool OnGossipHello(Player* player, Creature* creature) override
            {
                EquipmentCorpseState const* state = creature->CustomData.Get<EquipmentCorpseState>(EquipmentCorpseKey);
                if (!state || state->owner != player->GetGUID().GetCounter())
                {
                    CloseGossipMenuFor(player);
                    return true;
                }
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Recover my equipment", GOSSIP_SENDER_MAIN, 1);
                SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
                return true;
            }

            bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
            {
                ClearGossipMenuFor(player);
                CloseGossipMenuFor(player);
                EquipmentCorpseState const* state = creature->CustomData.Get<EquipmentCorpseState>(EquipmentCorpseKey);
                if (!state || state->owner != player->GetGUID().GetCounter() || sender != GOSSIP_SENDER_MAIN
                    || action != 1 || !player->IsAlive() || player->IsInCombat()
                    || !player->IsWithinDistInMap(creature, 5.0f))
                    return true;

                RecoverEquipmentCorpse(player, state->id);
                if (!CharacterDatabase.Query(SelectCorpseItems(state->id, state->owner)))
                {
                    {
                        std::lock_guard<std::mutex> lock(EquipmentCorpseMutex);
                        EquipmentCorpseGuids.erase(state->id);
                    }
                    creature->DespawnOrUnsummon();
                }
                return true;
            }
        };

        class OldSchoolEquipmentCorpseWorld : public WorldScript
        {
        public:
            OldSchoolEquipmentCorpseWorld() : WorldScript("OldSchoolEquipmentCorpseWorld", { WORLDHOOK_ON_STARTUP }) { }

            void OnStartup() override
            {
                auto* select = CharacterDatabase.GetPreparedStatement(CHAR_SEL_COA_MAX_EQUIPMENT_CORPSE);
                if (PreparedQueryResult result = CharacterDatabase.Query(select))
                    NextEquipmentCorpseId.store(result->Fetch()[0].Get<uint64>() + 1);
            }
        };
    }

    bool PreserveOldSchoolCorpseEquipment(Player* player)
    {
        if (!player || player->GetSession()->IsBot() || !player->IsInWorld() || !player->GetMap()
            || player->GetMap()->IsBattlegroundOrArena())
            return true;

        struct EquipmentItem
        {
            Item* item;
            uint8 slot;
            ItemUpdateState state;
            bool queued;
        };
        std::vector<EquipmentItem> equipment;
        for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
            if (Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
            {
                if (item->GetState() == ITEM_REMOVED)
                    return false;
                equipment.push_back({ item, slot, item->GetState(), item->IsInUpdateQueue() });
            }
        if (equipment.empty())
            return true;

        WorldLocation location(player->GetMapId(), player->GetPositionX(), player->GetPositionY(),
            player->GetPositionZ(), player->GetOrientation());
        if (player->HasPlayerFlag(PLAYER_FLAGS_GHOST))
            location = player->GetCorpseLocation();

        uint64 const id = NextEquipmentCorpseId.fetch_add(1);
        uint32 const owner = player->GetGUID().GetCounter();
        CharacterDatabaseTransaction transaction = CharacterDatabase.BeginTransaction();
        AppendCorpseHeader(transaction, player, id, location);
        for (EquipmentItem const& entry : equipment)
        {
            if (entry.state == ITEM_UNCHANGED)
                entry.item->FSetState(ITEM_CHANGED);
            entry.item->SaveToDB(transaction);
            entry.item->DeleteFromInventoryDB(transaction);
            auto* link = CharacterDatabase.GetPreparedStatement(CHAR_INS_COA_EQUIPMENT_CORPSE_ITEM);
            link->SetData(0, id);
            link->SetData(1, entry.item->GetGUID().GetCounter());
            link->SetData(2, entry.slot);
            transaction->Append(link);
        }
        CharacterDatabase.DirectCommitTransaction(transaction);

        auto* proof = CharacterDatabase.GetPreparedStatement(CHAR_SEL_COA_EQUIPMENT_CORPSE_COUNT);
        proof->SetData(0, id);
        proof->SetData(1, owner);
        PreparedQueryResult count = CharacterDatabase.Query(proof);
        if (!count || count->Fetch()[0].Get<uint32>() != equipment.size())
        {
            for (EquipmentItem const& entry : equipment)
            {
                entry.item->FSetState(entry.state);
                if (entry.queued)
                    entry.item->AddToUpdateQueueOf(player);
            }
            NotifyPlayer(player, "Old School: equipment could not be secured. Release again to retry safely.");
            return false;
        }

        for (EquipmentItem const& entry : equipment)
        {
            player->MoveItemFromInventory(INVENTORY_SLOT_BAG_0, entry.slot, true);
            entry.item->RemoveFromUpdateQueueOf(player);
            delete entry.item;
        }
        player->CustomData.GetDefault<EquipmentCorpsePlayerState>(PlayerCorpseKey)->scanRemaining = 0;
        NotifyPlayer(player, "Old School: your worn equipment remains at your death location. "
            "Release to revive at your bind point, then return alive and recover it from your corpse.");
        return true;
    }

    bool IsOldSchoolBindRespawn(Player const* player)
    {
        EquipmentCorpsePlayerState const* state = player
            ? player->CustomData.Get<EquipmentCorpsePlayerState>(PlayerCorpseKey) : nullptr;
        return state && state->bindRespawn;
    }

    bool RespawnOldSchoolAtBind(Player* player)
    {
        if (!player || player->GetSession()->IsBot() || !player->IsInWorld() || player->IsAlive()
            || !player->GetMap() || player->GetMap()->IsBattlegroundOrArena())
            return false;
        if (!PreserveOldSchoolCorpseEquipment(player))
            return false;

        ImportLegacyCorpse(player);
        EquipmentCorpsePlayerState* state = player->CustomData.GetDefault<EquipmentCorpsePlayerState>(PlayerCorpseKey);
        state->bindRespawn = true;
        player->ResurrectPlayer(0.2f, false);
        state->bindRespawn = false;
        if (!player->IsAlive())
            return false;
        player->SpawnCorpseBones();
        if (!player->TeleportTo(player->m_homebindMapId, player->m_homebindX, player->m_homebindY,
            player->m_homebindZ, 0.0f))
        {
            NotifyPlayer(player, "Old School: bind teleport failed. Your equipment is still secured on your corpse.");
            return true;
        }
        NotifyPlayer(player, "Old School: you are alive at your bind point with 20% health and mana. "
            "Enemies can attack you. Return to your equipment corpse to recover your gear.");
        return true;
    }

    void RecoverOldSchoolEquipmentAtDeath(Player* player)
    {
        if (!player || IsOldSchoolBindRespawn(player) || !player->IsAlive() || !player->IsInWorld())
            return;
        auto* select = CharacterDatabase.GetPreparedStatement(CHAR_SEL_COA_EQUIPMENT_CORPSES);
        select->SetData(0, player->GetGUID().GetCounter());
        select->SetData(1, player->GetMapId());
        select->SetData(2, player->GetInstanceId());
        if (PreparedQueryResult rows = CharacterDatabase.Query(select))
            do
            {
                Field* fields = rows->Fetch();
                if (player->GetDistance(fields[1].Get<float>(), fields[2].Get<float>(), fields[3].Get<float>()) <= 5.0f)
                    RecoverEquipmentCorpse(player, fields[0].Get<uint64>());
            }
            while (rows->NextRow());
    }

    void UpdateOldSchoolEquipmentCorpses(Player* player, uint32 diff, bool standardTrial)
    {
        if (!player || player->GetSession()->IsBot() || !player->IsInWorld() || !player->GetMap())
            return;
        EquipmentCorpsePlayerState* state = player->CustomData.GetDefault<EquipmentCorpsePlayerState>(PlayerCorpseKey);
        if (state->scanRemaining > diff)
        {
            state->scanRemaining -= diff;
            return;
        }
        state->scanRemaining = 5000;
        if (standardTrial && player->HasPlayerFlag(PLAYER_FLAGS_GHOST))
            RespawnOldSchoolAtBind(player);
        ScanEquipmentCorpses(player);
    }

    void RegisterOldSchoolEquipmentCorpses()
    {
        new OldSchoolEquipmentCorpse();
        new OldSchoolEquipmentCorpseWorld();
    }
}
