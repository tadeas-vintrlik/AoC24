local file = assert(io.open("input"), "Could not open file")

local rules = {}
local updates = {}
for line in file:lines() do
    if  string.find(line, "|") then
        _, _, num1, num2 = string.find(line, "(%d+)|(%d+)")
        if not rules[num2] then
            rules[num2] = {}
        end
        table.insert(rules[num2], num1)
    end

    if  string.find(line, ",") then
        table.insert(updates, {})
        for v in line:gmatch("%d+") do
            table.insert(updates[#updates], v)
        end
    end
end


function contains(haystack, needle)
    for _, value in ipairs(haystack) do
        if value == needle then
            return true
        end
    end
    return false
end

function intersect(arr1, arr2)
    local res = {}
    for _, v1 in ipairs(arr1) do
        if contains(arr2, v1) then
            table.insert(res, v1)
        end
    end
    return res
end

function isValidUpdate (update)
    local printed = {}
    for _, pageNum in ipairs(update) do
        before = rules[pageNum]
        if before then
            for _, v in ipairs(intersect(before, update)) do
                if not contains(printed, v) then
                    return false
                end
            end
        end
        table.insert(printed, pageNum)
    end
    return true
end


local validUpdates = {}
for _, update in ipairs(updates) do
    if isValidUpdate(update) then
        table.insert(validUpdates, update)
    end
end

local sumMiddles = 0
for _, vp in ipairs(validUpdates) do
    sumMiddles = sumMiddles + vp[math.ceil(#vp/2)]
end

print("Part 1: " .. sumMiddles)
