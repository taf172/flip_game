local ui = require 'ui'
local res = require 'res'

local Level = require 'level'
local Game = {}
Game.mainMenu = require 'game/mainMenu'
Game.levelSelect = require 'game/levelSelect'
Game.inLevel = require 'game/inLevel'
Game.shopMenu = require 'game/shop'
Game.settingsMenu = require 'game/settings'

Game.levels = {
    Level:new(2, 1),
    Level:new(3, 1),
    Level:new(4, 1),
    Level:new(5, 1),
    Level:new(6, 1),
}

-- State Management
function Game:startGame()
    self.state = self.inLevel
    self.level:load()
end

function Game:toMainMenu()
    self.state = self.mainMenu
end

function Game:toLevelSelect()
    self.state = self.levelSelect
end

function Game:back()
    if self.state == self.inLevel and self.levelNo > 1 then
        self.levelNo = self.levelNo - 1
        self:loadLevel()
    else
        self:toMainMenu()
    end
end

function Game:next()
    if self.state == self.inLevel then
        self.levelNo = self.levelNo + 1
        self:loadLevel()
    end
end

-- Level Management??
function Game:getLevel(n)
    while #self.levels < n do
        table.insert(self.levels, Level:new(6))
    end
    return self.levels[n]
end

function Game:loadLevel()
    self.level = self:getLevel(self.levelNo)
    self.level:load()
    ui.buttons.playButton.text = 'No. '..self.levelNo
    self.inLevel.title = 'No. '..self.levelNo
end

-- Love2D callbacks
function Game:load()
    self.state = self.mainMenu
    self.level = self.levels[1]
    self.levelNo = 1
    self.state = self.mainMenu
end

function Game:draw()
    self.state:draw()
    if self.state == self.inLevel then
        self.level:draw()
    end
end

function Game:update(dt)
    self.level:update(dt)
end

function Game:keypressed(key)
    if key == 'right' or key == 'd' then self.level:input('right') end
    if key == 'left' or key == 'a' then self.level:input('left') end
    if key == 'up' or key == 'w' then self.level:input('up') end
    if key == 'down' or key == 's' then self.level:input('down') end
end

function Game:mousepressed(x, y,  button, istouch, presses)
    self.state:mousepressed(x, y)
end

return Game