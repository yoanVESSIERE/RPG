-- =========================================
-- =                  WORLD                =
-- =========================================

world = {}
local entities = {}
local shouldRender = true
local shouldUpdate = true
local shouldGetEvent = true

function world.spawnEntity(entity)
    if class.isInstanceOf(entity, "Entity") then
        entities[#entities + 1] = entity
        return entity
    end
end

function world.setEntities(ent)
    entities = ent
end

function world.eventDisable()
    shouldGetEvent = false
end

function world.eventEnable()
    shouldGetEvent = true
end

function world.isEventEnabled()
    return shouldGetEvent
end

function world.isRenderEnabled()
    return shouldRender
end

function world.isUpdateEnabled()
    return shouldUpdate
end

function world.renderEnable()
    shouldRender = true
end

function world.renderDisable()
    shouldRender = false
end

function world.updateEnable()
    shouldUpdate = true
end

function world.updateDisable()
    shouldUpdate = false
end

function world.removeEntityByUUID(uuid)
    check(uuid, "string", 1)

    for i=1, #entities do
        if entities[i].getUUID and uuid == entities[i].getUUID() then
            table.remove(entities, i)
            break
        end
    end
end

function world.getEntityByUUID(uuid)
    check(uuid, "string", 1)

    for i=1, #entities do
        if uuid == entities[i].getUUID() then
            return entities[i]
        end
    end
end

function world.getEntities()
    return entities
end

function world.clearEntities()
    entities = nil
    entities = {}
end

local function depth_sort()
    table.sort(entities, function(a, b)
        local x, y = a.getPosition()
        local nx, ny = b.getPosition()
        return ny > y
    end)
end

function world.getEntitiesInRect(x, y, w, h)
    check(x, "number", 1)
    check(y, "number", 2)
    check(w, "number", 3)
    check(h, "number", 4)
    x, y, w, h = math.min(x, x + w), math.min(y, y + h), math.abs(w), math.abs(h)
    local ent = {}
    for i = 1, #entities do
        local nx, ny = entities[i].getPosition()
        if nx > x and nx < x + w and ny > y and ny < y + h then
            ent[#ent + 1] = entities[i]
        end
    end
    return ent
end

function world.getEntitiesRayhit(x, y, dx, dy)
    check(x, "number", 1)
    check(y, "number", 2)
    check(dx, "number", 3)
    check(dy, "number", 4)

    local ray = {{x, y}, {x + dx, y + dy}}
    local ent = {}
    for i = 1, #entities do
        local nx, ny = entities[i].getPosition()
        local boxes = entities[i].getHitboxs()
        for j=1, #boxes do
            local success = RayCast.simpleIntersectPolygon(ray, boxes[i].getPoints())
            if success then
                ent[#ent + 1] = entities[i]
                break
            end
        end
    end
    return ent
end

function world.getEntitiesInHitbox(hitbx, _type)
    _type = _type or "all"
    local ent = {}
    for i = 1, #entities do
        local boxes = entities[i].getHitboxs()
        for j=1, #boxes do
            if boxes[j].getType() == _type or _type == "all" then
                if hitbox.SAT(hitbx, boxes[j]) then
                    ent[#ent + 1] = entities[i]
                    break
                end
            end
        end
    end
    return ent
end

function world.draw()
    if shouldRender then
        depth_sort()
        for i=1, #entities do
            if entities[i] and entities[i].draw then
                entities[i].draw()
            end
        end
    end
end

function world.update()
    if shouldUpdate then
        for i=1, #entities do
            if entities[i] and entities[i].update then
                entities[i].update()
            end
        end
    end
end

function world.event(e)
    if shouldGetEvent then
        for i=1, #entities do
            if entities[i] and entities[i].event then
                entities[i].event(e)
                if e:isCanceled() then
                    break
                end
            end
        end
    end
end