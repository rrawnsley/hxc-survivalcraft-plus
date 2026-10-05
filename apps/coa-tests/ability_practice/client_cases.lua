local Model = HXCAbilityPracticeModel
local API = HXCAbilityPractice
local function Fixture()
    return { schemaVersion = 1, revision = 1, classId = 24, characterLevel = 24, abilities = {
        { abilityId = 1001, displaySpellId = 102, learnedRank = 2, proficiency = 23, points = 18,
          cap = 60, pointsPerLevel = 30, availability = 4, nextPoint = { status = 1, uses = "12" },
          nextRank = { spellId = 103, rankNumber = 3, characterLevel = 24, proficiency = 40, state = 4,
                       practice = { status = 1, uses = "492" } } }
    } }
end
local fixture = Fixture()
local validated = assert(Model.Validate(fixture))
assert(Model.PointText(validated.abilities[1]) == "12 qualifying uses to the next proficiency point.")
assert(string.find(Model.RankText(validated.abilities[1].nextRank), "492 qualifying uses", 1, true))
fixture.abilities[1].points = 19
assert(validated.abilities[1].points == 18)
fixture = Fixture()
fixture.abilities[1].nextPoint.uses = "9007199254740993"
assert(string.find(Model.PointText(assert(Model.Validate(fixture)).abilities[1]),
    "9007199254740993", 1, true))

local mutations = {
    function(s) s.schemaVersion = 2 end,
    function(s) s.revision = 0 end,
    function(s) s.characterLevel = 0 end,
    function(s) s.classId = 0 end,
    function(s) s.abilities[2] = s.abilities[1] end,
    function(s) s.abilities.extra = {} end,
    function(s) s.abilities[3] = s.abilities[1] end,
    function(s) s.abilities[1].points = 30 end,
    function(s) s.abilities[1].pointsPerLevel = 0 end,
    function(s) s.abilities[1].availability = 0 end,
    function(s) s.abilities[1].nextPoint.uses = 12 end,
    function(s) s.abilities[1].nextPoint.uses = "012" end,
    function(s) s.abilities[1].nextPoint.uses = "18446744073709551616" end,
    function(s) s.abilities[1].nextPoint.uses = "0" end,
    function(s) s.abilities[1].nextPoint.status = 3 end,
    function(s) s.abilities[1].nextRank.state = 8 end,
    function(s) s.abilities[1].nextRank.practice.uses = "invalid" end,
}
for _, mutate in ipairs(mutations) do
    local bad = Fixture()
    mutate(bad)
    assert(not Model.Validate(bad))
end

local capped = Fixture()
capped.abilities[1].availability = 5
capped.abilities[1].nextPoint = { status = 3, uses = "0" }
capped.abilities[1].proficiency = 80
assert(Model.Validate(capped))
assert(string.find(Model.PointText(capped.abilities[1]), "current proficiency cap", 1, true))
local fixed = Fixture()
fixed.abilities[1].availability = 6
fixed.abilities[1].pointsPerLevel = 0
fixed.abilities[1].points = 0
fixed.abilities[1].nextPoint = { status = 0, uses = "0" }
fixed.abilities[1].nextRank = nil
assert(Model.Validate(fixed))
assert(Model.PointText(fixed.abilities[1]) == "Fixed ability — no practice required.")

assert(API.ApplySnapshot(Fixture()))
assert(not API.ApplySnapshot(Fixture()))
local newer = Fixture()
newer.revision = 2
assert(API.ApplySnapshot(newer))
local wrongClass = Fixture()
wrongClass.revision = 3
wrongClass.classId = 25
assert(not API.ApplySnapshot(wrongClass))
assert(not HXCAbilityPracticePanel:IsShown())
API.Toggle()
assert(HXCAbilityPracticePanel:IsShown())
API.Toggle()
assert(not HXCAbilityPracticePanel:IsShown())
assert(SlashCmdList.HXCABILITYPRACTICE == API.Toggle)
assert(UISpecialFrames[1] == "HXCAbilityPracticePanel")
print("PASS: Lua 5.1 addon model, large exact-use strings, invalid snapshots, stale updates and menu smoke")
