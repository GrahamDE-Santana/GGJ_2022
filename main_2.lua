local sc_menu = 1
local sc_player_selection = 2
local sc_game = 3
local menu_file = require "scene"
local pl_select_file = require "player_selection"
-- Function d'initialisation


function love.load()
    num = 0
    nb_scene = sc_menu
    scene_tmp = {"one", "two", "tree"}
    menu = menu_file.newMenu()
    pl_select = pl_select_file.newPl_select()
    -- menu_sc = menu_scene.newMenu()
end

function love.keypressed(key, scancode, isrepeat)
   if key == scancode then
      return true
   end
   return false
end


--Boucle principal
function love.update(dt)
    if nb_scene == sc_menu then
        nb_scene = menu:boucle()
    elseif nb_scene == sc_player_selection then
        nb_scene = pl_select:boucle()
    end
    -- rajouter les autre scene

end


--function draw.
function love.draw()
    if nb_scene == sc_menu then
        love.graphics.print("Hello World", 400, 300)
        love.graphics.print(scene_tmp[sc_game], 200, 200)
        love.graphics.print(tostring(num), 100, 100)
    elseif nb_scene == sc_player_selection then
        love.graphics.print("Grosse pute", 400, 300)
    end
end