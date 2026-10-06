HXCAbilityPractice = {}
local API = HXCAbilityPractice
local Model = HXCAbilityPracticeModel
local snapshot, selectedId, receivedAt, serverFailure
local serverRevision = 0
local serverGeneration
local syncState = "waiting"
local tab = "skills"
local tabLabels = { skills = "My Skills", upcoming = "Upcoming", tracked = "Tracked", session = "Session" }
local offset = 0
local visible = {}
local rows = {}
local search = ""
local Refresh
local searchBox
local showRoadmap = false
local rankOffset = 0
local roadmapRows = {}
local roadmapButton
local sortButton
local filterButton
local filterCounts
local filterModes = { "all", "training", "capped", "paused", "unlearned" }
local filterLabels = { all = "All", training = "Training", capped = "At cap",
    paused = "Paused", unlearned = "Not learned" }
local sortModes = { "default", "name", "uses" }
local sortLabels = { default = "Default", name = "Name", uses = "Uses" }

local panel = CreateFrame("Frame", "HXCAbilityPracticePanel", UIParent)
panel:SetSize(760, 610)
panel:SetPoint("CENTER")
panel:SetFrameStrata("DIALOG")
panel:SetMovable(true)
panel:SetClampedToScreen(true)
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
local footer = Text(panel, "GameFontHighlightSmall", 28, -582, 704)
local sessionText = Text(panel, "GameFontHighlightSmall", 28, -558, 704)
local close = CreateFrame("Button", nil, panel, "UIPanelCloseButton")
close:SetPoint("TOPRIGHT", -6, -6)
local detail = CreateFrame("Frame", nil, panel)
detail:SetPoint("TOPLEFT", 285, -110)
detail:SetSize(442, 430)
local name = Text(detail, "GameFontNormalLarge", 0, 0, 440)
local rankLabel = Text(detail, "GameFontHighlight", 0, -32, 400)
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
local abilitySessionText = Text(detail, "GameFontHighlightSmall", 154, -160, 276)
local nextTitle = Text(detail, "GameFontNormal", 0, -195, 280)
local nextText = Text(detail, "GameFontHighlight", 0, -221, 430)

local function FitPanel()
    local width = math.max(1, UIParent:GetWidth() - 32)
    local height = math.max(1, UIParent:GetHeight() - 32)
    panel:SetScale(math.min(1, width / 760, height / 610))
end
panel:SetScript("OnShow", FitPanel)
panel:RegisterEvent("DISPLAY_SIZE_CHANGED")
panel:SetScript("OnEvent", function() if panel:IsShown() then FitPanel() end end)

local function UpdateSubtitle(now)
    if not snapshot and serverFailure then
        subtitle:SetText(syncState == "waiting" and "Checking saved progress again..."
            or (serverFailure.issueCode == 2 and "Saved progress is preserved; a skill needs a matching progression version."
                or "The server responded, but a skill's saved progress needs attention."))
        return
    end
    if not snapshot then
        subtitle:SetText(syncState == "unavailable" and "Server progress is unavailable. Open this menu to retry."
            or "Waiting for your server progress...")
        return
    end
    local status = syncState == "current" and "Server progress received"
        or (syncState == "waiting" and "Refreshing saved view..." or "Saved view - Server progress unavailable")
    if serverFailure and syncState ~= "waiting" then
        status = serverFailure.issueCode == 2 and "Saved view - Progress version mismatch"
            or "Saved view - Skill progress needs attention"
    end
    if #snapshot.abilities == 0 and syncState == "current" then status = "No practice catalog for this class" end
    local age = type(now) == "number" and type(receivedAt) == "number" and now >= receivedAt
        and now < math.huge and math.floor(now - receivedAt) or nil
    local ageText = age and ((age < 60 and (age .. "s") or
        (age < 3600 and (math.floor(age / 60) .. "m") or (math.floor(age / 3600) .. "h"))) .. " old")
        or "Update age unavailable"
    subtitle:SetText("Level " .. snapshot.characterLevel
        .. (snapshot.realmMaximumLevel and (" / Realm cap " .. snapshot.realmMaximumLevel) or "")
        .. " - " .. status .. " - " .. ageText)
end

local function GreaterDecimal(left, right)
    if #left ~= #right then return #left > #right end
    return left > right
end

local function SpellName(spellId)
    return GetSpellInfo(spellId) or ("Ability " .. spellId)
end

local function SessionMasteryText(ability)
    local highest
    for _, event in ipairs(Model.SessionMasteries(snapshot, ability.abilityId)) do
        highest = math.max(highest or 0, Model.MasteryBonusAmount(event))
    end
    if not highest then return nil end
    return (syncState == "current" and "Mastery earned: +" or "Saved mastery: +")
        .. string.format("%.2f", highest / 100):gsub("0+$", ""):gsub("%.$", "") .. "%"
end

local function SessionLearnText(ability)
    local highest = 0
    for _, event in ipairs(Model.SessionLearns(snapshot, ability.abilityId)) do
        highest = math.max(highest, event.rankNumber)
    end
    if highest == 0 then return nil end
    return (Model.IsFixed(ability) or Model.IsMastery(ability) or highest == 1)
        and "Learned ability this session" or ("Learned rank " .. highest .. " this session")
end

local function TrackedAbilities()
    if type(HXCAbilityPracticePreferences) ~= "table" then HXCAbilityPracticePreferences = {} end
    local key = snapshot and tostring(snapshot.classId)
    if not key then return {} end
    if type(HXCAbilityPracticePreferences[key]) ~= "table" then HXCAbilityPracticePreferences[key] = {} end
    return HXCAbilityPracticePreferences[key]
end

local function SortPreference()
    TrackedAbilities()
    local key = snapshot and tostring(snapshot.classId)
    if type(HXCAbilityPracticePreferences.sorts) ~= "table" then HXCAbilityPracticePreferences.sorts = {} end
    local value = key and HXCAbilityPracticePreferences.sorts[key]
    return sortLabels[value] and value or "default", key
end

local function FilterPreference()
    TrackedAbilities()
    local key = snapshot and tostring(snapshot.classId)
    if type(HXCAbilityPracticePreferences.filters) ~= "table" then HXCAbilityPracticePreferences.filters = {} end
    local value = key and HXCAbilityPracticePreferences.filters[key]
    return filterLabels[value] and value or "all", key
end

local function MatchesFilter(ability, mode)
    if mode == "training" then return ability.availability == 4 end
    if mode == "capped" then return ability.availability == 5 end
    if mode == "paused" then return ability.availability == 2 or ability.availability == 3 end
    if mode == "unlearned" then return ability.learnedRank == 0 end
    return true
end

local function TrainableMilestoneUses(ability)
    local milestone = Model.NextMilestone(ability)
    if ability.availability ~= 4 or ability.learnedRank == 0 or not milestone
        or milestone.state ~= 4 or milestone.characterLevel > snapshot.characterLevel
        or milestone.practice.status ~= 1 then return nil end
    return milestone.practice.uses
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

local practiceHelp = CreateFrame("Button", nil, detail, "UIPanelButtonTemplate")
practiceHelp:SetSize(22, 22)
practiceHelp:SetPoint("TOPLEFT", 408, -30)
practiceHelp:SetText("?")
practiceHelp:SetScript("OnEnter", function(self)
    if not snapshot or not selectedId or not GameTooltip then return end
    for _, ability in ipairs(snapshot.abilities) do
        if ability.abilityId == selectedId then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("What earns practice?")
            local acquisition = Model.AcquisitionText(ability)
            if acquisition then GameTooltip:AddLine("Acquisition: " .. acquisition, 1, 0.82, 0, true) end
            GameTooltip:AddLine(Model.PracticeRules(ability), 1, 1, 1, true)
            if ability.learnedRank > 0 and ability.hasCapInfo and not Model.IsFixed(ability) then
                local cap = ability.nextTrainingCap
                GameTooltip:AddLine(cap and Model.TrainingCapText(cap, snapshot.realmMaximumLevel,
                    snapshot.characterLevel) or
                    (ability.proficiency >= ability.cap and
                        "No additional practice beyond this proficiency in the current definition." or
                        "This is the highest defined training cap."), 1, 0.82, 0, true)
            end
            if syncState ~= "current" then
                GameTooltip:AddLine("These rules are from your saved view.", 1, 0.82, 0, true)
            end
            GameTooltip:Show()
            return
        end
    end
end)
local function HidePracticeTooltip(self)
    if GameTooltip and GameTooltip:IsOwned(self) then GameTooltip:Hide() end
end
practiceHelp:SetScript("OnLeave", HidePracticeTooltip)
practiceHelp:SetScript("OnHide", HidePracticeTooltip)

local function RenderDetail(ability)
    if not ability then detail:Hide(); return end
    detail:Show()
    track:SetText(TrackedAbilities()[tostring(ability.abilityId)] == true and "Stop tracking" or "Track ability")
    name:SetText(SpellName(ability.displaySpellId))
    local fixed = Model.IsFixed(ability)
    local mastery = Model.IsMastery(ability)
    local session = ability.session
    abilitySessionText:SetText(fixed and "" or (session and session.available and
        ((syncState == "current" and "This session: " or "Saved session: ") .. session.uses
            .. " practice uses\n+" .. session.proficiencyGained .. " proficiency")
        or "Ability session totals unavailable"))
    local requiredLevel
    for _, rank in ipairs(ability.ranks or {}) do
        if rank.spellId == ability.displaySpellId then requiredLevel = rank.characterLevel; break end
    end
    if not requiredLevel and ability.learnedRank == 0 and ability.nextRank then
        requiredLevel = ability.nextRank.characterLevel
    end
    local rankText = ability.learnedRank > 0 and ((fixed or mastery) and "Learned ability" or
        ("Learned rank " .. ability.learnedRank)) or "Not yet learned"
    rankLabel:SetText(rankText .. (requiredLevel and (" - Required level " .. requiredLevel) or "")
        .. (mastery and ("\n" .. Model.CurrentMasteryText(ability, syncState ~= "current")) or ""))
    local trains = ability.learnedRank > 0 and ability.pointsPerLevel > 0 and not Model.IsFixed(ability)
    local skillText = ability.proficiency > ability.cap and ("Saved proficiency " .. ability.proficiency
        .. " - current cap " .. ability.cap) or ("Proficiency " .. ability.proficiency .. " / " .. ability.cap)
    proficiency:SetText(trains and skillText or "")
    if trains then progress:Show() else progress:Hide() end
    if trains then
        local capped = ability.proficiency >= ability.cap
        progress:SetValue(capped and 1 or ability.points / ability.pointsPerLevel)
        local label = capped and
            (not Model.NextMilestone(ability) and "Training complete" or "Current cap reached") or
            (math.floor(100 * ability.points / ability.pointsPerLevel) .. "% to the next proficiency point")
        if ability.catchup and ability.catchup.boosted and ability.availability == 4 then
            label = label .. " · " .. ability.catchup.multiplier .. "x "
                .. (syncState == "current" and "catch-up" or "saved boost")
        end
        progressLabel:SetText(label)
        if ability.availability == 2 or ability.availability == 3 then
            progress:SetStatusBarColor(0.45, 0.45, 0.45)
        elseif capped and not Model.NextMilestone(ability) then
            progress:SetStatusBarColor(0.35, 0.72, 0.43)
        else progress:SetStatusBarColor(0.81, 0.62, 0.24) end
    end
    pointText:SetText(ability.replacementSpellId and Model.ReplacementText(ability, syncState ~= "current")
        or Model.PointText(ability, snapshot.realmMaximumLevel, snapshot.characterLevel))
    local nextRank = ability.nextRank
    local nextReward = Model.NextMastery(ability)
    nextTitle:SetText(nextRank and ((ability.learnedRank == 0 and "Upcoming ability: " or "Next rank: ")
        .. SpellName(nextRank.spellId) .. ((fixed or mastery) and "" or (" (Rank " .. nextRank.rankNumber .. ")")))
        or (fixed and "Ability details" or mastery and "Mastery benefits" or "Rank progression"))
    nextText:SetText(mastery and not nextRank and Model.MasteryText(nextReward, snapshot.realmMaximumLevel,
        snapshot.characterLevel, ability.acquisitionSource)
        or Model.RankText(nextRank, fixed, snapshot.realmMaximumLevel,
            snapshot.characterLevel, ability.acquisitionSource))
    local ranks = mastery and ability.rewards or ability.ranks
    roadmapButton:SetText(mastery and (showRoadmap and "Next benefit" or "All mastery")
        or (showRoadmap and "Next rank" or "All ranks"))
    if ranks and not fixed then roadmapButton:Show() else roadmapButton:Hide() end
    local displayRoadmap = not fixed and showRoadmap and ranks
    if displayRoadmap then
        nextText:Hide()
        rankOffset = math.max(0, math.min(rankOffset, math.max(0, #ranks - #roadmapRows)))
        nextTitle:SetText((mastery and "Mastery roadmap - " or "Rank roadmap - ") .. (rankOffset + 1) .. " to "
            .. math.min(rankOffset + #roadmapRows, #ranks) .. " of " .. #ranks)
    else nextText:Show() end
    for index, row in ipairs(roadmapRows) do
        local rank = displayRoadmap and ranks[index + rankOffset]
        if rank then
            row:Show()
            row.title:SetText(mastery and ("Mastery " .. (index + rankOffset))
                or ("Rank " .. rank.rankNumber .. " - " .. SpellName(rank.spellId)))
            row.info:SetText(mastery and Model.MasteryText(rank, snapshot.realmMaximumLevel,
                snapshot.characterLevel, ability.acquisitionSource)
                or Model.RankText(rank, fixed, snapshot.realmMaximumLevel,
                    snapshot.characterLevel, ability.acquisitionSource))
        else row:Hide() end
    end
end

roadmapButton = CreateFrame("Button", nil, detail, "UIPanelButtonTemplate")
roadmapButton:SetSize(135, 24)
roadmapButton:SetPoint("TOPLEFT", 295, -190)
roadmapButton:SetScript("OnClick", function() showRoadmap = not showRoadmap; rankOffset = 0; Refresh() end)
for index = 1, 3 do
    local row = CreateFrame("Frame", nil, detail)
    row:SetSize(430, 72)
    row:SetPoint("TOPLEFT", 0, -222 - (index - 1) * 72)
    row.title = Text(row, "GameFontNormal", 0, 0, 430)
    row.info = Text(row, "GameFontHighlightSmall", 0, -20, 430)
    row:EnableMouseWheel(true)
    row:SetScript("OnMouseWheel", function(_, delta) rankOffset = rankOffset - delta; Refresh() end)
    row:Hide()
    roadmapRows[index] = row
end

Refresh = function()
    title:SetText("Abilities & Practice - " .. tabLabels[tab])
    visible = {}
    local sortMode = SortPreference()
    if sortButton then sortButton:SetText("Sort: " .. sortLabels[sortMode]) end
    local filterMode = FilterPreference()
    filterCounts = snapshot and { all = 0, training = 0, capped = 0, paused = 0, unlearned = 0 } or nil
    if filterButton then filterButton:SetText("Filter: " .. filterLabels[filterMode]) end
    local session = snapshot and snapshot.session
    sessionText:SetText(session and session.available and
        ((syncState == "current" and "Class skills this session: " or "Saved class session: ") .. session.uses
        .. " uses that earned practice - +" .. session.proficiencyGained
        .. " proficiency") or "Session totals unavailable")
    UpdateSubtitle(GetTime())
    if not snapshot then
        footer:SetText("Practice counts meaningful uses. Your server determines eligibility and progression.")
        detail:Hide()
    else
        local tracked = TrackedAbilities()
        for _, ability in ipairs(snapshot.abilities) do
            local matchesTab = (tab == "skills" and ability.learnedRank > 0)
                or (tab == "upcoming" and Model.NextMilestone(ability))
                or (tab == "tracked" and tracked[tostring(ability.abilityId)] == true)
                or (tab == "session" and (SessionMasteryText(ability) or SessionLearnText(ability) or
                    (ability.session and ability.session.available and not Model.IsFixed(ability)
                        and (ability.session.uses ~= "0" or ability.session.proficiencyGained ~= "0"))))
            local matchesSearch = search == "" or string.find(string.lower(SpellName(ability.displaySpellId)),
                search, 1, true)
            if matchesTab and matchesSearch then
                for _, mode in ipairs(filterModes) do
                    if MatchesFilter(ability, mode) then filterCounts[mode] = filterCounts[mode] + 1 end
                end
                if MatchesFilter(ability, filterMode) then visible[#visible + 1] = ability end
            end
        end
        table.sort(visible, function(a, b)
            if sortMode == "uses" then
                local leftUses, rightUses = TrainableMilestoneUses(a), TrainableMilestoneUses(b)
                if (leftUses ~= nil) ~= (rightUses ~= nil) then return leftUses ~= nil end
                if leftUses and leftUses ~= rightUses then return GreaterDecimal(rightUses, leftUses) end
            end
            if sortMode == "default" and tab == "session" then
                if a.session.proficiencyGained ~= b.session.proficiencyGained then
                    return GreaterDecimal(a.session.proficiencyGained, b.session.proficiencyGained)
                end
                if a.session.uses ~= b.session.uses then return GreaterDecimal(a.session.uses, b.session.uses) end
            end
            if sortMode == "default" and tab == "upcoming"
                and Model.NextMilestone(a).characterLevel ~= Model.NextMilestone(b).characterLevel then
                return Model.NextMilestone(a).characterLevel < Model.NextMilestone(b).characterLevel
            end
            local left, right = SpellName(a.displaySpellId), SpellName(b.displaySpellId)
            if left == right then return a.abilityId < b.abilityId end
            return left < right
        end)
        offset = math.max(0, math.min(offset, math.max(0, #visible - #rows)))
        local chosen
        for _, ability in ipairs(visible) do if ability.abilityId == selectedId then chosen = ability end end
        chosen = chosen or visible[1]
        if not chosen or chosen.abilityId ~= selectedId then rankOffset = 0 end
        selectedId = chosen and chosen.abilityId or nil
        RenderDetail(chosen)
        local emptyText = syncState == "current" and "The server has no practice abilities configured for this class."
            or "This saved view contains no configured practice abilities."
        if filterButton then
            filterButton:SetText("Filter: " .. filterLabels[filterMode] .. " (" .. filterCounts[filterMode] .. ")")
        end
        local emptyView = "No abilities in this view."
        if search ~= "" then emptyView = "No abilities match your search and filter in this view."
        elseif filterMode ~= "all" then emptyView = "No abilities match this filter. Select Filter: All to see more."
        elseif tab == "session" then
            emptyView = (snapshot.schemaVersion ~= 4 or not session or not session.available)
                and "Per-ability session progress is unavailable in this snapshot."
                or (snapshot.learning and snapshot.learning.available
                    and (syncState == "current" and "No practice, learning or mastery recorded this session."
                        or "No practice, learning or mastery recorded in this saved view.")
                    or (syncState == "current" and "No qualifying practice has been recorded this session."
                        or "No qualifying practice was recorded in this saved view."))
        end
        footer:SetText(#snapshot.abilities == 0 and emptyText or
            (#visible == 0 and emptyView or
            (#visible .. " abilities · " .. (showRoadmap and chosen and chosen.ranks
                and "Use the mouse wheel over milestones to browse" or "Use the mouse wheel to browse")
                .. " · Forecasts count qualifying uses")))
        if tab == "session" and #visible > 0 and snapshot.learning and snapshot.learning.available then
            footer:SetText(#visible .. " abilities · Learned ability/rank events: " .. snapshot.learning.total
                .. " · Mastery: " .. (snapshot.mastery and snapshot.mastery.available
                    and snapshot.mastery.total or "unknown"))
        end
    end
    if serverFailure then
        footer:SetText(serverFailure.issueCode == 2
            and ("Progress preserved - " .. SpellName(serverFailure.spellId)
                .. " needs a matching progression version. Contact an admin.")
            or ("Saved progress for " .. SpellName(serverFailure.spellId)
                .. " could not be read safely. It was left unchanged; please report this."))
    end
    for index, row in ipairs(rows) do
        local ability = visible[index + offset]
        row.ability = ability
        if ability then row:Show() else row:Hide() end
        if ability then
            local _, _, icon = GetSpellInfo(ability.displaySpellId)
            row.icon:SetTexture(icon or "Interface\\Icons\\INV_Misc_QuestionMark")
            row.label:SetText((ability.abilityId == selectedId and "|cffffd36b" or "|cffffffff")
                .. SpellName(ability.displaySpellId) .. "|r")
            local rank = Model.NextMilestone(ability)
            local hasTraining = ability.learnedRank > 0 and not Model.IsFixed(ability) and ability.pointsPerLevel > 0
            if hasTraining then
                row.progress:Show()
                row.progress:SetValue(ability.proficiency >= ability.cap and 1
                    or ability.points / ability.pointsPerLevel)
                if ability.availability == 2 or ability.availability == 3 then
                    row.progress:SetStatusBarColor(0.45, 0.45, 0.45)
                elseif ability.availability == 5 then
                    if rank then row.progress:SetStatusBarColor(0.81, 0.62, 0.24)
                    else row.progress:SetStatusBarColor(0.35, 0.72, 0.43) end
                else row.progress:SetStatusBarColor(0.81, 0.62, 0.24) end
            else row.progress:Hide() end
            row.info:SetText(tab == "session" and
                ((ability.session and ability.session.available and not Model.IsFixed(ability)
                    and (ability.session.uses ~= "0" or ability.session.proficiencyGained ~= "0"))
                    and (ability.session.uses .. " uses · +" .. ability.session.proficiencyGained .. " proficiency")
                    or SessionMasteryText(ability) or SessionLearnText(ability)) or
                tab == "upcoming" and rank and
                ((ability.learnedRank == 0 and "New ability" or Model.IsMastery(ability) and "Next mastery benefit"
                    or ("Next rank " .. rank.rankNumber))
                    .. " · " .. (Model.BeyondRealmLevel(rank.characterLevel, snapshot.realmMaximumLevel,
                        snapshot.characterLevel) and ("Above realm cap " .. snapshot.realmMaximumLevel)
                        or ("Req. level " .. rank.characterLevel))) or
                (ability.learnedRank == 0 and "Not yet learned" or
                    (Model.IsFixed(ability) and "Fixed ability" or Model.IsMastery(ability) and
                        ("Mastery · Proficiency " .. ability.proficiency .. "/" .. ability.cap) or
                        ("Rank " .. ability.learnedRank .. " · Proficiency "
                            .. ability.proficiency .. "/" .. ability.cap))))
        end
    end
    if GameTooltip and GameTooltip:IsShown() then
        local owner = GameTooltip:GetOwner()
        if (owner == practiceHelp or owner == filterButton) and owner:IsShown() then
            owner:GetScript("OnEnter")(owner)
        else
            for _, row in ipairs(rows) do
                if owner == row and row:IsShown() then row:GetScript("OnEnter")(row); break end
            end
        end
    end
end

for index = 1, 9 do
    local row = CreateFrame("Button", nil, panel)
    row:SetSize(230, 42)
    row:SetPoint("TOPLEFT", 28, -110 - (index - 1) * 46)
    row:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
    row.icon = row:CreateTexture(nil, "ARTWORK")
    row.icon:SetSize(32, 32)
    row.icon:SetPoint("TOPLEFT", 2, -4)
    row.label = Text(row, "GameFontNormal", 40, -3, 186)
    row.info = Text(row, "GameFontHighlightSmall", 40, -22, 186)
    row.progress = CreateFrame("StatusBar", nil, row)
    row.progress:SetPoint("TOPLEFT", 40, -37)
    row.progress:SetSize(186, 3)
    row.progress:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    row.progress:SetMinMaxValues(0, 1)
    local background = row.progress:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints()
    background:SetTexture(0.12, 0.12, 0.12, 1)
    row.progress:Hide()
    row:SetScript("OnEnter", function(self)
        if not snapshot or not self.ability or not GameTooltip then return end
        local ability = self.ability
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(SpellName(ability.displaySpellId))
        local acquisition = Model.AcquisitionText(ability)
        if acquisition then GameTooltip:AddLine("Acquisition: " .. acquisition, 1, 0.82, 0, true) end
        if not Model.IsFixed(ability) then
            GameTooltip:AddLine("Proficiency " .. ability.proficiency .. " / Current cap " .. ability.cap,
                1, 0.82, 0, true)
            if ability.availability == 2 or ability.availability == 3 then
                GameTooltip:AddLine("The bar shows retained progress; training is paused.", 1, 1, 1, true)
            end
        end
        GameTooltip:AddLine(Model.PointText(ability, snapshot.realmMaximumLevel, snapshot.characterLevel),
            1, 1, 1, true)
        local catchup = Model.CatchupText(ability, syncState ~= "current")
        if catchup then GameTooltip:AddLine(catchup, 1, 0.82, 0, true) end
        if ability.session and ability.session.available and not Model.IsFixed(ability) then
            GameTooltip:AddLine((syncState == "current" and "This session: " or "Saved session: ")
                .. ability.session.uses .. " qualifying uses · +"
                .. ability.session.proficiencyGained .. " proficiency",
                1, 0.82, 0, true)
        end
        for _, event in ipairs(Model.SessionMasteries(snapshot, ability.abilityId)) do
            GameTooltip:AddLine((syncState == "current" and "Earned this session: +" or "Saved session reward: +")
                .. string.format("%.2f", Model.MasteryBonusAmount(event) / 100):gsub("0+$", ""):gsub("%.$", "")
                .. "% " .. Model.MasteryEffectText(event) .. " mastery · Proficiency " .. event.proficiency,
                0.55, 0.9, 0.6, true)
        end
        local learns = Model.SessionLearns(snapshot, ability.abilityId)
        for index = math.max(1, #learns - 2), #learns do
            local event = learns[index]
            GameTooltip:AddLine((syncState == "current" and "Learned this session: " or "Saved session learn: ")
                .. SpellName(event.spellId) .. ((Model.IsFixed(ability) or Model.IsMastery(ability)) and ""
                    or (" (Rank " .. event.rankNumber .. ")")), 0.55, 0.9, 0.6, true)
        end
        if #learns > 3 then
            GameTooltip:AddLine((#learns - 3) .. " earlier retained learns for this ability.", 1, 1, 1, true)
        end
        local milestone = Model.NextMilestone(ability)
        if milestone then
            local text = Model.IsMastery(ability) and not ability.nextRank
                and Model.MasteryText(milestone, snapshot.realmMaximumLevel,
                    snapshot.characterLevel, ability.acquisitionSource)
                or Model.RankText(milestone, Model.IsFixed(ability), snapshot.realmMaximumLevel,
                    snapshot.characterLevel, ability.acquisitionSource)
            GameTooltip:AddLine(text, 1, 1, 1, true)
        end
        if syncState ~= "current" then GameTooltip:AddLine("This is your saved view.", 1, 0.82, 0, true) end
        GameTooltip:Show()
    end)
    row:SetScript("OnLeave", HidePracticeTooltip)
    row:SetScript("OnHide", HidePracticeTooltip)
    row:SetScript("OnClick", function(self)
        if selectedId ~= self.ability.abilityId then rankOffset = 0 end
        selectedId = self.ability.abilityId
        Refresh()
    end)
    rows[index] = row
end
panel:EnableMouseWheel(true)
panel:SetScript("OnMouseWheel", function(_, delta) offset = offset - delta; Refresh() end)

filterButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
filterButton:SetSize(230, 24)
filterButton:SetPoint("TOPLEFT", 28, -526)
filterButton:SetScript("OnClick", function()
    local mode, key = FilterPreference()
    if not key then return end
    for index, value in ipairs(filterModes) do
        if value == mode then
            HXCAbilityPracticePreferences.filters[key] = filterModes[index % #filterModes + 1]
            break
        end
    end
    offset = 0
    Refresh()
end)
filterButton:SetScript("OnEnter", function(self)
    if not GameTooltip then return end
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("Filter abilities")
    if filterCounts then
        GameTooltip:AddLine(syncState == "current" and "In this tab and search:" or
            "In this saved tab and search:", 1, 0.82, 0, true)
        for _, mode in ipairs(filterModes) do
            GameTooltip:AddDoubleLine(filterLabels[mode], tostring(filterCounts[mode]), 1, 1, 1, 1, 1, 1)
        end
        GameTooltip:AddLine("Counts show matching abilities before the selected filter. Categories can overlap.",
            0.75, 0.75, 0.75, true)
    end
    GameTooltip:AddLine("Click to cycle All, Training, At cap, Paused and Not learned."
        .. " Your choice is saved for this class and applies to the selected tab and search.", 1, 1, 1, true)
    GameTooltip:AddLine("Training: the server currently permits practice. At cap: no more proficiency can be"
        .. " earned at your current cap, including completed skills.", 1, 1, 1, true)
    GameTooltip:AddLine("Paused: current character level or acquisition requirements are not met."
        .. " Not learned: the introductory ability has not been learned.", 1, 1, 1, true)
    GameTooltip:AddLine("Saved views use their last received state. Filtering does not change training.",
        1, 0.82, 0, true)
    GameTooltip:Show()
end)
filterButton:SetScript("OnLeave", HidePracticeTooltip)
filterButton:SetScript("OnHide", HidePracticeTooltip)

local function Tab(label, value, x)
    local button = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    button:SetSize(80, 24)
    button:SetPoint("TOPLEFT", x, -76)
    button:SetText(label)
    button:SetScript("OnClick", function() tab = value; offset = 0; Refresh() end)
end
Tab("My Skills", "skills", 28)
Tab("Upcoming", "upcoming", 116)
Tab("Tracked", "tracked", 204)
Tab("Session", "session", 292)
sortButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
sortButton:SetSize(124, 24)
sortButton:SetPoint("TOPLEFT", 388, -76)
sortButton:SetScript("OnClick", function()
    local mode, key = SortPreference()
    if not key then return end
    for index, value in ipairs(sortModes) do
        if value == mode then
            HXCAbilityPracticePreferences.sorts[key] = sortModes[index % #sortModes + 1]
            break
        end
    end
    offset = 0
    Refresh()
end)
sortButton:SetScript("OnEnter", function(self)
    if not GameTooltip then return end
    GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
    GameTooltip:SetText("Sort abilities")
    GameTooltip:AddLine("Click to cycle Default, Name and Uses. Your choice is saved for this class.", 1, 1, 1, true)
    GameTooltip:AddLine("Default orders upcoming milestones by required level and session progress by gains.",
        1, 1, 1, true)
    GameTooltip:AddLine("Uses puts currently trainable next ranks or mastery benefits first, ordered by the"
        .. " server's exact qualifying-use forecast. Blocked, paused and completed abilities follow by name.",
        1, 1, 1, true)
    GameTooltip:AddLine("Saved views use their last received forecasts. Sorting does not change training.",
        1, 0.82, 0, true)
    GameTooltip:Show()
end)
sortButton:SetScript("OnLeave", HidePracticeTooltip)
sortButton:SetScript("OnHide", HidePracticeTooltip)
local searchLabel = Text(panel, "GameFontHighlightSmall", 524, -82, 54)
searchLabel:SetText("Search")
searchBox = CreateFrame("EditBox", "HXCAbilityPracticeSearch", panel, "InputBoxTemplate")
searchBox:SetSize(147, 24)
searchBox:SetPoint("TOPLEFT", 578, -76)
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

function API.BeginServerGeneration(value)
    if not Model.ValidGeneration(value) or value == serverGeneration then return false end
    serverGeneration = value
    serverRevision = 0
    serverFailure = nil
    syncState = "waiting"
    Refresh()
    return true
end

function API.ApplySnapshot(value)
    local validated, reason = Model.Validate(value)
    if not validated then return false, reason end
    if snapshot and validated.classId ~= snapshot.classId then return false, "Mismatched progress update" end
    if validated.generation then API.BeginServerGeneration(validated.generation) end
    if validated.revision <= serverRevision then
        return false, "Stale or mismatched progress update"
    end
    snapshot = validated
    serverRevision = validated.revision
    serverFailure = nil
    receivedAt = GetTime()
    syncState = "current"
    Refresh()
    return true
end

function API.ApplyServerSnapshot(value)
    local validated, reason = Model.Validate(value)
    if not validated then return false, reason end
    if (not validated.generation or validated.generation == serverGeneration)
        and validated.revision <= serverRevision then return false, "Stale progress update" end
    local previousClass = snapshot and snapshot.classId or (serverFailure and serverFailure.classId)
    if previousClass and validated.classId ~= previousClass then API.Reset() end
    return API.ApplySnapshot(validated)
end

function API.ApplyServerFailure(value)
    local validated, reason = Model.ValidateFailure(value)
    if not validated then return false, reason end
    if validated.generation == serverGeneration and validated.revision <= serverRevision then
        return false, "Stale saved-progress issue"
    end
    local previousClass = snapshot and snapshot.classId or (serverFailure and serverFailure.classId)
    if previousClass and validated.classId ~= previousClass then API.Reset() end
    API.BeginServerGeneration(validated.generation)
    serverFailure = validated
    serverRevision = validated.revision
    syncState = "issue"
    Refresh()
    return true
end

function API.IsShown()
    return panel:IsShown()
end

function API.UpdateAge(now)
    if panel:IsShown() then UpdateSubtitle(now) end
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
    serverFailure = nil
    serverRevision = 0
    serverGeneration = nil
    receivedAt = nil
    syncState = "waiting"
    selectedId = nil
    offset = 0
    tab = "skills"
    showRoadmap = false
    rankOffset = 0
    search = ""
    searchBox:SetText("")
    Refresh()
end

SLASH_HXCABILITYPRACTICE1 = "/practice"
SlashCmdList.HXCABILITYPRACTICE = API.Toggle
Refresh()
