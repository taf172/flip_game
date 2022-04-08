-- assets
-- key: https://thenounproject.com/icon/key-3407510/

local res = require 'res'
local Tile = require 'tile'
local Player = require 'player'
local KeyHud = require 'keyHud'

love.window.setMode(800, 600, {vsync = false, msaa = 8, })

local ww, wh = love.graphics.getDimensions()
local font = love.graphics.newFont('Montserrat-Medium.ttf', 36)
local sFont = love.graphics.newFont('Montserrat-Medium.ttf', 12)
love.graphics.setFont(font)

local tiles = {}
for i = 1, 5 do
    table.insert(tiles, Tile:new( (ww - 5*74)/2 + (i - 1)*74 + 32, wh/2))
end
tiles[3]:setLock()
tiles[5]:setLock()

local start = tiles[1]
local keys = {2, 4}
local player = Player:new()
player:setStart(start, keys)

local keyHud = KeyHud:new(player)

function love.draw()
    for _, tile in pairs(tiles) do
        tile:draw()
    end
    player:draw()
    keyHud:draw()
end

function love.update(dt)
end

function love.mousepressed(x, y, button, istouch, presses)

end

local boardPosition = 1
function love.keypressed(key)
    local inputPosition
    if key == 'right' then inputPosition = boardPosition + 1 end
    if key == 'left' then inputPosition = boardPosition - 1 end
    if player:inputTile(tiles[inputPosition]) then boardPosition = inputPosition end

    --[[
    if key == 'up' then board:move('up') end
    if key == 'down' then board:move('down') end
    if key == 'space' then board:newPuzzle() end
    if key == 's' then board:solve() end
    --]]
end