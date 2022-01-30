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
  obj.del = {}
  for i=1, obj.nb  do
    obj.data[i] = {false, false, false, false, false, false, false, false}
  end
  for i=1, obj.nb  do
    obj.del[i] = {false, false, false, false, false, false, false, false}
  end
  obj.u = (60. / obj.tempo)

  obj.x = 1
  obj.y = 1
  obj.loop = true
  obj.barre = false
  obj.isEnd = false
  obj.next = true
  obj.px = 1
  obj.py = 1
  return (obj)
end

function RYTHME:getXY()
  local x = 1 + math.floor((self.t) / self.u)
  local y = 1 + math.floor(math.fmod((self.t / self.u) + 1, x) * 8)

  if (x > self.nb) then
    x = 1
    y = 1
  end
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


function RYTHME:drawUp(yy)
  local data = self.data
  local bpm = self.t;
  local x, y = self:getXY()
  local xx = 0
  local power = 0
  local size = 17
  for ix=1, 4 do
    for iy=1, 8 do
      if self.data[x][y] == true then
        love.graphics.setColor(1, 0.1, 0.1)
        power = 4 + power
      else
        love.graphics.setColor(0.3, 0.3, 0.3)
        power = 0
      end
      love.graphics.rectangle("fill",125 + xx ,yy-(power/2),size ,50+power)
      love.graphics.setColor(0.5, 0.5, 0.5)
      love.graphics.rectangle("line",125 + xx,yy-(power/2),size,50+power)

      xx = xx + size
      y = y - 1
      if y <= 0 then
        love.graphics.setColor(0.9, 0.9, 0.9)
        love.graphics.rectangle("fill",125 + xx - 4,yy - 5-(power/2),8,60+power)
        y = 8
        x = x - 1
        if (x <= 0) then x = self.nb end
      end

    end
  end
  love.graphics.setColor(1, 1, 1)
end

function RYTHME:drawDown(yy)
  local data = self.data
  local bpm = self.t;
  local x, y = self:getXY()
  local xx = 552 - 17.25
  local last = false
  local size = 17

  for ix=1, 4 do
    for iy=1, 8 do
      if self.data[x][y] == true then
        love.graphics.setColor(1, 0.1, 0.1)
      else
        love.graphics.setColor(0.3, 0.3, 0.3)
      end
      love.graphics.rectangle("fill",125 + xx,yy,size ,50)
      love.graphics.setColor(0.5, 0.5, 0.5)
      love.graphics.rectangle("line",125 + xx,yy,size,50)

      y = y - 1
      if y <= 0 then
        love.graphics.setColor(0.9, 0.9, 0.9)
        love.graphics.rectangle("fill",125 + xx - 4,yy - 5,8,60)
        y = 8
        x = x - 1
        if (x <= 0) then x = self.nb end
      end
      xx = xx - size
    end
  end
  love.graphics.setColor(1, 1, 1)
end

function RYTHME:drawRight(xx)
  local data = self.data
  local bpm = self.t;
  local x, y = self:getXY()
  local yy = 0
  local size = 17

  for ix=1, 4 do
    for iy=1, 8 do
      if self.data[x][y] == true then
        love.graphics.setColor(1, 0.1, 0.1)
      else
        love.graphics.setColor(0.3, 0.3, 0.3)
      end
      love.graphics.rectangle("fill",xx,125 + yy,50 ,size)
      love.graphics.setColor(0.5, 0.5, 0.5)
      love.graphics.rectangle("line",xx,125 + yy,50,size)

      yy = yy + size
      y = y - 1
      if y <= 0 then
        love.graphics.setColor(0.9, 0.9, 0.9)
        love.graphics.rectangle("fill",xx - 5,125 + yy - 4,60,8)
        y = 8
        x = x - 1
        if (x <= 0) then x = self.nb end
      end
    end
  end
  love.graphics.setColor(1, 1, 1)
end

function RYTHME:drawLeft(xx)
  local data = self.data
  local bpm = self.t;
  local x, y = self:getXY()
  local yy = 552 - 17.25
  local size = 17

  for ix=1, 4 do
    for iy=1, 8 do
      if self.data[x][y] == true then
        love.graphics.setColor(1, 0.1, 0.1)
      else
        love.graphics.setColor(0.3, 0.3, 0.3)
      end
      love.graphics.rectangle("fill",xx,125 + yy,50 ,size)
      love.graphics.setColor(0.5, 0.5, 0.5)
      love.graphics.rectangle("line",xx,125 + yy,50,size)

      y = y - 1
      if y <= 0 then
        love.graphics.setColor(0.9, 0.9, 0.9)
        love.graphics.rectangle("fill",xx - 5,125 + yy - 4,60,8)
        y = 8
        x = x - 1
        if (x <= 0) then x = self.nb
        end
      end
      yy = yy - size
    end
  end
  love.graphics.setColor(1, 1, 1)
end

function RYTHME:update(dt)
  self.next = false
  self.barre = false
  self.t = dt + self.t
  self.isEnd = false
  if self.t >= self.u * self.nb then
    self.isEnd = true
    if self.loop == true then
      self.t = 0
    else
      self.t = self.u * self.nb
    end
  end
  local x, y = self:getXY()
  if x ~= self.x or y ~= self.y then
    self.next = true
    self.px = self.x
    self.py = self.y
    if x ~= self.x then self.barre = true end
    self.x = x
    self.y = y
    x = x + 3
    if x > self.nb then
      x = x - self.nb
    end
    y = y - 1
    if y <= 0 then
      y = 8
      x = x - 1
      if x <= 0 then
        x = self.nb
      end
    end
    self.data[x][y] = false
  end
end

function RYTHME:getIn()
  local x, y = self:getXY()
  x = x + 4
  if x > self.nb then
     x = x - self.nb
  end
  local rv = self.data[x][y]
  --self.data[x][y] = false
  return rv
end

function RYTHME:getEnd()
  local x, y = self:getXY()

  return self.data[x][y]
end

function RYTHME:deleteLast()
  self.data[self.px][self.py] = false
end

function RYTHME:edit(v)
  local x, y = self:getXY()
  self.data[x][y] = v
end

function RYTHME:insert(v, x, y)
  self.data[x][y] = v
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
