local res = require 'res'
local Button = require 'ui/button'
local MenuBar = require 'ui/menuBar'

local ui = {
    font = res.fonts.big,
    fontHeight = res.fonts.big:getHeight(),
    levelText = '3 - 12',
    barRatio = 1/15
}

ui.buttons = {
    backButton = Button:new(res.icons.back),
    nextButton = Button:new(res.icons.forward),
    menuButton = Button:new(res.icons.menu),
    resetButton = Button:new(res.icons.reset),
    undoButton = Button:new(res.icons.undo),
    levelSelectButton = Button:new(res.icons.grid),
    settingsButton = Button:new(res.icons.settings),
    shopButton = Button:new(res.icons.cart),
}

ui.buttons.playButton = Button:new()
ui.buttons.playButton.showOutline = true
ui.buttons.playButton.text = 'play'

ui.levelMenuBar = MenuBar:new()
ui.levelMenuBar.spacing = 64*3
ui.levelMenuBar:add(ui.buttons.backButton)
ui.levelMenuBar:add(ui.buttons.nextButton)

ui.puzzleMenuBar = MenuBar:new()
ui.puzzleMenuBar:add(ui.buttons.menuButton)
ui.puzzleMenuBar:add(ui.buttons.resetButton)
ui.puzzleMenuBar:add(ui.buttons.undoButton)

ui.mainMenuBar = MenuBar:new()
ui.mainMenuBar.spacing = 32
ui.mainMenuBar:add(ui.buttons.levelSelectButton)
ui.mainMenuBar:add(ui.buttons.shopButton)
ui.mainMenuBar:add(ui.buttons.settingsButton)

function ui:constrain()
    local ww, wh = love.graphics.getDimensions()

    self.buttons.playButton.height = ww/3
    self.buttons.playButton.width = ww/3
    self.buttons.playButton.x = ww/2 - self.buttons.playButton.width/2
    self.buttons.playButton.y = wh/2 - self.buttons.playButton.height/2

    self.levelMenuBar:constrain('top', ui.barRatio)
    self.puzzleMenuBar:constrain('bottom', ui.barRatio)
    self.mainMenuBar:constrain('bottom', 0.15)
end

function ui:getTitleHeight(font)
    return self.levelMenuBar.y + (self.levelMenuBar.height- font:getHeight())/2
end

function ui:drawCenterLines()
    local ww, wh = love.graphics.getDimensions()
    love.graphics.setColor{0, 1, 0}
    love.graphics.line(ww/2, 0, ww/2, wh)
    love.graphics.line(0, wh/2, ww, wh/2)
end

return ui