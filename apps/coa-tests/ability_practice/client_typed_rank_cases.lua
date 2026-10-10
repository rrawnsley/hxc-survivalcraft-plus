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
    if ability.abilityId == 520412 then
        assert(#ability.ranks == 6 and ability.route == 1)
        assert(string.find(Model.PracticeRules(ability), "all ticks and targets share your original ground cast", 1, true))
        assert(string.find(Model.PracticeRules(ability), "at least ten seconds apart", 1, true))
        assert(string.find(Model.PracticeRules(ability), "Rage cost", 1, true))
    end
    if ability.abilityId == 500402 then
        assert(#ability.ranks == 10 and ability.route == 1)
        assert(string.find(Model.PracticeRules(ability), "all three stones share your original cast", 1, true))
        assert(string.find(Model.PracticeRules(ability), "at least five seconds apart", 1, true))
        assert(string.find(Model.PracticeRules(ability), "Rage generation", 1, true))
    end
    if ability.abilityId == 572384 or ability.abilityId == 800197 or ability.abilityId == 800266 or ability.abilityId == 706742 then
        assert(ability.route == 13)
        assert(string.find(Model.PracticeRules(ability), "melee and ranged effects", 1, true))
    end
    if ability.abilityId == 570752 then
        assert(ability.route == 13)
        assert(string.find(Model.PracticeRules(ability), "armor, all five stats, and magic resistance effects", 1, true))
    end
    if ability.abilityId == 706589 or ability.abilityId == 803667 then
        assert(ability.route == 13)
        assert(string.find(Model.PracticeRules(ability), "stat and resistance effects", 1, true))
    end
    if ability.abilityId == 800852 then
        assert(ability.route == 13)
        assert(string.find(Model.PracticeRules(ability), "five-percent", 1, true))
        assert(string.find(Model.PracticeRules(ability), "Switching devotions pauses", 1, true))
        assert(string.find(Model.PracticeRules(ability), "receiving mana ticks earns no practice", 1, true))
    end
    if ability.abilityId == 523489 then
        assert(ability.route == 13)
        assert(string.find(Model.PracticeRules(ability), "armor and all five stat effects", 1, true))
        assert(string.find(Model.PracticeRules(ability), "native strongest-buff rule", 1, true))
    end
    if ability.abilityId == 707693 then
        assert(ability.route == 13)
        assert(string.find(Model.PracticeRules(ability), "spell power and Shadow resistance", 1, true))
    end
    if ability.abilityId == 560300 then
        assert(ability.route == 13)
        assert(string.find(Model.PracticeRules(ability), "Spirit and magic resistance effects", 1, true))
    end
    if ability.route == 13 and (ability.abilityId == 523478 or ability.abilityId == 523485
        or ability.abilityId == 803651) then
        assert(string.find(Model.PracticeRules(ability), "Every component must remain effective", 1, true))
        assert(string.find(Model.PracticeRules(ability), "greater versions share", 1, true))
        if ability.abilityId == 523478 then
            assert(string.find(Model.PracticeRules(ability), "Native armor varies", 1, true))
        end
    end
    if ability.abilityId == 561237 and ability.route == 13 then
        assert(string.find(Model.PracticeRules(ability), "greater version shares", 1, true))
    end
    if ability.abilityId == 561236 or ability.abilityId == 560295 then
        assert(ability.kind == 3)
        assert(string.find(Model.PracticeRules(ability), "same native benefit", 1, true))
    end
    if ability.abilityId == 706742 and ability.route == 13 then
        assert(string.find(Model.PracticeRules(ability), "Greater Power Module shares", 1, true))
        assert(string.find(Model.PracticeRules(ability), "Switching modules", 1, true))
    end
    if ability.abilityId == 807834 and ability.route == 13 then
        assert(string.find(Model.PracticeRules(ability), "slowing effect", 1, true))
        assert(string.find(Model.PracticeRules(ability), "currently unavailable", 1, true))
        assert(string.find(Model.PracticeRules(ability), "Switching tattoos pauses Frost practice", 1, true))
    end
    if ability.abilityId == 803748 and ability.route == 13 then
        assert(string.find(Model.PracticeRules(ability), "both harmful-effect duration reductions", 1, true))
        assert(string.find(Model.PracticeRules(ability), "stronger duration effects", 1, true))
    end
    if ability.abilityId == 801106 and ability.route == 13 then
        assert(string.find(Model.PracticeRules(ability), "15% critical damage", 1, true))
        assert(string.find(Model.PracticeRules(ability), "Switching tattoos pauses Fire practice", 1, true))
    end
    if ability.abilityId == 561260 and ability.route == 13 then
        assert(string.find(Model.PracticeRules(ability), "healing received bonus", 1, true))
        assert(string.find(Model.PracticeRules(ability), "increases magic damage taken", 1, true))
        assert(string.find(Model.PracticeRules(ability), "Buffing an ally alone", 1, true))
    end
    if ability.abilityId == 805381 then
        assert(ability.kind == 2 and ability.route == 1)
        assert(string.find(Model.PracticeRules(ability), "ten seconds", 1, true))
        assert(string.find(Model.PracticeRules(ability), "up to 2%", 1, true))
        assert(string.find(Model.PracticeRules(ability), "native slow stays unchanged", 1, true))
        assert(string.find(Model.PracticeRules(ability), "one upcoming mastery milestone", 1, true))
    end
    if ability.abilityId == 581314 and ability.route == 13 then
        assert(string.find(Model.PracticeRules(ability), "Stronger competing Nature resistance", 1, true))
        assert(string.find(Model.PracticeRules(ability), "other players' actions do not count", 1, true))
        assert(string.find(Model.PracticeRules(ability), "Greater Essence shares", 1, true))
        assert(string.find(Model.PracticeRules(ability), "character level 60", 1, true))
    end
    if ability.abilityId == 560316 then
        assert(ability.kind == 3)
        assert(string.find(Model.PracticeRules(ability), "character level 32", 1, true))
        assert(string.find(Model.PracticeRules(ability), "two minutes", 1, true))
        assert(string.find(Model.PracticeRules(ability), "cannot be used in combat", 1, true))
        assert(string.find(Model.PracticeRules(ability), "thirty-minute cooldown", 1, true))
        assert(string.find(Model.PracticeRules(ability), "earns no practice", 1, true))
        assert(not string.find(Model.PracticeRules(ability), "set your Hearthstone", 1, true))
    end
    if ability.abilityId == 561265 then
        assert(ability.kind == 3)
        assert(string.find(Model.PracticeRules(ability), "character level 60", 1, true))
        assert(string.find(Model.PracticeRules(ability), "100%", 1, true))
        assert(string.find(Model.PracticeRules(ability), "thirty seconds", 1, true))
        assert(string.find(Model.PracticeRules(ability), "early removal ends", 1, true))
        assert(string.find(Model.PracticeRules(ability), "earns no practice", 1, true))
    end
    if ability.abilityId == 805382 then
        assert(ability.kind == 3)
        assert(string.find(Model.PracticeRules(ability), "four-second enemy stun", 1, true))
        assert(string.find(Model.PracticeRules(ability), "earns no practice", 1, true))
    end
    if ability.abilityId == 807013 then
        assert(ability.kind == 3)
        assert(string.find(Model.PracticeRules(ability), "character level 40", 1, true))
        assert(string.find(Model.PracticeRules(ability), "root/snare immunity", 1, true))
        assert(string.find(Model.PracticeRules(ability), "six seconds", 1, true))
        assert(string.find(Model.PracticeRules(ability), "earns no practice", 1, true))
    end
    if ability.abilityId == 807828 then
        assert(ability.kind == 3)
        assert(string.find(Model.PracticeRules(ability), "Runeshroud form", 1, true))
        assert(string.find(Model.PracticeRules(ability), "three yards", 1, true))
        assert(string.find(Model.PracticeRules(ability), "sixty seconds", 1, true))
        assert(string.find(Model.PracticeRules(ability), "earns no practice", 1, true))
    end
    if ability.abilityId == 807823 then
        assert(ability.kind == 3)
        assert(string.find(Model.PracticeRules(ability), "Runeshroud form", 1, true))
        assert(string.find(Model.PracticeRules(ability), "movement speed increases by 20%", 1, true))
        assert(string.find(Model.PracticeRules(ability), "earns no practice", 1, true))
    end
    if ability.abilityId == 805380 then
        assert(ability.route == 1 and ability.kind == 1)
        assert(string.find(Model.PracticeRules(ability), "first useful tick", 1, true))
        assert(string.find(Model.PracticeRules(ability), "additional charges share one original cast", 1, true))
        assert(string.find(Model.PracticeRules(ability), "ten seconds", 1, true))
        assert(string.find(Model.PracticeRules(ability), "native levels 20, 34 and 50", 1, true))
        assert(string.find(Model.PracticeRules(ability), "silence duration remain", 1, true))
    end
    if ability.abilityId == 534803 then
        assert(ability.route == 1 and ability.kind == 1)
        assert(string.find(Model.PracticeRules(ability), "bonus Fire hit", 1, true))
        assert(string.find(Model.PracticeRules(ability), "ten seconds", 1, true))
        assert(string.find(Model.PracticeRules(ability), "Arming, refreshing, expiry", 1, true))
    end
    if ability.abilityId == 680389 and ability.route == 13 then
        assert(ability.route == 13)
        assert(string.find(Model.PracticeRules(ability), "armor must remain effective", 1, true))
        assert(string.find(Model.PracticeRules(ability), "currently unavailable", 1, true))
        assert(string.find(Model.PracticeRules(ability), "practice does not activate it", 1, true))
    end
    if ability.abilityId == 680282 and ability.route == 13 then
        assert(string.find(Model.PracticeRules(ability), "3% spell haste", 1, true))
        assert(string.find(Model.PracticeRules(ability), "Switching Aegis pauses", 1, true))
    end
    if ability.abilityId == 1119881 and ability.route == 13 then
        assert(string.find(Model.PracticeRules(ability), "Shadow resistance must remain effective", 1, true))
        assert(string.find(Model.PracticeRules(ability), "Receiving another player's aura earns no practice", 1, true))
    end
    if ability.abilityId == 801107 and ability.route == 13 then
        assert(string.find(Model.PracticeRules(ability), "character-level scaling", 1, true))
        assert(string.find(Model.PracticeRules(ability), "mana ticks gives no practice", 1, true))
    end
    if ability.abilityId == 801094 and ability.route == 13 then
        assert(string.find(Model.PracticeRules(ability), "armor and Nature resistance", 1, true))
        assert(string.find(Model.PracticeRules(ability), "Switching tattoos pauses Earth practice", 1, true))
    end
    if ability.abilityId == 807734 then
        assert(Model.IsFixed(ability) and #ability.ranks == 1 and ability.ranks[1].characterLevel == 14)
        local rules = Model.PracticeRules(ability)
        assert(string.find(rules, "for 250% of normal damage threat", 1, true))
        assert(string.find(rules, "until removed", 1, true))
        assert(string.find(rules, "casting it earns no practice", 1, true))
    end
    if ability.abilityId == 807432 then
        assert(Model.IsFixed(ability) and #ability.ranks == 1 and ability.ranks[1].characterLevel == 8)
        local rules = Model.PracticeRules(ability)
        assert(string.find(rules, "movement speed by 50% for ten seconds", 1, true))
        assert(string.find(rules, "Earthshaping interaction stay unchanged", 1, true))
        assert(string.find(rules, "Using it earns no practice", 1, true))
    end
    if ability.abilityId == 805919 then
        assert(Model.IsFixed(ability) and #ability.ranks == 1)
        assert(ability.ranks[1].characterLevel == 12)
        local rules = Model.PracticeRules(ability)
        assert(string.find(rules, "victim changes to you", 1, true))
        assert(string.find(rules, "attack intervals increase by 50%", 1, true))
        assert(string.find(rules, "auto-attack consumes the slow", 1, true))
        assert(string.find(rules, "using it earns no practice", 1, true))
    end
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
        if ability.abilityId == 810942 then
            assert(ability.route == 2 and (ability.ruleSet == 1 or ability.ruleSet == 4))
            assert(string.find(Model.PracticeRules(ability), "Energy spent without actual healing", 1, true))
            assert(string.find(Model.PracticeRules(ability), "One original cast earns at most one award", 1, true))
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
        if ability.abilityId == 804674 then
            assert(string.find(Model.PracticeRules(ability), "one native rank and no practice levels", 1, true))
            assert(string.find(Model.PracticeRules(ability), "60-second scouting channel", 1, true))
        end
        if ability.abilityId == 500288 then
            assert(string.find(Model.PracticeRules(ability), "one native rank and no practice levels", 1, true))
            assert(string.find(Model.PracticeRules(ability), "movement penalty", 1, true))
            assert(string.find(Model.PracticeRules(ability), "Palm Sigil gate", 1, true))
        end
        if ability.abilityId == 802630 then
            assert(#ability.ranks == 1 and ability.ranks[1].characterLevel == 32)
            assert(string.find(Model.PracticeRules(ability), "roots and snares", 1, true))
            assert(string.find(Model.PracticeRules(ability), "Refreshing it earns no practice", 1, true))
        end
        if ability.abilityId == 653022 or ability.abilityId == 653264 or ability.abilityId == 653218
            or ability.abilityId == 653222 or ability.abilityId == 653213 or ability.abilityId == 653265 then
            assert(#ability.ranks == 1)
            assert(string.find(Model.PracticeRules(ability), "one native rank and no practice levels", 1, true))
            assert(string.find(Model.PracticeRules(ability), "weapon to be equipped", 1, true))
            assert(string.find(Model.PracticeRules(ability), "Refreshing the enchant earns no practice", 1, true))
        end
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
assert(count == 959)
assert(kinds[1] == 552 and kinds[2] == 53 and kinds[3] == 354)
for classId = 12, 32 do assert(classes[classId]) end
print("PASS: 959 typed snapshots across 21 classes: 552 ranked, 53 mastery, 354 fixed and menu rendering")
