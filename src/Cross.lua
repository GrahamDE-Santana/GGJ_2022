--Cross.lua

local FINAL_SCALE = 100 / 630

CROSS = {}
CROSSES = {}

function CROSS:new(x, y)
   local obj = {}
   setmetatable(obj, self)
   self.__index = self

   obj.sprite = love.graphics.newImage("assets/red_cross.png")
   obj.transparenty = 0
   obj.pos = {x, y}
   obj.scale = {200 / 630, 200 / 630}
   return (obj)
end

return {
   newCross = function(x, y)
      local object = CROSS:new(x, y)

      table.insert(CROSSES, object)
      return (object)
   end,
   draw = function()
      for i, val in pairs(CROSSES) do
         love.graphics.setColor(1, 1, 1, val.transparenty)
         love.graphics.draw(val.sprite, val.pos[1], val.pos[2], 0, val.scale[1], val.scale[2])
      end
   end,
   update = function()
      for i, val in pairs(CROSSES) do
         if (val.transparenty <= 1) then val.transparenty = val.transparenty + 0.02 end
         if (val.scale[1] >= FINAL_SCALE) then val.scale[1] = val.scale[1] - 0.005 end
         if (val.scale[2] >= FINAL_SCALE) then val.scale[2] = val.scale[2] - 0.005 end
      end
   end
}
