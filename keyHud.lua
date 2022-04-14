local res = require 'res'

local KeyHud = {}

function KeyHud:new(target)
    self.__index = self

    local hud = setmetatable({}, self)
    hud.icon = res.icons.key
    hud.width = 125
    hud.height = 64
    hud.spacing = 16
    hud.x = 0
    hud.y = 0
    hud.target = target

    hud.color = res.colors.primary
    hud.darkColor = res.colors.darkShade
    hud.font = res.fonts.medium

    return hud
end

function KeyHud:constrain()
    self.width = self.height
    for _, key in ipairs(self.target.keys) do
        self.width = self.width + self.font:getWidth(key)  + self.spacing
    end
    self.x = (love.graphics.getWidth() - self.width)/2
end

local function getScale(image, width, height)
    return width/image:getWidth(), height/image:getHeight()
end

function KeyHud:draw()
    if #self.target.keys == 0 then return end
    -- Draw Icon
    local sw, sh = getScale(self.icon, self.height, self.height)
    love.graphics.setColor(self.color)
    love.graphics.draw(self.icon, self.x, self.y, 0, sw, sh)

    -- Draw numbers
    local y = self.y + (self.height - self.font:getHeight())/2
    local x = self.x + self.height + self.spacing
    love.graphics.setFont(self.font)

    for i, key in ipairs(self.target.keys) do
        if key > #self.target.stack then
            love.graphics.setColor(self.color)
        else
            love.graphics.setColor(self.darkColor)
        end
        love.graphics.print(key, x, y)
        x = x + self.font:getWidth(key) + self.spacing
    end
end

return KeyHud