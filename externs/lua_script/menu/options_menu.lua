-- =========================================
-- =              OPTION MENU              =
-- =========================================

local background = lsfml.sprite.create()
background:setTexture(assets["background"], false)
local textRender = lsfml.text.create()
local offset = 1
textRender:setFont(assets["fsys"])
textRender:setCharacterSize(50)
local selected = nil

local function getKeyName(key)
    for k, v in pairs(keys) do
        if key == v and v > -1 then
            return k
        end
    end
end

local shortcuts = controls.getControls()
local bts = {}
for i = 1, 10 do
    bts[#bts + 1] = button.create{
        x = 400 + (math.floor(i / 6)) * 840,
        y = 50 + ((i - 1) % 5) * 170,
        width = 420,
        height = 170,
        callback = function(self, ...)
            local event = {...}
            local meta = getmetatable(self)
            if event[1] == "click" then
                if selected then
                    local meta_o = getmetatable(selected)
                    selected:setText(getKeyName(shortcuts[meta_o.__id + offset].key))
                end
                selected = self
                self:setText("")
            elseif event[1] == "enter" then
                assets["button_hover_sfx"]:play()
            end
        end,
        idle = assets["button_idle"],
        hover = assets["button_hover"],
        press = assets["button_pressed"],
        text = getKeyName(shortcuts[i].key),
        csize = 100,
    }
    local meta = getmetatable(bts[#bts])
    meta.__id = i - 1
end

function load()
    world.renderDisable()
    world.updateDisable()
    world.eventDisable()
    hud.renderDisable()
end

function unload()
    if prevScene == "main_menu" then
        world.updateEnable()
    end
    world.eventEnable()
    world.renderEnable()
    hud.renderEnable()
end

function draw()
    window:draw(background)
    local shortcuts = controls.getControls()
    for i=offset, math.min(offset + 9, #shortcuts) do
        textRender:setString(shortcuts[i].text)
        textRender:setPosition(math.floor((i - offset + 1) / 6) * 820 + 380 - (#shortcuts[i].text * 50) / 2, 100 + ((i - offset) % 5) * 170)
        window:draw(textRender)
    end
    for i=1, #bts do
        bts[i]:draw()
    end
end

function update()

end

function event(e)
    local event=e:getEvent()
    if event[1] == "key_pressed" and selected then
        local name = getKeyName(event[2])
        selected:setText(name)
        local meta = getmetatable(selected)
        controls.setControl(shortcuts[meta.__id + offset].name, event[2])
        selected = nil
    elseif event[1] == "mouse_pressed" then
        if selected then
            local meta_o = getmetatable(selected)
            selected:setText(getKeyName(shortcuts[meta_o.__id + offset].key))
            selected = nil
        end
    elseif event[1] == "mouse_scroll" then
        if selected then
            local meta_o = getmetatable(selected)
            selected:setText(getKeyName(shortcuts[meta_o.__id + offset].key))
            selected = nil
        end
        offset = offset -event[4]
        offset = math.max(1, math.min(offset, #shortcuts - 9))
        for i=1, #bts do
            local meta = getmetatable(bts[i])
            bts[i]:setText(getKeyName(shortcuts[meta.__id + offset].key))
        end
    elseif event[1] == "key_pressed" and event[2] == keys.Escape then
        setScene(prevScene)
    end
    for i=1, #bts do
        bts[i]:event(e)
    end
end
