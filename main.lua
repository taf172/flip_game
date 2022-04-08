-- assets
-- key: https://thenounproject.com/icon/key-3407510/
-- lock: https://thenounproject.com/icon/lock-4740763/


local res = require 'res'

local Grid = require 'grid'
local Board = require 'board'
local Puzzle = require 'puzzle'
local Player = require 'player'
local KeyHud = require 'keyHud'

love.window.setMode(800, 600, {vsync = false, msaa = 8, })
local ww, wh = love.graphics.getDimensions()

local grid = Grid:new(5, 5)
local board = Board:new(grid)
local player = Player:new()
local keyHud = KeyHud:new(player)
local currentPosition = 0

board:constrain()
board:spawnTiles()
board:constrainTiles()
keyHud.x = board.x
keyHud.y = board.y - keyHud.height - 10

local function newPuzzle()
    local puzzle = Puzzle:new(grid)
    local startTile = board:setPuzzle(puzzle)
    player:setStart(startTile, puzzle.keys)
    currentPosition = puzzle.start
end

newPuzzle()

function love.draw()
    board:draw()
    player:draw()
    keyHud:draw()

    love.graphics.print(#player.trail)
end

function love.update(dt)
end

function love.mousepressed(x, y, button, istouch, presses)

end

function love.keypressed(key)
    local inputPosition
    if key == 'right' then inputPosition = grid:getRight(currentPosition) end
    if key == 'left' then inputPosition = grid:getLeft(currentPosition) end
    if key == 'up' then inputPosition = grid:getAbove(currentPosition) end
    if key == 'down' then inputPosition = grid:getBelow(currentPosition) end

    if inputPosition then
        local tile = board:getTile(inputPosition)
        if player:inputTile(tile) then currentPosition = inputPosition end
    end

    if key == 'space' then newPuzzle() end
    --[[
        if key == 's' then board:solve() end
    --]]
end