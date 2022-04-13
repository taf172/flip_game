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

    tile.alpha = 1
    tile.font = res.fonts.big
    tile.color = res.colors.darkShade
    tile.textColor = res.colors.lightShade
    tile.active = true

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
    self.icon = nil
    if self.locked then
        self.textColor = res.colors.lightShade
        self.icon = res.icons.lockClosed
        res.audio.lock:play()
    end
    self.active = true
end

function Tile:deactivate()
    if self.locked then
        self.textColor = res.colors.darkShade
        self.icon = res.icons.lockOpen
        res.audio.unlock:play()
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

    if self.active then
        love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.alpha)
        love.graphics.rectangle(
            'fill', self.x, self.y, self.width, self.height, self.roundness
        )
    end

    love.graphics.setColor(self.textColor, self.alpha)
    if self.text then
        love.graphics.setFont(self.font)
        love.graphics.printf(
            self.text, self.x, self.y + (self.height - self.font:getHeight())/2,
            self.width, 'center'
        )
    end

    if self.icon then
        local sw, sh = getScale(self.icon, self.width*0.75, self.height*0.75)
        love.graphics.draw(
            self.icon, self.x + self.width*0.25/2, self.y + self.height*0.25/2, 0, sw, sh
        )
    end
end

return Tile