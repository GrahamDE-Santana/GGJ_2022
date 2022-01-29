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

function PL_SELECT:update(dt, player)
    --Faire l'affichage des perso

end

function PL_SELECT:keypress(key)
    if (Player.getSize() < 4) then
        if (Player.isPresent(key) == true) then
        text = "Key alreasy taken by player"
        else
        last = Player.newPlayer(key)
        end
    else
        game_loop:initialisation()
        nb_scene = sc_game
    end
    Player.playerPressDown(key)
    print ("")
    Player.foreach(print)
end

function PL_SELECT:keyrelease(key)
    Player.playerPressRelease(key)
    Player.foreach(print)
    if key == "return" then
      text = "RETURN has been released!"
    end
end

return { 
    newPl_select = function()
    obj = PL_SELECT:new()
    table.insert(PL_SELECT, obj)
    return obj
end
}