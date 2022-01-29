local sc_menu = 1
local sc_player_selection = 2
local sc_game = 3
MENU = {}

function MENU:new()
    obj = {}
    setmetatable(obj, self)
    self.__index = self
    return (obj)
end

function love.keypressed(key, scancode, isrepeat)
   if key == "return" then
      return ("return")
   end
   return ("false")
end

function MENU:boucle(nb)
    if love.keypressed(key, "return") then
        return sc_player_selection
    else return sc_menu
    end
end

return { 
    newMenu = function()
    obj = MENU:new()
    table.insert(MENU, obj)
    return obj
end
}