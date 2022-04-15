local res = require 'res'
local Button = require 'ui/button'
local MenuBar = require 'ui/menuBar'
local Menu = require 'ui/menu'

local ui = {
    font = res.fonts.big,
    fontHeight = res.fonts.big:getHeight(),
    levelText = '3 - 12',
    barRatio = 1/25
}

ui.buttons = {
    resetButton = Button:new(res.icons.reset),
    undoButton = Button:new(res.icons.undo),
    backButton = Button:new(res.icons.back),
    nextButton = Button:new(res.icons.forward),
    menuButton = Button:new(res.icons.menu),
    levelSelectButton = Button:new(res.icons.grid),
    settingsButton = Button:new(res.icons.drop),
    shopButton = Button:new(res.icons.cart),
    gridSize4Button = Button:new(),
    gridSize5Button = Button:new(),
    gridSize6Button = Button:new(),
    tutorialButton = Button:new(),
    bigBackButton = Button:new(),
    volumeButton = Button:new(res.icons.volumeHigh),
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
ui.mainMenuBar:add(ui.buttons.volumeButton)
ui.mainMenuBar:add(ui.buttons.settingsButton)

ui.gridSizeBar = MenuBar:new()
ui.gridSizeBar:add(ui.buttons.tutorialButton)
ui.gridSizeBar:add(ui.buttons.gridSize4Button)
ui.gridSizeBar:add(ui.buttons.gridSize5Button)
ui.gridSizeBar:add(ui.buttons.gridSize6Button)

ui.buttons.tutorialButton.text = 'T'
ui.buttons.gridSize4Button.text = '4'
ui.buttons.gridSize5Button.text = '5'
ui.buttons.gridSize6Button.text = '6'
ui.buttons.tutorialButton.showOutline = true
ui.buttons.gridSize4Button.showOutline = true
ui.buttons.gridSize5Button.showOutline = true
ui.buttons.gridSize6Button.showOutline = true

ui.storeMenu = Menu:new()
ui.optionsMenu = Menu:new()


--[[
ui.buttons.gridSize4Button.width = 128
ui.buttons.gridSize5Button.width = 128
ui.buttons.gridSize6Button.width = 128
--]]

ui.levelSelectBars = {}
for i = 1, 6 do
    local bar = MenuBar:new()
    bar.spacing = 8

    for j = 1, 5 do
        local button = Button:new()
        button.showOutline = true
        button.text = 0
        bar:add(button)
    end
    table.insert(ui.levelSelectBars, bar)
end

function ui:constrain()
    local ww, wh = love.graphics.getDimensions()

    self.buttons.playButton.height = ww/3
    self.buttons.playButton.width = ww/3
    self.buttons.playButton.x = ww/2 - self.buttons.playButton.width/2
    self.buttons.playButton.y = wh/2 - self.buttons.playButton.height/2

    self.levelMenuBar:constrain('top', self.barRatio)
    self.levelMenuBar.spacing = 64*3
    self.levelMenuBar:placeButtons()

    self.buttons.bigBackButton.text = 'back'
    self.buttons.bigBackButton.showOutline = true
    self.buttons.bigBackButton.width = 64*2
    self.buttons.bigBackButton.y = wh - wh*self.barRatio*3
    self.buttons.bigBackButton.x = ww/2 - self.buttons.bigBackButton.width/2


    self.puzzleMenuBar:constrain('bottom', self.barRatio)
    self.mainMenuBar:constrain('bottom', 0.15)
    self.gridSizeBar:constrain('bottom', self.barRatio*2.5)

    local top = self.levelSelectBars[1]
    for _, bar in ipairs(self.levelSelectBars) do
        bar:constrain('top', self.barRatio*4)
    end
    for i, bar in ipairs(self.levelSelectBars) do
        bar.y = top.y + (i - 1)*(top.height + top.spacing)
        bar:placeButtons()
    end
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