local res = {}

res.icons = {
    key = love.graphics.newImage('res/icons/key.png'),
    lockClosed = love.graphics.newImage('res/icons/lock_closed.png'),
    lockOpen = love.graphics.newImage('res/icons/lock_open.png'),
    undo = love.graphics.newImage('res/icons/undo.png'),
    reset = love.graphics.newImage('res/icons/refresh.png'),
    back = love.graphics.newImage('res/icons/back.png'),
    forward = love.graphics.newImage('res/icons/forward.png'),
    menu = love.graphics.newImage('res/icons/menu.png'),
    settings = love.graphics.newImage('res/icons/settings.png'),
    cart = love.graphics.newImage('res/icons/cart.png'),
    grid = love.graphics.newImage('res/icons/grid.png'),
    volumeHigh = love.graphics.newImage('res/icons/volume_high.png'),
    volumeLow = love.graphics.newImage('res/icons/volume_low.png'),
    volumeOff = love.graphics.newImage('res/icons/volume_off.png'),
    drop = love.graphics.newImage('res/icons/drop.png')
}

res.images = {
    title = love.graphics.newImage('res/title.png')
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