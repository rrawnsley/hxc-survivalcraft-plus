local API = HXCAbilityPractice
local event = HXCAbilityPracticeListener.scripts.OnEvent
MockTime = 0
assert(API.Request())
assert(#MockMessages == 1)
assert(MockMessages[1][1] == "HXAP" and MockMessages[1][2] == "HELLO|4")
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
