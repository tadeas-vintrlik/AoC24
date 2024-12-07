package.path = package.path .. ";../util/?.lua"
local Array = require("array")
local Map = require("map")

local file = assert(io.open("input"), "Could not open file")

local rules = Map()
local updates = Array()
for line in file:lines() do
    if  string.find(line, "|") then
        local _, _, num1, num2 = string.find(line, "(%d+)|(%d+)")
        if not rules[num2] then
            rules[num2] = Array()
        end
        table.insert(rules[num2], num1)
    end

    if  string.find(line, ",") then
        table.insert(updates, Array())
        for v in line:gmatch("%d+") do
            table.insert(updates[#updates], v)
        end
    end
end

local function isValidUpdate (update)
    local printed = Array()
    for _, pageNum in ipairs(update) do
        local before = rules[pageNum]
        if before then
            for _, v in ipairs(before:intersect(update)) do
                if not printed:contains(v) then
                    return false
                end
            end
        end
        table.insert(printed, pageNum)
    end
    return true
end


local validUpdates = Array()
local invalidUpdates = Array()
for _, update in ipairs(updates) do
    if isValidUpdate(update) then
        table.insert(validUpdates, update)
    else
        table.insert(invalidUpdates, update)
    end
end

local sumMiddles = 0
for _, vp in ipairs(validUpdates) do
    sumMiddles = sumMiddles + vp[math.ceil(#vp/2)]
end

print("Part 1: " .. sumMiddles)

for i, p in ipairs(invalidUpdates) do
    table.sort(p, function (v1, v2)
        local before = rules[v2]
        if before then
            return before:contains(v1)
        else
            return false
        end
    end)
    updates[i] = p
end

local sumMiddles2 = 0
for _, vp in ipairs(invalidUpdates) do
    sumMiddles2 = sumMiddles2 + vp[math.ceil(#vp/2)]
end

print("Part 2: " .. sumMiddles2)
