local res = {}


local imagePath = 'res/images/'

local Image = {}
function Image:new(name)
    self.__index = self
    local img = setmetatable({}, self)
    img.native = love.graphics.newImage('res/images/'..name)

    local dpi = 1
    local native = love.graphics.getDPIScale()
    if 320/native < dpi then
        img.image = love.graphics.newImage('res/images/xxhdpi/'..name)
    elseif 240/native < dpi then
        img.image = love.graphics.newImage('res/images/xhdpi/'..name)
    elseif 160/native < dpi then
        img.image = love.graphics.newImage('res/images/hdpi/'..name)
    elseif 1 < dpi then
        img.image = love.graphics.newImage('res/images/mdpi/'..name)
    else
        img.image = img.native
    end

    img.dpiScaleWidth = img.native:getWidth()/img.image:getWidth()
    img.dpiScaleHeight = img.native:getHeight()/img.image:getHeight()
    img.scaleWidth = 1
    img.scaleHeight = 1
    return img
end
function Image:scale(width, height)
    self.scaleWidth = width/self.native:getWidth()
    self.scaleHeight = height/self.native:getHeight()
end
function Image:draw(x, y, alignment)
    local sw = self.dpiScaleWidth*self.scaleWidth
    local sh = self.dpiScaleHeight*self.scaleHeight
    if alignment == 'centered' then
        x = x - self.image:getWidth()*sw/2
        y = y - self.image:getHeight()*sh/2
    end
    love.graphics.draw(self.image, x, y, 0, sw, sh)
end
--[[
function Image:getWidth()
    return self.image:getWidth()
end
function Image:getHeight()
    return self.image:getHeight()
end
--]]

res.icons = {
    key = Image:new('key.png'),
    lockClosed = Image:new('lock_closed.png'),
    lockOpen = Image:new('lock_open.png'),
    undo = Image:new('undo.png'),
    reset = Image:new('refresh.png'),
    back = Image:new('back.png'),
    forward = Image:new('forward.png'),
    menu = Image:new('menu.png'),
    grid = Image:new('grid.png'),
    volumeHigh = Image:new('volume_high.png'),
    volumeLow = Image:new('volume_low.png'),
    volumeOff = Image:new('volume_off.png'),
    drop = Image:new('drop.png')
}

res.images = {
    title = Image:new('title.png')
}

res.colors = {
    primary = {0, 0.38, 0.585},
    accent = {0.822, 0.281, 0.364},
    lightShade = {0.953, 0.953, 0.882},
    darkShade = {0.729, 0.82, 0.812},
}

res.fonts = {
    extraBig = love.graphics.newFont('res/Montserrat-Medium.ttf', 36),
    big = love.graphics.newFont('res/Montserrat-Medium.ttf', 30),
    medium = love.graphics.newFont('res/Montserrat-Medium.ttf', 20),
    small = love.graphics.newFont('res/Montserrat-Medium.ttf', 20),
}

love.audio.setEffect('compressor', {type = 'compressor', enable = true})
local Sound = {}
function Sound:new(name)
    self.__index = self
    local s = setmetatable({}, self)
        s.source = love.audio.newSource('res/sfx/'..name, 'static')
        s.source:setVolume(1)
        --s.source:setEffect('compressor')
    return s
end
function Sound:play()
    self.source:stop()
    self.source:play()
end

--Flotsam by Nul Tiel Records
local music = love.audio.newSource('res/flotsam.mp3', 'static')
music:setLooping(true)
music:setVolume(0.1)

local success = love.audio.newSource('res/sfx/success.wav', 'static')
success:setVolume(0.25)

res.audio = {
    music = music,
    move = Sound:new('slide.wav'),
    unlock = Sound:new('unlock.wav'),
    lock = Sound:new('lock.wav'),
    blocked = Sound:new('blocked.wav'),
    keychime = Sound:new('key.wav'),
    success = success,
    tap = Sound:new('tap.wav'),
}

return res