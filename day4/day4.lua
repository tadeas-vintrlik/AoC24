package.path = package.path .. ";../util/?.lua"
local Matrix = require("matrix")
local Point = require("point")

local file = assert(io.open("input"), "Could not open file")

local matrix = Matrix:fromFile(file)

-- A buffer that has always the last 4 characters
local buffer = { value = "" }
function buffer:concat(c)
    assert(#c == 1)
    self.value = string.sub(self.value, -3) .. c
    assert(#self.value <= 4)
end
function buffer:check()
    return self.value == "XMAS" or self.value == "SAMX"
end

-- horizontal
local count = 0
for y = 1,#matrix do
    buffer.value = ""
    for x = 1,#matrix[y] do
        buffer:concat(matrix:get(Point(x, y)))
        if buffer:check() then
            count = count + 1
        end
    end
end

-- vertical
for x = 1,#matrix[1] do
    buffer.value = ""
    for y = 1,#matrix do
        buffer:concat(matrix:get(Point(x, y)))
        if buffer:check() then
            count = count + 1
        end
    end
end

local loopMax = math.max(#matrix, #matrix[1])

-- diagonals LR
for offset = -loopMax+3,loopMax-3 do
    buffer.value = ""
    for i = 1,loopMax do
        buffer:concat(matrix:get(Point(i + offset, i)) or ".")
        if buffer:check() then
            count = count + 1
        end
    end
end

-- diagonals RL
for offset = -loopMax+3,loopMax-3 do
    buffer.value = ""
    for i = loopMax,0,-1 do
        buffer:concat(matrix:get(Point(i + offset, #matrix - i)) or ".")
        if buffer:check() then
            count = count + 1
        end
    end
end

print("Part 1: " .. count)
