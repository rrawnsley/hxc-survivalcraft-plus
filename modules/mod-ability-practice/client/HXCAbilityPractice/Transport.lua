local PREFIX = "HXAP"
local API = HXCAbilityPractice
local Wire = HXCAbilityPracticeWire
local revision = 0
local generation
local nextRequest = 0
local deadline
local nextPoll = 0
local elapsed = 0

function API.Request()
    local now = GetTime()
    if now < nextRequest or type(SendAddonMessage) ~= "function" then return false end
    local player = UnitName("player")
    if not player then return false end
    nextRequest = now + 2
    deadline = now + 6
    nextPoll = now + 10
    API.SetSyncState("waiting")
    SendAddonMessage(PREFIX, "HELLO|4", "WHISPER", player)
    return true
end

local listener = CreateFrame("Frame", "HXCAbilityPracticeListener", UIParent)
listener:RegisterEvent("PLAYER_LOGIN")
listener:RegisterEvent("CHAT_MSG_ADDON")
listener:SetScript("OnEvent", function(_, event, prefix, message, channel, sender)
    if event == "PLAYER_LOGIN" then
        Wire.Reset()
        API.Reset()
        revision = 0
        generation = nil
        nextRequest = 0
        deadline = nil
        nextPoll = 0
        elapsed = 0
        API.Request()
        return
    end
    if prefix ~= PREFIX or channel ~= "WHISPER" or sender ~= UnitName("player") then return end
    local snapshot, reason, failure = Wire.Accept(message, GetTime(), revision, generation)
    local incoming = snapshot and snapshot.generation or failure and failure.generation
        or (not reason and Wire.GetGeneration())
    if incoming and incoming ~= generation then
        API.BeginServerGeneration(incoming)
        generation = incoming
        revision = 0
    end
    if snapshot and API.ApplyServerSnapshot(snapshot) then
        revision = snapshot.revision
        deadline = nil
    elseif failure and API.ApplyServerFailure(failure) then
        revision = failure.revision
        deadline = nil
    elseif not reason then
        local assemblyDeadline = Wire.GetDeadline()
        if assemblyDeadline then
            deadline = assemblyDeadline
            API.SetSyncState("waiting")
        end
    end
end)
listener:SetScript("OnUpdate", function(_, delta)
    elapsed = elapsed + delta
    if elapsed < 1 then return end
    elapsed = 0
    local now = GetTime()
    API.UpdateAge(now)
    if deadline and now >= deadline then
        deadline = nil
        Wire.Reset()
        API.SetSyncState("unavailable")
    end
    if not deadline and API.IsShown() and now >= nextPoll then API.Request() end
end)
