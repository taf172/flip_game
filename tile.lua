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

function Tile:activate()
    self.render = true
    self.active = true
end

function Tile:deactivate()
    self.render = false
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

function Tile:draw()
    if not self.render then return false end
    love.graphics.setColor(self.color)
    love.graphics.rectangle(
        'fill', self.x, self.y, self.width, self.height, self.roundness
    )

    if self.text then
        love.graphics.setFont(self.font)
        love.graphics.setColor(self.textColor)
        love.graphics.printf(
            self.text, self.x, self.y + (self.height - self.font:getHeight())/2,
            self.width, 'center'
        )
    end
end

return Tile