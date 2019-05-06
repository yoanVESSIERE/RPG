-- =========================================
-- =                  ITEM                 =
-- =========================================

item = {}
items = {}
rarity = {"Crap", "Common", "Uncommon", "Rare", "Epic", "Legendary", "Unique", "Relic", "God"}

function item.create(name, texture, max_stack, userdata)
    check(name, "string", 1)
    check(texture, "texture", 2)
    check(max_stack, "number", 3)
    check(userdata, "table", 4)

    items[name] = setmetatable({}, {
        __index = item,
        __type = "item",
        __name = name,
        __texture = texture,
        __userdata = userdata,
        __max_stack = max_stack,
    })
    return items[name]
end

function item.getName(self)
    check(self, "item", 1)

    local meta = getmetatable(self)
    return meta.__name
end

function item.getTexture(self)
    check(self, "item", 1)

    local meta = getmetatable(self)
    return meta.__texture
end

function item.getUserdata(self)
    check(self, "item", 1)

    local meta = getmetatable(self)
    return meta.__userdata
end

function item.getMaxStackSize(self)
    check(self, "item", 1)

    local meta = getmetatable(self)
    return meta.__max_stack
end