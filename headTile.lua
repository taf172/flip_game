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

function HeadTile:hasKey(n)
    for _, key in ipairs(self.keys) do
        if key == n then return true end
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
        self.alpha = 0
        return true
    end

    if tile.locked and not self:hasKey(#self.stack + 1) then
        res.audio.blocked:play()
        return false
    end

    if tile.active then
        self:push(tile)
        self.alpha = 0
        if not tile.locked and self:hasKey(#self.stack) then
            res.audio.keychime:play()
        else
            res.audio.move:play()
        end
        return true
    end

    return false
end

function HeadTile:push(tile)
    table.insert(self.stack, tile)
    if self:hasKey(#self.stack) then
        tile.icon = res.icons.key
        tile.textColor = res.colors.darkShade
    end
    tile:deactivate()
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
    self:top():drawConnector(self)
end

function HeadTile:update(dt)
    local top = self:top()
    if top then
        self.x = top.x
        self.y = top.y
        self.width = top.width
        self.height = top.height
    end
    if self:top() and self:top().locked then
        self.text = nil
        self.icon = nil
        self.active = false
    elseif self:hasKey(#self.stack) then
        self.text = nil
        self.icon = res.icons.key
    else
        self.text = #self.stack
        self.icon = nil
        self.active = true
    end

    --[[
    if self.alpha < 1 then
        self.alpha = self.alpha + (1 - self.alpha)*dt
    end
    --]]
end

return HeadTile