local sc_menu = 1
local sc_player_selection = 2
local sc_game = 3
PL_SELECT = {}

function PL_SELECT:new()
    obj = {}
    setmetatable(obj, self)
    self.__index = self
    return (obj)
end

function PL_SELECT:boucle(nb)
    if love.keyboard.isDown("return") then
        return sc_game
    else return sc_pl_selection
    end
end

return { 
    newPl_select = function()
    obj = PL_SELECT:new()
    table.insert(PL_SELECT, obj)
    return obj
end
}