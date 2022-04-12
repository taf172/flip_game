local Grid = require 'grid'
local Board = require 'board'
local Puzzle = require 'puzzle'
local HeadTile = require 'headTile'

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
    level.startPosition = level.puzzle.path[1]
    return level
end

function Level:load()
    self.currentPosition = self.startPosition
    self.board:constrain()
    self.board:spawnTiles()
    self.board:placeTiles()
    self.head:clearStack()
    self.head:push(self.board:getTile(self.startPosition))
end

function Level:input(dir)
end

function Level:undo()
end

function Level:reset()
    self.currentPosition = self.startPosition
    self.board:spawnTiles()
    self.board:placeTiles()
    self.head:clearStack()
    self.head:push(self.board:getTile(self.startPosition))
end

function Level:draw()
    self.head:drawStack()
    self.board:draw()
    self.head:draw()
end

function Level:update(dt)
    self.head:update(dt)
end

return Level