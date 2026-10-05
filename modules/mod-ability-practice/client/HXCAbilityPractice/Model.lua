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

local function Ability(value)
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
    return { abilityId = value.abilityId, displaySpellId = value.displaySpellId, learnedRank = value.learnedRank,
        proficiency = value.proficiency, points = value.points, cap = value.cap, pointsPerLevel = value.pointsPerLevel,
        availability = value.availability, nextPoint = point, nextRank = rank }
end

function Model.Validate(snapshot)
    if type(snapshot) ~= "table" or (snapshot.schemaVersion ~= 1 and snapshot.schemaVersion ~= 2)
        or not Integer(snapshot.revision, 1, 4294967295) or not Integer(snapshot.classId, 1, 255)
        or not Integer(snapshot.characterLevel, 1, 255) or type(snapshot.abilities) ~= "table"
        or #snapshot.abilities > 512 then return nil, "Unsupported or incomplete progress update" end
    local session = snapshot.schemaVersion == 2 and Session(snapshot.session) or nil
    if snapshot.schemaVersion == 2 and not session then return nil, "Incomplete session progress" end
    if snapshot.schemaVersion == 1 and snapshot.session ~= nil then return nil, "Unexpected session progress" end
    local result = { schemaVersion = snapshot.schemaVersion, session = session, revision = snapshot.revision,
        classId = snapshot.classId,
        characterLevel = snapshot.characterLevel, abilities = {} }
    local seen = {}
    local count = 0
    for key in pairs(snapshot.abilities) do
        if not Integer(key, 1, #snapshot.abilities) then return nil, "Invalid ability list" end
        count = count + 1
    end
    if count ~= #snapshot.abilities then return nil, "Incomplete ability list" end
    for _, value in ipairs(snapshot.abilities) do
        local ability = Ability(value)
        if not ability or seen[ability.abilityId] then return nil, "Invalid or duplicate ability" end
        seen[ability.abilityId] = true
        result.abilities[#result.abilities + 1] = ability
    end
    return result
end

function Model.PointText(ability)
    local state = ability.availability
    if state == 1 then return "Learn this ability to begin practicing." end
    if state == 2 then return "Requires the appropriate talent or specialization." end
    if state == 3 then return "Requires a higher character level." end
    if state == 5 then return "At your current proficiency cap. More practice unlocks as you level." end
    if state == 6 then return "Fixed ability — no practice required." end
    if ability.nextPoint.status == 1 then
        local uses = ability.nextPoint.uses
        return uses .. (uses == "1" and " qualifying use" or " qualifying uses") .. " to the next proficiency point."
    end
    return "Progress forecast unavailable."
end

function Model.RankText(rank)
    if not rank then return "All currently defined ranks learned." end
    local requirement = "Character level " .. rank.characterLevel .. " · Proficiency " .. rank.proficiency
    if rank.state == 2 then return "Learn through your normal ability source.\n" .. requirement end
    if rank.state == 3 then return "Requires the previous rank and the appropriate talent or specialization.\n" .. requirement end
    if rank.state == 7 then return "Requirements met.\n" .. requirement end
    if rank.state == 5 then
        return (rank.rankNumber == 1 and "Waiting for character level.\n" or
            "Practice requirement met; waiting for character level.\n") .. requirement
    end
    if rank.practice.status == 3 then return "Beyond your current proficiency cap.\n" .. requirement end
    if rank.practice.status == 1 then
        return rank.practice.uses .. " qualifying uses remaining at your current training rate.\n" .. requirement
    end
    return requirement
end
