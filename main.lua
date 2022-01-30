local sc_menu = 1
local sc_player_selection = 2
local sc_game = 3
local sc_pause = 4
local sc_podium = 5
local menu_file = require "src.menu"
local pl_select_file = require "src.player_selection"
local game_loop_file = require "src.game_loop"
local pause_file = require "src.pause_menu"
local podium_file = require "src.podium"

Rythme_file =  require "src.rythme"
Player = require "src.Player"
Connector = require "src.connector"
Receptor = require "src.recepteur"
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
    pause = pause_file.newPause()
    podium = podium_file.newPodium()
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
  elseif nb_scene == sc_game then
    Player.playerPressDown(key)
  elseif (nb_scene == sc_menu) then
    menu:keypressed(key)
  end
  if key == 'escape' then
    if nb_scene ~= sc_podium then
      pause:keypressed()
    else
      for i, val in  pairs(PODIUM) do
        table.remove(PODIUM, i)
      end
      for i, val in  pairs(PLAYERS) do
        table.remove(PLAYERS, i)
      end
      nb_scene = sc_menu
    end
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

function love.textinput(t)
  if (nb_scene == sc_menu) then
    menu:textinput(t)
  end
end

function love.update(dt)
  if nb_scene == sc_player_selection then
    pl_select:update(dt)
  elseif nb_scene == sc_game then
    game_loop:update(dt)
  elseif nb_scene == sc_podium then
    podium:update(dt)
  end
end


--function draw.
function love.draw()
  if nb_scene == sc_menu then
    menu:draw()
  elseif (nb_scene == sc_player_selection) or (nb_scene == sc_game) then
    game_loop:draw()
  elseif (nb_scene == sc_pause) then
    pause:draw()
  elseif nb_scene == sc_podium then
    podium:draw(dt)
  end
end
