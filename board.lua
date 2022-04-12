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
    board.headTiles = {}
    board.tileSize = 64
    board.spacing = 4

    return board
end

function Board:constrain(widthRatio)
    --self.tileSize = math.min(self.width/self.grid.cols, self.height/self.grid.rows) - self.spacing
    self.width = self.grid.cols*(self.tileSize + self.spacing) - self.spacing
    self.height = self.grid.rows*(self.tileSize + self.spacing) - self.spacing
    self.x = (love.graphics.getWidth() - self.width)/2
    self.y = (love.graphics.getHeight() - self.height)/2
end


function Board:getTileCords(n)
    local gx, gy = self.grid:getPos(n)
    return
        self.x + gx*(self.tileSize + self.spacing),
        self.y + gy*(self.tileSize + self.spacing)
end

function Board:spawnTiles()
    self.tiles = {}
    for i = 1, self.grid.rows*self.grid.cols do
        self.tiles[i] = Tile:new()
    end
end

function Board:getTile(n)
    return self.tiles[n]
end

function Board:placeTiles()
    for i, tile in ipairs(self.tiles) do
        local x, y = self:getTileCords(i)
        tile.x = x
        tile.y = y
        tile.width = self.tileSize
        tile.height = self.tileSize
    end
end

function Board:isClear()
    for _, tile in ipairs(self.tiles) do
        if tile.active then return false end
    end
    return true
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