-- assets
-- key: https://thenounproject.com/icon/key-3407510/
-- lock: https://thenounproject.com/icon/lock-4740763/
-- audo: kenny assets, RCP tones

love.window.setMode(480, 800, {vsync = false, msaa = 8, })
local res = require 'res'
local ui = require 'ui'

local State = require 'state'
local Level = require 'level'


love.graphics.setBackgroundColor(res.colors.lightShade)
love.audio.setVolume(0.25)
ui:constrain()

local cheater = false
local stateNo = 0
local gameState = State:new()
gameState:load()

local level = 1
local function nextLevel()
    level = level + 1
    ui.levelText = 'No. '..level
end
ui.buttons.nextButton.onPress = nextLevel

function love.draw()
    gameState:draw()
    ui:draw()

    --[[ Draw centerlines
    local ww, wh = love.graphics.getDimensions()
    love.graphics.setColor{0, 1, 0}
    love.graphics.line(ww/2, 0, ww/2, wh)
    love.graphics.line(0, wh/2, ww, wh/2)
    --]]
end

function love.update(dt)

end

function love.mousepressed(x, y, button, istouch, presses)

end

function love.keypressed(key)
    gameState:input()

    if gameState:won() and key == 'space' then
        gameState = State:new()
        gameState:load()
        stateNo = stateNo + 1
        cheater = false
    end

    if gameState:won() then return end
    if key == 'right' then gameState:input('right') end
    if key == 'left' then gameState:input('left') end
    if key == 'up' then gameState:input('up') end
    if key == 'down' then gameState:input('down') end
    if key == 'space' then gameState:reset() end
    if key == 's' then cheater = true; gameState:solve() end

    --[[
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
        if key == 's' then board:solve() end
    --]]
end

function love.mousepressed(x, y, button)
    if not button == 1 then return end
    ui:mousepressed(x, y)
end