-- assets
-- key: https://thenounproject.com/icon/key-3407510/
-- lock: https://thenounproject.com/icon/lock-4740763/
-- audo: kenny assets, RCP tones

local res = require 'res'
local State = require 'state'

love.window.setMode(800, 600, {vsync = false, msaa = 8, })
love.graphics.setBackgroundColor(res.colors.lightShade)
love.audio.setVolume(0.25)
local ww, wh = love.graphics.getDimensions()

local cheater = false
local stateNo = 0
local gameState = State:new()
gameState:loadTutorial()

function love.draw()
    gameState:draw()

    if gameState:won() then
        love.graphics.setColor(res.colors.primary)
        if cheater then
            love.graphics.printf(
                'cheater >:(', 0, love.graphics.getHeight() - 125, love.graphics.getWidth(), 'center'
            )
        else
            love.graphics.printf(
                'you did it!\n< space >', 0, love.graphics.getHeight() - 125, love.graphics.getWidth(), 'center'
            )
        end
    elseif gameState.tutorial then
        love.graphics.printf(
            'arrow keys to move', 0, love.graphics.getHeight() - 125, love.graphics.getWidth(), 'center'
        )
    else
        love.graphics.print('space: reset', 0, love.graphics.getHeight() - 50)
    end

    if stateNo > 0 then
        love.graphics.print('No. '..stateNo)
    end
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