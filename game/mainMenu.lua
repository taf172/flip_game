local res = require 'res'
local ui = require 'ui'

local mainMenu = {}
mainMenu.font = res.fonts.extraBig
mainMenu.textColor = res.colors.primary
mainMenu.title = 'pathlock'
mainMenu.titleHeight = love.graphics.getHeight()*0.15
mainMenu.buttons = {
    ui.buttons.playButton,
    ui.buttons.shopButton,
    ui.buttons.settingsButton,
    ui.buttons.levelSelectButton,
}

function mainMenu:draw()
    love.graphics.setColor(self.textColor)
    love.graphics.setFont(self.font)
    love.graphics.draw(
        res.images.title, (love.graphics.getWidth() - res.images.title:getWidth())/2,
        love.graphics.getHeight()*0.15
    )
    for _, button in ipairs(self.buttons) do
        button:draw()
    end
end

function mainMenu:mousepressed(x, y)
    for _, button in ipairs(self.buttons) do
        button:mousepressed(x, y)
    end
end

return mainMenu