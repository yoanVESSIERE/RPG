-- =========================================
-- =                MAIN MENU              =
-- =========================================

local background = lsfml.sprite.create()
local title = lsfml.text.create()
background:setTexture(assets["background"], false)

title:setFont(assets["fsys"])
title:setCharacterSize(200)
title:setString("Enter The Lab")
title:setPosition(350, 50)

local play_button = button.create{
    x = 750,
    y = 1080 / 2 - 170 - 170 / 2,
    width = 420,
    height = 170,
    callback = function(self, ...)
        local event = {...}
        if event[1] == "click" then
            setScene("test_player")
        elseif event[1] == "enter" then
            assets["button_hover_sfx"]:play()
        end
    end,
    idle = assets["button_idle"],
    hover = assets["button_hover"],
    press = assets["button_pressed"],
    text = "Play",
    csize = 100,
}

local HowToPlay_button = button.create{
    x = 750,
    y = 1080 / 2 - 170 / 2,
    width = 420,
    height = 170,
    callback = function(self, ...)
        local event = {...}
        if event[1] == "click" then
            setScene("howtoplay_menu")
        elseif event[1] == "enter" then
            assets["button_hover_sfx"]:play()
        end
    end,
    idle = assets["button_idle"],
    hover = assets["button_hover"],
    press = assets["button_pressed"],
    text = "How To Play",
    csize = 70,
}

local option_button = button.create{
    x = 750,
    y = 1080 / 2 + 170 / 2,
    width = 420,
    height = 170,
    callback = function(self, ...)
        local event = {...}
        if event[1] == "click" then
            setScene("options_menu")
        elseif event[1] == "enter" then
            assets["button_hover_sfx"]:play()
        end
    end,
    idle = assets["button_idle"],
    hover = assets["button_hover"],
    press = assets["button_pressed"],
    text = "Options",
    csize = 100,
}

local exit_button = button.create{
    x = 750,
    y = 1080 / 2 + 170 / 2 + 170,
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
    play_button:setStatus("released")
    option_button:setStatus("released")
    HowToPlay_button:setStatus("released")
    world.renderDisable()
    world.updateDisable()
    world.eventDisable()
    hud.renderDisable()
    -- player.setLevel(1)
    -- player.setExperience(0)
    player.computeMaxHealth()
    player.setHealth(player.getMaximumHealth())
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
    play_button:draw()
    option_button:draw()
    exit_button:draw()
    HowToPlay_button:draw()
    window:draw(title)
end

function update()

end

function event(e)
    play_button:event(e)
    option_button:event(e)
    exit_button:event(e)
    HowToPlay_button:event(e)
end