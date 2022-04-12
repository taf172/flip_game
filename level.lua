local Grid = require 'grid'
local Board = require 'board'
local Puzzle = require 'puzzle'

local Level = {}

function Level:new(size, seed)
    self.__index = self

    local level = setmetatable({}, self)
    level.size = size
    level.number = seed

    level.grid = Grid:new(5, 5)
    level.puzzle = Puzzle:new(self.grid, seed)
    level.board = Board:new(self.grid)
    return level
end

function Level:load()
    self.board:spawnTiles()
end

function Level:undo()
end

function Level:reset()
end

return Level