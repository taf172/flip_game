local res = require 'res'

local Tile = require 'tile'
local HeadTile = Tile:new()

function HeadTile:new(keys)
    self.__index = self

    local head = setmetatable(Tile:new(), self)
    head.color = res.colors.primary
    head.text = 0
    head.stack = {}
    head.render = true
    head.keys = keys or {}
    return head
end

function HeadTile:hasKey()
    for _, key in ipairs(self.keys) do
        if key == #self.stack + 1 then return true end
    end
    return false
end

function HeadTile:clearStack()
    self.stack = {}
end

function HeadTile:attemptMove(tile)
    if not tile then return false end

    if tile == self.stack[#self.stack - 1] then
        self:pop()
        return true
    end

    if tile.locked and not self:hasKey() then
        return false
    end

    if tile.active then
        self:push(tile)
        return true
    end

    return false
end

function HeadTile:push(tile)
    tile:deactivate()
    table.insert(self.stack, tile)
end

function HeadTile:pop()
    self:top():activate()
    table.remove(self.stack)
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
    if self:hasKey() then
        self.text = nil
        self.icon = res.icons.key
    else
        self.text = #self.stack
        self.icon = nil
    end
end

return HeadTile