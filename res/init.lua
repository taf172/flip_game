local res = {}

res.icons = {
    key = love.graphics.newImage('res/icons/key.png'),
    lock = love.graphics.newImage('res/icons/lock_closed.png'),
    open = love.graphics.newImage('res/icons/lock_open.png'),
    undo = love.graphics.newImage('res/icons/undo.png'),
    reset = love.graphics.newImage('res/icons/refresh.png'),
    back = love.graphics.newImage('res/icons/back.png'),
    forward = love.graphics.newImage('res/icons/forward.png'),
    menu = love.graphics.newImage('res/icons/menu.png'),
    settings = love.graphics.newImage('res/icons/settings.png'),
    cart = love.graphics.newImage('res/icons/cart.png'),
    grid = love.graphics.newImage('res/icons/grid.png'),
}

res.colors = {
    primary = {0, 0.38, 0.585},
    lightAccent = {1, 1, 1},
    lightShade = {0.953, 0.953, 0.882},
    darkAccent = {0.822, 0.281, 0.364},
    darkShade = {0.729, 0.82, 0.812},
}

res.fonts = {
    extraBig = love.graphics.newFont('res/Montserrat-Medium.ttf', 64),
    big = love.graphics.newFont('res/Montserrat-Medium.ttf', 42),
    small = love.graphics.newFont('res/Montserrat-Medium.ttf', 12),
}

res.audio = {
    move = love.audio.newSource('res/sfx/slide.wav', 'static'),
    unlock = love.audio.newSource('res/sfx/unlock.wav', 'static'),
    lock = love.audio.newSource('res/sfx/lock.wav', 'static'),
    blocked = love.audio.newSource('res/sfx/blocked.wav', 'static'),
    keychime = love.audio.newSource('res/sfx/key.ogg', 'static'),
    sucess = love.audio.newSource('res/sfx/success.ogg', 'static')
}

return res