local sc_menu = 1
local sc_player_selection = 2
local sc_game = 3
local lg = love.graphics
local menu = "main"
MENU = {}

function MENU:new()
    obj = {}
    setmetatable(obj, self)
    self.__index = self
    -- Load Main Menu Canvas
    mainMenuCanvas = lg.newCanvas(800, 800)
    showCanvas = mainMenuCanvas
    mainMenu_back = lg.newImage("assets/main_menu/menu_back.png")
    mainMenu_buttonBack = lg.newImage("assets/main_menu/menu_buttonBack.png")
    mainMenu_playButton = lg.newImage("assets/main_menu/menu_playButton.png")
    mainMenu_settingsButton = lg.newImage("assets/main_menu/menu_settingsButton.png")
    mainMenu_exitButton = lg.newImage("assets/main_menu/menu_exitButton.png")
    playButton_maxX, playButton_maxY = 285 + 230, 350 + 100
    settingsButton_maxX, settingsButton_maxY = 215 + 370, 470 + 100
    exitButton_maxX, exitButton_maxY = 310 + 180, 590 + 100
    -- Load Settings Menu Canvas
    settingsMenuCanvas = lg.newCanvas(800, 800)
    settingsMenu_back = lg.newImage("assets/menu_settings/menu_back.png")
    settingsMenu_buttonBack = lg.newImage("assets/menu_settings/menu_buttonBack.png")
    settingsMenu_backButton = lg.newImage("assets/menu_settings/menu_backButton.png")
    backButton_maxX, backButton_maxY = 495 + 120, 690 + 48

    return (obj)
end

function MENU:mousepressed(x, y, button, istouch)
    if button == 1 then
        if string.find(menu, "main") then
            if (x >= 285 and x <= playButton_maxX) and (y >= 350 and y <= playButton_maxY) then
                menu = "play"
                nb_scene = sc_player_selection
                print(nb_scene)
                -- Add code to launch the game !
            elseif (x >= 215 and x <= settingsButton_maxX) and (y >= 470 and y <= settingsButton_maxY) then
                menu = "settings"
                showCanvas = settingsMenuCanvas
            elseif (x >= 310 and x <= exitButton_maxX) and (y >= 590 and y <= exitButton_maxY) then
                love.event.quit()
            end
        elseif string.find(menu, "settings") then
            if (x >= 495 and x <= backButton_maxX) and (y >= 690 and y <= backButton_maxY) then
                menu = "main"
                showCanvas = mainMenuCanvas
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