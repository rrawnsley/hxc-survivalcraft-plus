local Wire, Model, API = HXCAbilityPracticeWire, HXCAbilityPracticeModel, HXCAbilityPractice
local count = 0
for _, lines in ipairs(EncodedDebuffPracticeSnapshots) do
    Wire.Reset()
    local result
    for index, line in ipairs(lines) do result = Wire.Accept(line, index / 100, 0) end
    assert(result and result.schemaVersion == 7)
    local normalized = assert(Model.Validate(result))
    assert(API.ApplyServerSnapshot(result))
    local ability = normalized.abilities[1]
    assert(ability.kind == 1 and ability.route == 15 and #ability.ranks == 5)
    assert(string.find(Model.PracticeRules(ability), "actual attack power", 1, true))
    assert(string.find(Model.PracticeRules(ability), "Each original cast counts once", 1, true))
    assert(string.find(Model.PracticeRules(ability), "Refreshes without an additional reduction", 1, true))
    if count == 1 then assert(ability.nextRank.practice.uses == "90") end
    if count == 2 then assert(ability.nextRank.practice.uses == "1") end
    for _, legacy in ipairs({ 4, 5, 6 }) do
        Wire.Reset()
        local invalid
        for index, line in ipairs(lines) do
            invalid = Wire.Accept(string.gsub(line, "^B|7|", "B|" .. legacy .. "|"), index / 100, 0)
        end
        assert(not invalid)
    end
    local original = result.abilities[1].ruleSet
    result.abilities[1].ruleSet = 11
    assert(not Model.Validate(result))
    result.abilities[1].ruleSet = original
    count = count + 1
end
assert(count == 5)
print("PASS: 5 schema 7 debuff snapshots, exact forecasts, menu rendering and legacy rejection")
