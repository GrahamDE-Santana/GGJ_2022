RECEPTOR = {}
RECEPTORS = {}

function RECEPTOR:new(player, rythme)
  local obj = {}
  setmetatable(obj, self)
  self.__index = self

  obj.player = player
  obj.rythme = rythme

  obj.valide = false
  obj.spe = false
  obj.rv = 0
  obj.p = 0
  return obj
end

function RECEPTOR:win()
  --TODO
end

function RECEPTOR:wait()
  --TODO
end

function RECEPTOR:loose()
  --TODO
end
function RECEPTOR:update(dt)
  local p = self.player.pressed
  local r = self.rythme:getEnd()

  if p == true then
    self.player.sound:play()
  else
    self.player.sound:stop()
  end
  if p == r then
    self.valide = true
    obj.p = 0
    if p == true then obj.p = 1 end
  end
  if self.rythme.next == true then
    if self.valide == false then
      self:loose()
      return -1
    end
    print("valide", obj.p)
    self.valide = false
    self.spe = false
    self.rv = 1
    if self.valide == true then
      self:win()
    else
      self:wait()
    end
    return 1
  end
  return 0
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
