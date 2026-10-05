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

function Wire.GetDeadline()
    if not pending then return nil end
    if pending.schemaVersion == 4 then return math.min(pending.started + 90, pending.lastPart + 6) end
    return pending.started + 5
end

function Wire.GetGeneration()
    return pending and pending.generation or nil
end

local function Accept(message, now, currentRevision, currentGeneration)
    if type(now) ~= "number" or now ~= now or now == math.huge or now == -math.huge then
        return Reject("Invalid clock")
    end
    local fields = Fields(message)
    if not fields then return Reject("Invalid progress message") end
    local kind = fields[1]
    if kind == "F" then
        if #fields ~= 8 then return Reject("Invalid saved-progress issue") end
        local failure, reason = Model.ValidateFailure({ schemaVersion = tonumber(fields[2]),
            revision = tonumber(fields[3]), classId = tonumber(fields[4]), abilityId = tonumber(fields[5]),
            spellId = tonumber(fields[6]), issueCode = tonumber(fields[7]), generation = fields[8] })
        if not failure then return Reject(reason) end
        local floor = failure.generation == currentGeneration and (currentRevision or 0) or 0
        if failure.revision <= floor or (pending and pending.generation == failure.generation
            and failure.revision < pending.revision) then
            return nil, "Stale saved-progress issue"
        end
        pending = nil
        return nil, nil, failure
    end
    if kind == "B" then
        if #fields ~= 6 and #fields ~= 7 and #fields ~= 8 and #fields ~= 11 then
            return Reject("Invalid snapshot header")
        end
        local schema, revision, classId, level, count = tonumber(fields[2]), tonumber(fields[3]),
            tonumber(fields[4]), tonumber(fields[5]), tonumber(fields[6])
        if (schema ~= 1 and schema ~= 2 and schema ~= 3 and schema ~= 4)
            or revision < 1 or revision > 4294967295 or classId < 1 or classId > 255
            or level < 1 or level > 255 or count > 512 then return Reject("Unsupported snapshot header") end
        local generation = schema == 4 and fields[7] or nil
        local realmMaximumLevel = schema == 4 and fields[8] and tonumber(fields[8]) or nil
        if realmMaximumLevel and (realmMaximumLevel < 1 or realmMaximumLevel > 255) then
            return Reject("Invalid realm level cap")
        end
        if (schema == 4 and ((#fields ~= 7 and #fields ~= 8 and #fields ~= 11)
            or not Model.ValidGeneration(generation)))
            or (schema ~= 4 and #fields ~= 6) then return Reject("Invalid server instance identity") end
        local learning, learnCount
        if #fields == 11 then
            learnCount = tonumber(fields[10])
            if (fields[9] ~= "0" and fields[9] ~= "1") or not learnCount or learnCount > 32 then
                return Reject("Invalid session learning header")
            end
            learning = { available = fields[9] == "1", total = fields[11], events = {} }
        end
        local floor = generation and generation ~= currentGeneration and 0 or (currentRevision or 0)
        if revision <= floor or (pending and pending.generation == generation and revision <= pending.revision) then
            return nil, "Stale snapshot header"
        end
        pending = { schemaVersion = schema, revision = revision, classId = classId, characterLevel = level,
            count = count, generation = generation, realmMaximumLevel = realmMaximumLevel, started = now,
            lastPart = now, parts = {}, learning = learning, learnCount = learnCount,
            rankCount = 0, receivedRanks = 0, rewardCount = 0, receivedRewards = 0 }
        return nil
    end
    if not pending then return nil, "No snapshot in progress" end
    if now < pending.lastPart or now >= Wire.GetDeadline() then return Reject("Snapshot expired") end
    if tonumber(fields[2]) ~= pending.revision then return nil, "Unrelated snapshot message" end
    if kind == "E" then
        if #fields ~= 2 then return Reject("Invalid snapshot end") end
        if pending.schemaVersion >= 2 and not pending.session then return Reject("Missing session progress") end
        local snapshot = { schemaVersion = pending.schemaVersion, revision = pending.revision,
            classId = pending.classId, characterLevel = pending.characterLevel, generation = pending.generation,
            realmMaximumLevel = pending.realmMaximumLevel, session = pending.session,
            learning = pending.learning, mastery = pending.mastery, abilities = {} }
        if pending.learning then
            for index = 1, pending.learnCount do
                if not pending.learning.events[index] then return Reject("Incomplete session learning history") end
            end
        end
        if pending.mastery then
            for index = 1, pending.masteryCount do
                if not pending.mastery.events[index] then return Reject("Incomplete mastery history") end
            end
        end
        for index = 1, pending.count do
            local part = pending.parts[index]
            if not part or not part.A or not part.P or not part.R then return Reject("Incomplete snapshot") end
            local ability = part.A
            if pending.schemaVersion == 4 then
                if not part.T or not part.C then return Reject("Missing ability rules or cap") end
                ability.kind = part.T.kind
                ability.session = part.T.session
                ability.route = part.T.route
                ability.ruleSet = part.T.ruleSet
                ability.acquisitionSource = part.T.acquisitionSource
                ability.catchup = part.G
                ability.replacementSpellId = part.J
                ability.nextTrainingCap = part.C ~= true and part.C or nil
                ability.rewards = {}
                for ordinal = 1, part.T.rewardCount do
                    if not part.M or not part.M[ordinal] then return Reject("Incomplete mastery roadmap") end
                    ability.rewards[ordinal] = part.M[ordinal]
                end
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
    if kind == "H" then
        local count = tonumber(fields[4])
        if pending.schemaVersion ~= 4 or pending.mastery or #fields ~= 5 or not count or count > 32
            or (fields[3] ~= "0" and fields[3] ~= "1") then return Reject("Invalid mastery history header") end
        pending.mastery = { available = fields[3] == "1", total = fields[5], events = {} }
        pending.masteryCount = count
        return nil
    end
    if kind == "O" then
        local index = tonumber(fields[3])
        if pending.schemaVersion ~= 4 or not pending.mastery or (#fields ~= 8 and #fields ~= 9)
            or (#fields == 9 and fields[9] ~= "2") or not index
            or index < 1 or index > pending.masteryCount or pending.mastery.events[index] then
            return Reject("Invalid mastery history event")
        end
        pending.mastery.events[index] = { abilityId = tonumber(fields[4]), ordinal = tonumber(fields[5]),
            characterLevel = tonumber(fields[6]), proficiency = tonumber(fields[7]),
            healingBonusBasisPoints = #fields == 8 and tonumber(fields[8]) or 0,
            damageBonusBasisPoints = #fields == 9 and tonumber(fields[8]) or 0 }
        return nil
    end
    if kind == "N" then
        local index = tonumber(fields[3])
        if pending.schemaVersion ~= 4 or not pending.learning or #fields ~= 8 or not index
            or index < 1 or index > pending.learnCount or pending.learning.events[index] then
            return Reject("Invalid session learning event")
        end
        pending.learning.events[index] = { abilityId = tonumber(fields[4]), spellId = tonumber(fields[5]),
            rankNumber = tonumber(fields[6]), characterLevel = tonumber(fields[7]), proficiency = tonumber(fields[8]) }
        return nil
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
    if kind == "J" then
        local replacement = tonumber(fields[4])
        if pending.schemaVersion ~= 4 or part.J or #fields ~= 4 or not replacement
            or replacement < 1 or replacement > 4294967295 or replacement % 1 ~= 0 then
            return Reject("Invalid native ability replacement")
        end
        part.J = replacement
        return nil
    end
    if kind == "G" then
        if pending.schemaVersion ~= 4 or part.G or #fields ~= 8
            or (fields[8] ~= "0" and fields[8] ~= "1") then return Reject("Invalid catch-up policy") end
        part.G = { gap = tonumber(fields[4]), multiplier = tonumber(fields[5]),
            basePointsPerUse = tonumber(fields[6]), effectivePointsPerUse = tonumber(fields[7]),
            boosted = fields[8] == "1" }
        return nil
    end
    if kind == "C" then
        if pending.schemaVersion ~= 4 or part.C then return Reject("Invalid training cap update") end
        if #fields == 4 and fields[4] == "0" then part.C = true
        elseif #fields == 6 and fields[4] == "1" then
            part.C = { characterLevel = tonumber(fields[5]), proficiency = tonumber(fields[6]) }
        else return Reject("Invalid training cap update") end
        return nil
    end
    if kind == "T" then
        local abilityKind = tonumber(fields[4])
        local rewardCount = tonumber(fields[10])
        local acquisitionSource = fields[11] and tonumber(fields[11]) or nil
        if pending.schemaVersion ~= 4 or part.T or (#fields ~= 10 and #fields ~= 11) or not abilityKind
            or not rewardCount or rewardCount > 8
            or (acquisitionSource and (acquisitionSource < 1 or acquisitionSource > 4))
            or abilityKind < 1 or abilityKind > 3 or (fields[5] ~= "0" and fields[5] ~= "1") then
            return Reject("Invalid ability type or session progress")
        end
        pending.rewardCount = pending.rewardCount + rewardCount
        if pending.rewardCount > 512 then return Reject("Mastery roadmap is too large") end
        if part.M then
            for ordinal in pairs(part.M) do
                if ordinal > rewardCount then return Reject("Invalid mastery roadmap ordinal") end
            end
        end
        part.T = { kind = abilityKind, rewardCount = rewardCount, route = tonumber(fields[8]),
            ruleSet = tonumber(fields[9]), acquisitionSource = acquisitionSource,
            session = { available = fields[5] == "1", uses = fields[6],
            proficiencyGained = fields[7] } }
        return nil
    end
    if kind == "M" then
        local ordinal = tonumber(fields[4])
        if pending.schemaVersion ~= 4 or (#fields ~= 10 and #fields ~= 11)
            or (#fields == 11 and fields[11] ~= "2") or not ordinal or ordinal < 1 or ordinal > 8
            or (part.T and ordinal > part.T.rewardCount) then return Reject("Invalid mastery roadmap entry") end
        part.M = part.M or {}
        if part.M[ordinal] then return Reject("Duplicate mastery roadmap entry") end
        pending.receivedRewards = pending.receivedRewards + 1
        if pending.receivedRewards > 512 then return Reject("Mastery roadmap is too large") end
        part.M[ordinal] = { characterLevel = tonumber(fields[5]), proficiency = tonumber(fields[6]),
            healingBonusBasisPoints = #fields == 10 and tonumber(fields[7]) or 0,
            damageBonusBasisPoints = #fields == 11 and tonumber(fields[7]) or 0, state = tonumber(fields[8]),
            practice = { status = tonumber(fields[9]), uses = fields[10] } }
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

local function AcceptPacked(message, now, currentRevision, currentGeneration)
    if type(now) ~= "number" or now ~= now or now == math.huge or now == -math.huge then
        return Reject("Invalid clock")
    end
    if #message > 240 then return Reject("Packed progress message is too large") end
    local revisionText, body = string.match(message, "^D|(%d+)|(.+)$")
    if not revisionText or #revisionText > 10 or string.sub(revisionText, 1, 1) == "0"
        or tonumber(revisionText) > 4294967295 then return Reject("Invalid packed progress revision") end
    if not pending then return nil, "No snapshot in progress" end
    if pending.schemaVersion ~= 4 then return Reject("Packed progress requires typed snapshot") end
    if tonumber(revisionText) ~= pending.revision then return nil, "Unrelated packed progress message" end
    local parts = {}
    for part in string.gmatch(body .. ";", "([^;]*);") do
        local kind, fields = string.match(part, "^([ACPRTKLMNGOJ])|(.+)$")
        if not kind or #parts >= 32 then return Reject("Invalid packed progress part") end
        parts[#parts + 1] = kind .. "|" .. revisionText .. "|" .. fields
    end
    if #parts == 0 then return Reject("Empty packed progress message") end
    for _, part in ipairs(parts) do
        local snapshot, reason, failure = Accept(part, now, currentRevision, currentGeneration)
        if snapshot or failure or reason then return Reject(reason or "Unexpected packed progress result") end
    end
    return nil
end

function Wire.Accept(message, now, currentRevision, currentGeneration)
    local snapshot, reason, failure
    if type(message) == "string" and string.sub(message, 1, 2) == "D|" then
        snapshot, reason, failure = AcceptPacked(message, now, currentRevision, currentGeneration)
    else
        snapshot, reason, failure = Accept(message, now, currentRevision, currentGeneration)
    end
    if pending and not reason then pending.lastPart = now end
    return snapshot, reason, failure
end
