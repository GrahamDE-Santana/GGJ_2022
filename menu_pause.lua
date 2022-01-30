function love.load()
   
    pause = false
    game_is_paused = love.graphics.newImage('game_is_paused.png')
    
end 

function love.keypressed(key, unicode)
    if key == 'escape' then pause = not pause end
 
end

function love.update(dt)
    print(pause)
end 

function love.draw()
  
    if pause then 

        
        love.graphics.rectangle("fill",160,250, 450,50)

        love.graphics.setColor(0, 0, 0)
        love.graphics.draw(game_is_paused,165,250)
        love.graphics.setColor(1, 1, 1)
    end


  
end
