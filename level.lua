local Grid = require 'grid'
local Board = require 'board'
local Puzzle = require 'puzzle'

local Level = {}

function Level:new(size, seed)
    self.__index = self

    local level = setmetatable({}, self)
    level.size = size
    level.number = seed
    level.grid = Grid:new(size, size)
    level.puzzle = Puzzle:new(level.grid, seed)
    level.board = Board:new(level.grid)
    return level
end

function Level:load()
    self.board:constrain()
    self.board:spawnTiles()
    self.board:placeTiles()
end

function Level:undo()
end

function Level:reset()
    self.board:spawnTiles()
    self.board:placeTiles()
end


return Level