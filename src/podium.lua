local sc_menu = 1
local sc_player_selection = 2
local sc_game = 3
local sc_pause = 4
local sc_podium = 5
PODIUM = {}

function PODIUM:new()
    obj = {}
    setmetatable(obj, self)
    self.__index = self
    return (obj)
end

function PODIUM:update()
end

function PODIUM:draw()
end

return {
    newPodium = function()
    obj = PODIUM:new()
    table.insert(PODIUM, obj)
    return obj
end
}