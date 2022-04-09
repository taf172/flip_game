local Grid = require 'grid'
local Board = require 'board'
local Puzzle = require 'puzzle'
local Player = require 'player'
local KeyHud = require 'keyHud'


local State = {}

function State:new()
    self.__index = self

    local state = setmetatable({}, self)
    state.player = Player:new()
    state.keyHud = KeyHud:new(state.player)
    state.currentPosition = 0
    return state
end

function State:loadTutorial()
    self.tutorial = true
    self.grid = Grid:new(2, 2)
    self.board = Board:new(self.grid)
    self.board:constrain()
    self.keyHud:constrain(self.board)
    local puzzle = {
        keys = {4},
        locks = {4},
        start = 3,
        solution = {3, 1, 2, 4}
    }
    local startTile = self.board:setPuzzle(puzzle)
    self.player:setStart(startTile, puzzle.keys)
    self.currentPosition = puzzle.start
    self.puzzle = puzzle
end

function State:reset()
    local startTile = self.board:setPuzzle(self.puzzle)
    self.player:setStart(startTile, self.puzzle.keys)
    self.currentPosition = self.puzzle.start
end

function State:load()
    self.grid = Grid:new(5, 5)
    self.board = Board:new(self.grid)
    self.board:constrain()

    local puzzle = Puzzle:new(self.grid)
    local startTile = self.board:setPuzzle(puzzle)
    self.player:setStart(startTile, puzzle.keys)
    self.currentPosition = puzzle.start
    self.keyHud:constrain(self.board)

    self.puzzle = puzzle
end

function State:input(input)
    local inputPosition
    if input == 'right' then inputPosition = self.grid:getRight(self.currentPosition) end
    if input == 'left' then inputPosition = self.grid:getLeft(self.currentPosition) end
    if input == 'up' then inputPosition = self.grid:getAbove(self.currentPosition) end
    if input == 'down' then inputPosition = self.grid:getBelow(self.currentPosition) end
    if inputPosition then
        local tile = self.board:getTile(inputPosition)
        if self.player:inputTile(tile) then self.currentPosition = inputPosition end
    end

    --[[
    if input == 'new' then newPuzzle() end
        if key == 's' then board:solve() end
    --]]
end

function State:solve()
    self:reset()
    local tile
    for i = 2, #self.puzzle.solution do
        local tile = self.board:getTile(self.puzzle.solution[i])
        self.player:inputTile(tile)
    end
end

function State:won()
    return self.player.value >= self.grid.rows*self.grid.cols
end

function State:update()
end

function State:draw()
    self.player:drawTrail()
    self.board:draw()
    self.player:draw()
    self.keyHud:draw()
end

return State