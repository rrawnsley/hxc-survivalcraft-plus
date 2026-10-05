local PREFIX = "HXAP"
local API = HXCAbilityPractice
local Wire = HXCAbilityPracticeWire
local revision = 0
local nextRequest = 0

function API.Request()
    local now = GetTime()
    if now < nextRequest or type(SendAddonMessage) ~= "function" then return false end
    local player = UnitName("player")
    if not player then return false end
    nextRequest = now + 2
    SendAddonMessage(PREFIX, "HELLO|1", "WHISPER", player)
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
        nextRequest = 0
        API.Request()
        return
    end
    if prefix ~= PREFIX or channel ~= "WHISPER" or sender ~= UnitName("player") then return end
    local snapshot = Wire.Accept(message, GetTime(), revision)
    if snapshot and API.ApplySnapshot(snapshot) then revision = snapshot.revision end
end)
