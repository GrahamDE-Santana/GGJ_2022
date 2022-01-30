local sc_menu = 1
local sc_player_selection = 2
local sc_game = 3
local sc_pause = 4
local sc_podium = 5
GAME_LOOP = {}


function GAME_LOOP:new()
    obj = {}
    setmetatable(obj, self)
    self.__index = self
    return (obj)
end

function GAME_LOOP:update(dt)
    Player.update(dt)
    for i=1, 4 do
      dataR[i]:update(dt)
    end
    Receptor.update(dt)
end

function GAME_LOOP:draw()
    -- Background 
    love.graphics.draw(background, 0, 0)
    -- Line of the player
    love.graphics.rectangle("line", 20,20, 100,100)
    love.graphics.rectangle("line", 680 ,20, 100,100)
    love.graphics.rectangle("line", 20,480 + 200, 100,100)
    love.graphics.rectangle("line", 680,480 + 200, 100,100)
    -- Player and attribute
    Player.draw()
    -- Connectors
    dataR[1]:drawUp(50)
    dataR[2]:drawRight(715)
    dataR[3]:drawDown(715)
    dataR[4]:drawLeft(50)
    if Player:gameEnd() == true then
        nb_scene = sc_podium
    end
end

return { 
    newGame_loop = function()
    obj = GAME_LOOP:new()
    table.insert(GAME_LOOP, obj)
    return obj
end
}