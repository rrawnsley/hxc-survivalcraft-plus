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
assert(count == 745)
assert(kinds[1] == 453 and kinds[2] == 28 and kinds[3] == 264)
for classId = 12, 32 do assert(classes[classId]) end
print("PASS: 745 typed snapshots across 21 classes: 453 ranked, 28 mastery, 264 fixed and menu rendering")
