local res = require 'res'

local Tile = {}

function Tile:new(x, y)
    local tile = setmetatable({}, self)
    self.__index = self

    tile.x = x or 0
    tile.y = y or 0
    tile.width = 64
    tile.height = 64
    tile.roundness = 6

    tile.openIcon = res.images.openLockIcon
    tile.lockedIcon = res.images.lockIcon

    tile.color = res.colors.darkShade
    tile.textColor = res.colors.lightShade
    tile.lockedColor = res.colors.darkAccent

    tile.font = love.graphics.getFont()

    tile:activate()
    return tile
end

function Tile:setLock()
    self.color = self.lockedColor
    self.icon = self.lockedIcon
    self.locked = true
end

function Tile:activate()
    if self.locked then
        res.audio.lockSFX:play()
        self.icon = self.lockedIcon
        self.textColor = res.colors.lightShade
    end
    self.active = true
end

function Tile:deactivate()
    if self.locked then
        res.audio.unlockSFX:play()
        self.icon = self.openIcon
        self.textColor = res.colors.darkShade
    end
    self.active = false
end

local function getScale(image, width, height)
    return width/image:getWidth(), height/image:getHeight()
end

function Tile:drawConnector(tile)
    local x = math.min(self.x, tile.x)
    local y = math.min(self.y, tile.y)
    local width = math.abs(self.x - tile.x) + self.width
    local height = math.abs(self.y - tile.y) + self.height
    love.graphics.rectangle(
        'fill', x - self.width/2, y - self.height/2, width, height, self.roundness
    )
end

function Tile:draw()
    -- Draw rect
    if self.active then
        love.graphics.setColor(self.color)
        love.graphics.rectangle(
            'fill', self.x - self.width/2, self.y - self.height/2, self.width, self.height, self.roundness
        )
    end

    -- Draw icon
    if self.icon then
        local iw = self.width - 20
        local sw, sh = getScale(self.icon, iw, iw)
        love.graphics.setColor(self.textColor)
        love.graphics.draw(self.icon, self.x - iw/2, self.y - iw/2, 0, sw, sh)
    end
end

return Tile