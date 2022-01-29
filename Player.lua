--Player.lua

--Player = Class('Player')

PLAYER = {}
PLAYERS = {}

function PLAYER:new(key)
   local obj = {}
   setmetatable(obj, self)
   self.__index = self

   obj.key = key
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
