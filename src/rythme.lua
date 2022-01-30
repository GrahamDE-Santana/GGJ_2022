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
  obj.v = 0
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


---
--- Graham vas factoriser les function suivant
---

function RYTHME:drawUp(yy)
  local data = self.data
  local bpm = self.t;
  local x, y = self:getXY()
  local xx = 0
  local power = 0
  local up = self.v * 30
  local size = 17 + (up/15)
  for ix=1, 4 do
    for iy=1, 8 do
      if self.data[x][y] == true then
        love.graphics.setColor(1, 0.1, 0.1)
        power = 4 + power
      else
        love.graphics.setColor(0.3, 0.3, 0.3)
        power = 0
      end
      love.graphics.rectangle("fill",125 + xx-up ,yy-(power/2)-(up/2),size+up ,50+power+up)
      love.graphics.setColor(0.5, 0.5, 0.5)
      love.graphics.rectangle("line",125 + xx-up,yy-(power/2)-(up/2),size+up,50+power+up)

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
  local power = 0
  local up = self.v * 15
  local size = 17 + (up/15)
  for ix=1, 4 do
    for iy=1, 8 do
      if self.data[x][y] == true then
        love.graphics.setColor(1, 0.1, 0.1)
        power = 4 + power
      else
        love.graphics.setColor(0.3, 0.3, 0.3)
        power = 0
      end
      love.graphics.rectangle("fill",125 + xx-up ,yy-(power/2)-(up/2),size+up ,50+power+up)
      love.graphics.setColor(0.5, 0.5, 0.5)
      love.graphics.rectangle("line",125 + xx-up,yy-(power/2)-(up/2),size+up,50+power+up)

      xx = xx - size
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

function RYTHME:drawRight(xx)
  local data = self.data
  local bpm = self.t;
  local x, y = self:getXY()
  local yy = 0
  local power = 0
  local up = self.v * 15
  local size = 17 + (up/15)

  for ix=1, 4 do
    for iy=1, 8 do
      if self.data[x][y] == true then
        love.graphics.setColor(1, 0.1, 0.1)
        power = 4 + power
      else
        love.graphics.setColor(0.3, 0.3, 0.3)
        power = 0
      end
      love.graphics.rectangle("fill",xx-(power/2)-(up/2),125 + yy-up, 50+power+up,size+up)
      love.graphics.setColor(0.5, 0.5, 0.5)
      love.graphics.rectangle("line",xx-(power/2)-(up/2),125 + yy-up, 50+power+up,size+up)

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
  local power = 0
  local up = self.v * 15
  local size = 17 + (up/15)

  for ix=1, 4 do
    for iy=1, 8 do
      if self.data[x][y] == true then
        love.graphics.setColor(1, 0.1, 0.1)
        power = 4 + power
      else
        love.graphics.setColor(0.3, 0.3, 0.3)
        power = 0
      end
      love.graphics.rectangle("fill",xx-(power/2)-(up/2),125 + yy-up, 50+power+up,size+up)
      love.graphics.setColor(0.5, 0.5, 0.5)
      love.graphics.rectangle("line",xx-(power/2)-(up/2),125 + yy-up, 50+power+up,size+up)

      yy = yy - size
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
  self.v = math.max(self.v - dt, 0)
  if (self.v == 0) then self.v = self.u * 0.80 end
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
    self.data[x][y] = false
  end
end

---
--- Bon courrage
---


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
