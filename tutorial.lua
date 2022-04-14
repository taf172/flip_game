local Level = require 'level'

local start = Level:new(3)
start.puzzle.path = {5, 4, 1, 2, 3, 6, 9, 8, 7}
start.puzzle.locks = {}
start.puzzle.keys = {}
start.text = 'fill the grid'

local keys = Level:new(3)
keys.puzzle.path = {7, 4, 1, 2, 3, 6, 9, 8, 5}
keys.puzzle.locks = {}
keys.puzzle.keys = {3, 6, 9}
keys.text = 'plan your path'

local blocked = Level:new(3)
blocked.puzzle.path = {1, 4, 7, 8, 9, 6, 3, 2, 5}
blocked.puzzle.locks = {2, 5}
blocked.puzzle.keys = {8, 9}
blocked.text = 'locks will block you'

local wall = Level:new(3)
wall.puzzle.path = {7, 4, 1, 2, 5, 8, 9, 6, 3}
wall.puzzle.locks = {4, 5, 6}
wall.puzzle.keys = {2, 5, 8}
wall.text = 'use keys to pass'

local middle = Level:new(3)
middle.puzzle.path = {3, 2, 1, 4, 5, 6, 9, 7, 8}
middle.puzzle.locks = {5}
middle.puzzle.keys = {9}
middle.text = 'good luck ;)'

local tutorial = {
    start,
    keys,
    blocked,
    wall,
    middle,
}


return tutorial