HXCAbilityPractice = {}
local API = HXCAbilityPractice
local Model = HXCAbilityPracticeModel
local snapshot, selectedId
local syncState = "waiting"
local tab = "skills"
local offset = 0
local visible = {}
local rows = {}
local search = ""
local Refresh
local searchBox

local panel = CreateFrame("Frame", "HXCAbilityPracticePanel", UIParent)
panel:SetSize(760, 490)
panel:SetPoint("CENTER")
panel:SetFrameStrata("DIALOG")
panel:SetMovable(true)
panel:EnableMouse(true)
panel:RegisterForDrag("LeftButton")
panel:SetScript("OnDragStart", panel.StartMoving)
panel:SetScript("OnDragStop", panel.StopMovingOrSizing)
panel:SetBackdrop({ bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 } })
panel:Hide()
tinsert(UISpecialFrames, "HXCAbilityPracticePanel")

local function Text(parent, font, x, y, width)
    local label = parent:CreateFontString(nil, "OVERLAY", font)
    label:SetPoint("TOPLEFT", x, y)
    label:SetWidth(width)
    label:SetJustifyH("LEFT")
    return label
end

local title = Text(panel, "GameFontNormalLarge", 28, -24, 610)
title:SetText("Abilities & Practice")
local subtitle = Text(panel, "GameFontHighlightSmall", 28, -52, 660)
local footer = Text(panel, "GameFontHighlightSmall", 28, -462, 704)
local sessionText = Text(panel, "GameFontHighlightSmall", 28, -438, 704)
local close = CreateFrame("Button", nil, panel, "UIPanelCloseButton")
close:SetPoint("TOPRIGHT", -6, -6)
local detail = CreateFrame("Frame", nil, panel)
detail:SetPoint("TOPLEFT", 285, -110)
detail:SetSize(442, 320)
local name = Text(detail, "GameFontNormalLarge", 0, 0, 440)
local rankLabel = Text(detail, "GameFontHighlight", 0, -32, 440)
local proficiency = Text(detail, "GameFontNormal", 0, -68, 440)
local progress = CreateFrame("StatusBar", nil, detail)
progress:SetPoint("TOPLEFT", 0, -96)
progress:SetSize(430, 18)
progress:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
progress:SetStatusBarColor(0.81, 0.62, 0.24)
progress:SetMinMaxValues(0, 1)
local progressBackground = progress:CreateTexture(nil, "BACKGROUND")
progressBackground:SetAllPoints()
progressBackground:SetTexture(0.12, 0.12, 0.12, 1)
local progressLabel = progress:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
progressLabel:SetPoint("CENTER")
local pointText = Text(detail, "GameFontHighlight", 0, -130, 430)
local nextTitle = Text(detail, "GameFontNormal", 0, -195, 440)
local nextText = Text(detail, "GameFontHighlight", 0, -221, 430)

local function SpellName(spellId)
    return GetSpellInfo(spellId) or ("Ability " .. spellId)
end

local function TrackedAbilities()
    if type(HXCAbilityPracticePreferences) ~= "table" then HXCAbilityPracticePreferences = {} end
    local key = snapshot and tostring(snapshot.classId)
    if not key then return {} end
    if type(HXCAbilityPracticePreferences[key]) ~= "table" then HXCAbilityPracticePreferences[key] = {} end
    return HXCAbilityPracticePreferences[key]
end

local track = CreateFrame("Button", nil, detail, "UIPanelButtonTemplate")
track:SetSize(140, 24)
track:SetPoint("TOPLEFT", 0, -160)
track:SetScript("OnClick", function()
    if not selectedId or not snapshot then return end
    local tracked = TrackedAbilities()
    local key = tostring(selectedId)
    tracked[key] = tracked[key] ~= true and true or nil
    Refresh()
end)

local function RenderDetail(ability)
    if not ability then detail:Hide(); return end
    detail:Show()
    track:SetText(TrackedAbilities()[tostring(ability.abilityId)] == true and "Stop tracking" or "Track ability")
    name:SetText(SpellName(ability.displaySpellId))
    rankLabel:SetText(ability.learnedRank > 0 and ("Learned rank " .. ability.learnedRank) or "Not yet learned")
    local trains = ability.availability == 4 or ability.availability == 5
    proficiency:SetText(trains and ("Proficiency " .. ability.proficiency .. " / " .. ability.cap) or "")
    if trains then progress:Show() else progress:Hide() end
    if trains then
        local capped = ability.availability == 5
        progress:SetValue(capped and 1 or ability.points / ability.pointsPerLevel)
        progressLabel:SetText(capped and "Current cap reached" or
            (math.floor(100 * ability.points / ability.pointsPerLevel) .. "% to the next proficiency point"))
    end
    pointText:SetText(Model.PointText(ability))
    local nextRank = ability.nextRank
    nextTitle:SetText(nextRank and ((ability.learnedRank == 0 and "Upcoming ability: " or "Next rank: ")
        .. SpellName(nextRank.spellId) .. " (Rank " .. nextRank.rankNumber .. ")") or "Rank progression")
    nextText:SetText(ability.availability == 6 and "This ability works at full effectiveness without practice."
        or Model.RankText(nextRank))
end

Refresh = function()
    visible = {}
    local session = snapshot and snapshot.session
    sessionText:SetText(session and session.available and ("This session: " .. session.uses
        .. " uses that earned practice - +" .. session.proficiencyGained
        .. " proficiency") or "Session totals unavailable")
    if not snapshot then
        subtitle:SetText(syncState == "unavailable" and "Server progress is unavailable. Open this menu to retry."
            or "Waiting for your server progress...")
        footer:SetText("Practice counts meaningful uses. Your server determines eligibility and progression.")
        detail:Hide()
    else
        local status = syncState == "current" and "Server progress received"
            or (syncState == "waiting" and "Refreshing saved view..." or "Saved view - Server progress unavailable")
        subtitle:SetText("Character level " .. snapshot.characterLevel .. " - " .. status)
        local tracked = TrackedAbilities()
        for _, ability in ipairs(snapshot.abilities) do
            local matchesTab = (tab == "skills" and ability.learnedRank > 0)
                or (tab == "upcoming" and ability.nextRank)
                or (tab == "tracked" and tracked[tostring(ability.abilityId)] == true)
            local matchesSearch = search == "" or string.find(string.lower(SpellName(ability.displaySpellId)),
                search, 1, true)
            if matchesTab and matchesSearch then visible[#visible + 1] = ability end
        end
        table.sort(visible, function(a, b)
            if tab == "upcoming" and a.nextRank.characterLevel ~= b.nextRank.characterLevel then
                return a.nextRank.characterLevel < b.nextRank.characterLevel
            end
            local left, right = SpellName(a.displaySpellId), SpellName(b.displaySpellId)
            if left == right then return a.abilityId < b.abilityId end
            return left < right
        end)
        offset = math.max(0, math.min(offset, math.max(0, #visible - #rows)))
        local chosen
        for _, ability in ipairs(visible) do if ability.abilityId == selectedId then chosen = ability end end
        chosen = chosen or visible[1]
        selectedId = chosen and chosen.abilityId or nil
        RenderDetail(chosen)
        footer:SetText(#visible == 0 and "No abilities in this view." or
            (#visible .. " abilities · Use the mouse wheel to browse · Forecasts count qualifying uses"))
    end
    for index, row in ipairs(rows) do
        local ability = visible[index + offset]
        row.ability = ability
        if ability then row:Show() else row:Hide() end
        if ability then
            row.label:SetText((ability.abilityId == selectedId and "|cffffd36b" or "|cffffffff")
                .. SpellName(ability.displaySpellId) .. "|r")
            row.info:SetText(ability.learnedRank == 0 and "Not yet learned" or
                ("Rank " .. ability.learnedRank .. (ability.availability == 6 and " · Fixed" or
                    " · Proficiency " .. ability.proficiency)))
        end
    end
end

for index = 1, 7 do
    local row = CreateFrame("Button", nil, panel)
    row:SetSize(230, 42)
    row:SetPoint("TOPLEFT", 28, -110 - (index - 1) * 46)
    row:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
    row.label = Text(row, "GameFontNormal", 2, -3, 226)
    row.info = Text(row, "GameFontHighlightSmall", 2, -24, 226)
    row:SetScript("OnClick", function(self)
        selectedId = self.ability.abilityId
        Refresh()
    end)
    rows[index] = row
end
panel:EnableMouseWheel(true)
panel:SetScript("OnMouseWheel", function(_, delta) offset = offset - delta; Refresh() end)

local function Tab(label, value, x)
    local button = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    button:SetSize(90, 24)
    button:SetPoint("TOPLEFT", x, -76)
    button:SetText(label)
    button:SetScript("OnClick", function() tab = value; offset = 0; Refresh() end)
end
Tab("My Skills", "skills", 28)
Tab("Upcoming", "upcoming", 128)
Tab("Tracked", "tracked", 228)
local searchLabel = Text(panel, "GameFontHighlightSmall", 336, -82, 54)
searchLabel:SetText("Search")
searchBox = CreateFrame("EditBox", "HXCAbilityPracticeSearch", panel, "InputBoxTemplate")
searchBox:SetSize(330, 24)
searchBox:SetPoint("TOPLEFT", 395, -76)
searchBox:SetAutoFocus(false)
searchBox:SetMaxLetters(80)
searchBox:SetScript("OnTextChanged", function(self)
    search = string.lower(string.match(self:GetText() or "", "^%s*(.-)%s*$"))
    offset = 0
    Refresh()
end)
searchBox:SetScript("OnEscapePressed", searchBox.ClearFocus)
searchBox:SetScript("OnEnterPressed", searchBox.ClearFocus)
searchBox:SetText("")
panel:SetScript("OnHide", function() searchBox:ClearFocus() end)

function API.ApplySnapshot(value)
    local validated, reason = Model.Validate(value)
    if not validated then return false, reason end
    if snapshot and (validated.classId ~= snapshot.classId or validated.revision <= snapshot.revision) then
        return false, "Stale or mismatched progress update"
    end
    snapshot = validated
    syncState = "current"
    Refresh()
    return true
end

function API.IsShown()
    return panel:IsShown()
end

function API.SetSyncState(value)
    if value ~= "current" and value ~= "waiting" and value ~= "unavailable" then return false end
    if syncState ~= value then syncState = value; Refresh() end
    return true
end

function API.Toggle()
    if panel:IsShown() then panel:Hide() else
        Refresh()
        panel:Show()
        if API.Request then API.Request() end
    end
end

function API.Reset()
    snapshot = nil
    syncState = "waiting"
    selectedId = nil
    offset = 0
    tab = "skills"
    search = ""
    searchBox:SetText("")
    Refresh()
end

SLASH_HXCABILITYPRACTICE1 = "/practice"
SlashCmdList.HXCABILITYPRACTICE = API.Toggle
Refresh()
