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
        or not Model.ValidGeneration(value.generation) or not Integer(value.issueCode, 1, 2) then
        return nil, "Invalid saved-progress issue"
    end
    return { schemaVersion = 4, revision = value.revision, classId = value.classId,
        abilityId = value.abilityId, spellId = value.spellId, issueCode = value.issueCode, generation = value.generation }
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

local function SameRank(left, right)
    return left and right and left.spellId == right.spellId and left.rankNumber == right.rankNumber
        and left.characterLevel == right.characterLevel and left.proficiency == right.proficiency
        and left.state == right.state and left.practice.status == right.practice.status
        and left.practice.uses == right.practice.uses
end

local function ConsistentTypedRoadmap(value, ranks, nextRank, point, characterLevel)
    if ranks[1].proficiency ~= 1 or (value.kind == 1 and #ranks < 2)
        or (value.kind == 2 and #ranks ~= 1) then return false end
    local learned, display = 0, ranks[1].spellId
    for index, rank in ipairs(ranks) do
        if rank.rankNumber ~= index then return false end
        if rank.state == 1 then learned, display = index, rank.spellId end
    end
    if value.learnedRank ~= learned or value.displaySpellId ~= display then return false end
    if learned < #ranks then
        if not SameRank(nextRank, ranks[learned + 1]) then return false end
    elseif nextRank then return false end
    local introLevelMet = characterLevel >= ranks[1].characterLevel
    if value.availability == 1 then return learned == 0 and introLevelMet and point.status == 0 end
    if value.availability == 2 then return point.status == 0 end
    if value.availability == 3 then return not introLevelMet and point.status == 0 end
    if value.availability == 4 then
        return learned > 0 and introLevelMet and value.proficiency < value.cap and point.status == 1
    end
    if value.availability == 5 then
        return learned > 0 and introLevelMet and value.proficiency >= value.cap and point.status == 3
    end
    return value.availability == 6 and value.kind == 3 and learned > 0 and introLevelMet
end

local function Rewards(value, ability, ranks, characterLevel)
    if type(value) ~= "table" or #value > 8 then return nil end
    local count = 0
    for key in pairs(value) do
        if not Integer(key, 1, #value) then return nil end
        count = count + 1
    end
    if count ~= #value or (ability.kind ~= 2 and count ~= 0)
        or (ability.kind == 2 and (count == 0 or (ability.route ~= 1 and ability.route ~= 2))) then return nil end
    local result, previousLevel, previousProficiency, previousBonus = {}, ranks[1].characterLevel, 1, 0
    for _, entry in ipairs(value) do
        if type(entry) ~= "table" then return nil end
        local healing, damage = entry.healingBonusBasisPoints or 0, entry.damageBonusBasisPoints or 0
        local bonus = ability.route == 2 and healing or damage
        if (ability.route == 2 and damage ~= 0) or (ability.route == 1 and healing ~= 0)
            or not Integer(entry.characterLevel, previousLevel, 255)
            or not Integer(entry.proficiency, previousProficiency + 1, 4294967295)
            or not Integer(bonus, previousBonus + 1, 200) then return nil end
        local practice = Forecast(entry.practice)
        if not practice then return nil end
        local levelMet, practiceMet = characterLevel >= entry.characterLevel,
            ability.proficiency >= entry.proficiency
        local state = ability.availability == 2 and 3 or ability.learnedRank == 0 and 2
            or levelMet and practiceMet and 1 or levelMet and 4 or practiceMet and 5 or 6
        local forecast = practiceMet and 2 or entry.proficiency > ability.cap and 3 or 1
        if entry.state ~= state or practice.status ~= forecast then return nil end
        result[#result + 1] = { characterLevel = entry.characterLevel, proficiency = entry.proficiency,
            healingBonusBasisPoints = healing, damageBonusBasisPoints = damage,
            state = entry.state, practice = practice }
        previousLevel, previousProficiency, previousBonus = entry.characterLevel, entry.proficiency, bonus
    end
    if ability.kind == 2 and ability.cap > previousProficiency then return nil end
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
    local rewards, catchup
    if schema == 4 then
        if value.acquisitionSource ~= nil and not Integer(value.acquisitionSource, 1, 5) then return nil end
        if value.acquisitionSource == 5 and value.kind ~= 3 then return nil end
        if not session or not Integer(value.kind, 1, 3) or not Integer(value.route, 1, 13)
            or not Integer(value.ruleSet, 1, 10)
            or ((value.ruleSet == 3 or value.ruleSet == 6) and (value.kind ~= 1 or value.route ~= 2))
            or ((value.ruleSet == 7 or value.ruleSet == 8) and (value.kind ~= 2 or value.route ~= 1))
            or ((value.ruleSet == 9 or value.ruleSet == 10) and (value.kind ~= 2 or value.route ~= 2))
            or (value.route == 13 and (value.kind ~= 1 or (value.ruleSet ~= 1 and value.ruleSet ~= 4)))
            or ((value.kind == 3) ~= (value.route == 6)) then return nil end
        if value.route == 13 then
            if not Integer(value.buffState, 1, 5) then return nil end
        elseif value.buffState ~= nil then return nil end
        if value.replacementSpellId ~= nil then
            if not Integer(value.replacementSpellId, 1, 4294967295) or value.availability ~= 2 then return nil end
            for _, entry in ipairs(ranks) do
                if entry.spellId == value.replacementSpellId then return nil end
            end
        end
        if ((value.ruleSet >= 4 and value.ruleSet <= 6) or value.ruleSet == 8 or value.ruleSet == 10)
            ~= (value.catchup ~= nil) then return nil end
        if value.catchup then
            local policy = value.catchup
            if type(policy) ~= "table" or value.kind == 3 or not Integer(policy.gap, 1, 500)
                or not Integer(policy.multiplier, 2, 4) or not Integer(policy.basePointsPerUse, 1, 4294967295)
                or not Integer(policy.effectivePointsPerUse, 1, 4294967295)
                or type(policy.boosted) ~= "boolean" then return nil end
            local boosted = value.proficiency < value.cap and value.cap - value.proficiency >= policy.gap
            local expected = policy.basePointsPerUse * (boosted and policy.multiplier or 1)
            if boosted ~= policy.boosted or expected ~= policy.effectivePointsPerUse then return nil end
            catchup = { gap = policy.gap, multiplier = policy.multiplier,
                basePointsPerUse = policy.basePointsPerUse, effectivePointsPerUse = policy.effectivePointsPerUse,
                boosted = policy.boosted }
        end
        if not ConsistentTypedRoadmap(value, ranks, rank, point, characterLevel) then return nil end
        rewards = Rewards(value.rewards, value, ranks, characterLevel)
        if not rewards then return nil end
        if value.nextTrainingCap ~= nil then
            local cap = value.nextTrainingCap
            if type(cap) ~= "table" or not Integer(cap.characterLevel, characterLevel + 1, 255)
                or not Integer(cap.proficiency, 1, 4294967295)
                or cap.proficiency <= math.max(value.cap, value.proficiency)
                or cap.characterLevel < ranks[1].characterLevel or value.kind == 3 then return nil end
        end
        if value.kind == 3 then
            if value.learnedRank > #ranks or value.proficiency ~= 1 or value.cap ~= 1
                or value.points ~= 0 or value.pointsPerLevel ~= 0 or point.status ~= 0 then return nil end
            for _, rank in ipairs(ranks) do
                if rank.proficiency ~= 1 or rank.practice.status ~= 0
                    or (rank.state ~= 1 and rank.state ~= 2 and rank.state ~= 3
                        and rank.state ~= 5) then return nil end
            end
        elseif value.availability == 6 then return nil end
    elseif value.kind ~= nil or value.session ~= nil or value.route ~= nil or value.ruleSet ~= nil
        or value.nextTrainingCap ~= nil or value.rewards ~= nil or value.acquisitionSource ~= nil
        or value.catchup ~= nil or value.replacementSpellId ~= nil or value.buffState ~= nil then return nil end
    local cap = value.nextTrainingCap
    return { nextTrainingCap = cap and { characterLevel = cap.characterLevel, proficiency = cap.proficiency } or nil,
        hasCapInfo = schema == 4, kind = value.kind, session = session,
        route = value.route, ruleSet = value.ruleSet, acquisitionSource = value.acquisitionSource,
        replacementSpellId = value.replacementSpellId,
        buffState = value.buffState,
        ranks = ranks, rewards = rewards, catchup = catchup,
        abilityId = value.abilityId, displaySpellId = value.displaySpellId,
        learnedRank = value.learnedRank,
        proficiency = value.proficiency, points = value.points, cap = value.cap, pointsPerLevel = value.pointsPerLevel,
        availability = value.availability, nextPoint = point, nextRank = rank }
end

local function Learning(value, abilities)
    if type(value) ~= "table" or type(value.available) ~= "boolean" or not Counter(value.total)
        or type(value.events) ~= "table" or #value.events > 32 then return nil end
    local expected = #value.total <= 2 and math.min(tonumber(value.total), 32) or 32
    if not value.available and (value.total ~= "0" or #value.events ~= 0) then return nil end
    if value.available and #value.events ~= expected then return nil end
    local count = 0
    for key in pairs(value.events) do
        if not Integer(key, 1, #value.events) then return nil end
        count = count + 1
    end
    if count ~= #value.events then return nil end
    local byId = {}
    for _, ability in ipairs(abilities) do byId[ability.abilityId] = ability end
    local events = {}
    for _, event in ipairs(value.events) do
        if type(event) ~= "table" or not Integer(event.abilityId, 1, 4294967295)
            or not Integer(event.spellId, 1, 4294967295) or not Integer(event.rankNumber, 1, 64)
            or not Integer(event.characterLevel, 1, 255) or not Integer(event.proficiency, 1, 4294967295)
            or not byId[event.abilityId] then return nil end
        local matched = false
        for _, rank in ipairs(byId[event.abilityId].ranks or {}) do
            if rank.spellId == event.spellId and rank.rankNumber == event.rankNumber
                and rank.characterLevel == event.characterLevel and rank.proficiency == event.proficiency then
                matched = true
            end
        end
        if not matched then return nil end
        events[#events + 1] = { abilityId = event.abilityId, spellId = event.spellId,
            rankNumber = event.rankNumber, characterLevel = event.characterLevel, proficiency = event.proficiency }
    end
    return { available = value.available, total = value.total, events = events }
end

local function MasteryHistory(value, abilities)
    if type(value) ~= "table" or type(value.available) ~= "boolean" or not Counter(value.total)
        or type(value.events) ~= "table" or #value.events > 32 then return nil end
    local expected = #value.total <= 2 and math.min(tonumber(value.total), 32) or 32
    if not value.available and (value.total ~= "0" or #value.events ~= 0) then return nil end
    if value.available and #value.events ~= expected then return nil end
    local count = 0
    for key in pairs(value.events) do
        if not Integer(key, 1, #value.events) then return nil end
        count = count + 1
    end
    if count ~= #value.events then return nil end
    local byId, events, seen = {}, {}, {}
    for _, ability in ipairs(abilities) do byId[ability.abilityId] = ability end
    for _, event in ipairs(value.events) do
        if type(event) ~= "table" or not Integer(event.abilityId, 1, 4294967295)
            or not Integer(event.ordinal, 1, 8) then return nil end
        local identity = event.abilityId .. ":" .. event.ordinal
        if seen[identity] then return nil end
        seen[identity] = true
        local ability = byId[event.abilityId]
        local reward = ability and ability.kind == 2 and ability.rewards[event.ordinal]
        if not reward or event.characterLevel ~= reward.characterLevel or event.proficiency ~= reward.proficiency
            or (event.healingBonusBasisPoints or 0) ~= reward.healingBonusBasisPoints
            or (event.damageBonusBasisPoints or 0) ~= reward.damageBonusBasisPoints then return nil end
        events[#events + 1] = { abilityId = event.abilityId, ordinal = event.ordinal,
            characterLevel = event.characterLevel, proficiency = event.proficiency,
            healingBonusBasisPoints = event.healingBonusBasisPoints or 0,
            damageBonusBasisPoints = event.damageBonusBasisPoints or 0 }
    end
    return { available = value.available, total = value.total, events = events }
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
    if snapshot.realmMaximumLevel ~= nil and (snapshot.schemaVersion ~= 4
        or not Integer(snapshot.realmMaximumLevel, 1, 255)) then return nil, "Invalid realm level cap" end
    local session = snapshot.schemaVersion >= 2 and Session(snapshot.session) or nil
    if snapshot.schemaVersion >= 2 and not session then return nil, "Incomplete session progress" end
    if snapshot.schemaVersion == 1 and snapshot.session ~= nil then return nil, "Unexpected session progress" end
    local result = { schemaVersion = snapshot.schemaVersion, session = session, revision = snapshot.revision,
        classId = snapshot.classId, generation = snapshot.schemaVersion == 4 and snapshot.generation or nil,
        characterLevel = snapshot.characterLevel, realmMaximumLevel = snapshot.realmMaximumLevel, abilities = {} }
    local seen = {}
    local rankCount = 0
    local rewardCount = 0
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
        rewardCount = rewardCount + (ability.rewards and #ability.rewards or 0)
        if rewardCount > 512 then return nil, "Mastery roadmap is too large" end
        seen[ability.abilityId] = true
        result.abilities[#result.abilities + 1] = ability
    end
    if snapshot.learning ~= nil then
        if snapshot.schemaVersion ~= 4 then return nil, "Unexpected session learning history" end
        result.learning = Learning(snapshot.learning, result.abilities)
        if not result.learning then return nil, "Invalid session learning history" end
    end
    if snapshot.mastery ~= nil then
        if snapshot.schemaVersion ~= 4 then return nil, "Unexpected mastery history" end
        result.mastery = MasteryHistory(snapshot.mastery, result.abilities)
        if not result.mastery then return nil, "Invalid mastery history" end
    end
    return result
end

function Model.SessionMasteries(snapshot, abilityId)
    local result = {}
    if not snapshot.mastery or not snapshot.mastery.available then return result end
    for _, event in ipairs(snapshot.mastery.events) do
        if event.abilityId == abilityId then result[#result + 1] = event end
    end
    return result
end

function Model.SessionLearns(snapshot, abilityId)
    local result = {}
    if not snapshot.learning or not snapshot.learning.available then return result end
    for _, event in ipairs(snapshot.learning.events) do
        if event.abilityId == abilityId then result[#result + 1] = event end
    end
    return result
end

local acquisitionLabels = { "Class progression", "Talent", "Specialization", "Ability item", "Class trainer" }
local acquisitionSources = { "class progression", "the appropriate talent",
    "your specialization", "the appropriate ability item", "your class trainer" }

function Model.AcquisitionText(ability) return acquisitionLabels[ability.acquisitionSource] end

local function LearnText(source)
    return "Learn through " .. (acquisitionSources[source] or "your normal ability source") .. "."
end

function Model.IsFixed(ability)
    return ability.kind == 3 or ability.availability == 6
end

function Model.IsMastery(ability) return ability.kind == 2 end

function Model.PracticePaused(ability)
    return ability.availability == 2 or ability.availability == 3
        or (ability.availability == 4 and ability.route == 13 and ability.buffState ~= 3)
end

function Model.Practicing(ability)
    return ability.availability == 4 and not Model.PracticePaused(ability)
end

function Model.NextMastery(ability)
    for _, reward in ipairs(ability.rewards or {}) do
        if reward.state ~= 1 then return reward end
    end
end

function Model.NextMilestone(ability) return ability.nextRank or Model.NextMastery(ability) end

local function HealingBonusText(basisPoints)
    local bonus = string.format("%.2f", basisPoints / 100):gsub("0+$", ""):gsub("%.$", "")
    return "+" .. bonus .. "%"
end

function Model.MasteryBonusAmount(reward)
    return math.max(reward.healingBonusBasisPoints or 0, reward.damageBonusBasisPoints or 0)
end

function Model.MasteryEffectText(reward)
    return (reward.damageBonusBasisPoints or 0) > 0 and "damage" or "healing"
end

function Model.CurrentMasteryText(ability, saved)
    if not Model.IsMastery(ability) then return "" end
    local prefix = saved and "Saved benefit: " or "Current benefit: "
    if ability.learnedRank == 0 then return prefix .. "learn the ability first." end
    if ability.availability == 2 then return prefix .. "paused; prerequisites missing." end
    if ability.availability == 3 then return prefix .. "paused; character level required." end
    local earned
    for _, reward in ipairs(ability.rewards or {}) do
        if reward.state == 1 then earned = reward end
    end
    return prefix .. (earned and (HealingBonusText(Model.MasteryBonusAmount(earned))
        .. " " .. Model.MasteryEffectText(earned) .. " in qualifying PvE.") or "none earned yet.")
end

function Model.BeyondRealmLevel(required, realmMaximumLevel, characterLevel)
    return realmMaximumLevel and required > realmMaximumLevel and characterLevel and characterLevel < required
end

function Model.LevelText(required, realmMaximumLevel, characterLevel)
    return "Character level " .. required .. (Model.BeyondRealmLevel(required, realmMaximumLevel, characterLevel)
        and (" (above realm cap " .. realmMaximumLevel .. ")") or "")
end

function Model.TrainingCapText(cap, realmMaximumLevel, characterLevel)
    local level = Model.LevelText(cap.characterLevel, realmMaximumLevel, characterLevel)
    if Model.BeyondRealmLevel(cap.characterLevel, realmMaximumLevel, characterLevel) then
        return "More practice requires " .. level .. "; proficiency cap " .. cap.proficiency .. "."
    end
    return "More practice opens at " .. level .. " (cap " .. cap.proficiency .. ")."
end

function Model.MasteryText(reward, realmMaximumLevel, characterLevel, acquisitionSource)
    if not reward then return "Mastery complete. Only the highest earned benefit applies." end
    local benefit = HealingBonusText(Model.MasteryBonusAmount(reward)) .. " " .. Model.MasteryEffectText(reward)
        .. " in qualifying PvE combat."
    local requirement = Model.LevelText(reward.characterLevel, realmMaximumLevel, characterLevel)
        .. " · Proficiency " .. reward.proficiency
    if reward.state == 1 then return "Earned: " .. benefit .. "\n" .. requirement end
    local state = reward.state == 2 and LearnText(acquisitionSource)
        or reward.state == 3 and "Current acquisition requirements are not met."
        or reward.state == 5 and "Practice earned; waiting for character level."
        or reward.practice.status == 3 and "Practice requirement exceeds the current cap."
        or reward.practice.status == 1 and (reward.practice.uses .. " qualifying uses to the practice requirement.")
        or "Waiting for the remaining requirements."
    return benefit .. "\n" .. state .. "\n" .. requirement
end

function Model.ReplacementText(ability, saved)
    if not ability.replacementSpellId then return nil end
    local spell = type(GetSpellInfo) == "function" and GetSpellInfo(ability.replacementSpellId)
        or ("Ability " .. ability.replacementSpellId)
    return (saved and "Saved replacement: " or "Replaced by ") .. spell
        .. ".\nOriginal practice paused; progress retained."
end

function Model.PointText(ability, realmMaximumLevel, characterLevel)
    if ability.replacementSpellId then return Model.ReplacementText(ability) end
    local state = ability.availability
    if state == 1 then
        return LearnText(ability.acquisitionSource)
            .. (Model.IsFixed(ability) and " No practice required." or " Then begin practicing.")
    end
    if state == 2 then return "Current acquisition requirements are not met." end
    if state == 3 and Model.IsFixed(ability) then
        return "This ability requires a higher character level. No practice required."
    end
    if state == 3 then return ability.learnedRank > 0 and "Practice requires a higher character level."
        or "This ability unlocks at a higher character level." end
    if state == 5 then
        if not Model.NextMilestone(ability) then
            return Model.IsMastery(ability) and "Mastery complete. Only the highest earned benefit applies."
                or "Training complete. All defined ranks learned."
        end
        if ability.nextTrainingCap then
            return "Current cap reached. "
                .. Model.TrainingCapText(ability.nextTrainingCap, realmMaximumLevel, characterLevel)
        end
        return "Current proficiency cap reached. Check the next milestone for remaining requirements."
    end
    if state == 6 then return "Fixed ability — no practice required." end
    if ability.nextPoint.status == 1 then
        local uses = ability.nextPoint.uses
        return uses .. (uses == "1" and " qualifying use" or " qualifying uses") .. " to the next proficiency point."
    end
    return "Progress forecast unavailable."
end

function Model.RankText(rank, fixed, realmMaximumLevel, characterLevel, acquisitionSource)
    if fixed then
        if not rank then return "This ability works at full effectiveness without practice." end
        local requirement = Model.LevelText(rank.characterLevel, realmMaximumLevel, characterLevel)
            .. " - No practice required."
        local state = rank.state == 1 and "Learned." or rank.state == 3 and "Normal acquisition prerequisites required."
            or rank.state == 5 and "Waiting for character level." or LearnText(acquisitionSource)
        return state .. "\n" .. requirement
    end
    if not rank then return "All currently defined ranks learned." end
    local requirement = Model.LevelText(rank.characterLevel, realmMaximumLevel, characterLevel)
        .. " · Proficiency " .. rank.proficiency
    if rank.state == 1 then return "Learned.\n" .. requirement end
    if rank.state == 2 then return LearnText(acquisitionSource) .. "\n" .. requirement end
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

function Model.CatchupText(ability, saved)
    if not ability.catchup then return nil end
    local prefix = saved and "Saved catch-up: " or "Catch-up: "
    if Model.Practicing(ability) then
        return prefix .. (ability.catchup.boosted and (ability.catchup.multiplier .. "x training is active.")
            or "normal training rate.")
    end
    if ability.availability == 5 then return prefix .. "inactive at the current cap." end
    if Model.PracticePaused(ability) then
        if ability.availability == 4 and ability.catchup.boosted then
            return prefix .. ability.catchup.multiplier .. "x rate available when buff practice resumes."
        end
        return prefix .. "paused with training."
    end
    return prefix .. "learn this ability first; the boost requires a gap of "
        .. ability.catchup.gap .. " proficiency behind the current cap."
end

function Model.BuffStateText(ability, saved)
    if ability.route ~= 13 then return nil end
    local states = {
        [1] = "Cast your own buff to earn practice.",
        [2] = "Reapply your buff to earn practice.",
        [3] = "Your buff is ready for combat practice.",
        [4] = "Buff practice requirements are unavailable.",
        [5] = "Buff effect unavailable or suppressed; practice paused."
    }
    local text = states[ability.buffState]
    if ability.buffState == 3 and ability.availability == 5 then
        text = "Owned buff active; current cap reached."
    end
    return text and ((saved and "Saved update: " or "Last update: ") .. text) or nil
end

function Model.PracticeRules(ability, saved)
    if ability.replacementSpellId then
        return Model.ReplacementText(ability) .. "\n\nUse the replacement from your spellbook."
            .. " The original ability can resume practice when it is available again."
    end
    if Model.IsFixed(ability) then
        return "This ability has no practice levels. " .. LearnText(ability.acquisitionSource)
    end
    local ruleSet = Integer(ability.ruleSet, 1, 10) and
        (ability.ruleSet >= 9 and 9 or ability.ruleSet >= 7 and 7 or ((ability.ruleSet - 1) % 3 + 1)) or nil
    if not ruleSet then
        return "Practice rules are unavailable in this update. Refresh to request the current rules."
    end
    local rules = {
        [13] = "Keep this buff active on yourself from your own cast and use learned abilities that deal direct damage"
            .. " to a level-appropriate PvE opponent or restore missing health in a qualifying PvE fight."
            .. " Your owned buff must be valid when the combat cast begins and when its result qualifies."
            .. " Its supported buff effect must be active and positive; a stronger exclusive effect prevents practice."
            .. " Equal-strength exclusive effects remain eligible."
            .. " Paired attack-power buffs require both their melee and ranged effects to remain active."
            .. " Mana regeneration buffs also require an active mana resource and available native regeneration."
            .. " One combat cast can earn one use for this buff, with at least five seconds between counted uses."
            .. " Supported buffs progress independently; a combat cast can practice more than one active buff."
            .. " Native buff replacement rules still apply; a replaced buff pauses without losing progress."
            .. " Applying or refreshing the buff, auto-attacks and triggered helper spells earn no buff practice."
            .. " Other players' actions do not count. Reapply your buff after login or a class or specialization change.",
        [11] = "Deal direct damage or newly stun a live, level-appropriate PvE opponent with the learned ability."
            .. " Refreshes and already stunned enemies do not earn control credit."
            .. " Damage and control share one award for the original cast.",
        [12] = "Deal supported periodic damage or newly root a live, level-appropriate PvE opponent."
            .. " Refreshes, already immobilized enemies and roots suppressed by a stun do not earn control credit."
            .. " Damage ticks and control share one award for the original cast.",
        [10] = "Newly make a live, level-appropriate PvE opponent flee with the learned ability."
            .. " Refreshes, already fleeing enemies and casts prevented from taking control do not count."
            .. " Each original cast can earn one award.",
        [1] = "Deal damage to a level-appropriate PvE opponent with the learned ability.",
        [2] = "Restore missing health on a friendly unit fighting a live, level-appropriate PvE opponent."
            .. " Full overhealing does not count.",
        [3] = "Actually stop a cast by a live, level-appropriate PvE opponent. An idle target does not count.",
        [4] = "Successfully remove an aura. Offensive dispels require a level-appropriate PvE opponent;"
            .. " defensive dispels require a friendly unit in a qualifying PvE encounter.",
        [5] = "Successfully steal a beneficial aura from a live, level-appropriate PvE opponent.",
        [8] = "Deal direct damage or actually stop a cast by a level-appropriate PvE opponent."
            .. " Damage and interruption share one award for the original cast. An idle, undamaged target does not count.",
        [9] = "Deal direct damage to a level-appropriate PvE opponent or successfully remove an aura"
            .. " in a qualifying PvE encounter. Offensive dispels require an eligible opponent; defensive dispels"
            .. " require a friendly unit in the encounter. Damage and dispelling share one award for the original cast.",
        [7] = "Restore missing health in a qualifying PvE fight, or absorb actual damage from a level-appropriate"
            .. " PvE opponent with this ability's shield on a friendly unit."
            .. " Applying an unused shield or fully overhealing alone does not count."
            .. " Healing and absorption share one award for the original cast.",
    }
    local rule = rules[ability.route]
    if not rule then return "Practice rules are unavailable in this update." end
    local buffState = Model.BuffStateText(ability, saved)
    if buffState then rule = buffState .. "\n\n" .. rule end
    if ruleSet == 9 then
        rule = "Capture a new corpse from a level-appropriate hostile NPC and restore missing health or gain a Reaped Soul."
            .. " Post-combat recovery counts. Players, pets, training dummies and gray opponents do not count."
            .. " Capturing a corpse without healing or gaining a soul earns no practice."
            .. " Each original cast earns at most one award; the native once-per-corpse rule remains."
    elseif (ability.abilityId == 706589 or ability.abilityId == 803667) and ability.route == 13 then
        rule = "Keep your own Mark active and use a learned ability for useful damage or healing"
            .. " in a qualifying PvE fight. Both its stat and resistance effects must remain active and useful."
            .. " Casting another Mark replaces your previous Mark and pauses its practice."
            .. " Applying or refreshing the buff earns no practice."
            .. " One original ability cast earns one use, with at least five seconds between counted uses."
    elseif ability.abilityId == 560294 and ability.route == 13 then
        rule = "Keep your own Spirit Wuju active and use a learned ability for useful damage or healing"
            .. " in a qualifying PvE fight. Both Spirit and magic resistance effects must remain active and useful."
            .. " Applying or refreshing the buff earns no practice."
            .. " One original ability cast earns one use, with at least five seconds between counted uses."
    elseif (ability.abilityId == 572384 or ability.abilityId == 800197 or ability.abilityId == 800266
        or ability.abilityId == 706742) and ability.route == 13 then
        rule = "Keep your own attack-power buff active and land a learned melee or ranged damage ability"
            .. " on a level-appropriate PvE opponent."
            .. " Both its melee and ranged effects must remain active and useful."
            .. " Unrelated spell damage, healing, buff application and auto-attacks earn no practice."
            .. " One original ability cast earns one use, with at least five seconds between counted uses."
    elseif ability.abilityId == 807942 and ability.route == 2 and ability.kind == 2 then
        rule = "Restore your missing health with Fel Bargain during an eligible PvE fight."
            .. " Energy spent without actual healing earns no practice."
            .. " One original cast earns at most one award; the native Energy cost and cooldown remain."
    elseif ability.abilityId == 801901 and ability.route == 1 then
        rule = "Land a Twin Slice weapon hit on a level-appropriate PvE opponent."
            .. " The two weapon hits share one practice award for your original cast."
            .. " Felfury generation and independently cast helpers do not earn practice."
    elseif ruleSet == 7 then
        rule = "Earn practice when this ability's delayed damage lands on a level-appropriate PvE opponent."
            .. " Applying the ability and the enemy's casts do not earn extra practice."
            .. " One original cast earns at most one award."
    elseif ruleSet == 3 then
        rule = "Drain mana from a live, level-appropriate PvE opponent while this ability restores your missing health."
            .. " You must be in a qualifying PvE fight. No mana drained or full overhealing does not count."
            .. " Drain-and-heal ticks count once for your original cast."
    elseif ability.route == 1 or ability.route == 2 then
        rule = rule .. (ruleSet == 2 and
            (ability.route == 1 and
                " Supported damage-over-time and health-leech damage ticks can count once for the original cast."
                or " Supported healing-over-time ticks can count once for the original cast.")
            or " Only direct damage or healing counts in the current rules.")
    end
    if Model.IsMastery(ability) then
        rule = rule .. " Mastery improves this ability's " .. (ability.route == 1 and "damage" or "healing")
            .. (ruleSet == 9 and " when recovering health from eligible NPC corpses."
                or " in the same qualifying PvE encounters.")
            .. " Only the highest earned benefit applies; mastery benefits do not add together."
    end
    if ability.catchup then
        rule = rule .. "\n\nCatch-up grants " .. ability.catchup.multiplier .. "x practice while this ability is "
            .. ability.catchup.gap .. " or more proficiency behind its current cap."
            .. " The boost ends when the gap falls below " .. ability.catchup.gap .. "."
            .. " Uses-remaining forecasts include the change in rate."
        if Model.Practicing(ability) then
            rule = rule .. (ability.catchup.boosted and " Catch-up is active." or " Normal training rate is active.")
        elseif Model.PracticePaused(ability) then
            rule = rule .. " Training is paused; the forecast counts qualifying uses after practice resumes."
        end
    end
    return rule .. "\n\nOpponents that are too low level, players, player-controlled units, pets, totems,"
        .. " critters and training dummies do not qualify."
        .. "\n\nOnly your learned ability casts requested through your client can count."
        .. " Triggered casts, item casts, script-created spells and aura-triggered helpers do not count."
        .. " One award per original cast, regardless of targets, ticks or removals. Practice stops at your current cap."
end
