-- =========================================
-- =                 EVENT                 =
-- =========================================

event_helper = {}

function event_helper.create(...)
    local events = {...}
    return setmetatable({}, {
        __index = event_helper,
        __type = "event",
        __cancel = false,
        __eventType = events[1],
        __eventParams = {table.unpack(events, 2)},
        __event = events,
    })
end

function event_helper.setCanceled(self, cancel)
    check(self, "event", 1)
    check(cancel, "boolean", 2)

    local meta = getmetatable(self)
    meta.__cancel = cancel
end

function event_helper.isCanceled(self)
    check(self, "event", 1)

    local meta = getmetatable(self)
    return meta.__cancel
end

function event_helper.eventType(self)
    check(self, "event", 1)

    local meta = getmetatable(self)
    return meta.__eventType
end

function event_helper.eventParams(self)
    check(self, "event", 1)

    local meta = getmetatable(self)
    return meta.__eventParams
end

function event_helper.getEvent(self)
    check(self, "event", 1)

    local meta = getmetatable(self)
    return meta.__event
end