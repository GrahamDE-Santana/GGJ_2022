CONNECTOR = {}
CONNECTORS = {}

function  CONNECTOR:new(a, b)
  local obj = {}
  setmetatable(obj, self)
  self.__index = self

  obj.a = a
  obj.b = b
  return (obj)
end

function CONNECTOR:update(dt)
  -- local x, y = self.b:getXY()
  -- x = x + 4
  -- if x > self.b.nb then
  --   x = x - self.b.nb
  -- end
  -- self.b:insert(self.a:getCurrentValue(), x, y)
end


return {

  update = function(dt)
     for i, v in pairs(CONNECTORS) do
        v:update(dt)
     end
  end,

  newConnector = function(a, b)
    local obj = CONNECTOR:new(a, b)
    table.insert(CONNECTORS, obj)
    return obj
  end
}
