local res = require 'res'

local KeyHud = {}

function KeyHud:new(target)
    self.__index = self

    local hud = setmetatable({}, self)
    hud.icon = res.icons.key
    hud.width = 125
    hud.height = 32
    hud.spacing = 10
    hud.x = 0
    hud.y = 0
    hud.target = target
    hud.alpha = 1
    hud.color = res.colors.primary
    hud.darkColor = res.colors.darkShade
    hud.font = res.fonts.small

    return hud
end

function KeyHud:constrain(obj)
    self.y = obj.y - self.height*1.5
    self.width = self.height
    for _, key in ipairs(self.target.keys) do
        self.width = self.width + self.font:getWidth(key)  + self.spacing
    end
    self.x = (love.graphics.getWidth() - self.width)/2
end

function KeyHud:draw()
    if #self.target.keys == 0 then return end
    -- Draw Icon
    love.graphics.setColor(
        self.color[1], self.color[2], self.color[3], self.alpha
    )
    self.icon:scale(self.height, self.height)
    self.icon:draw(self.x, self.y)

    -- Draw numbers
    local y = self.y + (self.height - self.font:getHeight())/2
    local x = self.x + self.height + self.spacing
    love.graphics.setFont(self.font)

    for i, key in ipairs(self.target.keys) do
        if key > #self.target.stack then
            love.graphics.setColor(
                self.color[1], self.color[2], self.color[3], self.alpha
            )
        else
            love.graphics.setColor(
                self.darkColor[1], self.darkColor[2], self.darkColor[3], self.alpha
            )
        end
        love.graphics.print(key, x, y)
        x = x + self.font:getWidth(key) + self.spacing
    end
end

return KeyHud