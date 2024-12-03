local file = assert(io.open("input"), "Could not open file")

local mulPattern = "mul%((%d%d?%d?),(%d%d?%d?)%)"
local total1, total2 = 0, 0
local active = true

for line in file:lines() do
    for ins in string.gmatch(line, "[%a']+%(.-%)") do
        if string.find(ins, "don't%(%)") then
            active = false
        elseif string.find(ins, "do%(%)") then
            active = true
        else
            local num1, num2 = string.match(ins, mulPattern) 
            if num1 and num2 then
                total1 = total1 + tonumber(num1) * tonumber(num2)
                if active then
                    total2 = total2 + tonumber(num1) * tonumber(num2)
                end
            end
        end
    end
end

print("Part 1: " .. total1)
print("Part 2: " .. total2)
