local Point = { x = 0; y = 0}
Point.__index = Point

function Point:new(x, y)
    local p = { x = x or 0; y = y or 0}
    setmetatable(p, Point)
    return p
end

function Point:__tostring()
    return "(" .. self.x .. ", " .. self.y .. ")"
end

function Point:__eq(p2)
    return self.x == p2.x and self.y == p2.y
end

function Point:__add(p)
    return Point:new(self.x + p.x, self.y + p.y)
end

setmetatable(Point, {
    __call = Point.new,
})

return Point
