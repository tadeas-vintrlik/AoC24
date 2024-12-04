local file = assert(io.open("test"), "Could not open file")

local matrix = {}

for line in file:lines() do
    table.insert(matrix, {})
    for char in line:gmatch(".") do
        table.insert(matrix[#matrix], char)
    end
end

local horizontal = ""

for _, v in ipairs(matrix) do
    for _, vv in ipairs(v) do
        horizontal = horizontal .. vv
    end
end

local vertical = ""

for i = 1,#matrix do
    for j = 1,#matrix do
        vertical = vertical .. matrix[j][i]
    end
end

local diagonal = ""

for i = 0,math.max(#matrix,#matrix[1]) do
    for j = 1,math.max(#matrix,#matrix[1]) do
        if j+i <= #matrix[1] and j <= #matrix then
            diagonal = diagonal .. matrix[j][j+i] 
        end
    end
end

for i = 1,math.max(#matrix, #matrix[1]) do
    for j = 1,math.max(#matrix, #matrix[1]) do
        if j+i <= #matrix and j <= #matrix[1] then
            diagonal = diagonal .. matrix[j+i][j] 
        end
    end
end

local count = 0

for _, needle in ipairs({"XMAS", "SAMX"}) do
    for _, haystack in ipairs({horizontal, vertical, diagonal}) do
        while true do
            local i = string.find(haystack, needle)
            if i == nil then
                break
            end
            haystack = string.sub(haystack, i+1, #haystack)
            count = count + 1
        end
    end
end

print(count)
