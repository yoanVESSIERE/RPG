-- =========================================
-- =                  UUID                 =
-- =========================================

uuid = {}
local id = 0
local function getHex(num)
    local txt = string.format("%x", num)
    return string.rep("0", 2 - #txt)..txt
end

function uuid.randomUUID()
    id = id + 1
    return id..""
end