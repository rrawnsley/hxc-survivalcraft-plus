HXCAbilityPracticeModel = {}
local Model = HXCAbilityPracticeModel

local function Integer(value, minimum, maximum)
    return type(value) == "number" and value >= minimum and value <= maximum and value == math.floor(value)
end

local function Counter(value)
    return type(value) == "string" and string.match(value, "^%d+$") and #value <= 20
        and (#value == 1 or string.sub(value, 1, 1) ~= "0")
        and (#value < 20 or value <= "18446744073709551615")
end

function Model.ValidGeneration(value)
    return Counter(value) and value ~= "0"
end

function Model.ValidateFailure(value)
    if type(value) ~= "table" or value.schemaVersion ~= 4
        or not Integer(value.revision, 1, 4294967295) or not Integer(value.classId, 1, 255)
        or not Integer(value.abilityId, 1, 4294967295) or not Integer(value.spellId, 1, 4294967295)
        or not Model.ValidGeneration(value.generation) or value.issueCode ~= 1 then return nil, "Invalid saved-progress issue" end
    return { schemaVersion = 4, revision = value.revision, classId = value.classId,
        abilityId = value.abilityId, spellId = value.spellId, issueCode = 1, generation = value.generation }
end


local function Session(value)
    if type(value) ~= "table" or type(value.available) ~= "boolean"
        or not Counter(value.uses) or not Counter(value.proficiencyGained) then return nil end
    if not value.available and (value.uses ~= "0" or value.proficiencyGained ~= "0") then
        return nil
    end
    return { available = value.available, uses = value.uses,
        proficiencyGained = value.proficiencyGained }
end

local function Forecast(value)
    if type(value) ~= "table" or not Integer(value.status, 0, 3) then return nil end
    if type(value.uses) ~= "string" or not string.match(value.uses, "^%d+$") then return nil end
    if #value.uses > 20 or (#value.uses > 1 and string.sub(value.uses, 1, 1) == "0") then return nil end
    if #value.uses == 20 and value.uses > "18446744073709551615" then return nil end
    if value.status ~= 1 and value.uses ~= "0" then return nil end
    if value.status == 1 and value.uses == "0" then return nil end
    return { status = value.status, uses = value.uses }
end

local function Rank(value)
    if type(value) ~= "table" or not Integer(value.spellId, 1, 4294967295)
        or not Integer(value.rankNumber, 1, 4294967295) or not Integer(value.characterLevel, 1, 255)
        or not Integer(value.proficiency, 1, 4294967295) or not Integer(value.state, 0, 7) then return nil end
    local practice = Forecast(value.practice)
    if not practice then return nil end
    return { spellId = value.spellId, rankNumber = value.rankNumber, characterLevel = value.characterLevel,
        proficiency = value.proficiency, state = value.state, practice = practice }
end

local function Ranks(value)
    if type(value) ~= "table" or #value == 0 or #value > 64 then return nil end
    local count = 0
    for key in pairs(value) do
        if not Integer(key, 1, #value) then return nil end
        count = count + 1
    end
    if count ~= #value then return nil end
    local result, seen = {}, {}
    for index, entry in ipairs(value) do
        local rank = Rank(entry)
        if not rank or rank.state == 0 or seen[rank.spellId] then return nil end
        local previous = result[index - 1]
        if previous and (rank.rankNumber <= previous.rankNumber or rank.characterLevel < previous.characterLevel
            or rank.proficiency < previous.proficiency) then return nil end
        result[index] = rank
        seen[rank.spellId] = true
    end
    return result
end

local function Ability(value, schema, characterLevel)
    if type(value) ~= "table" then return nil end
    local positive = { "abilityId", "displaySpellId", "proficiency", "cap" }
    for _, field in ipairs(positive) do
        if not Integer(value[field], 1, 4294967295) then return nil end
    end
    local nonnegative = { "learnedRank", "points", "pointsPerLevel" }
    for _, field in ipairs(nonnegative) do
        if not Integer(value[field], 0, 4294967295) then return nil end
    end
    if not Integer(value.availability, 1, 6) then return nil end
    if value.pointsPerLevel > 0 and value.points >= value.pointsPerLevel then return nil end
    if (value.availability == 4 or value.availability == 5) and value.pointsPerLevel == 0 then return nil end
    local point = Forecast(value.nextPoint)
    if not point then return nil end
    local rank = value.nextRank and Rank(value.nextRank) or nil
    if value.nextRank and not rank then return nil end
    local ranks = schema >= 3 and Ranks(value.ranks) or nil
    if schema >= 3 and not ranks then return nil end
    if schema < 3 and value.ranks ~= nil then return nil end
    if rank and ranks then
        local matched = false
        for _, entry in ipairs(ranks) do
            if entry.spellId == rank.spellId and entry.rankNumber == rank.rankNumber
                and entry.characterLevel == rank.characterLevel and entry.proficiency == rank.proficiency
                and entry.state == rank.state and entry.practice.status == rank.practice.status
                and entry.practice.uses == rank.practice.uses then matched = true end
        end
        if not matched then return nil end
    end
    local session = schema == 4 and Session(value.session) or nil
    if schema == 4 then
        if not session or not Integer(value.kind, 1, 3) or not Integer(value.route, 1, 6)
            or value.ruleSet ~= 1 or ((value.kind == 3) ~= (value.route == 6)) then return nil end
        if value.nextTrainingCap ~= nil then
            local cap = value.nextTrainingCap
            if type(cap) ~= "table" or not Integer(cap.characterLevel, characterLevel + 1, 255)
                or not Integer(cap.proficiency, 1, 4294967295)
                or cap.proficiency <= math.max(value.cap, value.proficiency)
                or cap.characterLevel < ranks[1].characterLevel or value.kind == 3 then return nil end
        end
        if value.kind == 3 then
            if #ranks ~= 1 or value.learnedRank > 1 or value.proficiency ~= 1 or value.cap ~= 1
                or value.points ~= 0 or value.pointsPerLevel ~= 0 or point.status ~= 0
                or ranks[1].proficiency ~= 1 or ranks[1].practice.status ~= 0
                or (ranks[1].state ~= 1 and ranks[1].state ~= 2 and ranks[1].state ~= 3
                    and ranks[1].state ~= 5) then return nil end
        elseif value.availability == 6 then return nil end
    elseif value.kind ~= nil or value.session ~= nil or value.route ~= nil or value.ruleSet ~= nil
        or value.nextTrainingCap ~= nil then return nil end
    local cap = value.nextTrainingCap
    return { nextTrainingCap = cap and { characterLevel = cap.characterLevel, proficiency = cap.proficiency } or nil,
        hasCapInfo = schema == 4, kind = value.kind, session = session,
        route = value.route, ruleSet = value.ruleSet, ranks = ranks,
        abilityId = value.abilityId, displaySpellId = value.displaySpellId,
        learnedRank = value.learnedRank,
        proficiency = value.proficiency, points = value.points, cap = value.cap, pointsPerLevel = value.pointsPerLevel,
        availability = value.availability, nextPoint = point, nextRank = rank }
end

function Model.Validate(snapshot)
    if type(snapshot) ~= "table"
        or (snapshot.schemaVersion ~= 1 and snapshot.schemaVersion ~= 2 and snapshot.schemaVersion ~= 3
            and snapshot.schemaVersion ~= 4)
        or not Integer(snapshot.revision, 1, 4294967295) or not Integer(snapshot.classId, 1, 255)
        or not Integer(snapshot.characterLevel, 1, 255) or type(snapshot.abilities) ~= "table"
        or #snapshot.abilities > 512 then return nil, "Unsupported or incomplete progress update" end
    if snapshot.schemaVersion == 4 and not Model.ValidGeneration(snapshot.generation) then
        return nil, "Missing server instance identity"
    end
    local session = snapshot.schemaVersion >= 2 and Session(snapshot.session) or nil
    if snapshot.schemaVersion >= 2 and not session then return nil, "Incomplete session progress" end
    if snapshot.schemaVersion == 1 and snapshot.session ~= nil then return nil, "Unexpected session progress" end
    local result = { schemaVersion = snapshot.schemaVersion, session = session, revision = snapshot.revision,
        classId = snapshot.classId, generation = snapshot.schemaVersion == 4 and snapshot.generation or nil,
        characterLevel = snapshot.characterLevel, abilities = {} }
    local seen = {}
    local rankCount = 0
    local count = 0
    for key in pairs(snapshot.abilities) do
        if not Integer(key, 1, #snapshot.abilities) then return nil, "Invalid ability list" end
        count = count + 1
    end
    if count ~= #snapshot.abilities then return nil, "Incomplete ability list" end
    for _, value in ipairs(snapshot.abilities) do
        local ability = Ability(value, snapshot.schemaVersion, snapshot.characterLevel)
        if not ability or seen[ability.abilityId] then return nil, "Invalid or duplicate ability" end
        rankCount = rankCount + (ability.ranks and #ability.ranks or 0)
        if rankCount > 2048 then return nil, "Rank roadmap is too large" end
        seen[ability.abilityId] = true
        result.abilities[#result.abilities + 1] = ability
    end
    return result
end

function Model.IsFixed(ability)
    return ability.kind == 3 or ability.availability == 6
end

function Model.PointText(ability)
    local state = ability.availability
    if state == 1 then
        return Model.IsFixed(ability) and "Learn through your normal ability source. No practice required."
            or "Learn this ability to begin practicing."
    end
    if state == 2 then return "Requires the appropriate talent or specialization." end
    if state == 3 and Model.IsFixed(ability) then
        return "This ability requires a higher character level. No practice required."
    end
    if state == 3 then return ability.learnedRank > 0 and "Practice requires a higher character level."
        or "This ability unlocks at a higher character level." end
    if state == 5 then
        if not ability.nextRank then return "Training complete. All defined ranks learned." end
        if ability.nextTrainingCap then
            return "Current cap reached. More practice opens at character level "
                .. ability.nextTrainingCap.characterLevel .. " (cap " .. ability.nextTrainingCap.proficiency .. ")."
        end
        return "Current proficiency cap reached. Check the next rank for remaining requirements."
    end
    if state == 6 then return "Fixed ability — no practice required." end
    if ability.nextPoint.status == 1 then
        local uses = ability.nextPoint.uses
        return uses .. (uses == "1" and " qualifying use" or " qualifying uses") .. " to the next proficiency point."
    end
    return "Progress forecast unavailable."
end

function Model.RankText(rank, fixed)
    if fixed then
        if not rank then return "This ability works at full effectiveness without practice." end
        local requirement = "Character level " .. rank.characterLevel .. " - No practice required."
        local state = rank.state == 1 and "Learned." or rank.state == 3 and "Normal acquisition prerequisites required."
            or rank.state == 5 and "Waiting for character level." or "Learn through your normal ability source."
        return state .. "\n" .. requirement
    end
    if not rank then return "All currently defined ranks learned." end
    local requirement = "Character level " .. rank.characterLevel .. " · Proficiency " .. rank.proficiency
    if rank.state == 1 then return "Learned.\n" .. requirement end
    if rank.state == 2 then return "Learn through your normal ability source.\n" .. requirement end
    if rank.state == 3 then
        local forecast = rank.practice.status == 1 and (rank.practice.uses
            .. " qualifying uses to the proficiency requirement.\n")
            or (rank.practice.status == 3 and "Practice exceeds the current cap.\n" or "")
        return "Requires earlier ranks or normal acquisition prerequisites.\n" .. forecast .. requirement
    end
    if rank.state == 7 then return "Requirements met.\n" .. requirement end
    if rank.state == 5 then
        return (rank.rankNumber == 1 and "Waiting for character level.\n" or
            "Practice requirement met; waiting for character level.\n") .. requirement
    end
    if rank.practice.status == 3 then return "Beyond your current proficiency cap.\n" .. requirement end
    if rank.practice.status == 1 then
        return rank.practice.uses .. " qualifying uses remaining under current training rules.\n" .. requirement
    end
    return requirement
end

function Model.PracticeRules(ability)
    if Model.IsFixed(ability) then
        return "This ability has no practice levels. Learn it through your normal ability source."
    end
    if ability.ruleSet ~= 1 then
        return "Practice rules are unavailable in this update. Refresh to request the current rules."
    end
    local rules = {
        [1] = "Deal damage to a level-appropriate PvE opponent with the learned ability.",
        [2] = "Restore missing health on a friendly unit fighting a live, level-appropriate PvE opponent."
            .. " Full overhealing does not count.",
        [3] = "Actually stop a cast by a live, level-appropriate PvE opponent. An idle target does not count.",
        [4] = "Successfully remove an aura. Offensive dispels require a level-appropriate PvE opponent;"
            .. " defensive dispels require a friendly unit in a qualifying PvE encounter.",
        [5] = "Successfully steal a beneficial aura from a live, level-appropriate PvE opponent.",
    }
    local rule = rules[ability.route]
    if not rule then return "Practice rules are unavailable in this update." end
    return rule .. "\n\nOpponents that are too low level, players, player-controlled units, pets, totems"
        .. " and critters do not qualify."
        .. "\n\nOnly your learned ability casts requested through your client can count."
        .. " Triggered casts, item casts, script-created spells and aura-triggered helpers do not count."
        .. " One award per cast, regardless of targets or removals. Practice stops at your current cap."
end
