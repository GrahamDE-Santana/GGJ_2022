--Player.lua

--Player = Class('Player')

PLAYER = {}
PLAYERS = {}

function PLAYER:new(key)
   local obj = {}
   setmetatable(obj, self)
   self.__index = self

   if (PLAYER:getSize() == 0) then
      obj.color = {255, 0, 0}
      obj.pos = {20, 20}
   elseif (PLAYER:getSize() == 1) then
      obj.color = {0, 255, 0}
      obj.pos = {20, 480}
   elseif (PLAYER:getSize() == 2) then
      obj.color = {0, 0, 255}
      obj.pos = {680, 20}
   else
      obj.color = {255, 255, 0}
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

function PLAYER:update()
   --
end

return {
   draw = function()
      for k, val in pairs(PLAYERS) do
         love.graphics.setColor(val.color[1], val.color[2], val.color[3])
         love.graphics.rectangle("fill", val.pos[1], val.pos[2], 100, 100)
      end
      love.graphics.setColor(255, 255, 255)
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
      local obj = PLAYER:new(key)
      table.insert(PLAYERS, obj)
      return obj
   end
}
