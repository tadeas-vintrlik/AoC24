package.path = package.path .. ";./util/?.lua"
local Array = require("array")

assert(Array:new({1,2,3}):contains(3) == true)
assert(Array:new({1,3}):contains(2) == false)
assert(Array:new({}):contains(1) == false)
assert(Array:new({1}):contains(1) == true)
assert(Array:new({4,2,5,1,3}):contains(5) == true)

local n1 = Array:new({1,2,3})
local n2 = Array({1,2,3})
for i, v in ipairs(n1) do
    assert(v == n2[i])
end

assert(tostring(Array({})) == "{}")
assert(tostring(Array({1})) == "{1}")
assert(tostring(Array({1,2})) == "{1, 2}")


local correct = {2, 3}
for i, v in ipairs(Array({1,2,3}):intersect(Array({2,3}))) do
    assert(correct[i] == v)
end

for i, v in ipairs(Array({1,2,3}):intersect({2,3})) do
    assert(correct[i] == v)
end
