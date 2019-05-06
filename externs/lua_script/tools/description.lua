-- =========================================
-- =               description               =
-- =========================================

description = {}

function description.create(texture, font)
    check(texture, "texture", 1)
    check(font, "font", 2)

    local text = lsfml.text.create()
    text:setFont(font)
    text:setCharacterSize(40)
    local name = lsfml.text.create()
    name:setFont(font)
    name:setCharacterSize(40)
    local sprite = lsfml.sprite.create()
    local size = {texture:getSize()}
    sprite:setTexture(texture, false)
    return setmetatable({}, {
        __type = "description",
        __index = function(self, key)
            check(self, "description", 1)
            local meta = getmetatable(self)
            if description[key] then
                return description[key]
            elseif sprite[key] then
                return function (self, ...)
                    return sprite[key](meta.__sprite, ...)
                end
            elseif text[key] then
                return function (self, ...)
                    return text[key](meta.__text, ...)
                end
            end
        end,
        __scale_x = 1,
        __scale_y = 1,
        __name = name,
        __sprite = sprite,
        __text = text,
        __visible = true,
    })
end

function description.setScale(self, x, y)
    check(self, "description", 1)
    check(x, "number", 2)
    check(y, "number", 3)

    local meta = getmetatable(self)
    meta.__sprite:setScale(x, y)
    meta.__scale_x = x
    meta.__scale_y = y
    local x_p, y_p = meta.__sprite:getPosition()
    meta.__name:setPosition(x_p + 470 * meta.__scale_x, y_p + 80 * meta.__scale_y)
end

function description.setName(self, name)
    check(self, "description", 1)
    check(name, "string", 2)

    local meta = getmetatable(self)
    meta.__name:setString(name)
    meta.__name:setOrigin(meta.__name.getCenter(meta.__name:getString(), 40))
end

function description.setPosition(self, x, y)
    check(self, "description", 1)
    check(x, "number", 2)
    check(y, "number", 3)

    local meta = getmetatable(self)
    meta.__sprite:setPosition(x, y)
    meta.__text:setPosition(x + 15, y + 60)
    meta.__name:setOrigin(meta.__name.getCenter(meta.__name:getString(), 40))
    meta.__name:setPosition(x + 470 * meta.__scale_x, y + 80 * meta.__scale_y)
end

function description.show(self)
    check(self, "description", 1)

    local meta = getmetatable(self)
    meta.__visible = true
end

function description.hide(self)
    check(self, "description", 1)

    local meta = getmetatable(self)
    meta.__visible = false
end

function description.draw(self)
    check(self, "description", 1)

    local meta = getmetatable(self)
    if meta.__visible then
        window:draw(meta.__sprite)
        window:draw(meta.__text)
        window:draw(meta.__name)
    end
end