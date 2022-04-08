local function reverse(tbl, s, e)
    local s = s or 1
    local e = e or #tbl
    while s < e do
        tbl[s], tbl[e] = tbl[e], tbl[s]
        s = s + 1
        e = e - 1
    end
end

local function getPlow(grid)
    local plow = {}
    for i = 1, grid.rows*grid.cols do
        table.insert(plow, i)
    end
    for i = 1, grid.rows, 2 do
        reverse(plow, i*grid.cols + 1, (i + 1)*grid.cols)
    end
    return plow
end

local function backbite(path, grid)
    local forward = true
    local head = path[1]
    local pair = path[2]
    if math.random() > 0.5 then
        forward = false
        head = path[#path]
        pair = path[#path]
    end

    -- Choose one non-connected randomly
    local adj = grid:getAdj(head)
    local rand = math.random(#adj)
    local chosen = adj[rand]
    while chosen == pair do
        -- TODO: While loop probably not good for performance
        rand = math.random(#adj)
        chosen = adj[rand]
    end

    -- Reverse from head to chosen
    for i, v in ipairs(path) do
        if v == chosen then
            if forward then
                reverse(path, 1, i - 1)
            else
                reverse(path, i + 1, #path)
            end
        end
    end
end

local function genPolymer(grid, iter)
    local poly = getPlow(grid)
    for i = 1, 1000 do
        backbite(poly, grid)
    end
    return poly
end

local Puzzle = {}

function Puzzle:new(grid)
    self.__index = self

    local puzzle = setmetatable({}, Puzzle)
    puzzle.solution = genPolymer(grid, 1000)
    puzzle:load()
    return puzzle
end

function Puzzle:load()
    self.start = self.solution[1]
    self.keys = {}
    self.locks = {}
    local rng = {}
    for i = 1, math.random(3, 6) do
        local rand = math.random(2, #self.solution - 1)
        while rng[rand] do
            rand = math.random(2, #self.solution - 1)
        end
        rng[rand] = true
        table.insert(self.keys, rand)
    end
    table.insert(self.keys, #self.solution)
    table.sort(self.keys)
    for _, key in pairs(self.keys) do
        table.insert(self.locks, self.solution[key])
    end
end

return Puzzle