-- =========================================
-- =                  HUD                  =
-- =========================================

hud = {}
hudorder = {}
huds = {}
local openCount = 0
local shouldRender = true

function hud.createFromFile(filename, zindex, canBeClosed)
    check(filename, "string", 1)
    cassert(type(zindex) == "nil" or type(zindex) == "number", "zindex must be a number", 3)
    cassert(type(canBeClosed) == "nil" or type(canBeClosed) == "boolean", "canBeClosed must be a boolean", 3)
    local handle = io.open("./externs/lua_script/"..filename, "r")
    if handle then
        local code = handle:read("*all")
        handle:close()
        local env = setmetatable({}, {__index = _G})
        local func, err = load(code, filename, "t", env)
        if func then
            local s, e = pcall(func)
            if s then
                local name = filename:match("([^/]+).lua$")
                local data = {}
                for k, v in pairs(env) do
                    data[k] = v
                end
                local meta = setmetatable({}, {
                    __index = function(self, key)
                        if hud[key] then
                            return hud[key]
                        else
                            return rawget(data, key)
                        end
                    end,
                    __env = data,
                    __type = "hud",
                    __name = name,
                    __uuid = uuid.randomUUID(),
                    __status = "close",
                    __canBeClosed = type(canBeClosed) == "nil" or canBeClosed
                })
                if data.load then
                    data.load(meta)
                end
                huds[#huds + 1] = meta
                return meta
            else
                print(filename..({e:match(":.+")})[1])
            end
        else
            error("[HUD LOADER ERROR] "..err, 2)
        end
    end
end

function hud.open(self)
    check(self, "hud", 1)

    if self:isClose() then
        hudorder[#hudorder + 1] = self
        local meta = getmetatable(self)
        meta.__status = "open"
        if meta.__canBeClosed then
            openCount = openCount + 1
        end
        if meta.__env.open then
            meta.__env.open(self)
        end
    end
end

function hud.areAllClosed()
    return openCount == 0
end

function hud.openCount()
    return openCount
end

function hud.close(self)
    check(self, "hud", 1)

    if self:isOpen() then
        local meta = getmetatable(self)
        if meta.__canBeClosed then
            for i = 1, #hudorder do
                if hudorder[i]:getUUID() == meta.__uuid then
                    table.remove(hudorder, i)
                    break
                end
            end
            openCount = openCount - 1
            meta.__status = "close"
            if meta.__env.close then
                meta.__env.close(self)
            end
        end
    end
end

function hud.getUUID(self)
    check(self, "hud", 1)

    local meta = getmetatable(self)
    return meta.__uuid
end

function hud.draw(self)
    check(self, "hud", 1)

    if shouldRender then
        local meta = getmetatable(self)
        if meta.__env.draw then
            meta.__env.draw(self)
        end
    end
end

function hud.event(self, e)
    check(self, "hud", 1)

    local meta = getmetatable(self)
    if meta.__env.event then
        meta.__env.event(self, e)
    end
end

function hud.update(self)
    check(self, "hud", 1)

    local meta = getmetatable(self)
    if meta.__env.update then
        meta.__env.update(self)
    end
end

function hud.canBeClosed(self)
    check(self, "hud", 1)

    local meta = getmetatable(self)
    return meta.__canBeClosed
end

function hud.getName(self)
    check(self, "hud", 1)

    local meta = getmetatable(self)
    return meta.__name
end

function hud.getName(self)
    check(self, "hud", 1)

    local meta = getmetatable(self)
    return meta.__name
end

function hud.isOpen(self)
    check(self, "hud", 1)

    local meta = getmetatable(self)
    return meta.__status == "open"
end

function hud.isClose(self)
    check(self, "hud", 1)

    local meta = getmetatable(self)
    return meta.__status == "close"
end

function hud.getZIndex(self)
    check(self, "hud", 1)

    local meta = getmetatable(self)
    for k, v in pairs(hudorder) do
        local meta_hud = getmetatable(v)
        if meta_hud.__name == meta.__name then
            return k
        end
    end
end

function hud.getByName(name)
    check(self, "string", 1)

    for k, v in pairs(hudorder) do
        local meta_hud = getmetatable(v)
        if meta_hud.__name == name then
            return v
        end
    end
end

function hud.setZIndex(self, zindex)
    check(self, "hud", 1)
    cassert(type(zindex) == "nil" or type(zindex) == "number", "zindex must be a number", 3)

    local meta = getmetatable(self)
    for k, v in pairs(hudorder) do
        local meta_hud = getmetatable(v)
        if meta_hud.__name == meta.__name then
            table.remove(hudorder, k)
            table.insert(hudorder, zindex, self)
            return
        end
    end
end

function hud.renderEnable()
    shouldRender = true
end

function hud.renderDisable()
    shouldRender = false
end

function hud.isRenderEnabled()
    return shouldRender
end