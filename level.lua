local res = require 'res'
local Grid = require 'grid'
local Board = require 'board'
local Puzzle = require 'puzzle'
local HeadTile = require 'headTile'
local KeyHud = require 'keyHud'

local Level = {}

function Level:new(size, seed)
    self.__index = self

    local level = setmetatable({}, self)
    level.size = size
    level.number = seed
    level.grid = Grid:new(size, size)
    level.puzzle = Puzzle:new(level.grid, seed)
    level.board = Board:new(level.grid)
    level.head = HeadTile:new()
    level.keyHud = KeyHud:new(level.head)
    return level
end

function Level:load()
    self.currentPosition = self.puzzle.path[1]
    self.cleared = false
    self.board:constrain()
    self.board:spawnTiles()
    self.board:placeTiles()
    self.board:lockTiles(self.puzzle.locks)
    self.head:growIn()
    self.head:clearStack()
    self.head:push(self.board:getTile(self.currentPosition))
    self.head.keys = self.puzzle.keys
    self.keyHud.height = self.board.tileSize*0.75
    self.keyHud.y = self.board.y - self.keyHud.height - self.board.spacing*4
    self.keyHud.x = self.board.x
    self.keyHud:constrain()
end

function Level:input(dir)
    if self.cleared then return end
    local inputPosition
    if dir == 'right' then inputPosition = self.grid:getRight(self.currentPosition) end
    if dir == 'left' then inputPosition = self.grid:getLeft(self.currentPosition) end
    if dir == 'up' then inputPosition = self.grid:getAbove(self.currentPosition) end
    if dir == 'down' then inputPosition = self.grid:getBelow(self.currentPosition) end
    if inputPosition then
        local tile = self.board:getTile(inputPosition)
        if self.head:attemptMove(tile) then self.currentPosition = inputPosition end
        if self.board:isClear() then
            self.cleared = true;
            self.completed = true
            self:onClear()
        end
    end
end

function Level:undo()
    if self.cleared then return end
    self.head:attemptMove(self.head.stack[#self.head.stack - 1])
    self.currentPosition = self.board:getTilePosition(self.head:top())
end

function Level:reset()
    if self.cleared then return end
    self:load()
end

function Level:draw()
    self.head:drawStack()
    self.board:draw()
    self.head:draw()
    self.keyHud:draw()

    if self.text then
        love.graphics.setColor(res.colors.primary)
        love.graphics.setFont(res.fonts.medium)
        love.graphics.printf(
            self.text, 0, self.board.y + self.board.height + self.board.spacing*6,
            love.graphics.getWidth(), 'center'
        )
    end
end

function Level:update(dt)
    self.head:update(dt)
end

function Level:onClear()
end

return Level