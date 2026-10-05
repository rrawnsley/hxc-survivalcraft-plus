local Wire = HXCAbilityPracticeWire
local lines = EncodedPracticeSnapshot
local result
for index, line in ipairs(lines) do
    result = Wire.Accept(line, index / 10, 0)
    if index < #lines then assert(not result) end
end
assert(result and result.revision == 10 and result.classId == 24)
assert(result.abilities[1].nextPoint.uses == "12")
assert(result.abilities[1].nextRank.practice.uses == "492")
assert(HXCAbilityPractice.ApplySnapshot(result))
assert(not Wire.Accept(lines[1], 0, 10))

Wire.Reset()
Wire.Accept(lines[1], 0, 0)
Wire.Accept(lines[2], 0, 0)
assert(not Wire.Accept(lines[#lines], 0, 0))
assert(not Wire.Accept(lines[3], 0, 0))
Wire.Reset()
Wire.Accept(lines[1], 0, 0)
Wire.Accept(lines[2], 0, 0)
assert(not Wire.Accept(lines[2], 0, 0))
assert(not Wire.Accept(lines[#lines], 0, 0))
Wire.Reset()
Wire.Accept(lines[1], 0, 0)
assert(not Wire.Accept(lines[2], 6, 0))
assert(not Wire.Accept(lines[#lines], 6, 0))
assert(not Wire.Accept(string.rep("x", 241), 0, 0))
assert(not Wire.Accept("B|1|10|24|24|513", 0, 0))
assert(not Wire.Accept("B|2|10|24|24|1", 0, 0))
assert(not Wire.Accept("B|1|010|24|24|1", 0, 0))
assert(not Wire.Accept("B|1|10|24|24|1", math.huge, 0))

Wire.Reset()
Wire.Accept(lines[1], 0, 0)
Wire.Accept("B|1|9|24|24|1", 0, 0)
Wire.Accept("P|9|1|1|12", 0, 0)
for index = 2, #lines do result = Wire.Accept(lines[index], 0, 0) end
assert(result and result.revision == 10)
Wire.Reset()
assert(not Wire.Accept("B|1|11|24|24|0", 0, 0))
result = Wire.Accept("E|11", 0, 0)
assert(result and #result.abilities == 0)
print("PASS: C++ to Lua snapshot round trip, atomic assembly, duplicates, expiry and stale frames")
