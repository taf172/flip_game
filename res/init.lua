local res = {}

local imagePath = 'res/x1/'
res.icons = {
    key = love.graphics.newImage(imagePath..'key.png'),
    lockClosed = love.graphics.newImage(imagePath..'lock_closed.png'),
    lockOpen = love.graphics.newImage(imagePath..'lock_open.png'),
    undo = love.graphics.newImage(imagePath..'undo.png'),
    reset = love.graphics.newImage(imagePath..'refresh.png'),
    back = love.graphics.newImage(imagePath..'back.png'),
    forward = love.graphics.newImage(imagePath..'forward.png'),
    menu = love.graphics.newImage(imagePath..'menu.png'),
    grid = love.graphics.newImage(imagePath..'grid.png'),
    volumeHigh = love.graphics.newImage(imagePath..'volume_high.png'),
    volumeLow = love.graphics.newImage(imagePath..'volume_low.png'),
    volumeOff = love.graphics.newImage(imagePath..'volume_off.png'),
    drop = love.graphics.newImage(imagePath..'drop.png')
}

res.images = {
    title = love.graphics.newImage(imagePath..'title.png')
}

res.colors = {
    primary = {0, 0.38, 0.585},
    accent = {0.822, 0.281, 0.364},
    lightShade = {0.953, 0.953, 0.882},
    darkShade = {0.729, 0.82, 0.812},
}

res.fonts = {
    extraBig = love.graphics.newFont('res/Montserrat-Medium.ttf', 48),
    big = love.graphics.newFont('res/Montserrat-Medium.ttf', 36),
    medium = love.graphics.newFont('res/Montserrat-Medium.ttf', 36),
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