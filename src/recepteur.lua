RECEPTOR = {}
RECEPTORS = {}

function RECEPTOR:new(player, rythmeIn, rythmeOut)
  local obj = {}
  setmetatable(obj, self)
  self.__index = self

  obj.player = player
  print(obj.player)
  obj.rin = rythmeIn
  obj.rout = rythmeOut

  obj.valide = false
  obj.spe = false
  obj.rv = 0
  obj.p = 0
  obj.onCreate = false
  obj.last = 10
  obj.r = false
  return obj
end

function RECEPTOR:win()
  self.player.life = math.min(self.player.life + 3, 150)
  --TODO
end

function RECEPTOR:wait()
  --TODO
end

function RECEPTOR:loose()
  self.player.life = self.player.life - 2.5
  print("AIE")
  self.player.isHit = true
  self.player.finishedAnimation = false
  --TODO
end

function RECEPTOR:createe()
  self.rout:edit(true)
  self.player.life = self.player.life - 2
end

function RECEPTOR:update(dt)
  local p = self.player.pressed
  if self.rin.next == true then
    self.r = self.rin:getIn()
  end

  if self.player.life <= 0 then
    self.player:stopSong()
    self.player.life = 0
    if self.r == true then
      self:createe()
    end
    return 0
  end
  if p == true or self.r == true then
    self.player:playSong()
  else
    self.player:stopSong()
  end

  if (self.r == true) then
    print("OK!!")
  end
  if p == self.r and self.onCreate == false then
    self.valide = true
    obj.p = 0
    if p == true then obj.p = 1 end
  end
  if self.rin.next == true then
    --print("CHECK")
    self.last = math.max(self.last - 1, 0)
    if (p == false) then self.onCreate = false end
    if ((self.valide == false and p == true and self.r == false) or (self.onCreate == true)) and
        self.last == 0 then
        print("last : ", self.last)
        self.onCreate = true
        self:createe()
        return (0)
      end
    if self.valide == false then
      self:loose()
      return -1
    end
    self.valide = false
    self.spe = false
    self.rv = 1
    if obj.p == 1 then
      self.last = 8
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
  newReceptor = function(player, rin, rout)
    local obj = RECEPTOR:new(player, rin, rout)
    table.insert(RECEPTORS, obj)
    return obj
  end
}
