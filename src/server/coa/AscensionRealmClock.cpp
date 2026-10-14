/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */

#include "AscensionRealmClock.h"
#include "Chat.h"
#include "Opcodes.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "WorldPacket.h"
#include "WorldScript.h"
#include "WorldSession.h"
#include "WorldSessionMgr.h"

namespace
{
class RealmDayCycleWorld final : public WorldScript
{
public:
    RealmDayCycleWorld() : WorldScript("RealmDayCycleWorld", { WORLDHOOK_ON_UPDATE }) { }

    void OnUpdate(uint32) override
    {
        bool const daylight = AscensionRealmClock::IsDaylight();
        if (!_initialized)
        {
            _initialized = true;
            _isDaylight = daylight;
            return;
        }
        if (_isDaylight == daylight)
            return;

        _isDaylight = daylight;
        time_t const clientTime = AscensionRealmClock::ClientTime();
        float const gameSpeed = AscensionRealmClock::GameSpeed();
        for (auto const& [accountId, session] : sWorldSessionMgr->GetAllSessions())
        {
            if (!session || !session->GetPlayer() || !session->GetPlayer()->IsInWorld())
                continue;

            WorldPacket packet(SMSG_LOGIN_SETTIMESPEED, 12);
            packet.AppendPackedTime(clientTime);
            packet << gameSpeed;
            packet << uint32(0);
            session->GetPlayer()->SendDirectMessage(&packet);
        }
        ChatHandler(nullptr).SendWorldText("{}", daylight
            ? "Dawn breaks. The world grows brighter."
            : "The world grows dark. Light a torch or seek shelter.");
    }

private:
    bool _initialized = false;
    bool _isDaylight = false;
};
}

void AddSC_AscensionRealmClock()
{
    new RealmDayCycleWorld();
}
