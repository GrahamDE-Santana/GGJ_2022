--Player.lua

--Player = Class('Player')

local Y_SCALING = 42
local X_SCALING = 44

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
      obj.animation = PLAYER:newAnimation(love.graphics.newImage("assets/mask_idle32x32.png"), 32, 32, 1)
      obj.color = {255, 0, 0}
      obj.scale = {X_SCALING / 32 * 2, Y_SCALING / 32 * 2}
      obj.pos = {20, 20}
   elseif (PLAYER:getSize() == 1) then
      obj.animation = PLAYER:newAnimation(love.graphics.newImage("assets/virual_idle32x32.png"), 32, 32, 1)
      obj.color = {0, 255, 0}
      obj.scale = {X_SCALING / 32 * 2, Y_SCALING / 32 * 2}
      obj.pos = {20, 480}
   elseif (PLAYER:getSize() == 2) then
      obj.animation = PLAYER:newAnimation(love.graphics.newImage("assets/idle_bunny34x44.png"), 34, 44, 1)
      obj.color = {0, 0, 255}
      obj.scale = {X_SCALING / 34 * 2, Y_SCALING / 44 * 2}
      obj.pos = {680, 20}
   else
      obj.animation = PLAYER:newAnimation(love.graphics.newImage("assets/plant_idle44x42.png"), 44, 42, 1)
      obj.color = {255, 255, 0}
      obj.scale = {2, 2}
      obj.pos = {680, 480}
   end
   obj.key = key
   obj.life = 3
   obj.pressed = false
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
   draw = function()
      for k, val in pairs(PLAYERS) do
         local spriteNum = math.floor(val.animation.currentTime / val.animation.duration * #val.animation.quads) + 1
         love.graphics.draw(val.animation.spriteSheet, val.animation.quads[spriteNum],
                            val.pos[1], val.pos[2], 0, val.scale[1], val.scale[2])
      end
   end,
   update = function(dt)
      for k, val in pairs(PLAYERS) do
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
