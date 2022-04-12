local res = require 'res'
local ui = require 'ui'

local Level = require 'level'

local inLevel = {}
inLevel.font = res.fonts.big
inLevel.textColor = res.colors.primary
inLevel.title = 'No. '
inLevel.titleHeight = love.graphics.getHeight()
inLevel.buttons = {
    ui.buttons.backButton,
    ui.buttons.nextButton,
    ui.buttons.undoButton,
    ui.buttons.resetButton,
    ui.buttons.menuButton,
}

inLevel.levelNo = 1

local levels = {
    Level:new(2, 1),
    Level:new(3, 1),
    Level:new(4, 1),
    Level:new(5, 1),
    Level:new(6, 1),
}

function inLevel:load()
    self.level = levels[self.levelNo]
    self.level:load()
end

function inLevel:draw()
    love.graphics.setColor(self.textColor)
    love.graphics.setFont(self.font)
    love.graphics.printf(
        self.title..self.levelNo, 0, ui:getTitleHeight(self.font),
        love.graphics.getWidth(), 'center'
    )
    for _, button in ipairs(self.buttons) do
        button:draw()
    end
    self.level.board:draw()
end

function inLevel:mousepressed(x, y)
    for _, button in ipairs(self.buttons) do
        button:mousepressed(x, y)
    end
end

return inLevel