local methods = {}
local function Widget()
    return setmetatable({ shown = true, scripts = {} }, { __index = methods })
end
function methods:CreateFontString() return Widget() end
function methods:CreateTexture() return Widget() end
function methods:SetScript(event, callback) self.scripts[event] = callback end
function methods:SetText(value) self.text = value end
function methods:SetValue(value) self.value = value end
function methods:Show() self.shown = true end
function methods:Hide() self.shown = false end
function methods:IsShown() return self.shown end
local setters = { "SetSize", "SetWidth", "SetPoint", "SetFrameStrata", "SetMovable", "EnableMouse",
    "RegisterForDrag", "SetBackdrop", "SetJustifyH", "SetStatusBarTexture", "SetStatusBarColor",
    "SetMinMaxValues", "SetAllPoints", "SetTexture", "SetHighlightTexture", "EnableMouseWheel",
    "StartMoving", "StopMovingOrSizing" }
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
