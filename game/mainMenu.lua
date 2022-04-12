local res = require 'res'
local ui = require 'ui'

local mainMenu = {}
mainMenu.font = res.fonts.extraBig
mainMenu.textColor = res.colors.primary
mainMenu.title = 'pathlock'
mainMenu.titleHeight = love.graphics.getHeight()*0.1
mainMenu.buttons = {
    ui.buttons.playButton,
    ui.buttons.shopButton,
    ui.buttons.settingsButton,
    ui.buttons.levelSelectButton,
}

function mainMenu:load()
end

function mainMenu:draw()
    love.graphics.setColor(self.textColor)
    love.graphics.setFont(self.font)
    love.graphics.printf(
        self.title, 0, self.titleHeight, love.graphics.getWidth(), 'center'
    )
    for _, button in ipairs(self.buttons) do
        button:draw()
    end
end

function mainMenu:update()
end

function mainMenu:mousepressed(x, y)
    for _, button in ipairs(self.buttons) do
        button:mousepressed(x, y)
    end
end

return mainMenu