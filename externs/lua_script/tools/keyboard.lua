-- =========================================
-- =               KEYBOARD                =
-- =========================================

keyboard = {}
local key_status = {}


function keyboard.keyPressed(key)
    check(key, "number", 1)

    -- return key_status[key] and true or false
    return lsfml.keyboard.keyPressed(key)
end

function keyboard.setKeyPressed(key, state)
    check(key, "number", 1)
    check(state, "boolean", 2)

    key_status[key] = state
end

function keyboard.areKeyPressed(...)
    local keys = {...}
    for i=1, #keys do
        if not key_status[keys[i]] then
            return false
        end
    end
    return true
end

function keyboard.getKeyName(key)
    for k, v in pairs(keys) do
        if key == v and v > -1 then
            return k
        end
    end
end