local API = HXCAbilityPractice
local entry, attachedTo

local launcher = CreateFrame("Button", "HXCAbilityPracticeLauncher", UIParent)
launcher:SetSize(36, 36)
launcher:SetFrameStrata("MEDIUM")
launcher:SetMovable(true)
launcher:SetClampedToScreen(true)
launcher:EnableMouse(true)
launcher:RegisterForClicks("LeftButtonUp")
launcher:RegisterForDrag("LeftButton")
launcher:SetNormalTexture("Interface\\Icons\\INV_Misc_Book_09")
launcher:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
local border = launcher:CreateTexture(nil, "OVERLAY")
border:SetTexture("Interface\\Buttons\\UI-Quickslot2")
border:SetAllPoints()

local function Preferences()
    if type(HXCAbilityPracticePreferences) ~= "table" then HXCAbilityPracticePreferences = {} end
    return HXCAbilityPracticePreferences
end

local function PositionLauncher()
    local position = Preferences().launcherPosition
    launcher:ClearAllPoints()
    if type(position) == "table" and type(position.x) == "number" and type(position.y) == "number"
        and position.x >= 0 and position.x <= 1 and position.y >= 0 and position.y <= 1 then
        launcher:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT",
            position.x * UIParent:GetWidth(), position.y * UIParent:GetHeight())
    else
        launcher:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -220, -125)
    end
end

launcher:SetScript("OnClick", function() API.Toggle() end)
launcher:SetScript("OnDragStart", function(self) self:StartMoving() end)
launcher:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    local width, height = UIParent:GetWidth(), UIParent:GetHeight()
    if width > 0 and height > 0 then
        Preferences().launcherPosition = {
            x = math.max(0, math.min(1, (self:GetLeft() or 0) / width)),
            y = math.max(0, math.min(1, (self:GetBottom() or 0) / height))
        }
    end
end)
launcher:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("Abilities & Practice")
    GameTooltip:AddLine("Click to open. Drag to move.", 1, 1, 1)
    GameTooltip:Show()
end)
launcher:SetScript("OnLeave", function() GameTooltip:Hide() end)

local function AttachEntry()
    if type(InCombatLockdown) == "function" and InCombatLockdown() then return end
    local parent = AscensionSpellbookFrame or SpellBookFrame
    if not parent or parent == attachedTo then return end
    if not entry then
        entry = CreateFrame("Button", "HXCAbilityPracticeSpellbookButton", parent, "UIPanelButtonTemplate")
        entry:SetSize(110, 22)
        entry:SetText("Practice")
        entry:SetScript("OnClick", function() API.Toggle() end)
    else entry:SetParent(parent) end
    entry:ClearAllPoints()
    entry:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -44, -34)
    attachedTo = parent
end

local listener = CreateFrame("Frame", "HXCAbilityPracticeEntryListener", UIParent)
listener:RegisterEvent("PLAYER_LOGIN")
listener:RegisterEvent("ADDON_LOADED")
listener:RegisterEvent("PLAYER_REGEN_ENABLED")
listener:SetScript("OnEvent", function(_, event)
    AttachEntry()
    if event == "PLAYER_LOGIN" then PositionLauncher() end
end)
AttachEntry()
PositionLauncher()
