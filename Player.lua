--Player.lua

--Player = Class('Player')

local Y_SCALING = 42
local X_SCALING = 44
local PLAYER_X = {32, 34, 44, 32}
local PLAYER_Y = {32, 44, 42, 32}
local DURATION = 1
local PLAYER_SHEET = {"assets/mask_idle32x32.png", "assets/idle_bunny34x44.png", "assets/plant_idle44x42.png", "assets/virual_idle32x32.png"}

PLAYER = {}
PLAYERS = {}

function PLAYER:newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    animation.duration = duration or 1
    animation.currentTime = 0
    return animation
end

function PLAYER:new(key)
   local obj = {}
   setmetatable(obj, self)
   self.__index = self

   if (PLAYER:getSize() == 0) then
      obj.color = {200, 0, 0}
      obj.pos = {20, 20}
      obj.sound = love.audio.newSource("sound/FM_twang.mp3", "static")
      obj.life_full = {20 + 120, 20 + 100, 0, 20}
      obj.life_empty = {20 + 120, 20 + 100, 150, 20}
    elseif (PLAYER:getSize() == 1) then
      obj.pos = {680, 20}
      obj.sound = love.audio.newSource("sound/rock_organ.mp3", "static")
      obj.life_full = {680 - 170, 20 + 100, 0, 20}
      obj.life_empty = {680 - 170, 20 + 100, 150, 20}
      obj.color = {200, 0, 220}
   elseif (PLAYER:getSize() == 2) then
     obj.pos = {680, 680}
     obj.sound = love.audio.newSource("sound/BeepBox-Song.mp3", "static")
     obj.life_full = {680 - 170, 680, 0, 20}
     obj.life_empty = {680 - 170, 680, 150, 20}
     obj.color = {220, 180, 0}
   else
     obj.pos = {20, 680}
     obj.sound = love.audio.newSource("sound/music_box.mp3", "static")
     obj.life_full = {20 + 120, 680, 0, 20}
     obj.life_empty = {20 + 120, 680, 150, 20}
     obj.color = {0, 20, 200}
   end
   obj.scale = {X_SCALING / 96 * 2, Y_SCALING / 96 * 2}
   obj.animation = PLAYER:newAnimation(love.graphics.newImage("assets/appear_96_96.png"), 96, 96, DURATION)
   obj.key = key
   obj.life = 50
   obj.pressed = false
   obj.appeared = false
   obj.isHit = false
   obj.finishedAnimation = false
   return (obj)
end

function PLAYER:getSize()
   len = 0
   for i in pairs(PLAYERS) do
      len = len + 1
   end
   return len
end

return {
  players = function()
    return PLAYERS
  end,
   draw = function()
      for k, val in pairs(PLAYERS) do
         local spriteNum = math.floor(val.animation.currentTime / val.animation.duration * #val.animation.quads) + 1
         if (spriteNum == #val.animation.quads) then val.finishedAnimation = true end
         --print("spritenum: ", spriteNum, "total: ", #val.animation.quads)
         --if (val.finishedAnimation == true) then
         love.graphics.draw(val.animation.spriteSheet, val.animation.quads[spriteNum],
                            val.pos[1], val.pos[2], 0, val.scale[1], val.scale[2])
         --end
         love.graphics.rectangle("fill", val.life_full[1],
                                 val.life_full[2], val.life, val.life_full[4], love.graphics.setColor(val.color))
         love.graphics.rectangle("line", val.life_empty[1],
                                 val.life_empty[2], val.life_empty[3], val.life_empty[4], love.graphics.setColor(val.color))
         love.graphics.setColor(1, 1, 1)
      end
   end,
   update = function(dt)
      for k, val in pairs(PLAYERS) do
         if (val.finishedAnimation == true and val.appeared == false) then
            val.animation = PLAYER:newAnimation(love.graphics.newImage(PLAYER_SHEET[k]), PLAYER_X[k], PLAYER_Y[k], DURATION)
            val.scale = {X_SCALING / PLAYER_X[k] * 2, Y_SCALING / PLAYER_Y[k] * 2}
            val.appeared = true
         end
         val.animation.currentTime = val.animation.currentTime + dt
         if val.animation.currentTime >= val.animation.duration then
            val.animation.currentTime = val.animation.currentTime - val.animation.duration
         end
      end
   end,
   playerPressDown = function(key)
      for k, val in pairs(PLAYERS) do
         if (val.key == key) then
            val.pressed = true
         end
      end
   end,
   playerPressRelease = function(key)
      for k, val in pairs(PLAYERS) do
         if (val.key == key) then
            val.pressed = false
         end
      end
   end,
   remove = function(index)
      print(PLAYER:getSize())
      if (index ~= 0 and index <= (PLAYER:getSize())) then
         table.remove(PLAYERS, index)
      end
   end,
   foreach = function(f)
      t_c = {}
      for i, v in pairs(PLAYERS) do
         table.insert(t_c, v)
      end
      for i, v in pairs(t_c) do
         f(i, v.key, v.pressed)
      end
   end,
   isPresent = function(key)
      for k, val in pairs(PLAYERS) do
         if (val.key == key) then
            return (true)
         end
      end
      return (false)
   end,
   getSize = function()
      len = PLAYER:getSize()
      return (len)
   end,
   newPlayer = function(key)
      if (key ~= "escape") then
         local obj = PLAYER:new(key)
         table.insert(PLAYERS, obj)
         return (obj)
      end
   end
}
