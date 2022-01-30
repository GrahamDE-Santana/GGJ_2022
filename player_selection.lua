local sc_menu = 1
local sc_player_selection = 2
local sc_game = 3
local Player = require "Player"
PL_SELECT = {}



function PL_SELECT:new()
    obj = {}
    setmetatable(obj, self)
    self.__index = self
    return (obj)
end

function PL_SELECT:update(dt)
  Player.update(dt)
end

function PL_SELECT:keypress(key)
    if (Player.getSize() < 4) then
        if (Player.isPresent(key) ~= true) then
            Player.newPlayer(key)
        end
    end
    if Player.getSize() == 4 then
        Receptor.newReceptor(Player.players()[1], dataR[4], dataR[1])
        Receptor.newReceptor(Player.players()[2], dataR[1], dataR[2])
        Receptor.newReceptor(Player.players()[3], dataR[2], dataR[3])
        Receptor.newReceptor(Player.players()[4], dataR[3], dataR[4])
        musique:play()
        nb_scene = sc_game
    end
end

return { 
    newPl_select = function()
    obj = PL_SELECT:new()
    table.insert(PL_SELECT, obj)
    return obj
end
}