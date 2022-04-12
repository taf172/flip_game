local res = require 'res'
local Button = {}

function Button:new(icon, callback)
    self.__index = self

    local button = setmetatable({}, self)
    button.x = 0
    button.y = 0
    button.width = 100
    button.height = 50
    button.color = res.colors.primary
    button.icon = icon
    button.onPress = callback or function()end
    button.pressSound = res.audio.lock
    button.font = res.fonts.big
    button.roundness = 4
    return button
end

function Button:draw()
    love.graphics.setColor(self.color)
    if self.showOutline then
        love.graphics.setLineWidth(4)
        love.graphics.rectangle('line', self.x, self.y, self.width, self.height, self.roundness)
    end

    if self.icon then
        love.graphics.draw(self.icon, self.x, self.y)
    end

    if self.text then
        love.graphics.setFont(self.font)
        love.graphics.printf(
            self.text, self.x, self.y + self.height/2 - self.font:getHeight()/2,
            self.width, 'center'
        )
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