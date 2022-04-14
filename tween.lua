-- https://www.gizma.com/easing
local ease = {}
function ease.linear(t, b, c, d)
    return c*t/d + b
end
function ease.quadIn (t, b, c, d)
	t = t/d
	return c*t*t + b
end
function ease.quadOut (t, b, c, d)
	t = t/d
	return -c * t*(t-2) + b
end
function ease.cubicIn (t, b, c, d)
    t = t/d;
	return c*t*t*t + b
end
function ease.cubicOut (t, b, c, d)
	t = t/d;
	t = t - 1
	return c*(t*t*t + 1) + b
end

local ActiveTween = {}
local active = {}

function ActiveTween:new(tbl, key, target, duration, delay)
    self.__index = self
    local tween = setmetatable({}, self)
    tween.tbl = tbl
    tween.key = key
    tween.start = tbl[key]
    tween.target = target
    tween.change = tween.target - tween.start
    tween.duration = duration
    tween.delay = delay or 0
    tween.time = -tween.delay
    tween.fn = ease.linear
    table.insert(active, tween)
    return tween
end

function ActiveTween:remove()
    for i, tween in ipairs(active) do
        if self == tween then table.remove(active, i) end
    end
end

function ActiveTween:update(dt)
    self.time = self.time + dt
    if self.time < 0 then return end
    if self.time < self.duration then
        self.tbl[self.key] = self.fn(self.time, self.start, self.change, self.duration)
    else
        self.tbl[self.key] = self.target
        self:remove()
    end
end

local Tween = {}

for k, fn in pairs(ease) do
    Tween[k] = function (Tween, tbl, key, target, time, delay)
        local tween = ActiveTween:new(tbl, key, target, time, delay)
        tween.fn = ease.quadIn
        return tween
    end
end

--[[
function Tween:quadIn(tbl, key, target, time, delay)
    local tween = ActiveTween:new(tbl, key, target, time, delay)
    tween.fn = ease.quadIn
    return tween
end
function Tween:quadOut(tbl, key, target, time, delay)
    local tween = ActiveTween:new(tbl, key, target, time, delay)
    tween.fn = ease.quadOut
    return tween
end
function Tween:quartIn(tbl, key, target, time, delay)
    local tween = ActiveTween:new(tbl, key, target, time, delay)
    tween.fn = ease.quartIn
    return tween
end
-]]

function Tween:update(dt)
    for _, tween in ipairs(active) do
        tween:update(dt)
    end
end

return Tween