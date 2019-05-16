-- =========================================
-- =                MAIN MENU              =
-- =========================================

local background = lsfml.sprite.create()
local fen = lsfml.sprite.create()
local arrow = lsfml.sprite.create()
local title = lsfml.text.create()
local how = {lsfml.text.create(), lsfml.text.create()}
local nb_hud
background:setTexture(assets["background"], false)
fen:setTexture(assets["blank"], false)
arrow:setTexture(assets["arrow"], false)

fen:setPosition(300, 170)
fen:scale(0.9, 0.9)

arrow:setPosition(1550, 1080/2 - 105)
arrow:scale(1, 1)

title:setFont(assets["fsys"])
title:setCharacterSize(200)
title:setString("How To Play")
title:setPosition(450, -70)

how[1]:setFont(assets["fsys"])
how[1]:setCharacterSize(50)
how[1]:setPosition(350, 200)

how[2]:setFont(assets["fsys"])
how[2]:setCharacterSize(50)
how[2]:setString("-You can't change map if ennemies are still\nalive\n\n-You can change map if you are in an\noptional boss room\n\n-Ennemies respawn after a certain amount of\ntime so don't be surprise !!!\n\n-There is 3 boss in the map, one is optional,\nan other is on the map and the last is\nthe final boss\n\n-All ennemies have a small but real chance to\ndrop armor pieces in a different rarity")
how[2]:setPosition(350, 200)

local right_button = button.create{
    x = 1550 - 50,
    y = 1080 / 2 - 105,
    width = 210,
    height = 210,
    callback = function(self, ...)
        local event = {...}
        if nb_hud <= 1 then
            if event[1] == "click" then
                nb_hud = nb_hud + 1
            elseif event[1] == "enter" then
                assets["button_hover_sfx"]:play()
            end
        end
    end,
    idle = assets["arrow"],
    hover = assets["arrow_active"],
    press = assets["arrow"],
}

local left_button = button.create{
    x = 143 - 50,
    y = 1080 / 2 - 105,
    width = 210,
    height = 210,
    callback = function(self, ...)
        local event = {...}
        if nb_hud >= 2 then
            if event[1] == "click" then
                nb_hud = nb_hud - 1
            elseif event[1] == "enter" then
                assets["button_hover_sfx"]:play()
            end
        end
    end,
    idle = assets["arrowr"],
    hover = assets["arrowr_active"],
    press = assets["arrowr"],
}

local exit_button = button.create{
    x = 1500,
    y = 1080 / 2 + 300,
    width = 420,
    height = 170,
    callback = function(self, ...)
        local event = {...}
        if event[1] == "click" then
            setScene("main_menu")
        elseif event[1] == "enter" then
            assets["button_hover_sfx"]:play()
        end
    end,
    idle = assets["button_idle"],
    hover = assets["button_hover"],
    press = assets["button_pressed"],
    text = "Back",
    csize = 100,
}

function load()
    nb_hud = 1
    player_hud:close()
    exit_button:setStatus("released")
    right_button:setStatus("released")
    left_button:setStatus("released")
    world.renderDisable()
    world.updateDisable()
    world.eventDisable()
    hud.renderDisable()
end

function unload()
    world.eventEnable()
    world.updateEnable()
    world.renderEnable()
    hud.renderEnable()
end

function draw()
    window:draw(background)
    window:draw(fen)
    right_button:draw()
    left_button:draw()
    exit_button:draw()
    window:draw(title)
    window:draw(how[nb_hud])
end

function update()
    how[1]:setString("-Move your character with ["..keyboard.getKeyName(controls.getControl("move_up")).."-"..keyboard.getKeyName(controls.getControl("move_left")).."-"..keyboard.getKeyName(controls.getControl("move_down")).."-"..keyboard.getKeyName(controls.getControl("move_right")).."]\n-Open your inventory with ["..keyboard.getKeyName(controls.getControl("inventory")).."]\n-Open your spell menu with ["..keyboard.getKeyName(controls.getControl("menu_spell")).."]\n-Open your quest menu (if you have one quest)\nwith ["..keyboard.getKeyName(controls.getControl("hide/show")).."]\n-Interact with items, pnj or items on the\nground with ["..keyboard.getKeyName(controls.getControl("action")).."]\n\n-Drag your spells in the spell bar\nwith the mouse (drag and drop)\n-You can scroll down the option menu\n-You can equip weapons by drag them in one\nof the two bottom slots of your inventory\n-You gain all your life and mana when you\nlevel up")
end

function event(e)
    local event = e:getEvent()
    if event[1] == "key_pressed" and event[2] == keys.Escape then
        setScene("main_menu")
        return
    end
    exit_button:event(e)
    right_button:event(e)
    left_button:event(e)
end