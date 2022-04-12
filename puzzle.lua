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
    puzzle.positions = {}
    puzzle.values = {}
    puzzle:genPuzzle()

    return puzzle
end

function Puzzle:getNorm()
    math.randomseed(self.seed)

    for i = 2, #self.solution do
    end

    return self
end

function Puzzle:genPuzzle() -- FIX THIS LOL
    local total = 1
    local max = 5

    while total < #self.path - max do
        local rng = math.random(max)
        table.insert(self.positions, self.path[total])
        table.insert(self.values, rng)
        total = total + rng
    end

    self.positions = {1, 7, 9}
    self.values = {2, 2, 4}
end




return Puzzle