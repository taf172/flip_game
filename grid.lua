local function reverse(tbl, s, e)
    local s = s or 1
    local e = e or #tbl
    while s < e do
        tbl[s], tbl[e] = tbl[e], tbl[s]
        s = s + 1
        e = e - 1
    end
end

local Grid = {}

function Grid:new(rows, cols)
    self.__index = self

    local grid = setmetatable({}, Grid)
    grid.rows = rows or 3
    grid.cols = cols or 3
    return grid
end

function Grid:getPos(v)
    return (v - 1) % self.cols, math.floor((v - 1)/self.cols)
end

function Grid:getAdj(v)
    local adj = {}
    if (v - 1) % self.cols > 0 then
        table.insert(adj, v - 1)
    end
    if v % self.cols > 0 then
        table.insert(adj, v + 1)
    end
    if (v - self.cols) > 0 then
        table.insert(adj, v - self.cols)
    end
    if (v + self.cols) < self.cols*self.rows then
        table.insert(adj, v + self.cols)
    end
    return adj
end

function Grid:getAbove(v)
    if (v - self.cols) > 0 then return v - self.cols end
end

function Grid:getBelow(v)
    if (v + self.cols) <= self.cols*self.rows then return v + self.cols end
end

function Grid:getRight(v)
    if v % self.cols > 0 then return v + 1 end
end

function Grid:getLeft(v)
    if (v - 1) % self.cols > 0 then return v - 1 end
end

return Grid