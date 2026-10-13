local count = 0
for _, lines in ipairs(EncodedUtilityMasterySnapshots) do
    HXCAbilityPracticeWire.Reset()
    local snapshot
    for _, line in ipairs(lines) do
        local result, reason = HXCAbilityPracticeWire.Accept(line, 0, 0, nil)
        assert(not reason, reason)
        snapshot = result or snapshot
    end
    assert(snapshot and snapshot.schemaVersion == 8 and #snapshot.abilities == 1)
    local ability = snapshot.abilities[1]
    assert(ability.kind == 2 and (ability.route == 16 or ability.route == 17))
    assert(#ability.rewards == 3 and HXCAbilityPracticeModel.MasteryBonusAmount(ability.rewards[3]) == 200)
    local label = HXCAbilityPracticeModel.MasteryEffectText(ability.rewards[3])
    assert(label == "cooldown efficiency" or label == "resource efficiency")
    count = count + 1
end
assert(count == 19)
print("PASS: 19 schema8 utility mastery snapshots retain accurate benefits and roadmaps")
