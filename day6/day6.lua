package.path = package.path .. ";../util/?.lua"
local Matrix = require("matrix")
local Point = require("point")

local file = assert(io.open("input"), "Could not open file")

local m = Matrix:fromFile(file)
local guard = m:find("^")[1]

local function dirIter(_)
    local i = -1
    local directions = {
        Point(0, -1), Point(1, 0), Point(0, 1), Point(-1, 0)
    }
    local dirlen = #directions
    return function()
        i = i + 1
        return directions[1 + i - math.floor(i/dirlen)*dirlen]
    end
end
local di = dirIter()
local dir = di()

local visited = {}
while true do
    if m:get(guard) == nil then
        break
    end
    visited[tostring(guard)] = true
    if m:get(guard + dir) == "#" then
        dir = di()
    end
    guard = guard + dir
end

local count = 0
for _, _ in pairs(visited) do
    count = count + 1
end
print("Part 1: " .. count)
