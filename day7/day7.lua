package.path = package.path .. ";../util/?.lua"
local Array = require("array")

local file = assert(io.open("input"), "Could not open file")

local equations = {}
for line in file:lines() do
    local iColon = line:find(":")
    local index = tonumber(line:sub(1, iColon - 1))
    equations[index] = Array()
    line = line:sub(iColon + 2)
    for num in line:gmatch("%d+") do
        table.insert(equations[index], num)
    end
end

local trueEq = Array()
for k, v in pairs(equations) do
    local combs = generateCombinations(#v, {"*", "+"})
    for _, c in ipairs(combs) do
        local res = v[1]
        for i = 2,#v do
            local op = c[i-1]
            if op == "*" then
                res = res * v[i]
            else
                res = res  + v[i]
            end
        end
        if res == k then
            table.insert(trueEq, k)
            break
        end
    end
end

local sum = 0
for _, v in ipairs(trueEq) do
    sum = sum + v
end

print("Part 1: " .. sum)

local trueEq2 = Array()
for k, v in pairs(equations) do
    local combs = generateCombinations(#v, {"*", "+", "||" })
    for _, c in ipairs(combs) do
         (function()
            local res = v[1]
            for i = 2,#v do
                local op = c[i-1]
                if op == "*" then
                    res = res * v[i]
                elseif op == "+" then
                    res = res + v[i]
                else
                    res = res .. v[i]
                end
                if tonumber(res) > tonumber(k) then
                    return
                end
            end
            if tonumber(res) == tonumber(k) and not trueEq2:contains(k) then
                table.insert(trueEq2, k)
                return
            end
        end)()
    end
end

local sum2 = 0
for _, v in ipairs(trueEq2) do
    sum2 = sum2 + v
end

print("Part 2: " .. sum2)
