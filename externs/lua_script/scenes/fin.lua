-- =========================================
-- =                MAIN MENU              =
-- =========================================

local background = lsfml.sprite.create()
local text_fin = lsfml.text.create()
background:setTexture(assets["background"], false)

text_fin:setFont(assets["fsys"])
text_fin:setCharacterSize(60)
text_fin:setString("Merci d'avoir jouer a notre jeu, nous l'avons\nrealise a trois jusqu'a la fin\net on compte bien evidemment le continuer,\nceci n'est que notre premiere version qui\nplus est assez complete !!\nFait par Combe Yannick, Begard Cyril et Vessiere Yoan")
text_fin:setPosition(250, 100)

local exit_button = button.create{
    x = 750,
    y = 1080 / 2 + 170 / 2 + 170 / 2,
    width = 420,
    height = 170,
    callback = function(self, ...)
        local event = {...}
        if event[1] == "click" then
            window:close()
        elseif event[1] == "enter" then
            assets["button_hover_sfx"]:play()
        end
    end,
    idle = assets["button_idle"],
    hover = assets["button_hover"],
    press = assets["button_pressed"],
    text = "Exit",
    csize = 100,
}

local main_menu = button.create{
    x = 750,
    y = 1080 / 2,
    width = 420,
    height = 170,
    callback = function(self, ...)
        local event = {...}
        if event[1] == "click" then
            setScene("main_menu")
            option_menu:close()
        elseif event[1] == "enter" then
            assets["button_hover_sfx"]:play()
        end
    end,
    idle = assets["button_idle"],
    hover = assets["button_hover"],
    press = assets["button_pressed"],
    text = "Main menu",
    csize = 86,
}

function load()
    player_hud:close()
    assets["menu_music"]:setLoop(true)
    assets["menu_music"]:play()
    exit_button:setStatus("released")
    main_menu:setStatus("released")
    world.renderDisable()
    world.updateDisable()
    world.eventDisable()
    hud.renderDisable()
end

function unload()
    assets["menu_music"]:stop()
    world.eventEnable()
    world.updateEnable()
    world.renderEnable()
    hud.renderEnable()
end

function draw()
    window:draw(background)
    main_menu:draw()
    exit_button:draw()
    window:draw(text_fin)
end

function update()

end

function event(e)
    main_menu:event(e)
    exit_button:event(e)
end