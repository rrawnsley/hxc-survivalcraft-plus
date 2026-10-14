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
assert(string.find(Model.RankText(validated.abilities[1].nextRank),
    "Proficiency does not block learning.", 1, true))
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
assert(Model.PointText(capped.abilities[1]) ==
    "Current proficiency cap reached. Check the next milestone for remaining requirements.")
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

assert(not HXCAbilityPracticeTracker:IsShown())
API.Minimize()
assert(not HXCAbilityPracticePanel:IsShown() and HXCAbilityPracticeTracker:IsShown())
assert(API.IsShown())
assert(HXCAbilityPracticeTrackerRow1.ability.abilityId == 1001)
assert(HXCAbilityPracticeTrackerRow1.info.text == "Rank 2 - Proficiency 23/60")
assert(HXCAbilityPracticeTrackerRow1.uses.text == "12 qualifying uses to next point")
assert(HXCAbilityPracticeTrackerRow1.progress.value == 18/30)
HXCAbilityPracticeTrackerSmaller.scripts.OnClick()
assert(HXCAbilityPracticeTracker.scale == 0.9)
assert(API.SetTrackerScale(0.5))
HXCAbilityPracticeTrackerSmaller.scripts.OnClick()
assert(HXCAbilityPracticeTracker.scale == 0.5)
HXCAbilityPracticeTrackerBigger.scripts.OnClick()
assert(HXCAbilityPracticeTracker.scale == 0.6)
assert(API.SetTrackerScale(2) and HXCAbilityPracticeTracker.scale == 1.25)
assert(not API.SetTrackerScale("bad"))
assert(not API.SetTrackerScale(0/0))
assert(API.SetTrackerScale(0.75))
API.UpdateAge(0)
assert(HXCAbilityPracticeTracker.scale == 0.75)

local trackerUpdate = Fixture()
trackerUpdate.revision = 3
trackerUpdate.abilities[1].points = 19
trackerUpdate.abilities[1].nextPoint.uses = "11"
assert(API.ApplySnapshot(trackerUpdate))
assert(HXCAbilityPracticeTrackerRow1.uses.text == "11 qualifying uses to next point")
assert(HXCAbilityPracticeTrackerRow1.progress.value == 19/30)
API.SetSyncState("unavailable")
assert(HXCAbilityPracticeTrackerRow1.uses.text == "11 qualifying uses to next point")
API.Reset()
assert(HXCAbilityPracticeTracker:IsShown())
assert(not HXCAbilityPracticeTrackerRow1:IsShown())
assert(HXCAbilityPracticeTracker.scale == 0.75)
assert(API.ApplySnapshot(Fixture()))
API.Restore()
assert(HXCAbilityPracticePanel:IsShown() and not HXCAbilityPracticeTracker:IsShown())
API.Minimize()
API.CloseTracker()
assert(not API.IsShown())
API.Toggle()
API.Toggle()
API.Reset()
assert(API.ApplySnapshot(Fixture()))
local many = Fixture()
API.Reset()
HXCAbilityPracticePreferences["24"] = {}
for id = 1002, 1006 do
    many.abilities[#many.abilities + 1] = { abilityId = id, displaySpellId = id, learnedRank = 2,
        proficiency = 23, points = 18, cap = 60, pointsPerLevel = 30, availability = 4,
        nextPoint = { status = 1, uses = "9007199254740993" },
        nextRank = { spellId = id + 100, rankNumber = 3, characterLevel = 24, proficiency = 40,
            state = 4, practice = { status = 1, uses = "492" } } }
    HXCAbilityPracticePreferences["24"][tostring(id)] = true
end
assert(API.ApplySnapshot(many))
API.Minimize()
assert(HXCAbilityPracticeTrackerRow1.ability.abilityId == 1002)
assert(HXCAbilityPracticeTrackerRow1.uses.text == "9007199254740993 qualifying uses to next point")
assert(HXCAbilityPracticeTrackerRow4.ability.abilityId == 1005)
HXCAbilityPracticeTracker.scripts.OnMouseWheel(HXCAbilityPracticeTracker, -1)
assert(HXCAbilityPracticeTrackerRow1.ability.abilityId == 1003)
assert(HXCAbilityPracticeTrackerRow4.ability.abilityId == 1006)
API.CloseTracker()
HXCAbilityPracticePreferences["24"] = {}
API.Reset()
assert(API.ApplySnapshot(Fixture()))
print("PASS: minimized tracker updates, exact counts, stale data, restoration and close")

assert(UISpecialFrames[1] == "HXCAbilityPracticePanel")
print("PASS: Lua 5.1 addon model, large exact-use strings, invalid snapshots, stale updates and menu smoke")
