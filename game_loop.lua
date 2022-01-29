local sc_menu = 1
local sc_player_selection = 2
local sc_game = 3
local Rythme_file =  require "rythme"
local denver = require 'denver'
local saw = {}
local dong = {}
local over = {}
local edit = true
-- local mainTheme = audio.loadSound("mainTheme.mp3")
GAME_LOOP = {}


function GAME_LOOP:new()
    obj = {}
    setmetatable(obj, self)
    self.__index = self

    obj.rythme = Rythme_file.newRythme(150, 8)
    obj.begin = false -- le sequence a ete lance
    obj.played = false -- le joueur a jouer sa sequance
    obj.edit = true --  le jouer acutel dois editer (true) ou bien imitier (false)
    obj.key = ""
    obj.current_value = false
    obj.is_touch = true
    return (obj)
end

function GAME_LOOP:initialisation()
    print("init -- ")
    -- love.audio.play("mainTheme.mp3")
    self.rythme:beginEdit()
    self.begin = true
    saw = denver.get({waveform='square', frequency='F#2', frequency=240})
    dong = denver.get({waveform='sinus', frequency=440, length=0.15})
    over = denver.get({waveform='sinus', frequency=700, length=0.15})
    saw:setLooping(true)
    self.rythme:setTableData(1, {false, false, false, false, false, false, false, false})
    self.rythme:setTableData(2, {false, false, false, false, false, false, false, false})
    self.rythme:setTableData(3, {false, false, false, false, false, false, false, false})
    self.rythme:setTableData(4, {false, false, false, false, false, false, false, false})
    self.rythme:setTableData(5, {false, false, false, false, false, false, false, false})
    self.rythme:setTableData(6, {false, false, false, false, false, false, false, false})
    self.rythme:setTableData(7, {false, false, false, false, false, false, false, false})
    self.rythme:setTableData(8, {false, false, false, false, false, false, false, false})
    end

function GAME_LOOP:record_loop()
    if self.played == false then
        self.rythme.loop = true
    else 
        self.rythme.loop = false
    end
end

function GAME_LOOP:edit_record(dt, player_touch)
    print("chien")
    self.key = love.keyboard.isDown(player_touch)
    self:record_loop()
    if self.rythme.isEnd then
        -- Passe le tour a l'autre
        self.edit = false
        -- relance la boucle.
        self.rythme.loop = true
        self.rythme.t = 0
    end
    -- update le rythme
    self.rythme:update(dt)
    -- -------------------

    local z = love.keyboard.isDown("z")
    if self.key then 
        self.rythme:edit(true)
        self.played = true
    end
    if z then self.rythme:edit(false) end

    local b = self.rythme:getCurrentValue()
    if b == true then
        love.audio.play(saw)
    else
        love.audio.stop(saw)
    end
    if self.rythme.barre == true then
        love.audio.play(dong)
    end
end

function GAME_LOOP:reprod_record(dt, player_touch)
    self.key = love.keyboard.isDown(player_touch)
    if self.rythme.t == self.rythme.u * self.rythme.nb then
        -- Passe le tour a l'autre
        self.edit = false
    end
    self.rythme:update(dt)
    if self.key then
        self.touch = true
    end
    self.current_value = self.rythme:getCurrentValue()
    if self.current_value == true  and self.touch then
        love.audio.play(saw)
    else
        love.audio.stop(saw)
    end
    if self.touch and self.current_value == false then
        love.audio.play(over)

        -- Faire un son de deffaire et enlever une vie

    end
    self.touch = false
end

function GAME_LOOP:update(dt, player)
    
    if self.edit then
        self:edit_record(dt, "a")
    elseif not self.edit then
        self:reprod_record(dt, "l")
    end
    -- appeller le lopp entre 2 jouer
end

function GAME_LOOP:keypress(key)
    print("press")
    -- appeller le bon player
end

function GAME_LOOP:keyrelease(key)
    print("release")
    -- ici je sais pas
end 

function GAME_LOOP:draw()
    local data = self.rythme:getData()
      local bpm = self.rythme.t;
      local x = 0
      for i, v in pairs(data) do
        for i = 1, 8 do
          if v[i] == true then
            love.graphics.setColor(1, 0.1, 0.1)
          else
            love.graphics.setColor(0.3, 0.3, 0.3)
          end
          love.graphics.rectangle("fill",25 + x,100,25,50)
          love.graphics.setColor(1, 1, 1)
          love.graphics.rectangle("line",25 + x,100,25,50)
          x = x + 25
        end
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("fill",25 + x,100 - 10,5,70)
      end
      bpm = (self.rythme:getTime()) * (25 * 8)
      love.graphics.setColor(0.9, 0.9, 0.1)
      love.graphics.rectangle("fill",25 + bpm,100,5,50)
end

return { 
    newGame_loop = function()
    obj = GAME_LOOP:new()
    table.insert(GAME_LOOP, obj)
    return obj
end
}