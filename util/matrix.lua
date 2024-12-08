local Array = require("array")
local Point = require("point")

local Matrix = {}
Matrix.__index = Matrix

function Matrix:new(m)
    if m == nil then m = Array() end
    setmetatable(m, Matrix)
    return m
end

function Matrix:fromFile(f)
    local m = Array()
    for line in f:lines() do
        table.insert(m, Array())
        for char in line:gmatch(".") do
           table.insert(m[#m], char)
        end
    end
    return Matrix(m)
end

function Matrix:get(p)
    if p.y < 1 or p.y > #self or p.x < 1 or p.x > #self[p.y] then
        return nil
    end
    return self[p.y][p.x] or nil
end

function Matrix:set(p, v)
    self[p.y][p.x] = v
end

function Matrix:find(v)
    local res = Array()
    for i = 1,#self do
        for j = 1,#self[i] do
            if self[i][j] == v then
                table.insert(res, Point(j,i))
            end
        end
    end
    return res
end

function Matrix:__tostring()
    local lines = {}
    for _, a in ipairs(self) do
        local elements = {}
        for _, v  in ipairs(a) do
            table.insert(elements, v)
        end
        table.insert(lines, table.concat(elements, ""))
    end
    return table.concat(lines, "\n")
end

setmetatable(Matrix, {
    __call = Matrix.new,
    __tostring = Matrix.__tostring,
--    __pairs = Matrix.__pairs,
})

return Matrix
