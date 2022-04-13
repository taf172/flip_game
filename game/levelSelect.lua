local res = require 'res'
local ui = require 'ui'

local levelSelectMenu = {}
levelSelectMenu.font = res.fonts.big
levelSelectMenu.textColor = res.colors.primary
levelSelectMenu.title = 'levels'
levelSelectMenu.titleHeight = love.graphics.getHeight()*0.1
levelSelectMenu.buttons = {
    ui.buttons.backButton,
}
levelSelectMenu.bars = ui.levelSelectBars
levelSelectMenu.page = 1
levelSelectMenu.gridSizeBar = ui.gridSizeBar
levelSelectMenu.completedLevels = {}

function levelSelectMenu:load()
end

function levelSelectMenu:draw()
    love.graphics.setColor(self.textColor)
    love.graphics.setFont(self.font)
    love.graphics.printf(
        self.title, 0, ui:getTitleHeight(self.font),
        love.graphics.getWidth(), 'center'
    )
    for _, button in ipairs(self.buttons) do
        button:draw()
    end
    for _, bar in ipairs(self.bars) do
        bar:draw()
    end
    self.gridSizeBar:draw()
end

function levelSelectMenu:loadPage()
    self.selectedLevel = nil
    local levelNo = 1
    for _, bar in ipairs(self.bars) do
        for _, button in ipairs(bar.buttons) do
            if self.completedLevels[levelNo] then
                button.color = res.colors.primary
            else
                button.color = res.colors.darkShade
            end
            button.text = levelNo
            button.onPress = function ()
                self.selectedLevel = levelNo
                self:onLevelSelect()
            end
            levelNo = levelNo + 1
        end
    end
end

function levelSelectMenu:onLevelSelect()
end

function levelSelectMenu:mousepressed(x, y)
    for _, button in ipairs(self.buttons) do
        button:mousepressed(x, y)
    end
    for _, bar in ipairs(self.bars) do
        bar:mousepressed(x, y)
    end
end

return levelSelectMenu