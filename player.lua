local res = require 'res'

local Tile = require 'tile'
local Player = {}

function Player:new(x, y)
    local player = setmetatable({}, self)
    self.__index = self

    player.tile = Tile:new()
    player.tile.color = res.colors.primary

    player.trail = {}
    player.value = 0
    player.keys = {}

    player.font = res.fonts.bigFont
    player.textColor = res.colors.lightShade
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

    if not tile.active then
        return false
    end

    if tile.locked then
        if self:hasKey() then
            -- Unlock tile
            self:moveForward(tile)
            return true
        else
            -- Locked tile error
            res.audio.blockedSFX:play()
            return false
        end
    end

    if self:hasKey() then
        -- Key but no lock error
        res.audio.keychimeSFX:play()
        return false
    end

    self:moveForward(tile)
    return true

end

function Player:moveForward(tile)
    tile:deactivate()
    table.insert(self.trail, tile)
    self.tile.x = tile.x
    self.tile.y = tile.y
    self.value = self.value + 1
    res.audio.moveSFX:play()
    if self:hasKey() then res.audio.keychimeSFX:play() end
end

function Player:moveBack()
    table.remove(self.trail):activate()
    local last = self.trail[#self.trail]
    self.tile.x = last.x
    self.tile.y = last.y
    self.value = self.value - 1
    res.audio.moveSFX:play()
end

function Player:drawTrail()
    if #self.trail <= 1 then return nil end
    love.graphics.setColor(self.tile.color)
    for i = 2, #self.trail do
        local t1 = self.trail[i]
        local t2 = self.trail[i - 1]
        t2:drawConnector(t1)
    end
end

local function getScale(image, width, height)
    return width/image:getWidth(), height/image:getHeight()
end

function Player:smallVal()
    for _, key in ipairs(self.keys) do
        if key - self.value > 0 then return key - self.value end
    end
    return 0
end

function Player:draw()
    self.tile:draw()
    love.graphics.setColor{1, 1, 1}

    love.graphics.setFont(self.font)
    love.graphics.setColor(self.textColor)

    if self:hasKey() and false then
        local iw = self.tile.width - 20
        local sw, sh = getScale(res.images.keyIcon, iw, iw)
        love.graphics.draw(res.images.keyIcon, self.tile.x - iw/2, self.tile.y - iw/2, 0, sw, sh)
    else
        love.graphics.printf(
            self:smallVal(), self.tile.x - self.tile.width/2, self.tile.y - self.font:getHeight()/2, self.tile.width, 'center'
        )
    end

end

return Player