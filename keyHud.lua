local res = require 'res'

local KeyHud = {}

function KeyHud:new(player)
    self.__index = self

    local hud = setmetatable({}, self)
    hud.icon = res.images.keyIcon
    hud.width = 125
    hud.height = 50
    hud.spacing = 16
    hud.x = 0
    hud.y = 0
    hud.player = player

    hud.color = res.colors.primary
    hud.darkColor = res.colors.darkShade
    hud.font = res.fonts.bigFont

    return hud
end

function KeyHud:constrain(obj)
    self.x = obj.x
    self.y = obj.y - self.height - 25
end

local function getScale(image, width, height)
    return width/image:getWidth(), height/image:getHeight()
end

function KeyHud:draw()
    -- Draw Icon
    local sw, sh = getScale(self.icon, self.height, self.height)
    love.graphics.setColor(self.color)
    love.graphics.draw(self.icon, self.x, self.y, 0, sw, sh)

    -- Draw numbers
    local y = self.y + (self.height - self.font:getHeight())/2
    local x = self.x + self.height + self.spacing
    love.graphics.setFont(self.font)

    for _, key in ipairs(self.player.keys) do
        if key > self.player.value then
            love.graphics.setColor(self.color)
        else
            love.graphics.setColor(self.darkColor)
        end
        love.graphics.print(key - 1, x, y)
        x = x + self.font:getWidth(key) + self.spacing
    end
end

return KeyHud