local Map = {}
Map.__index = Map

function Map:new(m)
    if m == nil then m = {} end
    setmetatable(m, Map)
    return m
end

function Map:__tostring()
    local elements = {}
    for k, v in pairs(self) do
        if k ~= "__index" then
            table.insert(elements, "  " .. tostring(k) .. ": " .. tostring(v))
        end
    end
    return "{\n" .. table.concat(elements, ",\n") .. "\n}"
end

setmetatable(Map, {
    __call = Map.new,
    __tostring = Map.__tostring
})

return Map
