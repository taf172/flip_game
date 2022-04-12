local res = require 'res'
local Button = {}

function Button:new(icon, callback)
    self.__index = self

    local button = setmetatable({}, self)
    button.x = 0
    button.y = 0
    button.width = 100
    button.height = 50
    button.icon = icon
    button.iconColor = res.colors.primary
    button.onPress = callback or function()end
    button.pressSound = res.audio.lock
    return button
end

function Button:draw()
    if self.icon then
        love.graphics.setColor(self.iconColor)
        love.graphics.draw(self.icon, self.x, self.y)
    end
end

function Button:mousepressed(x, y)
    if x > self.x and x < self.x + self.width
    and y > self.y and y < self.y + self.height then
        self.onPress()
        self.pressSound:play()
    end
end

return Button