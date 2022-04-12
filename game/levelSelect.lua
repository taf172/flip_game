local res = require 'res'
local ui = require 'ui'

local levelSelectMenu = {}
levelSelectMenu.font = res.fonts.big
levelSelectMenu.textColor = res.colors.primary
levelSelectMenu.title = 'levels'
levelSelectMenu.titleHeight = love.graphics.getHeight()*0.1
levelSelectMenu.buttons = {
    ui.buttons.backButton,
}

function levelSelectMenu:load()
end

function levelSelectMenu:draw()
    love.graphics.setColor(self.textColor)
    love.graphics.setFont(self.font)
    love.graphics.printf(
        self.title, 0, ui:getTitleHeight(self.font),
        love.graphics.getWidth(), 'center'
    )
    for _, button in ipairs(self.buttons) do
        button:draw()
    end
end

function levelSelectMenu:update(dt)
end

function levelSelectMenu:mousepressed(x, y)
    for _, button in ipairs(self.buttons) do
        button:mousepressed(x, y)
    end
end

return levelSelectMenu