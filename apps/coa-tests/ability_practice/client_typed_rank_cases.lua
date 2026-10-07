local Wire = HXCAbilityPracticeWire
local Model = HXCAbilityPracticeModel
local API = HXCAbilityPractice
local classes = {}
local count = 0
local kinds = { 0, 0, 0 }
for _, lines in ipairs(EncodedTypedPracticeSnapshots) do
    Wire.Reset()
    local result
    for index, line in ipairs(lines) do
        result = Wire.Accept(line, index / 100, 0)
        if index < #lines then assert(not result) end
    end
    assert(result and result.schemaVersion == 4 and result.generation == "777")
    assert(Model.Validate(result))
    assert(API.ApplyServerSnapshot(result))
    assert(not API.ApplyServerSnapshot(result))
    classes[result.classId] = true
    local ability = result.abilities[1]
    kinds[ability.kind] = kinds[ability.kind] + 1
    if ability.kind == 1 then assert(ability.catchup) end
    if ability.kind == 2 then
        assert(Model.IsMastery(ability) and #ability.rewards == 3)
        if ability.abilityId == 712483 then
            assert(ability.ruleSet == 7 or ability.ruleSet == 8)
            assert(string.find(Model.PracticeRules(ability), "delayed damage", 1, true))
            local ruleSet = ability.ruleSet
            ability.ruleSet = 11
            assert(not Model.Validate(result))
            ability.ruleSet = ruleSet == 7 and 8 or 7
            assert(not Model.Validate(result))
            ability.ruleSet = ruleSet
            local route = ability.route
            ability.route = 2
            assert(not Model.Validate(result))
            ability.route = route
            assert(Model.Validate(result))
        end
        if ability.abilityId == 561289 then
            assert(ability.ruleSet == 9 or ability.ruleSet == 10)
            assert(string.find(Model.PracticeRules(ability), "Reaped Soul", 1, true))
            assert(string.find(Model.PracticeRules(ability), "Post-combat recovery counts", 1, true))
            assert(string.find(Model.PracticeRules(ability), "recovering health from eligible NPC corpses", 1, true))
            local route = ability.route
            ability.route = 1
            assert(not Model.Validate(result))
            ability.route = route
            local ruleSet = ability.ruleSet
            ability.ruleSet = ruleSet == 9 and 10 or 9
            assert(not Model.Validate(result))
            ability.ruleSet = ruleSet
            assert(Model.Validate(result))
        end
        for _, reward in ipairs(ability.rewards) do
            if reward.characterLevel <= result.characterLevel and reward.proficiency <= ability.proficiency then
                assert(reward.state == 1)
            end
        end
    end
    if ability.kind == 3 then
        assert(Model.IsFixed(ability) and not Model.Practicing(ability))
        assert(ability.proficiency == 1 and ability.points == 0 and ability.pointsPerLevel == 0)
        assert(not ability.nextTrainingCap and #ability.rewards == 0)
    end
    assert(type(Model.PointText(ability, result.realmMaximumLevel, result.characterLevel)) == "string")
    if ability.kind ~= 3 and ability.proficiency > ability.cap then
        assert(ability.availability == 5 and ability.nextPoint.status == 3)
        assert(not Model.Practicing(ability))
    end
    if ability.route == 13 and ability.availability == 4 and ability.buffState ~= 3 then
        assert(Model.PracticePaused(ability) and not Model.Practicing(ability))
    end
    count = count + 1
end
assert(count == 772)
assert(kinds[1] == 456 and kinds[2] == 40 and kinds[3] == 276)
for classId = 12, 32 do assert(classes[classId]) end
print("PASS: 772 typed snapshots across 21 classes: 456 ranked, 40 mastery, 276 fixed and menu rendering")
