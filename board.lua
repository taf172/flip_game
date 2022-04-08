local Tile = require 'tile'

local Board = {}

function Board:new(grid)
    self.__index = self

    local board = setmetatable({}, Board)
    board.grid = grid
    board.x = 0
    board.y = 0
    board.width = 400
    board.height = 400

    board.tiles = {}
    board.spacing = 8

    return board
end

function Board:constrain()
    self.tileSize = math.min(self.width/self.grid.cols, self.height/self.grid.rows) - self.spacing
    self.x = (love.graphics.getWidth() - self.width)/2
    self.y = (love.graphics.getHeight() - self.height)/2
end

function Board:getTileCords(n)
    local gx, gy = self.grid:getPos(n)
    return
        self.x + gx*(self.tileSize + self.spacing) + (self.tileSize + self.spacing)/2,
        self.y + gy*(self.tileSize + self.spacing) + (self.tileSize + self.spacing)/2
end

function Board:spawnTiles()
    self.tiles = {}
    for i = 1, self.grid.rows*self.grid.cols do
        self.tiles[i] = Tile:new()
    end
end

function Board:constrainTiles()
    for i, tile in ipairs(self.tiles) do
        local x, y = self:getTileCords(i)
        tile.x = x
        tile.y = y
        tile.width = self.tileSize
        tile.height = self.tileSize
    end
end

function Board:getTile(n)
    return self.tiles[n]
end

function Board:setPuzzle(puzzle)
    self:spawnTiles()
    self:constrainTiles()
    for _, lock in ipairs(puzzle.locks) do
        self:getTile(lock):setLock()
    end
    return self:getTile(puzzle.start)
end

function Board:move(dir)
    --[[
    local pos = self.headTile.value
    if dir == 'right' then pos = self.grid:getRight(self.path[#self.path]) end
    if dir == 'left' then pos = self.grid:getLeft(self.path[#self.path]) end
    if dir == 'up' then pos = self.grid:getAbove(self.path[#self.path]) end
    if dir == 'down' then pos = self.grid:getBelow(self.path[#self.path]) end
    --]]
end

function Board:draw()
    --love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    for _, tile in pairs(self.tiles) do
        tile:draw()
    end
end

function Board:update(dt)
    for _, tile in pairs(self.tiles) do
        tile:update(dt)
    end
end


return Board