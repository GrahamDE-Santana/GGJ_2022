local sc_menu = 1
local sc_player_selection = 2
local sc_game = 3
local menu_file = require "scene"
local pl_select_file = require "player_selection"
local game_loop_file = require "game_loop"
Rythme_file =  require "rythme"
Player = require "Player"

-- Function d'initialisation
nb_scene = 0


function love.load()
    num = 0
    love.window.setMode(1600, 1200, {resizable = false})
    nb_scene = sc_player_selection
    menu = menu_file.newMenu()
    pl_select = pl_select_file.newPl_select()
    game_loop = game_loop_file.newGame_loop()
end

function love.keypressed(key)
    if nb_scene == sc_player_selection then
        pl_select:keypress(key)
    elseif nb_scene == sc_game then
        game_loop:keypress(key)
    end
    --payer
    if (Player.getSize() < 4) then
       if (Player.isPresent(key) ~= true) then
          Player.newPlayer(key)
       end
    end
    Player.playerPressDown(key)
end

function love.keyreleased(key)
    if nb_scene == sc_player_selection then
        pl_select:keyrelease(key)
    elseif nb_scene == sc_game then
        game_loop:keyrelease(key)
    end
end


function love.keyreleased(key)
   Player.playerPressRelease(key)
end

--Boucle principal
function love.update(dt)
    if nb_scene == sc_menu then
        nb_scene = menu:boucle()
    elseif nb_scene == sc_game then
        game_loop:update(dt)
    -- elseif nb_scene == sc_player_selection then
    --     nb_scene = pl_select:update(dt)
    end
     Player.update(dt)
end


--function draw.
function love.draw()
    if nb_scene == sc_menu then
        love.graphics.print("Hello World", 400, 300)
        love.graphics.print(tostring(num), 100, 100)
    elseif nb_scene == sc_player_selection then
        love.graphics.print("hello manuel", 400, 300)
    elseif nb_scene == sc_game then
        game_loop:draw()
    end
    Player.draw()
end
