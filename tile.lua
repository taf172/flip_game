local res = require 'res'

local Tile = {}

local grey = {0.75, 0.75, 0.75}
local red = {1, 0.25, 0.25}
local green = {0.25, 1, 0.25}

function Tile:new(x, y)
    local tile = setmetatable({}, self)
    self.__index = self

    tile.x = x or 0
    tile.y = y or 0
    tile.width = 64
    tile.height = 64
    tile.color = grey

    tile.textColor = {1, 1, 1}
    tile.font = love.graphics.getFont()

    tile:activate()
    return tile
end

function Tile:setLock()

    self.locked = true
end

function Tile:activate()
    self.active = true
end

function Tile:deactivate()
    self.active = false
end

local function getScale(image, width, height)
    return width/image:getWidth(), height/image:getHeight()
end

function Tile:draw()
    if not self.active then return end
    love.graphics.setColor(self.color)
    if self.locked then love.graphics.setColor{0.25, 0.25, 0.25} end
    love.graphics.rectangle('fill', self.x - self.width/2, self.y - self.height/2, self.width, self.height)

    love.graphics.setColor(self.textColor)
    if self.text then
        love.graphics.printf(
            self.text, self.x, self.y + self.height/2 - self.font:getHeight()/2, self.width, 'center'
        )
    end

    if self.locked then
        local iw = self.width - 20
        local sw, sh = getScale(res.images.lockIcon, iw, iw)
        love.graphics.draw(res.images.lockIcon, self.x - iw/2, self.y - iw/2, 0, sw, sh)
    end
end

return Tile