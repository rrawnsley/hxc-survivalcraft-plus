local API = HXCAbilityPractice
local event = HXCAbilityPracticeListener.scripts.OnEvent
MockTime = 0
assert(API.Request())
assert(#MockMessages == 1)
assert(MockMessages[1][1] == "HXAP" and MockMessages[1][2] == "HELLO|7")
assert(MockMessages[1][3] == "WHISPER" and MockMessages[1][4] == "TestPlayer")
assert(not API.Request())
MockTime = 2
assert(API.Request() and #MockMessages == 2)
event(nil, "PLAYER_LOGIN")
assert(#MockMessages == 3)
for _, line in ipairs(EncodedPracticeSnapshot) do
    event(nil, "CHAT_MSG_ADDON", "HXAP", line, "WHISPER", "AnotherPlayer")
end
assert(API.ApplySnapshot({ schemaVersion = 1, revision = 1, classId = 24, characterLevel = 24, abilities = {} }))
event(nil, "PLAYER_LOGIN")
for _, line in ipairs(EncodedPracticeSnapshot) do
    event(nil, "CHAT_MSG_ADDON", "HXAP", line, "WHISPER", "TestPlayer")
end
assert(not API.ApplySnapshot({ schemaVersion = 1, revision = 10, classId = 24, characterLevel = 24, abilities = {} }))
event(nil, "PLAYER_LOGIN")
event(nil, "CHAT_MSG_ADDON", "HXAP", "B|1|1|24|24|0", "WHISPER", "TestPlayer")
event(nil, "CHAT_MSG_ADDON", "HXAP", "E|1", "WHISPER", "TestPlayer")
assert(not API.ApplySnapshot({ schemaVersion = 1, revision = 1, classId = 24, characterLevel = 24, abilities = {} }))
print("PASS: self-whisper transport, request throttle, sender rejection and login revision reset")

event(nil, "PLAYER_LOGIN")
MockTime = 9
HXCAbilityPracticeListener.scripts.OnUpdate(nil, 1)
assert(MockMessages[#MockMessages][2] == "HELLO|6")
MockTime = 16
HXCAbilityPracticeListener.scripts.OnUpdate(nil, 1)
assert(MockMessages[#MockMessages][2] == "HELLO|5")
MockTime = 23
HXCAbilityPracticeListener.scripts.OnUpdate(nil, 1)
assert(MockMessages[#MockMessages][2] == "HELLO|4")
event(nil, "CHAT_MSG_ADDON", "HXAP", "B|4|1|13|60|0|778|80", "WHISPER", "TestPlayer")
event(nil, "CHAT_MSG_ADDON", "HXAP", "S|1|1|0|0", "WHISPER", "TestPlayer")
event(nil, "CHAT_MSG_ADDON", "HXAP", "E|1", "WHISPER", "TestPlayer")
MockTime = 27
assert(API.Request())
assert(MockMessages[#MockMessages][2] == "HELLO|4")
print("PASS: schema 7 request falls back through schemas 6 and 5 to schema 4 when an older server does not respond")

API.SetOldSchoolRequired(true)
API.SetOldSchoolRequired(false)
event(nil, "CHAT_MSG_ADDON", "HXAP", "MODE|OLD_SCHOOL_REQUIRED", "WHISPER", "TestPlayer")
event(nil, "CHAT_MSG_ADDON", "HXAP", "MODE|ACTIVE", "WHISPER", "TestPlayer")
print("PASS: Old School participation notices are accepted without changing snapshot protocol")

event(nil, "CHAT_MSG_ADDON", "HXAP", "MODE|OLD_SCHOOL_ENDED", "WHISPER", "TestPlayer")
local endedLabel = false
for _, widget in ipairs(MockWidgets) do
    if widget.text and string.find(widget.text, "Old School run ended", 1, true) then endedLabel = true end
end
assert(endedLabel)
event(nil, "CHAT_MSG_ADDON", "HXAP", "MODE|ACTIVE", "WHISPER", "TestPlayer")
print("PASS: ended trial displays retained progress and normal progression rather than a restart prompt")

local function Mode(message, sender)
    event(nil, "CHAT_MSG_ADDON", "HXAP", message, "WHISPER", sender or "TestPlayer")
end
local function HidePractice()
    HXCAbilityPracticePanel:Hide()
    API.CloseTracker()
end
HidePractice()
event(nil, "PLAYER_LOGIN")
Mode("MODE|OLD_SCHOOL_REQUIRED")
assert(not API.IsShown())
Mode("MODE|ACTIVE", "AnotherPlayer")
assert(not API.IsShown())
Mode("MODE|ACTIVE")
assert(API.IsShown())
HidePractice()
Mode("MODE|ACTIVE")
assert(not API.IsShown())
Mode("MODE|OLD_SCHOOL_REQUIRED")
Mode("MODE|ACTIVE")
assert(API.IsShown())
API.Minimize()
event(nil, "PLAYER_LOGIN")
Mode("MODE|ACTIVE")
assert(HXCAbilityPracticeTracker:IsShown())
assert(not HXCAbilityPracticePanel:IsShown())
API.CloseTracker()
Mode("MODE|ACTIVE")
assert(not API.IsShown())
Mode("MODE|OLD_SCHOOL_ENDED")
assert(not API.IsShown())
event(nil, "PLAYER_LOGIN")
Mode("MODE|ACTIVE")
assert(API.IsShown())
HidePractice()
event(nil, "PLAYER_LOGIN")
for _, line in ipairs(EncodedPracticeSnapshot) do
    event(nil, "CHAT_MSG_ADDON", "HXAP", line, "WHISPER", "TestPlayer")
end
Mode("MODE|OLD_SCHOOL_REQUIRED")
assert(not API.IsShown())
local sentBefore = #MockMessages
MockTime = MockTime + 11
HXCAbilityPracticeListener.scripts.OnUpdate(nil, 1)
assert(#MockMessages == sentBefore + 1)
Mode("MODE|ACTIVE")
assert(API.IsShown())
print("PASS: automatic Old School opening, active-login restore, minimized preference, hidden polling and close preservation")
