
function love.load()
    background = love.graphics.newImage('background.png')
 
end 

function love.draw()
    love.graphics.draw(background, 0, 0)

    love.graphics.rectangle("line", 20,20, 100,100)
    love.graphics.rectangle("line", 680,20, 100,100)
    love.graphics.rectangle("line", 20,480, 100,100)
    love.graphics.rectangle("line", 680,480, 100,100)
    love.graphics.rectangle("line", 60,120, 10,357)
    love.graphics.rectangle("line", 720,120, 10,357)
    love.graphics.rectangle("line", 120,70, 557,10)
    love.graphics.rectangle("line", 120,530, 557,10)
    

end

