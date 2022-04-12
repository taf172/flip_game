-- assets
-- key: https://thenounproject.com/icon/key-3407510/
-- lock: https://thenounproject.com/icon/lock-4740763/
-- audo: kenny assets, RCP tones


local res = require 'res'
local ui = require 'ui'
local game = require 'game'

function love.load()
    love.window.setMode(480, 800, {vsync = false, msaa = 8, })
    love.graphics.setBackgroundColor(res.colors.lightShade)
    love.audio.setVolume(0.25)

    -- Set UI buttons
    ui.buttons.playButton.onPress = function ()
        game:switch(game.inLevel)
    end
    ui.buttons.levelSelectButton.onPress = function ()
        game:switch(game.levelSelect)
    end
    ui.buttons.backButton.onPress = function ()
        if game.currentState == game.inLevel then
            if game.currentLevel == 1 then return end
            game.currentLevel = game.currentLevel - 1
            game:switchLevel(game.currentLevel)
        else
            game:switch(game.mainMenu)
        end
    end
    ui.buttons.nextButton.onPress = function ()
        game.currentLevel = game.currentLevel + 1
        game:switchLevel(game.currentLevel)
    end
    ui.buttons.menuButton.onPress = function ()
        game:switch(game.mainMenu)
    end

    ui:constrain()
    game:load()
end

function love.draw()
    game:draw()
end

function love.update(dt)
    game:update(dt)
end

function love.mousepressed(x, y, button, istouch, presses)
    game:mousepressed(x, y, button, istouch, presses)
end

function love.keypressed(key)
    --[[
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
    --]]
end

function love.mousepressed(x, y, button)
    if not button == 1 then return end
    game:mousepressed(x, y)
end