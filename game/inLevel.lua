local res = require 'res'
local ui = require 'ui'

local Level = require 'level'

local inLevel = {}
inLevel.font = res.fonts.medium
inLevel.textColor = res.colors.primary
inLevel.title = 'No. 1'
inLevel.titleHeight = love.graphics.getHeight()
inLevel.buttons = {
    ui.buttons.backButton,
    ui.buttons.nextButton,
    ui.buttons.undoButton,
    ui.buttons.resetButton,
    ui.buttons.menuButton,
}

function inLevel:draw()
    love.graphics.setColor(res.colors.primary)
    love.graphics.setFont(self.font)
    love.graphics.printf(
        self.title, 0, ui:getTitleHeight(self.font),
        love.graphics.getWidth(), 'center'
    )
    for _, button in ipairs(self.buttons) do
        button:draw()
    end
end

function inLevel:mousepressed(x, y)
    for _, button in ipairs(self.buttons) do
        button:mousepressed(x, y)
    end
end

return inLevel