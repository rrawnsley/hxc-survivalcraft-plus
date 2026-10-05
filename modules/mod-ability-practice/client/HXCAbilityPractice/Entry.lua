local API = HXCAbilityPractice
local entry, attachedTo

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
listener:SetScript("OnEvent", AttachEntry)
AttachEntry()
