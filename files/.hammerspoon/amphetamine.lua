-- caffeine replacement
-- https://github.com/heptal/dotfiles/blob/9f1277e162a9416b5f8b4094e87e7cd1fc374b18/roles/hammerspoon/files/amphetamine.lua


local ampOn = [[ASCII:
.....1a..........AC..........E
..............................
......4.......................
1..........aA..........CE.....
e.2......4.3...........h......
..............................
..............................
.......................h......
e.2......6.3.........t...q....
5..........c.........s........
......6.......................
.........................q....
.....5c..............s...t....
]]

local ampOff = [[ASCII:
.....1a.....x....AC.y.......zE
..............................
......4.......................
1..........aA..........CE.....
e.2......4.3...........h......
..............................
..............................
.......................h......
e.2......6.3.........t...q....
5..........c.........s........
......6.......................
.........................q....
...x.5c....y.......z.s...t....
]]


local module = {}

local function setIcon(state)
  module.menu:setIcon(state and ampOff or ampOn)
end

module.menu = hs.menubar.new()
module.menu:setClickCallback(function() setIcon(hs.caffeinate.toggle("displayIdle")) end)
setIcon(hs.caffeinate.get("displayIdle"))

return module
