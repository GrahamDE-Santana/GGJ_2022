RYTHME = {}

function math.Clamp(val, min, max)
    return math.min(math.max(val, min), max)
end

function  RYTHME:new(tempo, nb)
  local obj = {}
  setmetatable(obj, self)
  self.__index = self

  obj.tempo = tempo
  obj.nb = nb
  obj.t = 0
  obj.onEdit = false
  obj.data = {}
  obj.data[1] = {false, false, false, false}
  obj.u = (60. / obj.tempo)

  obj.x = 1
  obj.y = 1
  obj.loop = true
  obj.barre = false
  return (obj)
end

function RYTHME:getXY()
  local x = 1 + math.floor((self.t) / self.u)
  local y = 1 + math.floor(math.fmod((self.t / self.u) + 1, x) * 4)

  return x, y
end

function RYTHME:getCurrentValue()
  local x, y = self:getXY()

  return ((self.data[x])[y])
end

function RYTHME:getTime()
  local unit = (60. / self.tempo)
  --return self.t
  return (self.t / unit)
end

function RYTHME:beginEdit()
  self.t = 0
  self.onEdit = true
end

function RYTHME:setTableData(nb, data)
  self.data[nb] = data
end

function RYTHME:getData(nb, data)
  return self.data
end


function RYTHME:update(dt)
  self.barre = false
  self.t = dt + self.t
  if self.t >= self.u * self.nb then
    if self.loop == true then
      self.t = 0
    else
      self.t = self.u * self.nb
    end
  end
  local x, y = self:getXY()
  if x ~= self.x or y ~= self.y then
    if x ~= self.x then self.barre = true end
    self.x = x
    self.y = y
  end
end

function RYTHME:edit(v)
  local tmp = self.t
  self.t = self.t + (self.u * 0.25)
  local x, y = self:getXY()
  x = math.Clamp(x, 1, self.nb)
  y = math.Clamp(y, 1, self.nb)

  self.data[x][y] = v
  self.t = tmp
end

function RYTHME:endEdit()
  self.onEdit = false
end

return {
  newRythme = function(tempo, nb)
    local obj = RYTHME:new(tempo, nb)
    return obj
  end
}
