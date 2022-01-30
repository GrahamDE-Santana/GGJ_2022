local sc_menu = 1
local sc_player_selection = 2
local sc_game = 3
local sc_pause = 4
local pause = false
local game_is_paused = love.graphics.newImage('assets/game_is_paused.png')
PAUSE = {}
require "src.game_loop"

function PAUSE:new()
    obj = {}
    setmetatable(obj, self)
    self.__index = self
    return (obj)
end

function PAUSE:keypressed()
    pause = not pause
    if pause then
        nb_scene = sc_pause
    else
        nb_scene = sc_game
    end
end

function PAUSE:draw()
    GAME_LOOP:draw()
    if pause then
        love.graphics.rectangle("fill",160,250, 450,50)
        love.graphics.setColor(0, 0, 0)
        love.graphics.draw(game_is_paused,165,250)
        love.graphics.setColor(1, 1, 1)
    end
end

return {
    newPause = function()
    obj = PAUSE:new()
    table.insert(PAUSE, obj)
    return obj
end
}
