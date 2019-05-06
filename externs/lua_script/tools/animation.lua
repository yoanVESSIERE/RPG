-- =========================================
-- =               ANIMATION               =
-- =========================================

animation = {}

function animation.create(texture, where)
    check(texture, "texture", 1)
    check(where, "table", 2)

    local sprite = lsfml.sprite.create()
    local size = {texture:getSize()}
    sprite:setTexture(texture, false)
    sprite:setTextureRect(table.unpack(where))
    return setmetatable({}, {
        __type = "animation",
        __index = function(self, key)
            check(self, "animation", 1)

            local meta = getmetatable(self)
            if animation[key] then
                return animation[key]
            elseif sprite[key] then
                return function (self, ...)
                    return sprite[key](meta.__sprite, ...)
                end
            end
        end,
        __sprite = sprite,
        __anim = 0,
        __where = where,
        __size = size,
        __visible = true,
        __anim_max = size[1] / where[3],
    })
end

function animation.changeRect(self, where)
    check(self, "animation", 1)
    check(where, "table", 2)

    local meta = getmetatable(self)
    meta.__where = where
    meta.__sprite:setTextureRect(math.floor(meta.__where[1] + meta.__where[3] * meta.__anim), math.floor(meta.__where[2]), math.floor(meta.__where[3]), math.floor(meta.__where[4]))
end

function animation.getAnimationFrame(self)
    check(self, "animation", 1)

    local meta = getmetatable(self)
    return meta.__anim
end

function animation.setAnimationFrame(self, id)
    check(self, "animation", 1)
    check(id, "number", 2)

    local meta = getmetatable(self)
    meta.__anim = math.floor(id % meta.__anim_max)
    meta.__sprite:setTextureRect(math.floor(meta.__where[1] + meta.__where[3] * meta.__anim), math.floor(meta.__where[2]), math.floor(meta.__where[3]), math.floor(meta.__where[4]))
end

function animation.next(self)
    check(self, "animation", 1)

    local meta = getmetatable(self)
    if meta.__anim + 1 < meta.__anim_max then
        meta.__anim = meta.__anim + 1
        meta.__sprite:setTextureRect(math.floor(meta.__where[1] + meta.__where[3] * meta.__anim), math.floor(meta.__where[2]), math.floor(meta.__where[3]), math.floor(meta.__where[4]))
    end
end

function animation.restart(self)
    check(self, "animation", 1)

    local meta = getmetatable(self)
    meta.__anim = 0
    meta.__sprite:setTextureRect(math.floor(meta.__where[1] + meta.__where[3] * meta.__anim), math.floor(meta.__where[2]), math.floor(meta.__where[3]), math.floor(meta.__where[4]))
end

function animation.hasEnded(self)
    check(self, "animation", 1)

    local meta = getmetatable(self)
    return meta.__anim + 1 >= meta.__anim_max
end

function animation.show(self)
    check(self, "animation", 1)

    local meta = getmetatable(self)
    meta.__visible = true
end

function animation.hide(self)
    check(self, "animation", 1)

    local meta = getmetatable(self)
    meta.__visible = false
end

function animation.draw(self)
    check(self, "animation", 1)

    local meta = getmetatable(self)
    if meta.__visible then
        window:draw(meta.__sprite)
    end
end