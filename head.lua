local res = require 'res'

local Tile = require 'tile'
local HeadTile = Tile:new()

function HeadTile:new(tile, max)
    self.__index = self

    local head = setmetatable(tile or Tile:new(), self)
    head.color = res.colors.primary
    head.max = max + 1
    head.text = head.max - 1
    head.stack = {}

    return head
end

function HeadTile:activate()
    self.render = true
end

function HeadTile:input(tile)
    if not tile then return false end

    if tile == self.stack[#self.stack - 1] then
        self:pop()
        self.text = self.max - #self.stack
        return true
    end

    if self:push(tile) then
        self.text = self.max - #self.stack
        return true
    end

    return false
end

function HeadTile:push(tile)
    if #self.stack >= self.max then return false end
    if not tile.active then return false end

    tile:deactivate()
    table.insert(self.stack, tile)
    return true
end

function HeadTile:pop()
    self:top():activate()
    return table.remove(self.stack)
end

function HeadTile:top()
    return self.stack[#self.stack]
end

function HeadTile:drawStack()
    if #self.stack == 1 then return end
    love.graphics.setColor(self.color)
    for i = 2, #self.stack do
        self.stack[i]:drawConnector(self.stack[i -1])
    end
end

function HeadTile:draw()
    self:drawStack()
    Tile.draw(self)
end

return HeadTile