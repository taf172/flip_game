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
    for i = 1, iter do
        backbite(poly, grid)
    end
    return poly
end

local function gauss (mean, variance)
    local mean = mean or 0
    local variance = variance or 1

    local r = variance + 1
    while r > variance or r < -variance do
        r  = math.sqrt(-2 * variance * math.log(math.random()))
        r =  r * math.cos(2 * math.pi * math.random())
    end
    return mean + r
end

local Puzzle = {}
function Puzzle:new(grid, seed)
    self.__index = self

    local puzzle = setmetatable({}, Puzzle)
    puzzle.path = genPolymer(grid, 10000)
    puzzle.seed = seed or 0
    puzzle.size = grid.rows
    puzzle.keys = {}
    puzzle.locks = {}
    puzzle:genPuzzle()
    return puzzle
end

local function gaussian (mean, variance)
    return  math.sqrt(-2 * variance * math.log(math.random())) *
            math.cos(2 * math.pi * math.random()) + mean
end

function Puzzle:genStep()
    local avgGap = 3
    local var = 1
    if self.size == 4 then
        avgGap = 4
        var = 1
    elseif self.size == 5 then
        avgGap = 4
        var = 0.5
    elseif self.size == 6 then
        avgGap = 4
        var = 0.2
    end
    return math.max(1, math.ceil(gaussian(avgGap, var)))
end

function Puzzle:genPuzzle()
    math.randomseed(self.seed)
    local randPos = 1 + self:genStep()
    while randPos < #self.path do
        table.insert(self.keys, randPos)
        table.insert(self.locks, self.path[randPos])
        randPos = randPos + self:genStep()
    end
end




return Puzzle