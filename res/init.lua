local res = {}

res.images = {
    keyIcon = love.graphics.newImage('res/key.png'),
    lockIcon = love.graphics.newImage('res/lock_closed.png'),
    openLockIcon = love.graphics.newImage('res/lock_open.png')
}

res.colors = {
    primary = {0, 0.38, 0.585},
    lightAccent = {1, 1, 1},
    lightShade = {0.953, 0.953, 0.882},
    darkAccent = {0.822, 0.281, 0.364},
    darkShade = {0.729, 0.82, 0.812},
}

res.fonts = {
    bigFont = love.graphics.newFont('res/Montserrat-Medium.ttf', 42),
    smallFont = love.graphics.newFont('res/Montserrat-Medium.ttf', 12),
}

res.audio = {
    moveSFX = love.audio.newSource('res/slide.wav', 'static'),
    unlockSFX = love.audio.newSource('res/unlock.wav', 'static'),
    lockSFX = love.audio.newSource('res/lock.wav', 'static'),
    blockedSFX = love.audio.newSource('res/blocked.wav', 'static'),
    keychimeSFX = love.audio.newSource('res/key.ogg', 'static'),
    sucessSFX = love.audio.newSource('res/success.ogg', 'static')
}

return res