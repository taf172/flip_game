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
function Game:switch(state)
    self.currentState = state
end

-- Level Management??
function Game:loadLevel()
    ui.buttons.playButton.text = 'No. '..self.levelNo
    self.inLevel.title = 'No. '..self.levelNo
    self.currentLevel = self.levels[self.levelNo]
    self.currentLevel:load()
end

function Game:nextLevel()
    self.levelNo = self.levelNo + 1
    self:loadLevel()
end

function Game:previousLevel()
    if self.levelNo == 1 then return end
    self.levelNo = self.levelNo - 1
    self:loadLevel()
end

function Game:input(dir)
end

-- Love2D callbacks
function Game:load()
    self.currentState = self.mainMenu
    self.currentLevel = self.levels[1]
    self.levelNo = 1
    self:switch(self.mainMenu)
end

function Game:draw()
    self.currentState:draw()
    if self.currentState == self.inLevel then
        self.currentLevel:draw()
    end
end

function Game:update(dt)
    self.currentLevel:update(dt)
end

function Game:keypressed(key)
    if key == 'right' then self.currentLevel:input('right') end
    if key == 'left' then self.currentLevel:input('left') end
    if key == 'up' then self.currentLevel:input('up') end
    if key == 'down' then self.currentLevel:input('down') end
end

function Game:mousepressed(x, y,  button, istouch, presses)
    self.currentState:mousepressed(x, y)
end

return Game