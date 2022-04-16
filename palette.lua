local res = require 'res'
local ui = require 'ui'
local tween = require 'tween'

local function rgb(r, g, b)
    return {r/255, g/255, b/255}
end

local palette = {}
palette.current = 1
palette.choices = {
    {
        primary = {0, 0.38, 0.585},
        accent = {0.822, 0.281, 0.364},
        lightShade = {0.953, 0.953, 0.882},
        darkShade = {0.729, 0.82, 0.812},
    },
    {
        primary = {1, 1, 1},
        accent = rgb(138, 180, 248),
        lightShade = rgb(32, 33, 36),
        darkShade = rgb(48, 49, 52),
    },
}

function palette:set(n)
    if n > #self.choices then n = 1 end
    self.current = n
    local pick = self.choices[n]
    res.colors.primary = pick.primary
    res.colors.accent = pick.accent
    res.colors.lightShade = pick.lightShade
    res.colors.darkShade = pick.darkShade
end

function palette:getPalette()
    return self.current
end

function palette:swap(n)
    self.current = self.current + 1
    if self.current > #self.choices then self.current = 1 end
    local pick = self.choices[self.current]
    self:tweenColor(res.colors.primary, pick.primary)
    self:tweenColor(res.colors.accent, pick.accent)
    self:tweenColor(res.colors.lightShade, pick.lightShade)
    self:tweenColor(res.colors.darkShade, pick.darkShade)
end

function palette:tweenColor(c1, c2)
    tween:quadIn(c1, 1, c2[1], 0.25)
    tween:quadIn(c1, 2, c2[2], 0.25)
    tween:quadIn(c1, 3, c2[3], 0.25)
end

function palette:average(c1, c2, weight)
    local c = {0, 0, 0}
    for i = 1, weight do
        c[1]  = c[1] + c1[1]^2
        c[2]  = c[2] + c1[2]^2
        c[3]  = c[3] + c1[3]^2
    end
    c[1]  = c[1] + c2[1]^2
    c[2]  = c[2] + c2[2]^2
    c[3]  = c[3] + c2[3]^2
    return {
        math.sqrt(c[1]/(weight + 1)),
        math.sqrt(c[2]/(weight + 1)),
        math.sqrt(c[3]/(weight + 1)),
    }
end

function palette:update(dt)
    love.graphics.setBackgroundColor(res.colors.lightShade)
    for _, button in pairs(ui.buttons) do
        button.color = res.colors.primary
    end
end

return palette