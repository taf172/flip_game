local res = require 'res'

local Tile = require 'tile'
local HeadTile = Tile:new()

function HeadTile:new()
    self.__index = self

    local head = setmetatable(Tile:new(), self)
    head.color = res.colors.primary
    head.text = 0
    head.stack = {}
    head.render = true

    return head
end

function HeadTile:clearStack()
    self.stack = {}
end

function HeadTile:input(tile)
    if not tile then return false end

    if tile == self.stack[#self.stack - 1] then
        self:pop()
        return true
    end

    if self:push(tile) then
        return true
    end

    return false
end

function HeadTile:push(tile)
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

function HeadTile:update(dt)
    local top = self:top()
    if top then
        self.x = top.x
        self.y = top.y
        self.width = top.width
        self.height = top.height
    end
    self.text = #self.stack
end

return HeadTile