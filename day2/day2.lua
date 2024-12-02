local file = assert(io.open("input"), "Could not open input")

function signum (number)
    if number == 0 then
        return 0
    elseif number > 0 then
        return 1
    elseif number < 0 then
        return -1
    end
end

function isSafe (report)
    local last = nil
    local lastSign = nil
    for _, val in ipairs(report) do
        if last ~= nil then
            local diff = last - val
            local sign = signum(diff)
            if (math.abs(diff) > 3) or
               (math.abs(diff) < 1) or
               (lastSign and sign ~= lastSign) then
                return false
            end
            lastSign = sign
        end
        last = val
    end
    return true
end

local reports = {}
for line in file:lines() do
    table.insert(reports, {})
    for num in string.gmatch(line, "%d+") do
        table.insert(reports[#reports], tonumber(num)) 
    end
end

file:close()

-- Part 1

local safe1 = 0
for _, report in ipairs(reports) do
    if isSafe(report) then
        safe1 = safe1 + 1
    end
end

print("Part 1: " .. safe1)

local safe2 = 0
for i, report in ipairs(reports) do
    if isSafe(report) then
        safe2 = safe2 + 1
    else
        for j = 1,#report do
            local dampened = { table.unpack(report) }
            table.remove(dampened, j)
            if isSafe(dampened) then
                safe2 = safe2 + 1
                break
            end
        end
    end
end

print("Part 2: " .. safe2)
