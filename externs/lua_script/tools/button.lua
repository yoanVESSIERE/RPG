-- =========================================
-- =                BUTTON                 =
-- =========================================

-- ===========================
-- =    BUTTON PARAMETERS    =
-- ===========================

-- =========
-- MANDATORY
-- =========
-- x [NUMBER] (Position X of the button)
-- y [NUMBER] (Position Y of the button)
-- width [NUMBER] (Width of the button)
-- height [NUMBER] (Height of the button)
-- idle [TEXTURE] (Texture when the button do nothing)
-- hover [TEXTURE] (Texture when mouse is over the button)
-- press [TEXTURE] (Texture when button is pressed)

-- ========
-- OPTIONAL
-- ========
-- visible [BOOLEAN] (Can we see the button or not ?)
-- text [STRING/NUMBER/BOOLEAN] (Button Text)
-- csize [NUMBER] (Character Size)
-- callback [FUNCTION] (Function called when an event is triggered on the button)


-- ===========================
-- =      BUTTON EVENTS      =
-- ===========================

-- enter (when mouse enter the button area)
-- exit (when mouse leave the button area)
-- hover (when mouse is moving in the button area)
-- press (when mouse is pressed in the button area)
-- release (when button was pressed and mouse released)
-- click (when mouse press and release in the button area)
-- drag (when mouse is pressed and move in the button area)


button = {}

function cassert(cond, msg, lvl)
    if not cond and type(lvl) == "number" then
        error(msg, lvl)
    end
    if type(lvl) ~= "number" then
        error(msg, 2)
    end
end

function button.create(info)
    check(info, "table", 1)
    cassert(type(info.x) == "number", "x must be a number", 3)
    cassert(type(info.y) == "number", "y must be a number", 3)
    cassert(type(info.width) == "number", "width must be a number", 3)
    cassert(type(info.height) == "number", "height must be a number", 3)
    cassert(type(info.callback) == "nil" or type(info.callback) == "function", "callback must be a function", 3)
    cassert(type(info.idle) == "texture", "idle must be a texture", 3)
    cassert(type(info.hover) == "texture", "hover must be a texture", 3)
    cassert(type(info.press) == "texture", "press must be a texture", 3)
    cassert(type(info.visible) == "nil" or type(info.visible) == "boolean", "visible must be a boolean", 3)
    cassert(type(info.csize) == "nil" or type(info.csize) == "number", "csize must be a number", 3)

    local sprite = lsfml.sprite.create()
    local text = lsfml.text.create()
    text:setFont(assets["fsys"])
    text:setCharacterSize(info.csize or 11)
    text:setString(info.text and tostring(info.text) or "")
    sprite:setTexture(info.idle, false)
    sprite:setPosition(info.x, info.y)
    local csize = info.csize or 10
    local txt = tostring(info.text or "")
    text:setPosition(info.x + info.width / 2 - (#txt * csize) / 4, info.y + info.height / 2 - csize / 1.25)
    return setmetatable({}, {
        __index = button,
        __type = "button",
        __sprite = sprite,
        __g_text = text,
        __x = info.x,
        __y = info.y,
        __mx = 0,
        __my = 0,
        __width = info.width,
        __height = info.height,
        __callback = info.callback or function() end,
        __idle = info.idle,
        __press = info.press,
        __hover = info.hover,
        __status = "released",
        __visible = type(info.visible) == "nil" and true or info.visible,
        __text = info.text or "",
        __csize = info.csize or 11,
    })
end

function button.setPosition(self, x, y)
    check(self, "button", 1)
    check(x, "number", 2)
    check(y, "number", 3)

    local meta = getmetatable(self)
    meta.__x = x
    meta.__y = y
    meta.__g_text:setPosition(x + meta.__width / 2 - (#meta.__text * meta.__csize) / 4, y + meta.__height / 2 - meta.__csize / 1.25)
    meta.__sprite:setPosition(x, y)
end

function button.setSize(self, width, height)
    check(self, "button", 1)
    check(width, "number", 2)
    check(height, "number", 3)

    local meta = getmetatable(self)
    meta.__width = width
    meta.__height = height
end

function button.getStatus(self)
    check(self, "button", 1)

    local meta = getmetatable(self)
    return meta.__status
end

function button.setStatus(self, status)
    check(self, "button", 1)
    check(status, "string", 2)

    local meta = getmetatable(self)
    if status == "pressed" then
        meta.__sprite:setTexture(meta.__press, false)
        meta.__status = status
    elseif status == "released" then
        meta.__sprite:setTexture(meta.__idle, false)
        meta.__status = status
    elseif status == "hover" then
        meta.__sprite:setTexture(meta.__hover, false)
        meta.__status = status
    end
end

function button.getSize(self)
    check(self, "button", 1)

    local meta = getmetatable(self)
    return meta.__width, meta.__height
end

function button.getPosition(self)
    check(self, "button", 1)

    local meta = getmetatable(self)
    return meta.__x, meta.__y
end

function button.setCallback(self, func)
    check(self, "button", 1)
    check(func, "function", 2)

    local meta = getmetatable(self)
    meta.__callback = func
end

function button.isVisible(self)
    check(self, "button", 1)

    local meta = getmetatable(self)
    return meta.__visible
end

function button.setVisible(self, boolean)
    check(self, "button", 1)
    check(boolean, "boolean", 2)

    local meta = getmetatable(self)
    meta.__visible = boolean
end

function button.setText(self, str)
    check(self, "button", 1)

    local meta = getmetatable(self)
    meta.__text = str
    meta.__g_text:setPosition(meta.__x + meta.__width / 2 - (#meta.__text * meta.__csize) / 4, meta.__y + meta.__height / 2 - meta.__csize / 1.25)
    meta.__g_text:setString(str)
end

function button.getText(self)
    check(self, "button", 1)

    local meta = getmetatable(self)
    return meta.__text
end

function button.setCharacterSize(self, size)
    check(self, "button", 1)
    check(size, "number", 2)

    local meta = getmetatable(self)
    meta.__csize = size
    meta.__g_text:setPosition(meta.__x + meta.__width / 2 - (#meta.__text * meta.__csize) / 4, meta.__y + meta.__height / 2 - meta.__csize / 1.25)
    meta.__g_text:setCharacterSize(size)
end

function button.getCharacterSize(self)
    check(self, "button", 1)

    local meta = getmetatable(self)
    return meta.__csize
end


function button.event(self, e)
    check(self, "button", 1)

    local event = e:getEvent()
    local meta = getmetatable(self)
    if meta.__visible then
        if event[1] == "mouse_pressed" then
            if event[2] > meta.__x and event[2] < meta.__x + meta.__width and
            event[3] > meta.__y and event[3] < meta.__y + meta.__height then
                meta.__sprite:setTexture(meta.__press, false)
                meta.__callback(self, "press", event[4], event[2], event[3])
                meta.__status = "pressed"
                meta.__mx = event[2]
                meta.__my = event[3]
            end
        elseif event[1] == "mouse_released" then
            if event[2] > meta.__x and event[2] < meta.__x + meta.__width and
            event[3] > meta.__y and event[3] < meta.__y + meta.__height then
                meta.__sprite:setTexture(meta.__hover, false)
                if meta.__status == "pressed" then
                    meta.__callback(self, "click", event[4], event[2], event[3])
                    meta.__status = "released"
                    meta.__callback(self, "release", event[4], event[2], event[3])
                end
            else
                if meta.__status == "pressed" then
                    meta.__sprite:setTexture(meta.__idle, false)
                    meta.__callback(self, "release", event[4], event[2], event[3])
                    meta.__status = "released"
                end
            end
        elseif event[1] == "mouse_move" then
            if event[2] > meta.__x and event[2] < meta.__x + meta.__width and
            event[3] > meta.__y and event[3] < meta.__y + meta.__height then
                meta.__callback(self, "hover", event[2], event[3])
                if meta.__status == "released" then
                    meta.__status = "hover"
                    meta.__sprite:setTexture(meta.__hover, false)
                    meta.__callback(self, "enter")
                end
                if meta.__status == "pressed" then
                    meta.__callback(self, "drag", event[2], event[3], event[2] - meta.__mx, event[3] - meta.__my)
                    meta.__mx = event[2]
                    meta.__my = event[3]
                end
            else
                if meta.__status == "hover" then
                    meta.__sprite:setTexture(meta.__idle, false)
                    meta.__callback(self, "exit")
                    meta.__status = "released"
                end
            end
        end
    end
    meta.__callback(self, table.unpack(event))
end

function button.draw(self)
    check(self, "button", 1)

    local meta = getmetatable(self)
    if meta.__visible then
        window:draw(meta.__sprite)
        window:draw(meta.__g_text)
    end
end