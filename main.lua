-- assets
-- key: https://thenounproject.com/icon/key-3407510/
-- lock: https://thenounproject.com/icon/lock-4740763/
-- audo: kenny assets, RCP tones

local res = require 'res'

local Grid = require 'grid'
local Board = require 'board'
local Puzzle = require 'puzzle'
local Player = require 'player'
local KeyHud = require 'keyHud'

love.window.setMode(800, 600, {vsync = false, msaa = 8, })
love.graphics.setBackgroundColor(res.colors.lightShade)
love.audio.setVolume(0.25)
local ww, wh = love.graphics.getDimensions()

local grid = Grid:new(2, 2)
local board = Board:new(grid)
local player = Player:new()
local keyHud = KeyHud:new(player)
local currentPosition = 0

board:constrain()
board:spawnTiles()
board:constrainTiles()

keyHud:constrain(board)

---[[
local function setTutorial()
    board:constrain()

    local puzzle = {
        keys = {4},
        locks = {4},
        start = 3,
        solution = {3, 1, 2, 4}
    }
    local startTile = board:setPuzzle(puzzle)
    player:setStart(startTile, puzzle.keys)
    currentPosition = puzzle.start
end
setTutorial()
--]]

---[[
local function newPuzzle()
    grid = grid:new(5, 5)
    board = Board:new(grid)
    board:constrain()
    board:spawnTiles()
    board:constrainTiles()

    local puzzle = Puzzle:new(grid)
    local startTile = board:setPuzzle(puzzle)
    player:setStart(startTile, puzzle.keys)
    currentPosition = puzzle.start
    keyHud.x = board.x
    keyHud.y = board.y - keyHud.height - 10
end
--]]

function love.draw()
    player:drawTrail()
    board:draw()
    player:draw()
    keyHud:draw()

    --love.graphics.print(#player.trail)
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