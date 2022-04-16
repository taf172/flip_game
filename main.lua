-- assets
-- key: https://thenounproject.com/icon/key-3407510/
-- lock: https://thenounproject.com/icon/lock-4740763/
-- audo: kenny assets, RCP tones

local res = require 'res'
local ui = require 'ui'
local game = require 'game'
local tween = require 'tween'
local palette = require 'palette'

function love.load()
    --love.window.setMode(480, 800, {vsync = false})
    love.graphics.setBackgroundColor(res.colors.lightShade)

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
    if dt > 1/60 then dt = 1/60 end
    tween:update(dt)
    game:update(dt)
    palette:update(dt)
end

function love.keypressed(key)
    game:keypressed(key)
end

local drag = {}
function love.mousepressed(x, y, button, istouch, presses)
    game:mousepressed(x, y, button, istouch, presses)
    drag.x = x
    drag.y = y
end

function love.mousereleased(x, y, button, istouch, presses)
    local dx = x - drag.x
    local dy = y - drag.y
    if math.abs(dx) < 4 and math.abs(dy) < 4 then return end
    if math.abs(dx) > math.abs(dy) then
        if dx > 0 then game:keypressed('right') end
        if dx < 0 then game:keypressed('left') end
    else
        if dy < 0 then game:keypressed('up') end
        if dy > 0 then game:keypressed('down') end
    end
end