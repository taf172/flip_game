local ui = require 'ui'
local res = require 'res'

local Game = {}
Game.mainMenu = require 'game/mainMenu'
Game.levelSelect = require 'game/levelSelect'
Game.inLevel = require 'game/inLevel'

Game.shopMenu = require 'game/shop'
Game.settingsMenu = require 'game/settings'

Game.currentState = Game.mainMenu
Game.currentLevel = 1

-- State Management
function Game:switch(state)
    state:load()
    self.currentState = state
end

function Game:switchLevel(n)
    self.inLevel.levelNo = self.currentLevel
    ui.buttons.playButton.text = 'No. '..Game.currentLevel
    self:switch(self.inLevel)
end

-- Logic??



-- Love2D callbacks
function Game:load()
    self:switch(self.mainMenu)
end

function Game:draw()
    self.currentState:draw()
end

function Game:update()
end

function Game:mousepressed(x, y)
    self.currentState:mousepressed(x, y)
end

return Game