local res = {}

res.images = {
    keyIcon = love.graphics.newImage('key.png'),
    lockIcon = love.graphics.newImage('lock.png')
}

res.colors = {
    keyColor = {253/255, 166/255, 58/255},
    playerColor = {0.5, 0.8, 0.95}
}

res.fonts = {
    bigFont = love.graphics.newFont('Montserrat-Medium.ttf', 36),
    smallFont = love.graphics.newFont('Montserrat-Medium.ttf', 12),
}

return res