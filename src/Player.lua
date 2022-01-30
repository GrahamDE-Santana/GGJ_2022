--Player.lua

local Cross = require "src.Cross"

local Y_SCALING = 42
local X_SCALING = 44
local PLAYER_X = {32, 34, 44, 32}
local PLAYER_Y = {32, 44, 42, 32}
local DURATION = 1

local GAME_END = false
local REMAINING_PLAYERS = 4
local SPAWNED_PLAYERS = {false, false, false, false}
local DEAD_PLAYERS = {false, false, false, false}
local PLAYER_SHEET = {"assets/mask_idle32x32.png",
                      "assets/idle_bunny34x44.png",
                      "assets/plant_idle44x42.png",
                      "assets/virual_idle32x32.png"}

PLAYER = {}
PLAYERS = {}
PODIUM = {}

function PLAYER:gameEnd()
   if (GAME_END == true) then
      table.remove(PODIUM, 1)
      table.remove(PODIUM, 5)
   --for i, val in pairs(PODIUM) do
      --print(i, val.name)
   --end
   end
   return (GAME_END)
end

function PLAYER:new(key)
   local obj = {}
   setmetatable(obj, self)
   self.__index = self

   if (PLAYER:getSize() == 0) then
      obj.color = {200, 0, 0}
      obj.name = "mask"
      obj.pos = {20, 20}
      obj.sound = {}
      obj.sound[1] = love.audio.newSource("sound/FM_twang_do.mp3", "static")
      obj.sound[2] = love.audio.newSource("sound/FM_twang_mi.mp3", "static")
      obj.sound[3] = love.audio.newSource("sound/FM_twang_sol.mp3", "static")
      obj.sound[4] = love.audio.newSource("sound/FM_twang_si.mp3", "static")
      obj.sound[5] = love.audio.newSource("sound/FM_twang_dodo.mp3", "static")
      obj.life_full = {20 + 120, 20 + 100, 0, 20}
      obj.life_empty = {20 + 120, 20 + 100, 150, 20}
      obj.hitAnim = PLAYER:newAnimation(love.graphics.newImage("assets/mask_hit_32x32.png"), 32, 32, DURATION)
      obj.hitScale = {X_SCALING / 32 * 2, Y_SCALING / 32 * 2}
   elseif (PLAYER:getSize() == 1) then
      obj.pos = {680, 20}
      obj.sound = {}
      obj.name = "bunny"
      obj.sound[1] = love.audio.newSource("sound/rock_organ_do.mp3", "static")
      obj.sound[2] = love.audio.newSource("sound/rock_organ_mi.mp3", "static")
      obj.sound[3] = love.audio.newSource("sound/rock_organ_sol.mp3", "static")
      obj.sound[4] = love.audio.newSource("sound/rock_organ_si.mp3", "static")
      obj.sound[5] = love.audio.newSource("sound/rock_organ_dodo.mp3", "static")
      obj.life_full = {680 - 170, 20 + 100, 0, 20}
      obj.life_empty = {680 - 170, 20 + 100, 150, 20}
      obj.color = {200, 0, 220}
      obj.hitAnim = PLAYER:newAnimation(love.graphics.newImage("assets/bunny_hit_34_44.png"), 34, 44, DURATION)
      obj.hitScale = {X_SCALING / 34 * 2, Y_SCALING / 44 * 2}
   elseif (PLAYER:getSize() == 2) then
     obj.pos = {680, 680}
     obj.sound = {}
     obj.name = "plant"
     obj.sound[1] = love.audio.newSource("sound/tuba_do.mp3", "static")
     obj.sound[2] = love.audio.newSource("sound/tuba_mi.mp3", "static")
     obj.sound[3] = love.audio.newSource("sound/tuba_sol.mp3", "static")
     obj.sound[4] = love.audio.newSource("sound/tuba_si.mp3", "static")
     obj.sound[5] = love.audio.newSource("sound/tuba_dodo.mp3", "static")
     obj.life_full = {680 - 170, 680, 0, 20}
     obj.life_empty = {680 - 170, 680, 150, 20}
     obj.color = {220, 180, 0}
     obj.hitAnim = PLAYER:newAnimation(love.graphics.newImage("assets/plant_hit_44_42.png"), 44, 42, DURATION)
     obj.hitScale = {X_SCALING / 44 * 2, Y_SCALING / 42 * 2}
   else
     obj.pos = {20, 680}
     obj.sound = {}
     obj.name = "virt"
     obj.sound[1] = love.audio.newSource("sound/music_box_do.mp3", "static")
     obj.sound[2] = love.audio.newSource("sound/music_box_mi.mp3", "static")
     obj.sound[3] = love.audio.newSource("sound/music_box_sol.mp3", "static")
     obj.sound[4] = love.audio.newSource("sound/music_box_si.mp3", "static")
     obj.sound[5] = love.audio.newSource("sound/music_box_dodo.mp3", "static")
     obj.life_full = {20 + 120, 680, 0, 20}
     obj.life_empty = {20 + 120, 680, 150, 20}
     obj.color = {0, 20, 200}
     obj.hitAnim = PLAYER:newAnimation(love.graphics.newImage("assets/virt_hit32x32.png"), 32, 32, DURATION)
     obj.hitScale = {X_SCALING / 32 * 2, Y_SCALING / 32 * 2}
   end
   obj.scale = {X_SCALING / 96 * 2, Y_SCALING / 96 * 2}
   obj.animation = PLAYER:newAnimation(love.graphics.newImage("assets/appear_96_96.png"), 96, 96, DURATION)
   obj.key = key
   obj.life = 50
   obj.pressed = false
   obj.isHit = false
   obj.finishedAnimation = false
   obj.prevN = 1
   obj.ps = 1
   obj.isPlaying = false
   return (obj)
end

function PLAYER:newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    animation.duration = duration or 1
    animation.currentTime = 0
    return animation
end

function PLAYER:getSize()
   len = 0
   for i in pairs(PLAYERS) do
      len = len + 1
   end
   return len
end

function PLAYER:playSong()
  if self.isPlaying ~= true then
    self.isPlaying = true
    self.sound[self.ps]:stop()
    self.ps = self.ps + 1
    if self.ps > 5 then self.ps = 1 end
    self.sound[self.ps]:play()
  end
end

function PLAYER:stopSong()
  self.sound[self.ps]:stop()
  self.isPlaying = false
end

function PLAYER:spawnPlayer(k, val)
   if (val.finishedAnimation == true) then
      val.animation = PLAYER:newAnimation(love.graphics.newImage(PLAYER_SHEET[k]), PLAYER_X[k], PLAYER_Y[k], DURATION)
      val.scale = {X_SCALING / PLAYER_X[k] * 2, Y_SCALING / PLAYER_Y[k] * 2}
      SPAWNED_PLAYERS[k] = true
   end
end

function PLAYER:killPlayer(k, val)
   Cross.newCross(val.pos[1], val.pos[2])
   val.animation = PLAYER:newAnimation(love.graphics.newImage("assets/dead_96x96.png"), 96, 96, DURATION)
   val.scale = {X_SCALING / 96 * 2, Y_SCALING / 96 * 2}
   DEAD_PLAYERS[k] = true
   val.finishedAnimation = false
   REMAINING_PLAYERS = REMAINING_PLAYERS - 1
   table.insert(PODIUM, val)
end

function PLAYER:hitAnimation(k, val)
   local spriteNum = math.floor(val.hitAnim.currentTime / val.hitAnim.duration * #val.hitAnim.quads) + 1

   if (spriteNum == #val.hitAnim.quads) then val.finishedAnimation = true else val.finishedAnimation = false end
   love.graphics.draw(val.hitAnim.spriteSheet, val.hitAnim.quads[spriteNum],
                      val.pos[1], val.pos[2], 0, val.hitScale[1], val.hitScale[2])
end

function PLAYER:idleAnimation(k, val)
   local spriteNum = math.floor(val.animation.currentTime / val.animation.duration * #val.animation.quads) + 1

   if (spriteNum == #val.animation.quads) then val.finishedAnimation = true else val.finishedAnimation = false end
   love.graphics.draw(val.animation.spriteSheet, val.animation.quads[spriteNum],
                      val.pos[1], val.pos[2], 0, val.scale[1], val.scale[2])
end

return {
   gameEnd = function()
      isTrue = PLAYER:gameEnd()
      return (isTrue)
   end,
   players = function()
      return PLAYERS
   end,
   draw = function()
      for k, val in pairs(PLAYERS) do
         if (DEAD_PLAYERS[k] ~= true) then
            if (val.isHit ~= true) then PLAYER:idleAnimation(k, val) else PLAYER:hitAnimation(k, val) end
            love.graphics.rectangle("fill", val.life_full[1],
                                    val.life_full[2], val.life, val.life_full[4], love.graphics.setColor(val.color))
            love.graphics.rectangle("line", val.life_empty[1],
                                    val.life_empty[2], val.life_empty[3], val.life_empty[4], love.graphics.setColor(val.color))
            love.graphics.setColor(1, 1, 1)
         else if (val.finishedAnimation == false) then PLAYER:idleAnimation(k, val) end end
      end
      Cross.draw()
   end,
   update = function(dt)
      for k, val in pairs(PLAYERS) do
         if (SPAWNED_PLAYERS[k] == false) then PLAYER:spawnPlayer(k, val) end
         if (val.life <= 0 and DEAD_PLAYERS[k] == false) then PLAYER:killPlayer(k, val) end
         if (REMAINING_PLAYERS == 1) then
            for k, val in pairs(PLAYERS) do
               val.animation = PLAYER:newAnimation(love.graphics.newImage(PLAYER_SHEET[k]), PLAYER_X[k], PLAYER_Y[k], DURATION)
               if (DEAD_PLAYERS[k] == false) then table.insert(PODIUM, val) GAME_END = true end
            end
         end
            
         if (val.isHit == true and val.finishedAnimation == true) then val.isHit = false end
            val.animation.currentTime = val.animation.currentTime + dt
            if val.animation.currentTime >= val.animation.duration then
               val.animation.currentTime = val.animation.currentTime - val.animation.duration
            end
            val.hitAnim.currentTime = val.hitAnim.currentTime + dt
            if val.hitAnim.currentTime >= val.hitAnim.duration then
               val.hitAnim.currentTime = val.hitAnim.currentTime - val.hitAnim.duration
            end
      end --end for
      Cross.update()
   end,
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
      local t_c = {}

      for i, v in pairs(PLAYERS) do
         table.insert(t_c, v)
      end
      for i, v in pairs(t_c) do
         f(v)
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
      if (key ~= "escape") then
         local obj = PLAYER:new(key)
         table.insert(PLAYERS, obj)
         return (obj)
      end
   end
}
