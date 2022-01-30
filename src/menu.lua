
local sc_player_selection = 2
local sc_game = 3
local lg = love.graphics
local menu = "main"
MENU = {}

function MENU:new()
    obj = {}
    setmetatable(obj, self)
    self.__index = self
    fontsize = 75
    fontname = "font/04B_03__.TTF"
    font = lg.newFont(fontname, fontsize)
    lg.setFont(font)
    allowed_chars = "0123456789"
    love.keyboard.setTextInput(false)
    input_text1 = "100"
    input_text2 = "100"
    input_text3 = "100"
    input_text4 = "100"
    output1_x = 460
    output1_y = 305
    output1_limit = 450 + 150
    output2_x = 460
    output2_y = 405
    output2_limit = 450 + 150
    output3_x = 460
    output3_y = 505
    output3_limit = 450 + 150
    output4_x = 460
    output4_y = 605
    output4_limit = 450 + 150
    -- Load Main Menu Canvas
    mainMenuCanvas = lg.newCanvas(800, 800)
    showCanvas = mainMenuCanvas
    mainMenu_back = lg.newImage("assets/main_menu/menu_back.png")
    mainMenu_buttonBack = lg.newImage("assets/main_menu/menu_buttonBack.png")
    mainMenu_playButton = lg.newImage("assets/main_menu/menu_playButton.png")
    mainMenu_settingsButton = lg.newImage("assets/main_menu/menu_settingsButton.png")
    mainMenu_exitButton = lg.newImage("assets/main_menu/menu_exitButton.png")
    playButton_minX, playButton_minY, playButton_maxX, playButton_maxY = 285, 350, 285 + 230, 350 + 100
    settingsButton_minX, settingsButton_minY, settingsButton_maxX, settingsButton_maxY = 215, 470, 215 + 370, 470 + 100
    exitButton_minX, exitButton_minY, exitButton_maxX, exitButton_maxY = 310, 590, 310 + 180, 590 + 100
    -- Load Settings Menu Canvas
    settingsMenuCanvas = lg.newCanvas(800, 800)
    settingsMenu_back = lg.newImage("assets/menu_settings/menu_back.png")
    settingsMenu_buttonBack = lg.newImage("assets/menu_settings/menu_buttonBack.png")
    settingsMenu_backButton = lg.newImage("assets/menu_settings/menu_backButton.png")
    settingsMenu_soundP1Text = lg.newImage("assets/menu_settings/menu_soundP1.png")
    settingsMenu_soundP2Text = lg.newImage("assets/menu_settings/menu_soundP2.png")
    settingsMenu_soundP3Text = lg.newImage("assets/menu_settings/menu_soundP3.png")
    settingsMenu_soundP4Text = lg.newImage("assets/menu_settings/menu_soundP4.png")
    settingsMenu_inputBox1 = lg.newImage("assets/menu_settings/menu_input.png")
    settingsMenu_inputBox2 = lg.newImage("assets/menu_settings/menu_input.png")
    settingsMenu_inputBox3 = lg.newImage("assets/menu_settings/menu_input.png")
    settingsMenu_inputBox4 = lg.newImage("assets/menu_settings/menu_input.png")
    backButton_minX, backButton_minY, backButton_maxX, backButton_maxY = 495, 690, 495 + 120, 690 + 48
    inputBox1_minX, inputBox1_minY, inputBox1_maxX, inputBox1_maxY = 450, 305, 450 + 150, 305 + 70
    inputBox2_minX, inputBox2_minY, inputBox2_maxX, inputBox2_maxY = 450, 405, 450 + 150, 405 + 70
    inputBox3_minX, inputBox3_minY, inputBox3_maxX, inputBox3_maxY = 450, 505, 450 + 150, 505 + 70
    inputBox4_minX, inputBox4_minY, inputBox4_maxX, inputBox4_maxY = 450, 605, 450 + 150, 605 + 70
    return (obj)
end

function MENU:mousepressed(x, y, button, istouch)
    if button == 1 then
        if string.find(menu, "main") then
            if (x >= playButton_minX and x <= playButton_maxX) and (y >= playButton_minY and y <= playButton_maxY) then
                menu = "play"
                nb_scene = sc_player_selection
                print(nb_scene)
            elseif (x >= settingsButton_minX and x <= settingsButton_maxX) and (y >= settingsButton_minY and y <= settingsButton_maxY) then
                menu = "settings"
                showCanvas = settingsMenuCanvas
            elseif (x >= exitButton_minX and x <= exitButton_maxX) and (y >= exitButton_minY and y <= exitButton_maxY) then
                love.event.quit()
            end
        elseif string.find(menu, "settings") then
            if (x >= backButton_minX and x <= backButton_maxX) and (y >= backButton_minY and y <= backButton_maxY) then
                menu = "main"
                love.keyboard.setTextInput(false)
                showCanvas = mainMenuCanvas
            elseif (x >= inputBox1_minX and x <= inputBox1_maxX) and (y >= inputBox1_minY and y <= inputBox1_maxY) then
                love.keyboard.setTextInput(true)
                box = "1"
            elseif (x >= inputBox2_minX and x <= inputBox2_maxX) and (y >= inputBox2_minY and y <= inputBox2_maxY) then
                love.keyboard.setTextInput(true)
                box = "2"
            elseif (x >= inputBox3_minX and x <= inputBox3_maxX) and (y >= inputBox3_minY and y <= inputBox3_maxY) then
                love.keyboard.setTextInput(true)
                box = "3"
            elseif (x >= inputBox4_minX and x <= inputBox4_maxX) and (y >= inputBox4_minY and y <= inputBox4_maxY) then
                love.keyboard.setTextInput(true)
                box = "4"
            else
                love.keyboard.setTextInput(false)
            end
        end
    end
 end

 function MENU:keypressed(key)
    if key == "backspace" or key == "delete" then
        if box == "1" then
            input_text1 = input_text1:sub(1, -2)
        elseif box == "2" then
            input_text2 = input_text2:sub(1, -2)
        elseif box == "3" then
            input_text3 = input_text3:sub(1, -2)
        elseif box == "4" then
            input_text4 = input_text4:sub(1, -2)
        end
    end
end

function MENU:textinput(t)
    for i = 1, #allowed_chars do
        if box == "1" then
            if allowed_chars :sub(i,i) == t and string.len(input_text1) < 3 then
                input_text1 = input_text1 ..t
            end
        elseif box == "2" then
            if allowed_chars :sub(i,i) == t and string.len(input_text2) < 3 then
                input_text2 = input_text2 ..t
            end
        elseif box == "3" then
            if allowed_chars :sub(i,i) == t and string.len(input_text3) < 3 then
                input_text3 = input_text3 ..t
            end
        elseif box == "4" then
            if allowed_chars :sub(i,i) == t and string.len(input_text4) < 3 then
                input_text4 = input_text4 ..t
            end
        end
    end
end

function MENU:boucle(nb)
end

function MENU:draw()
    -- Main Menu Canvas Draw
    lg.setCanvas( {mainMenuCanvas, stencil=true})
    lg.clear(0, 0, 0, 0)
    lg.draw(mainMenu_back, 0, 0)
    lg.draw(mainMenu_buttonBack, 150, 270)
    lg.draw(mainMenu_playButton, 285, 350)
    lg.draw(mainMenu_settingsButton, 215, 470)
    lg.draw(mainMenu_exitButton, 310, 590)
    lg.setCanvas()
     -- Settings Menu Canvas Draw
    lg.setCanvas( {settingsMenuCanvas, stencil=true})
    lg.clear(0, 0, 0, 0)
    lg.draw(settingsMenu_back, 0, 0)
    lg.draw(settingsMenu_buttonBack, 150, 270)
    lg.draw(settingsMenu_backButton, 495, 690)
    lg.draw(settingsMenu_soundP1Text, 200, 305)
    lg.draw(settingsMenu_inputBox1, 450, 305)
    lg.printf(input_text1, output1_x, output1_y, output1_limit)
    lg.draw(settingsMenu_soundP2Text, 200, 405)
    lg.draw(settingsMenu_inputBox2, 450, 405)
    lg.printf(input_text2, output2_x, output2_y, output2_limit)
    lg.draw(settingsMenu_soundP3Text, 200, 505)
    lg.draw(settingsMenu_inputBox3, 450, 505)
    lg.printf(input_text3, output3_x, output3_y, output3_limit)
    lg.draw(settingsMenu_soundP4Text, 200, 605)
    lg.draw(settingsMenu_inputBox4, 450, 605)
    lg.printf(input_text4, output4_x, output4_y, output4_limit)
    lg.setCanvas()
    -- Show Canvas Selected
    lg.draw(showCanvas, 0, 0)
end

return {
    newMenu = function()
    obj = MENU:new()
    table.insert(MENU, obj)
    return obj
end
}