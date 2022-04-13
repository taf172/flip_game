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
}

Level.onClear = function () Game:onClear() end
Game.levelSelect.onLevelSelect = function (n)
    Game:onLevelSelect(n)
end

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
    for i, level in ipairs(self.levels) do
        if level.completed then
            self.levelSelect.completedLevels[i] = true
        end
    end
    self.levelSelect:loadPage(1)
end

function Game:onLevelSelect(levelNo)
    self.levelNo = levelNo
    self:loadLevel()
    self.state = Game.inLevel
end

function Game:back()
    if self.state == self.inLevel and self.levelNo > 1 then
        self.levelNo = self.levelNo - 1
        self:loadLevel()
    elseif self.state == self.levelSelect and self.levelSelect.pageNo > 1 then
        self.levelSelect:loadPage(self.levelSelect.pageNo - 1)
    else
        self:toMainMenu()
    end
end

function Game:next()
    if self.state == self.inLevel then
        self.levelNo = self.levelNo + 1
        self:loadLevel()
    end
    if self.state == self.levelSelect then
        self.levelSelect:loadPage(self.levelSelect.pageNo + 1)
    end
end

-- Level Management??
function Game:getLevel(n)
    if not self.levels[n] then
        self.levels[n] = Level:new(6, n)
    end
    return self.levels[n]
end

function Game:loadLevel()
    self.level = self:getLevel(self.levelNo)
    self.level:load()
    ui.buttons.playButton.text = 'No. '..self.levelNo
    self.inLevel.title = 'No. '..self.levelNo
end

function Game:onClear()
    self:next()
    res.audio.success:play()
end

-- Love2D callbacks
function Game:load()
    self.state = self.mainMenu
    self.level = self.levels[1]
    self.levelNo = 1
    self.state = self.mainMenu

    ---[[ Debug stuff
        self.levels[1].completed = true
        self.levels[2].completed = true
        self.levels[3].completed = true
    --]]
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