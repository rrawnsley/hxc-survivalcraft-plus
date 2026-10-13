local Wire = HXCAbilityPracticeWire
local Model = HXCAbilityPracticeModel
local count = 0
for _, lines in ipairs(EncodedSharedPracticeSnapshots) do
    Wire.Reset()
    local result
    for index, line in ipairs(lines) do
        local reason
        result, reason = Wire.Accept(line, index / 100, 0)
        assert(not reason, reason)
    end
    assert(result and result.schemaVersion == 5)
    local ability = result.abilities[1]
    assert(#ability.sharedAbilities == 1)
    local shared = ability.sharedAbilities[1]
    assert(shared.spellId == 680308 or shared.spellId == 501330 or shared.spellId == 501331
        or shared.spellId == 501332 or shared.spellId == 501333 or shared.spellId == 501334 or shared.spellId == 501336
        or shared.spellId == 712458 or shared.spellId == 680872 or shared.spellId == 800195
        or shared.spellId == 523513 or shared.spellId == 680294
        or shared.spellId == 523495 or shared.spellId == 523510 or shared.spellId == 803657
        or shared.spellId == 680303 or shared.spellId == 681442
        or shared.spellId == 572390 or shared.spellId == 575045 or shared.spellId == 681160
        or shared.spellId == 572396 or shared.spellId == 680307
        or shared.spellId == 582536 or shared.spellId == 680280 or shared.spellId == 582261
        or shared.spellId == 575846 or shared.spellId == 578316 or shared.spellId == 680291
        or shared.spellId == 573348 or shared.spellId == 680301
        or shared.spellId == 575842 or shared.spellId == 578130 or shared.spellId == 680298
        or shared.spellId == 570756 or shared.spellId == 572817 or shared.spellId == 680310
        or shared.spellId == 803665 or shared.spellId == 680315 or shared.spellId == 561241 or shared.spellId == 561242 or shared.spellId == 561243)
    assert(string.find(Model.SharedAbilityText(ability, shared, 80, result.characterLevel),
        "no separate practice counter", 1, true))
    HXCAbilityPractice.Reset()
    assert(HXCAbilityPractice.ApplySnapshot(result))
    if ability.kind == 3 and shared.state ~= 1 then assert(Model.NextMilestone(ability).spellId == shared.spellId) end
    local button
    for _, widget in ipairs(MockWidgets) do
        if widget.shown and widget.text == "All milestones" then button = widget end
    end
    assert(button and button.scripts.OnClick)
    button.scripts.OnClick()
    for _, widget in ipairs(MockWidgets) do
        if widget.scripts.OnMouseWheel then widget.scripts.OnMouseWheel(widget, -64) end
    end
    local found = false
    for _, widget in ipairs(MockWidgets) do
        if widget.shown and widget.text == "Shared - Test Ability " .. shared.spellId then found = true end
    end
    assert(found)
    local equivalent = shared.equivalentSpellId
    shared.equivalentSpellId = 999999
    assert(not Model.Validate(result))
    shared.equivalentSpellId = equivalent
    local proficiency = shared.proficiency
    shared.proficiency = proficiency + 1
    assert(not Model.Validate(result))
    shared.proficiency = proficiency
    assert(Model.Validate(result))
    Wire.Reset()
    local _, reason = Wire.Accept("B|9|1|13|60|0|779|80", 0, 0)
    assert(reason == "Unsupported snapshot header")
    local expanded = {}
    for _, line in ipairs(lines) do
        local revision, body = string.match(line, "^D|(%d+)|(.+)$")
        if body then
            for compact in string.gmatch(body .. ";", "([^;]+);") do
                local kind, fields = string.match(compact, "^(%a)|(.+)$")
                expanded[#expanded + 1] = kind .. "|" .. revision .. "|" .. fields
            end
        else expanded[#expanded + 1] = line end
    end
    for _, omitted in ipairs({ "V", "W" }) do
        Wire.Reset()
        local failure
        for index, line in ipairs(expanded) do
            if string.sub(line, 1, 1) ~= omitted then
                _, failure = Wire.Accept(line, index / 100, 0)
            end
        end
        assert(failure == (omitted == "V" and "Missing shared ability count" or "Incomplete shared abilities"))
    end
    Wire.Reset()
    for index, line in ipairs(expanded) do
        Wire.Accept(line, index / 100, 0)
        if string.sub(line, 1, 1) == "W" then
            _, reason = Wire.Accept(line, index / 100, 0)
            assert(reason == "Duplicate shared ability")
            break
        end
    end
    count = count + 1
end
assert(count == 123)
print("PASS: 102 shared buff snapshots, exact parent forecasts, model rejection and menu rendering")
