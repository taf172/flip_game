local res = require 'res'

local Tile = require 'tile'
local Player = {}

function Player:new(x, y)
    local player = setmetatable({}, self)
    self.__index = self

    player.tile = Tile:new()
    player.tile.color = res.colors.playerColor

    player.trail = {}
    player.value = 0
    player.keys = {}

    player.font = res.fonts.bigFont
    player.textColor = {1, 1, 1}
    return player
end

function Player:setStart(tile, keys)
    self.value = 0
    self.keys = keys
    self.trail = {}
    self.tile.width = tile.width
    self.tile.height = tile.height
    self:moveForward(tile)
end

function Player:hasKey()
    for _, key in ipairs(self.keys) do
        if key == self.value + 1 then return true end
    end
    return false
end

function Player:inputTile(tile)
    if not tile then return false end

    if tile == self.trail[#self.trail - 1] then
        self:moveBack()
        return true
    end

    if tile.active and tile.locked then
        if self:hasKey() then
            self:moveForward(tile)
            return true
        else
            return false
        end
    end

    if tile.active then
        self:moveForward(tile)
        return true
    end

    if not tile.active then
        return false
    end

end

function Player:moveForward(tile)
    tile:deactivate()
    table.insert(self.trail, tile)
    self.tile.x = tile.x
    self.tile.y = tile.y
    self.value = self.value + 1
end

function Player:moveBack()
    table.remove(self.trail):activate()
    local last = self.trail[#self.trail]
    self.tile.x = last.x
    self.tile.y = last.y
    self.value = self.value - 1
end

function Player:drawTrail()
    if #self.trail <= 1 then return nil end
    love.graphics.setLineWidth(6)
    love.graphics.setColor(self.tile.color)
    for i = 2, #self.trail do
        local t1 = self.trail[i]
        local t2 = self.trail[i - 1]
        love.graphics.line(t1.x, t1.y, t2.x, t2.y)
    end
end

local function getScale(image, width, height)
    return width/image:getWidth(), height/image:getHeight()
end

function Player:draw()
    self:drawTrail()
    self.tile:draw()
    love.graphics.setColor{1, 1, 1}

    love.graphics.setFont(self.font)
    love.graphics.setColor(self.textColor)

    if self:hasKey() then
        local iw = self.tile.width - 20
        local sw, sh = getScale(res.images.keyIcon, iw, iw)
        love.graphics.draw(res.images.keyIcon, self.tile.x - iw/2, self.tile.y - iw/2, 0, sw, sh)
    else
        love.graphics.printf(
            self.value, self.tile.x - self.tile.width/2, self.tile.y - self.font:getHeight()/2, self.tile.width, 'center'
        )
    end

end

return Player