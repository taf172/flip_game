local res = require 'res'
local tween = require 'tween'

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
    level.alpha = 0
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
    self.keyHud:constrain(self.board)
    self.keyHud.alpha = 0

    self.alpha = 0
    self.canvas = nil
    self.fading = false
    tween:quadOut(self, 'alpha', 1, 0.5, 0.25)
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

function Level:fadeOut()
    self.fading = true
    self.canvas = love.graphics.newCanvas()
    love.graphics.setCanvas(self.canvas)
        self.head:drawStack()
        self.board:draw()
        self.head:draw()
    love.graphics.setCanvas()
    tween:quadOut(self, 'alpha', 0, 0.5, 1)
end

function Level:draw()
    if self.canvas then
        love.graphics.setColor(1, 1, 1, self.alpha)
        love.graphics.draw(self.canvas)
    else
        self.head:drawStack()
        self.board:draw()
        self.head:draw()
    end

    self.keyHud:draw()
    if self.text then
        love.graphics.setColor(
            res.colors.primary[1], res.colors.primary[2], res.colors.primary[3], self.alpha
        )
        love.graphics.setFont(res.fonts.medium)
        love.graphics.printf(
            self.text, 0, self.board.y + self.board.height + self.board.spacing*6,
            love.graphics.getWidth(), 'center'
        )
    end
end

function Level:update(dt)
    self.head:update(dt)
    self.keyHud.alpha = self.alpha

    if self.board:isClear() and not self.fading then
        res.audio.success:play()
        self:fadeOut()
    end

    if self.fading and self.alpha == 0 then
        self:onClear()
    end
end

function Level:onClear()
end

return Level