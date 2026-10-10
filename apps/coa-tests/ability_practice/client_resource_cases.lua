local Wire, Model, API = HXCAbilityPracticeWire, HXCAbilityPracticeModel, HXCAbilityPractice
local count = 0
for _, lines in ipairs(EncodedResourcePracticeSnapshots) do
    Wire.Reset()
    local result
    for index, line in ipairs(lines) do result = Wire.Accept(line, index / 100, 0) end
    assert(result and result.schemaVersion == 6)
    local normalized = assert(Model.Validate(result))
    assert(API.ApplyServerSnapshot(result))
    local ability = normalized.abilities[1]
    assert(ability.kind == 2 and ability.route == 14 and #ability.rewards == 3)
    assert(#ability.sharedAbilities == 0)
    assert(string.find(Model.PracticeRules(ability), "actual mana drained", 1, true))
    assert(string.find(Model.PracticeRules(ability), "full mana pool", 1, true))
    for _, reward in ipairs(ability.rewards) do
        assert(reward.resourceDrainBonusBasisPoints > 0)
        assert(reward.healingBonusBasisPoints == 0 and reward.damageBonusBasisPoints == 0)
        assert(Model.MasteryEffectText(reward) == "mana drain")
    end
    for _, event in ipairs(normalized.mastery.events) do
        assert(event.resourceDrainBonusBasisPoints > 0)
        assert(event.healingBonusBasisPoints == 0 and event.damageBonusBasisPoints == 0)
    end
    for _, legacy in ipairs({ 4, 5 }) do
        Wire.Reset()
        local invalid
        for index, line in ipairs(lines) do
            invalid = Wire.Accept(string.gsub(line, "^B|6|", "B|" .. legacy .. "|"), index / 100, 0)
        end
        assert(not invalid)
    end
    count = count + 1
end
assert(count == 8)
print("PASS: 8 schema 6 resource mastery snapshots, history, labels, catch-up and legacy rejection")
