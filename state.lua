local Grid = require 'grid'
local Board = require 'board'
local Puzzle = require 'puzzle'

local State = {}

function State:new()
    self.__index = self
    local state = setmetatable({}, self)

    return state
end

function State:loadTutorial()
    self.grid = Grid:new(5, 5)
    self.puzzle = Puzzle:new(self.grid)
    self.board = Board:new(self.grid)

    self.board:spawnTiles()
    self.board:placeTiles()

    --[[
    self.board:setHeadTile(1, 3)
    self.board:setHeadTile(9, 4)
    self.board:activateTiles()

    self.currentHeadTile = self.board:getTile(1)

    self.currentPosition = 1
    --]]
end

function State:input(input)
    --[[
    local inputPosition
    if input == 'right' then inputPosition = self.grid:getRight(self.currentPosition) end
    if input == 'left' then inputPosition = self.grid:getLeft(self.currentPosition) end
    if input == 'up' then inputPosition = self.grid:getAbove(self.currentPosition) end
    if input == 'down' then inputPosition = self.grid:getBelow(self.currentPosition) end

    if inputPosition then
        local tile = self.board:getTile(inputPosition)
        if self.currentHeadTile:input(tile) then self.currentPosition = inputPosition end
    end
    --]]
end

function State:won()
end

function State:draw()
    self.board:draw()
end

return State