local sc_menu = 1
local sc_player_selection = 2
local sc_game = 3
local menu_file = require "scene"
local pl_select_file = require "player_selection"
local game_loop_file = require "game_loop"
Rythme_file =  require "rythme"
Player = require "Player"
Connector = require "connector"

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
    dataR[1]:setTableData(1, {true, true, true, true, false, false, false, false})
    background = love.graphics.newImage('background.png')
    Connector.newConnector(dataR[1], dataR[2])
    --toto.t = toto.u * 4
    toto = Connector.newConnector(dataR[2], dataR[3])
    Connector.newConnector(dataR[3], dataR[4])
    toto = Connector.newConnector(dataR[4], dataR[1])
    print (toto.a)
    musique = love.audio.newSource("songTheme_150.mp3", "stream")
    musique:setLooping(true)
    musique:play()
end

function love.keypressed(key)
  if (Player.getSize() < 4) then
    if (Player.isPresent(key) ~= true) then
      Player.newPlayer(key)
    end
  end
  Player.playerPressDown(key)
end

function love.keyreleased(key)
  Player.playerPressRelease(key)
end

--Boucle principal
function love.update(dt)
  print(toto.a)
  Connector.update(dt)
  if Player.getSize() == 4 then
  end
  --dataR[1]:edit(true)
  for i=1, 4 do
    dataR[i]:update(dt)
  end
  Player.update(dt)
  if math.random(100) == 1 then
    dataR[1]:edit(true)
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
