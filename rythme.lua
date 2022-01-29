RYTHME = {}

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

  return (obj)
end

function RYTHME:getCurrentValue()
  local x = 1 + math.floor(self.t / self.u)
  local y = 1 + math.floor(math.fmod((self.t / self.u) + 1, x) * 4)

  --print("dt : ", self.t)
  --print("x : ", x, self.u * self.t)
  --print("y : ", y, math.fmod(self.u * self.t, self.u))
  --print("")
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
  self.t = dt + self.t
  if self.t >= self.u * self.nb then
    self.t = 0
  end
end

function RYTHME:edit(dt, v)
  self.t = dt + self.t
  if self.t >= self.nb * self.tempo then
    self.t = self.nb * self.tempo
  end
  if v ~= nil then
    local x, y = self:getTable()
    self.data[x][y] = v
  end
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
