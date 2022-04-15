local ui = require 'ui'
local res = require 'res'
local palette = require 'palette'

local Level = require 'level'
local Game = {}
Game.mainMenu = require 'game/mainMenu'
Game.levelSelect = require 'game/levelSelect'
Game.inLevel = require 'game/inLevel'
Game.shopMenu = require 'game/shop'
Game.settingsMenu = require 'game/settings'

Game.tutorialLevels = require 'tutorial'
Game.levelNo = 1
Game.completedLevels = {}

Level.onClear = function () Game:onClear() end
Game.levelSelect.onLevelSelect = function (n)
    Game:selectLevel(n)
end

-- button :)
local paletteButton = ui.buttons.settingsButton
paletteButton.onPress = function ()
    palette:swap()
    Game:load()
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
    for i in pairs(self.completedLevels) do
        if self.completedLevels[i] then
            self.levelSelect.completedLevels[i] = true
        end
    end
    self.levelSelect:loadPage(1)
end

function Game:selectLevel(levelNo)
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
    if n <= #self.tutorialLevels then
        return self.tutorialLevels[n]
    elseif n < 20 then
        return Level:new(4, n)
    elseif n < 60 then
        return Level:new(5, n)
    end
    return Level:new(6, n)
end

function Game:loadLevel()
    self.level = self:getLevel(self.levelNo)
    self.level:load()
    ui.buttons.playButton.text = 'No. '..self.levelNo
    self.inLevel.title = 'No. '..self.levelNo
    self:save()
end

function Game:onClear()
    self.completedLevels[self.levelNo] = true
    self:next()
    res.audio.success:play()
end

-- Love2D callbacks
function Game:save()
    local completed = '0'
    for i in pairs(self.completedLevels) do
        completed = completed..' '..i
    end
    love.filesystem.write('save.txt', self.levelNo..'\n'..completed)
end

function Game:load()
    res.audio.music:play()
    self.state = self.mainMenu

    ---[[
    if not love.filesystem.getInfo('save.txt') then love.filesystem.write('save.txt', '1\n0') end
    local data = {}
    for line in love.filesystem.lines('save.txt') do
        table.insert(data, line)
    end
    for i in data[2]:gmatch('%w+') do
        self.completedLevels[tonumber(i)] = true
    end
    --]]

    self.levelNo = tonumber(data[1])
    self:loadLevel()
    self.state = self.mainMenu

end

local menu = ui.optionsMenu

function Game:draw()
    self.state:draw()
    if self.state == self.inLevel then
        self.level:draw()
    end
    menu:draw()
end

function Game:update(dt)
    self.level:update(dt)
end

function Game:keypressed(key)
    if self.state == self.inLevel then
        if key == 'right' or key == 'd' then self.level:input('right') end
        if key == 'left' or key == 'a' then self.level:input('left') end
        if key == 'up' or key == 'w' then self.level:input('up') end
        if key == 'down' or key == 's' then self.level:input('down') end
    end
end

function Game:mousepressed(x, y,  button, istouch, presses)
    self.state:mousepressed(x, y)
end

return Game