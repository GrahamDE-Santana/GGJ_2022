RECEPTOR = {}
RECEPTORS = {}

function RECEPTOR:new(player, rythme)
  local obj = {}
  setmetatable(obj, self)
  self.__index = self

  obj.player = player
  obj.rythme = rythme
  obj.prevP = obj.player.pressed
  obj.prevR = obj.rythme:getEnd()
  obj.w = 0
  obj.t = 0
  obj.r_v = 0
  obj.pv = 0
  return obj
end

function RECEPTOR:update(dt)
  local p = self.player.pressed
  local r = self.rythme:getEnd()
  local r_v = 0

  --print(self.rythme:getEnd())
  if p ~= r then
    self.w = self.w + dt
    if (self.w > 0.10) then
      self.w = 0
      r_v = -1
    else
      r_v = 0
    end
  else
    self.w = 0
    r_v = 1
  end

  self.prevP = p
  self.prevR = r
  self.r_v = r_v
  if p then
    self.player.sound:play()
  else 
    self.player.sound:stop()
  end
  if self.pv ~= -1 and self.r_v == 1 then
    print(self.player, " OK")
  end
  if (self.r_v == -1) then
    print(self.player, " wrong")
  end
  self.pv = r_v
  return r_v
end

return {
  first = function()
    return RECEPTORS[1]
  end,
  update = function(dt)
     for i, v in pairs(RECEPTORS) do
        v:update(dt)
     end
  end,
  newReceptor = function(player, rythme)
    local obj = RECEPTOR:new(player, rythme)
    table.insert(RECEPTORS, obj)
    return obj
  end
}
