local file = assert(io.open("input"), "Could not open input")

local firsts = {}
local seconds = {}

for line in file:lines() do
    local first, second = line:match("(%d+)%s+(%d+)")
    table.insert(firsts, tonumber(first))
    table.insert(seconds, tonumber(second))
end

file:close()

table.sort(firsts)
table.sort(seconds)

-- Part 1
local sum1 = 0

for i = 1,#firsts do
    sum1 = sum1 + math.abs(firsts[i] - seconds[i])
end

print("Part 1: " .. sum1)

-- Part 2
local counts = {}

local sum2 = 0
for _, first in ipairs(firsts) do
    for _, second in ipairs(seconds) do
        if first == second then
            sum2 = sum2 + first
        end
    end
end

print("Part 2: " .. sum2)
