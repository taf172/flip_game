local res = require 'res'
local ui = require 'ui'

local levelSelectMenu = {}
levelSelectMenu.font = res.fonts.big
levelSelectMenu.textColor = res.colors.primary
levelSelectMenu.title = 'levels'
levelSelectMenu.titleHeight = love.graphics.getHeight()*0.1
levelSelectMenu.buttons = {
    ui.buttons.backButton,
    ui.buttons.nextButton,
    ui.buttons.bigBackButton,
}
levelSelectMenu.bars = ui.levelSelectBars
levelSelectMenu.page = 3
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
    if self.pageNo > 1 then
        self.buttons[1]:draw()
    end
    if self.pageNo < 3 then
        self.buttons[2]:draw()
    end
    for _, bar in ipairs(self.bars) do
        bar:draw()
    end
    self.buttons[3]:draw()
end

function levelSelectMenu:loadPage(n)
    self.pageNo = n
    local levelNo = 1 + (self.pageNo - 1)*30
    for _, bar in ipairs(self.bars) do
        for _, button in ipairs(bar.buttons) do
            if self.completedLevels[levelNo] then
                button.color = res.colors.primary
            else
                button.color = res.colors.darkShade
            end
            button.text = levelNo
            button.levelNo = levelNo
            function button:onPress()
                levelSelectMenu.onLevelSelect(button.levelNo)
            end
            levelNo = levelNo + 1
        end
    end
end

function levelSelectMenu:onLevelSelect()
end

function levelSelectMenu:mousepressed(x, y)
    if self.pageNo > 1 then
        self.buttons[1]:mousepressed(x, y)
    end
    if self.pageNo < 3 then
        self.buttons[2]:mousepressed(x, y)
    end
    self.buttons[3]:mousepressed(x, y)

    for _, bar in ipairs(self.bars) do
        bar:mousepressed(x, y)
    end
end

return levelSelectMenu