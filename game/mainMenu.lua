local res = require 'res'
local ui = require 'ui'

local mainMenu = {}
mainMenu.font = res.fonts.big
mainMenu.textColor = res.colors.primary
mainMenu.title = 'pathlock'
mainMenu.titleHeight = love.graphics.getHeight()*0.15
mainMenu.buttons = {
    ui.buttons.playButton,
    ui.buttons.volumeButton,
    ui.buttons.settingsButton,
    ui.buttons.levelSelectButton,
}

ui.buttons.playButton.font = res.fonts.big

local volumeButton = ui.buttons.volumeButton
local volume = 2
love.audio.setVolume(0.3)

volumeButton.onPress = function ()
    volume = (volume - 1) % 3
    if volume == 0 then
        volumeButton.icon = res.icons.volumeOff
        love.audio.setVolume(0)
    elseif volume == 1 then
        volumeButton.icon = res.icons.volumeLow
        love.audio.setVolume(0.1)
    elseif volume == 2 then
        volumeButton.icon = res.icons.volumeHigh
        love.audio.setVolume(0.3)
    end
end

function mainMenu:draw()
    love.graphics.setColor(res.colors.primary)
    love.graphics.setFont(self.font)
    res.images.title:draw(love.graphics.getWidth()/2, love.graphics.getHeight()*0.15, 'centered')
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