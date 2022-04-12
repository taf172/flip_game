local MenuBar = {}

function MenuBar:new()
    self.__index = self

    local bar = setmetatable({}, self)
    bar.buttons = {}
    bar.x = 0
    bar.y = 0
    bar.width = 100
    bar.height = 64
    bar.buttonSize = 64
    bar.spacing = 64

    return bar
end

function MenuBar:placeButtons()
    local x = self.width/2 - #self.buttons*self.buttonSize/2 - (#self.buttons - 1)*self.spacing/2
    local y = self.y + self.buttonSize/2
    for _, button in ipairs(self.buttons) do
        button.x = x
        button.y = y - button.height/2
        x = x + button.width + self.spacing
    end
end

function MenuBar:constrain(dir, ratio)
    self.width = love.graphics.getWidth()
    self.buttonSize = self.height
    self.x = 0
    if dir == 'top' then
        self.y = love.graphics.getHeight()*ratio
    elseif dir == 'bottom' then
        self.y = love.graphics.getHeight()*(1 - ratio) - self.height
    end
    self:placeButtons()
end

function MenuBar:add(button)
    table.insert(self.buttons, button)
    button.height = self.buttonSize
    button.width = self.buttonSize
    self:placeButtons()
end

function MenuBar:remove(button)
    for i, b in ipairs(self.buttons) do
        if button == b then
            table.remove(self.buttons, i)
        end
    end
    self:placeButtons()
end



function MenuBar:mousepressed(x, y)
    for _, button in ipairs(self.buttons) do
        button:mousepressed(x, y)
    end
end

function MenuBar:draw()
    --[[
    love.graphics.setColor(0.25, 0.25, 0.25)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    --]]

    for _, button in ipairs(self.buttons) do
        button:draw()
    end

end

return MenuBar