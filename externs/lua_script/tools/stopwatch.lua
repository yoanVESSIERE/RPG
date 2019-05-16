-- =========================================
-- =                STOPWATCH              =
-- =========================================

stopwatch = {}
local stopwatchs = {}
function stopwatch.create()
    local function stringify(self)
        return tostring(self:getEllapsedTime())
    end
    local stopwtch = setmetatable({}, {
        __index = stopwatch,
        __type = "stopwatch",
        __time = 0,
        __id = #stopwatchs + 1,
        __clock = lsfml.clock.create(),
        __pause = false,
        __gstate = isPaused(),
        __tostring = stringify,
        __gc = function(self)
            local meta = getmetatable(self)

            table.remove(stopwatchs, meta.__id)
        end,
    })
    stopwatchs[#stopwatchs + 1] = stopwtch
    return stopwtch
end

function stopwatch.update()
    for i=1, #stopwatchs do
        stopwatchs[i]:getEllapsedTime()
    end
end

function stopwatch.restart(self)
    check(self, "stopwatch", 1)

    local meta = getmetatable(self)
    lsfml.clock.restart(meta.__clock)
    meta.__time = 0
    meta.__pause = false
end

function stopwatch.isPaused(self)
    check(self, "stopwatch", 1)

    local meta = getmetatable(self)
    return meta.__pause
end

function stopwatch.pause(self)
    check(self, "stopwatch", 1)

    local meta = getmetatable(self)
    if not meta.__pause then
        meta.__time = meta.__time + lsfml.clock.getEllapsedTime(meta.__clock)
        meta.__pause = true
        lsfml.clock.restart(meta.__clock)
    end
end

function stopwatch.start(self)
    check(self, "stopwatch", 1)

    local meta = getmetatable(self)
    if meta.__pause then
        meta.__pause = false
        lsfml.clock.restart(meta.__clock)
    end
end

function stopwatch.getEllapsedTime(self)
    check(self, "stopwatch", 1)

    local meta = getmetatable(self)
    if meta.__gstate ~= isPaused() then
        if isPaused() then
            if not meta.__pause then
                local time = lsfml.clock.getEllapsedTime(meta.__clock)
                meta.__time = meta.__time + time
            end
        else
            lsfml.clock.restart(meta.__clock)
        end
        meta.__gstate = isPaused()
    end
    if meta.__pause or isPaused() then
        lsfml.clock.restart(meta.__clock)
        return meta.__time
    else
        return meta.__time + lsfml.clock.getEllapsedTime(meta.__clock)
    end
end

function stopwatch.destroy(self)
    check(self, "stopwatch", 1)

    local meta = getmetatable(self)
    meta.__clock:destroy()
end

function stopwatch.copy(stopwatch)
    check(stopwatch, "stopwatch", 1)

    local function stringify(self)
        return tostring(self:getEllapsedTime())
    end
    local meta = getmetatable(stopwatch)
    return setmetatable({}, {
        __index = stopwatch,
        __type = "stopwatch",
        __time = meta.__time,
        __pause = meta.__pause,
        __clock = meta.__clock:copy(),
        __tostring = stringify,
    })
end