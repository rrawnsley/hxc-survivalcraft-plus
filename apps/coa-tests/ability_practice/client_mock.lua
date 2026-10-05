local methods = {}
local function Widget()
    return setmetatable({ shown = true, scripts = {} }, { __index = methods })
end
function methods:CreateFontString() return Widget() end
function methods:CreateTexture() return Widget() end
function methods:SetScript(event, callback) self.scripts[event] = callback end
function methods:SetText(value) self.text = value end
function methods:GetText() return self.text end
function methods:GetWidth() return 1024 end
function methods:GetHeight() return 768 end
function methods:SetValue(value) self.value = value end
function methods:Show() self.shown = true end
function methods:Hide() self.shown = false end
function methods:IsShown() return self.shown end
local setters = { "SetSize", "SetWidth", "SetPoint", "SetScale", "SetClampedToScreen", "SetFrameStrata", "SetMovable", "EnableMouse",
    "RegisterForDrag", "SetBackdrop", "SetJustifyH", "SetStatusBarTexture", "SetStatusBarColor",
    "SetMinMaxValues", "SetAllPoints", "SetTexture", "SetHighlightTexture", "EnableMouseWheel",
    "StartMoving", "StopMovingOrSizing", "RegisterEvent", "SetAutoFocus", "SetMaxLetters", "ClearFocus" }
for _, method in ipairs(setters) do methods[method] = function() end end
function CreateFrame(_, name)
    local frame = Widget()
    if name then _G[name] = frame end
    return frame
end
function GetSpellInfo(spellId) return "Test Ability " .. spellId end
UIParent = Widget()
UISpecialFrames = {}
SlashCmdList = {}
tinsert = table.insert
MockTime = 0
MockMessages = {}
function GetTime() return MockTime end
function UnitName() return "TestPlayer" end
function SendAddonMessage(prefix, message, channel, target)
    MockMessages[#MockMessages + 1] = { prefix, message, channel, target }
end
