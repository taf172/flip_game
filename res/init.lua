local res = {}

local iconPath = 'res/x1/'
res.icons = {
    key = love.graphics.newImage(iconPath..'key.png'),
    lockClosed = love.graphics.newImage(iconPath..'lock_closed.png'),
    lockOpen = love.graphics.newImage(iconPath..'lock_open.png'),
    undo = love.graphics.newImage(iconPath..'undo.png'),
    reset = love.graphics.newImage(iconPath..'refresh.png'),
    back = love.graphics.newImage(iconPath..'back.png'),
    forward = love.graphics.newImage(iconPath..'forward.png'),
    menu = love.graphics.newImage(iconPath..'menu.png'),
    grid = love.graphics.newImage(iconPath..'grid.png'),
    volumeHigh = love.graphics.newImage(iconPath..'volume_high.png'),
    volumeLow = love.graphics.newImage(iconPath..'volume_low.png'),
    volumeOff = love.graphics.newImage(iconPath..'volume_off.png'),
    drop = love.graphics.newImage(iconPath..'drop.png')
}

res.images = {
    title = love.graphics.newImage(iconPath..'title.png')
}

res.colors = {
    primary = {0, 0.38, 0.585},
    accent = {0.822, 0.281, 0.364},
    lightShade = {0.953, 0.953, 0.882},
    darkShade = {0.729, 0.82, 0.812},
}

res.fonts = {
    extraBig = love.graphics.newFont('res/Montserrat-Medium.ttf', 64),
    big = love.graphics.newFont('res/Montserrat-Medium.ttf', 42),
    medium = love.graphics.newFont('res/Montserrat-Medium.ttf', 32),
    small = love.graphics.newFont('res/Montserrat-Medium.ttf', 12),
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