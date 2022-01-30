local sc_menu = 1
local sc_player_selection = 2
local sc_game = 3
local sc_pause = 4
local sc_podium = 5
local font = love.graphics.newImage('assets/sky.png')
local podium = love.graphics.newImage('assets/podium.png')
PODIUMSC = {}

function PODIUMSC:new()
    obj = {}
    setmetatable(obj, self)
    self.__index = self
    return (obj)
end

function PODIUMSC:update()
end

function PODIUMSC:draw()
    -- love.graphics.setColor(200, 0, 180)
    -- love.graphics.rectangle("fill",0, 0, 800,800)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(font,0, 0, 0, 4, 4)
    -- love.graphics.draw(podium,200, 250, 0, 4, 4)
    love.graphics.print("YOU WIN !", 200, 50)
    love.graphics.draw(PODIUM[4].animation.spriteSheet, PODIUM[4].animation.quads[1],
                      320, 270, 0, 3, 3)
 
end

return {
    newPodium = function()
    obj = PODIUMSC:new()
    table.insert(PODIUM, obj)
    return obj
end
}