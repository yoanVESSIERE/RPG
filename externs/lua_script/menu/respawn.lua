-- =========================================
-- =                MAIN MENU              =
-- =========================================

local background = lsfml.sprite.create()
background:setTexture(assets["background"], false)

local respawn_button = button.create{
    x = 750,
    y = 1080 / 2 - 170 - 170 / 2,
    width = 420,
    height = 170,
    callback = function(self, ...)
        local event = {...}
        if event[1] == "click" then
            player.respawn()
            setScene("test_player")
        elseif event[1] == "enter" then
            assets["button_hover_sfx"]:play()
        end
    end,
    idle = assets["button_idle"],
    hover = assets["button_hover"],
    press = assets["button_pressed"],
    text = "Respawn",
    csize = 100,
}

local main_menu = button.create{
    x = 750,
    y = 1080 / 2 - 170 / 2,
    width = 420,
    height = 170,
    callback = function(self, ...)
        local event = {...}
        if event[1] == "click" then
            player.respawn()
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

local exit_button = button.create{
    x = 750,
    y = 1080 / 2 + 170 / 2,
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

function load()
    player_hud:close()
    assets["menu_music"]:setLoop(true)
    assets["menu_music"]:play()
    exit_button:setStatus("released")
    respawn_button:setStatus("released")
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
    respawn_button:draw()
    main_menu:draw()
    exit_button:draw()
end

function update()

end

function event(e)
    respawn_button:event(e)
    main_menu:event(e)
    exit_button:event(e)
end