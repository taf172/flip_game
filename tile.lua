local res = require 'res'
local tween = require 'tween'

local Tile = {}

function Tile:new(x, y, delay)
    local tile = setmetatable({}, self)
    self.__index = self

    tile.render = true
    tile.x = x or 0
    tile.y = y or 0
    tile.roundness = 2
    tile.size = 64
    tile.width = tile.size
    tile.height = tile.size

    tile.alpha = 1
    tile.font = res.fonts.big
    tile.color = res.colors.darkShade
    tile.textColor = res.colors.lightShade
    tile.active = true

    tile:fadeIn(delay)
    tile:growIn(delay)
    return tile
end

function Tile:fadeIn(delay)
    self.alpha = 0
    tween:quadOut(self, 'alpha', 1, 0.25, delay)
end
function Tile:growIn(delay)
    self.width = 0
    self.height = 0
    local r = math.random()/10
    tween:quadOut(self, 'width', self.size, 0.25, delay)
    tween:quadOut(self, 'height', self.size, 0.25, delay)
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
    love.graphics.push()
    love.graphics.translate(-self.height/2, -self.width/2)
    local x = math.min(self.x, tile.x)
    local y = math.min(self.y, tile.y)
    local width = math.abs(self.x - tile.x) + self.width
    local height = math.abs(self.y - tile.y) + self.height
    love.graphics.rectangle(
        'fill', x, y, width, height, self.roundness
    )
    love.graphics.pop()
end

local function getScale(image, width, height)
    return width/image:getWidth(), height/image:getHeight()
end

function Tile:draw()
    love.graphics.push()
    love.graphics.translate(-self.height/2, -self.width/2)
    if self.active then
        if self.width > 0 and self.height > 0 then
            love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.alpha)
            love.graphics.rectangle(
                'fill', self.x , self.y, self.width, self.height, self.roundness
            )
        end
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
    love.graphics.pop()
end

return Tile