function love.load()
    love.window.setMode(1920, 1080, {resizable = false})
    menu_back = love.graphics.newImage("images/menu_back.png")
    menu_buttonBack = love.graphics.newImage("images/menu_buttonBack.png")
    menu_playButton = love.graphics.newImage("images/menu_playButton.png")
    menu_settingsButton = love.graphics.newImage("images/menu_settingsButton.png")
    menu_exitButton = love.graphics.newImage("images/menu_exitButton.png")

end

function love.update(dt)
    playButton_maxX, playButton_maxY = 845 + 230, 525 + 100
    settingsButton_maxX, settingsButton_maxY = 777 + 370, 645 + 100
    exitButton_maxX, exitButton_maxY = 865 + 180, 760 + 100
    mouse_posX, mouse_posY = love.mouse.getPosition()

    if love.mouse.isDown(1) then
        if (mouse_posX >= 845 and mouse_posX <= playButton_maxX) and (mouse_posY >= 525 and mouse_posY <= playButton_maxY) then
            print("Play Button")
        elseif (mouse_posX >= 777 and mouse_posX <= settingsButton_maxX) and (mouse_posY >= 645 and mouse_posY <= settingsButton_maxY) then
            print("Settings Button")
        elseif (mouse_posX >= 865 and mouse_posX <= exitButton_maxX) and (mouse_posY >= 760 and mouse_posY <= exitButton_maxY) then
            print("Exit Button")
        end
    end
end

function love.draw()
    love.graphics.draw(menu_back, 0, 0)
    love.graphics.draw(menu_buttonBack, 710, 440)
    love.graphics.draw(menu_playButton, 845, 525)
    love.graphics.draw(menu_settingsButton, 777, 645)
    love.graphics.draw(menu_exitButton, 865, 760)
end
