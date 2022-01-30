local sc_menu = 1
local sc_player_selection = 2
local sc_game = 3
local menu_file = require "scene"
local pl_select_file = require "player_selection"
local game_loop_file = require "game_loop"
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
    nb_scene = sc_player_selection
    menu = menu_file.newMenu()
    pl_select = pl_select_file.newPl_select()
    game_loop = game_loop_file.newGame_loop()
    for i=1, 4 do
      dataR[i] = Rythme_file.newRythme(150, 8)
    end
    background = love.graphics.newImage('background.png')
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

function love.update(dt)
  if nb_scene == sc_player_selection then
    pl_select:update(dt)
  elseif nb_scene == sc_game then
    game_loop:update(dt)
  end
end


--function draw.
function love.draw()
    -- game loop ou pl_select
    love.graphics.draw(background, 0, 0)

    -- mettre ca dans la game loop et dans le player selection
    love.graphics.rectangle("line", 20,20, 100,100)
    love.graphics.rectangle("line", 680 ,20, 100,100)
    love.graphics.rectangle("line", 20,480 + 200, 100,100)
    love.graphics.rectangle("line", 680,480 + 200, 100,100)

    --m Mettre ca dans la game loop
    Player.draw()
    dataR[1]:drawUp(50)
    dataR[2]:drawRight(715)
    dataR[3]:drawDown(715)
    dataR[4]:drawLeft(50)
end
