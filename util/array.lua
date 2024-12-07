local Array = {}
Array.__index = Array

function Array:new(a)
    if a == nil then a = {} end
    setmetatable(a, Array)
    return a
end

function Array:contains(value)
    for _, v in ipairs(self) do
        if v == value then
            return true
        end
    end
    return false
end

function Array:intersect(arr2)
    local res = Array()
    for _, v2 in ipairs(arr2) do
        if self:contains(v2) then
            table.insert(res, v2)
        end
    end
    return res
end

function Array:__tostring()
    local elements = {}
    for _, v in ipairs(self) do
        table.insert(elements, tostring(v))
    end
    return "{" .. table.concat(elements, ", ") .. "}"
end

setmetatable(Array, {
    __call = Array.new,
    __tostring = Array.__tostring
})

return Array
