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
    ui.buttons.playButton.onPress = function () game:startGame(); end
    ui.buttons.levelSelectButton.onPress = function () game:toLevelSelect() end
    ui.buttons.menuButton.onPress = function () game:toMainMenu() end
    ui.buttons.backButton.onPress = function () game:back() end
    ui.buttons.nextButton.onPress = function () game:next() end
    ui.buttons.resetButton.onPress = function () game.level:reset() end
    ui.buttons.undoButton.onPress = function () game.level:undo() end
    ui.buttons.bigBackButton.onPress = function () game:toMainMenu() end


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
    game:keypressed(key)
end
