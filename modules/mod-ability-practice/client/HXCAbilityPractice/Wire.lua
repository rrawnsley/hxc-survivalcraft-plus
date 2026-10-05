HXCAbilityPracticeWire = {}
local Wire = HXCAbilityPracticeWire
local Model = HXCAbilityPracticeModel
local pending

local function Fields(message)
    if type(message) ~= "string" or #message > 240 then return nil end
    local fields = {}
    for value in string.gmatch(message .. "|", "([^|]*)|") do fields[#fields + 1] = value end
    if #fields > 11 then return nil end
    for index = 2, #fields do
        local value = fields[index]
        if not string.match(value, "^%d+$") or #value > 20
            or (#value > 1 and string.sub(value, 1, 1) == "0") then return nil end
    end
    return fields
end

local function Reject(reason)
    pending = nil
    return nil, reason
end

function Wire.Reset() pending = nil end

function Wire.Accept(message, now, currentRevision)
    if type(now) ~= "number" or now ~= now or now == math.huge or now == -math.huge then
        return Reject("Invalid clock")
    end
    local fields = Fields(message)
    if not fields then return Reject("Invalid progress message") end
    local kind = fields[1]
    if kind == "B" then
        if #fields ~= 6 then return Reject("Invalid snapshot header") end
        local schema, revision, classId, level, count = tonumber(fields[2]), tonumber(fields[3]),
            tonumber(fields[4]), tonumber(fields[5]), tonumber(fields[6])
        if (schema ~= 1 and schema ~= 2 and schema ~= 3 and schema ~= 4)
            or revision < 1 or revision > 4294967295 or classId < 1 or classId > 255
            or level < 1 or level > 255 or count > 512 then return Reject("Unsupported snapshot header") end
        if revision <= (currentRevision or 0) or (pending and revision <= pending.revision) then
            return nil, "Stale snapshot header"
        end
        pending = { schemaVersion = schema, revision = revision, classId = classId, characterLevel = level,
            count = count, started = now, parts = {}, rankCount = 0, receivedRanks = 0 }
        return nil
    end
    if not pending then return nil, "No snapshot in progress" end
    if now < pending.started or now - pending.started > 5 then return Reject("Snapshot expired") end
    if tonumber(fields[2]) ~= pending.revision then return nil, "Unrelated snapshot message" end
    if kind == "E" then
        if #fields ~= 2 then return Reject("Invalid snapshot end") end
        if pending.schemaVersion >= 2 and not pending.session then return Reject("Missing session progress") end
        local snapshot = { schemaVersion = pending.schemaVersion, revision = pending.revision,
            classId = pending.classId, characterLevel = pending.characterLevel, session = pending.session, abilities = {} }
        for index = 1, pending.count do
            local part = pending.parts[index]
            if not part or not part.A or not part.P or not part.R then return Reject("Incomplete snapshot") end
            local ability = part.A
            if pending.schemaVersion == 4 then
                if not part.T then return Reject("Missing ability type") end
                ability.kind = part.T
            end
            ability.nextPoint = part.P
            ability.nextRank = part.R ~= true and part.R or nil
            if pending.schemaVersion >= 3 then
                if not part.K then return Reject("Missing rank roadmap") end
                ability.ranks = {}
                for ordinal = 1, part.K do
                    if not part.L or not part.L[ordinal] then return Reject("Incomplete rank roadmap") end
                    ability.ranks[ordinal] = part.L[ordinal]
                end
            end
            snapshot.abilities[index] = ability
        end
        pending = nil
        return Model.Validate(snapshot)
    end
    if kind == "S" then
        if pending.schemaVersion < 2 or pending.session or #fields ~= 5
            or (fields[3] ~= "0" and fields[3] ~= "1") then return Reject("Invalid session progress") end
        pending.session = { available = fields[3] == "1", uses = fields[4],
            proficiencyGained = fields[5] }
        return nil
    end
    local index = tonumber(fields[3])
    if not index or index < 1 or index > pending.count then return Reject("Invalid ability index") end
    local part = pending.parts[index] or {}
    pending.parts[index] = part
    if kind == "T" then
        local abilityKind = tonumber(fields[4])
        if pending.schemaVersion ~= 4 or part.T or #fields ~= 4 or not abilityKind
            or abilityKind < 1 or abilityKind > 3 then return Reject("Invalid ability type") end
        part.T = abilityKind
        return nil
    end
    if kind == "K" then
        local count = tonumber(fields[4])
        if pending.schemaVersion < 3 or part.K or #fields ~= 4 or not count or count < 1 or count > 64
            then return Reject("Invalid rank roadmap count") end
        pending.rankCount = pending.rankCount + count
        if pending.rankCount > 2048 then return Reject("Rank roadmap is too large") end
        part.K = count
        if part.L then
            for ordinal in pairs(part.L) do
                if ordinal > count then return Reject("Invalid rank roadmap ordinal") end
            end
        end
        return nil
    end
    if kind == "L" then
        local ordinal = tonumber(fields[4])
        if pending.schemaVersion < 3 or #fields ~= 11 or not ordinal or ordinal < 1 or ordinal > 64
            or (part.K and ordinal > part.K) then return Reject("Invalid rank roadmap entry") end
        part.L = part.L or {}
        if part.L[ordinal] then return Reject("Duplicate rank roadmap entry") end
        pending.receivedRanks = pending.receivedRanks + 1
        if pending.receivedRanks > 2048 then return Reject("Rank roadmap is too large") end
        part.L[ordinal] = { spellId = tonumber(fields[5]), rankNumber = tonumber(fields[6]),
            characterLevel = tonumber(fields[7]), proficiency = tonumber(fields[8]), state = tonumber(fields[9]),
            practice = { status = tonumber(fields[10]), uses = fields[11] } }
        return nil
    end
    if part[kind] then return Reject("Duplicate snapshot part") end
    if kind == "A" and #fields == 11 then
        part.A = { abilityId = tonumber(fields[4]), displaySpellId = tonumber(fields[5]),
            learnedRank = tonumber(fields[6]), proficiency = tonumber(fields[7]), points = tonumber(fields[8]),
            cap = tonumber(fields[9]), pointsPerLevel = tonumber(fields[10]), availability = tonumber(fields[11]) }
    elseif kind == "P" and #fields == 5 then
        part.P = { status = tonumber(fields[4]), uses = fields[5] }
    elseif kind == "R" and #fields == 4 and fields[4] == "0" then part.R = true
    elseif kind == "R" and #fields == 11 and fields[4] == "1" then
        part.R = { spellId = tonumber(fields[5]), rankNumber = tonumber(fields[6]),
            characterLevel = tonumber(fields[7]), proficiency = tonumber(fields[8]), state = tonumber(fields[9]),
            practice = { status = tonumber(fields[10]), uses = fields[11] } }
    else return Reject("Invalid snapshot part") end
    return nil
end
