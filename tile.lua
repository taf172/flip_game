local res = require 'res'

local Tile = {}

function Tile:new(x, y)
    local tile = setmetatable({}, self)
    self.__index = self

    tile.render = true
    tile.x = x or 0
    tile.y = y or 0
    tile.width = 64
    tile.height = 64
    tile.roundness = 2

    tile.font = res.fonts.big
    tile.color = res.colors.darkShade
    tile.textColor = res.colors.lightShade

    tile:activate()
    return tile
end

function Tile:setLocked()
    self.textColor = res.colors.lightShade
    self.icon = res.icons.lockClosed
    self.color = res.colors.accent
    self.locked = true
end

function Tile:activate()
    if self.locked then
        self.textColor = res.colors.lightShade
        self.icon = res.icons.lockClosed
    end
    self.active = true
end

function Tile:deactivate()
    if self.locked then
        self.textColor = res.colors.darkShade
        self.icon = res.icons.lockOpen
    end
    self.active = false
end

function Tile:drawConnector(tile)
    local x = math.min(self.x, tile.x)
    local y = math.min(self.y, tile.y)
    local width = math.abs(self.x - tile.x) + self.width
    local height = math.abs(self.y - tile.y) + self.height
    love.graphics.rectangle(
        'fill', x, y, width, height, self.roundness
    )
end

local function getScale(image, width, height)
    return width/image:getWidth(), height/image:getHeight()
end

function Tile:draw()
    if not self.active then return end
    love.graphics.setColor(self.color)
    love.graphics.rectangle(
        'fill', self.x, self.y, self.width, self.height, self.roundness
    )

    love.graphics.setColor(self.textColor)
    if self.text then
        love.graphics.setFont(self.font)
        love.graphics.printf(
            self.text, self.x, self.y + (self.height - self.font:getHeight())/2,
            self.width, 'center'
        )
    end

    if self.icon then
        local sw, sh = getScale(self.icon, self.width, self.height)
        love.graphics.draw(self.icon, self.x, self.y, 0, sw, sh)
    end
end

return Tile