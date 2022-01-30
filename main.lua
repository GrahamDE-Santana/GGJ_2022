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

dataR = {}

-- Function d'initialisation
nb_scene = 0
local toto = {}

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
    dataR[1]:setTableData(1, {false, false, false, false, true, true, false, false})
    background = love.graphics.newImage('background.png')
    Connector.newConnector(dataR[1], dataR[2])
    --toto.t = toto.u * 4
    toto = Connector.newConnector(dataR[2], dataR[3])
    Connector.newConnector(dataR[3], dataR[4])
    toto = Connector.newConnector(dataR[4], dataR[1])
    musique = love.audio.newSource("songTheme_150.mp3", "stream")
    musique:setLooping(true)
end

function love.keypressed(key)
  if (Player.getSize() < 4) then
    if (Player.isPresent(key) ~= true) then
      local p = Player.newPlayer(key)
      Receptor.newReceptor(p,dataR[Player.getSize()])
      if Player.getSize() == 4 then musique:play() end
    end
  end
  Player.playerPressDown(key)
end

function love.keyreleased(key)
  Player.playerPressRelease(key)
end

function love.update(dt)
  Connector.update(dt)
  Player.update(dt)
  if Player.getSize() == 4 then
    --Boucle principal
    Receptor.update(dt)
    --Receptor.first():update(dt)
    for i=1, 4 do
      dataR[i]:update(dt)
    end
    --END
  end
end


--function draw.
function love.draw()
    love.graphics.draw(background, 0, 0)

    love.graphics.rectangle("line", 20,20, 100,100)
    love.graphics.rectangle("line", 680 ,20, 100,100)
    love.graphics.rectangle("line", 20,480 + 200, 100,100)
    love.graphics.rectangle("line", 680,480 + 200, 100,100)

    Player.draw()
    dataR[1]:drawUp(50)
    dataR[2]:drawRight(715)
    dataR[3]:drawDown(715)
    dataR[4]:drawLeft(50)
end
