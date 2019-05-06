-- =========================================
-- =                MAIN MENU              =
-- =========================================

local play_button = button.create{
    x = 750,
    y = 1080 / 2 - 170 * 2,
    width = 420,
    height = 170,
    callback = function(self, ...)
        local event = {...}
        if event[1] == "click" then
            option_menu:close()
        elseif event[1] == "enter" then
            assets["button_hover_sfx"]:play()
        end
    end,
    idle = assets["button_idle"],
    hover = assets["button_hover"],
    press = assets["button_pressed"],
    text = "Resume",
    csize = 100,
}

local option_button = button.create{
    x = 750,
    y = 1080 / 2 - 170,
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

local exit_button = button.create{
    x = 750,
    y = 1080 / 2 + 170,
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
    exit_button:setStatus("released")
    play_button:setStatus("released")
    main_menu:setStatus("released")
    option_button:setStatus("released")
end

function unload()

end

function open()
    setPaused(true)
    world.updateDisable()
end

function close()
    setPaused(false)
    world.updateEnable()
end

function draw()
    play_button:draw()
    option_button:draw()
    main_menu:draw()
    exit_button:draw()
end

function update()

end

function event(self, e)
    local event = e:getEvent()
    if self:isOpen() then
        if event[1] == "key_pressed" and event[2] ~= keys.Escape then
            e:setCanceled(true)
        end
        play_button:event(e)
        option_button:event(e)
        main_menu:event(e)
        exit_button:event(e)
    end
end