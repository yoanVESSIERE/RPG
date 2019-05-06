spell = {}
spells = {}

function spell.createFromFile(filename)
    check(filename, "string", 1)
    local handle = io.open("./externs/lua_script/"..filename, "r")
    if handle then
        local code = handle:read("*all")
        handle:close()
        local env = setmetatable({}, {__index = _G})
        local func, err = load(code, filename, "t", env)
        if func then
            local success, ret = pcall(func)
            if success then
                local data = {}
                for k, v in pairs(env) do
                    data[k] = v
                end
                local sp = setmetatable({}, {
                    __type = "spell",
                    __env = data,
                    __cd = stopwatch.create(),
                    __isInCD = false,
                    __status = "idle",
                    __index = function(self, key)
                        local meta = getmetatable(self)
                        if spell[key] then
                            return spell[key]
                        else
                            return meta.__env[key]
                        end
                    end,
                })
                spells[#spells + 1] = sp
                return sp
            else
                error(err, 2)
            end
        else
            error("[ERROR LOADING SPELL] "..err, 2)
        end
    else
        error("File not found '"..filename.."'", 2)
    end
end

function spell.getName(self)
    check(self, "spell", 1)

    local meta = getmetatable(self)
    if meta.__env["getName"] then
        return meta.__env.getName(self)
    end
end

function spell.getCost(self)
    check(self, "spell", 1)

    local meta = getmetatable(self)
    if meta.__env["getCost"] then
        return meta.__env.getCost(self)
    else
        return 0
    end
end

function spell.getCooldown(self)
    check(self, "spell", 1)

    local meta = getmetatable(self)
    return math.max(self:getMaxCooldown() - meta.__cd:getEllapsedTime() / 1000000, 0)
end

function spell.isInCooldown(self)
    check(self, "spell", 1)

    local meta = getmetatable(self)
    return meta.__isInCD
end

function spell.cast(self)
    check(self, "spell", 1)

    local meta = getmetatable(self)
    if meta.__env["isNotValid"] then
        if meta.__env.isNotValid(self) then
            return
        end
    end
    if not meta.__isInCD then
        if not self:cooldownStartAtEnd() and self:getMaxCooldown() > 0 then
            meta.__cd:restart()
            meta.__isInCD = true
        end
        if meta.__env["cast"] then
            meta.__env.cast(self)
        end
        if self:cooldownStartAtEnd() and self:getMaxCooldown() > 0 then
            meta.__cd:restart()
            meta.__isInCD = true
        end
    end
end

function spell.getMaxCooldown(self)
    check(self, "spell", 1)

    local meta = getmetatable(self)
    if meta.__env["getMaxCooldown"] then
        return meta.__env.getMaxCooldown(self)
    else
        return 0
    end
end

function spell.cooldownStartAtEnd(self)
    check(self, "spell", 1)

    local meta = getmetatable(self)
    if meta.__env["cooldownStartAtEnd"] then
        return meta.__env.cooldownStartAtEnd(self)
    else
        return true
    end
end

function spell.update(self)
    check(self, "spell", 1)

    if not isPaused() then
        local meta = getmetatable(self)
        if meta.__status == "idle" and not meta.__isInCD then
            meta.__cd:restart()
            meta.__isInCD = false
        end
        if meta.__status == "enable" then
            if self:cooldownStartAtEnd() or self:getMaxCooldown() == 0 then
                meta.__cd:restart()
                meta.__isInCD = false
            else
                if not meta.__isInCD and self:getMaxCooldown() > 0 then
                    meta.__cd:restart()
                    meta.__isInCD = true
                end
            end
            if meta.__env["cast"] then
                return meta.__env.cast(self)
            end
        elseif meta.__status == "disable" and not meta.__isInCD then
            if self:cooldownStartAtEnd() and self:getMaxCooldown() > 0 then
                meta.__isInCD = true
                meta.__cd:restart()
            end
        end
        if (meta.__isInCD and self:getCooldown() <= 0) or self:getMaxCooldown() <= 0 then
            meta.__isInCD = false
            meta.__status = "idle"
        end
        if meta.__env["update"] then
            return meta.__env.update(self)
        end
    end
end

function spell.getStatus(self)
    check(self, "spell", 1)

    local meta = getmetatable(self)
    return meta.__status
end

function spell.enable(self)
    check(self, "spell", 1)

    local meta = getmetatable(self)
    if meta.__status == "idle" then
        meta.__status = "enable"
        if meta.__env["enable"] then
            return meta.__env.enable(self)
        end
    end
end

function spell.disable(self)
    check(self, "spell", 1)

    local meta = getmetatable(self)
    if meta.__status == "enable" then
        meta.__status = "disable"
        if meta.__env["disable"] then
            return meta.__env.disable(self)
        end
    end
end

function spell.getByName(name)
    for i=1, #spells do
        if spells[i]:getName() == name then
            return spells[i]
        end
    end
end

function spell.isInstant(self)
    check(self, "spell", 1)

    local meta = getmetatable(self)
    if meta.__env["isInstant"] then
        return meta.__env.isInstant(self)
    else
        return true
    end
end