local sc_menu = 1
local sc_player_selection = 2
local sc_game = 3
GAME_LOOP = {}


function GAME_LOOP:new()
    obj = {}
    setmetatable(obj, self)
    self.__index = self
    return (obj)
end

function GAME_LOOP:update(dt)
    Player.update(dt)
    for i=1, 4 do
      dataR[i]:update(dt)
    end
    Receptor.update(dt)
end

function GAME_LOOP:draw()
end

return { 
    newGame_loop = function()
    obj = GAME_LOOP:new()
    table.insert(GAME_LOOP, obj)
    return obj
end
}