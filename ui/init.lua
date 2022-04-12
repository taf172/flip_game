local res = require 'res'
local Button = require 'ui/button'
local MenuBar = require 'ui/menuBar'

local barRatio = 1/15
local ui = {
    font = res.fonts.big,
    fontHeight = res.fonts.big:getHeight(),
    levelText = '3 - 12',
}

ui.buttons = {
    backButton = Button:new(res.icons.back),
    nextButton = Button:new(res.icons.forward),
    menuButton = Button:new(res.icons.menu),
    resetButton = Button:new(res.icons.reset),
    undoButton = Button:new(res.icons.undo),
}

local levelMenuBar = MenuBar:new()
levelMenuBar.spacing = 64*3
levelMenuBar:constrain('top', barRatio)
levelMenuBar:add(ui.buttons.backButton)
levelMenuBar:add(ui.buttons.nextButton)


local puzzleMenuBar = MenuBar:new()
puzzleMenuBar:constrain('bottom', barRatio)
puzzleMenuBar:add(ui.buttons.menuButton)
puzzleMenuBar:add(ui.buttons.resetButton)
puzzleMenuBar:add(ui.buttons.undoButton)

function ui:constrain()
    ui.width = love.graphics.getWidth()
    ui.height = love.graphics.getHeight()
end

function ui:draw()
    for _, button in pairs(self.buttons) do
        button:draw()
    end
    love.graphics.setFont(self.font)
    love.graphics.printf(
        self.levelText, 
        levelMenuBar.x, levelMenuBar.y + (levelMenuBar.height - self.fontHeight)/2 ,
        self.width, 'center'
    )
end

function ui:mousepressed(x, y)
    for _, button in pairs(self.buttons) do
        button:mousepressed(x, y)
    end
end

return ui