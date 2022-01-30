local sc_menu = 1
local sc_player_selection = 2
local sc_game = 3
local sc_podium = 4
local menu_file = require "menu"
local pl_select_file = require "player_selection"
local game_loop_file = require "game_loop"
-- local podium_file = require "podium"
Rythme_file =  require "rythme"
Player = require "Player"
Connector = require "connector"
Receptor = require "recepteur"
nb_scene = 0
dataR = {}

-- Function d'initialisation

function love.load()
    num = 0
    love.window.setMode(800, 800)
    nb_scene = sc_menu
    menu = menu_file.newMenu()
    pl_select = pl_select_file.newPl_select()
    game_loop = game_loop_file.newGame_loop()
    -- podium = podium_file()
    for i=1, 4 do
      dataR[i] = Rythme_file.newRythme(150, 8)
    end
    background = love.graphics.newImage('assets/background.png')
    Connector.newConnector(dataR[1], dataR[2])
    Connector.newConnector(dataR[2], dataR[3])
    Connector.newConnector(dataR[3], dataR[4])
    Connector.newConnector(dataR[4], dataR[1])
    musique = love.audio.newSource("songTheme_150.mp3", "stream")
    musique:setLooping(true)
end

function love.keypressed(key)
  if nb_scene == sc_player_selection then
    pl_select:keypress(key)
  else
    Player.playerPressDown(key)
  end
end
 

function love.keyreleased(key)
  if (nb_scene == sc_player_selection or nb_scene == sc_game) then
    Player.playerPressRelease(key)
  end
end

function love.mousepressed(x, y, button, istouch)
  if (nb_scene == sc_menu) then
    menu:mousepressed(x, y, button, istouch)
  end
end


function love.update(dt)
  if nb_scene == sc_player_selection then
    pl_select:update(dt)
  elseif nb_scene == sc_game then
    game_loop:update(dt)
  end
end


--function draw.
function love.draw()
  if nb_scene == sc_menu then
    menu:draw()
  elseif (nb_scene == sc_player_selection) or (nb_scene == sc_game) then
    game_loop:draw()
  -- elseif (nb_scene == sc_podium) then
  end
end
