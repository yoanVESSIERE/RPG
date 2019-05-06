-- =========================================
-- =                 HITBOXS               =
-- =========================================

hitbox = {}
local showHitbox = false
push_rays = {{0, 1}, {0.70, -0.70}, {1, 0}, {0.70, 0.70}, {0, 1}, {-0.70, 0.70}, {-1, 0}, {-0.70, -0.70}}
local hitboxes = {}

function hitbox.add(hbx)
    check(hbx, "Hitbox", 1)

    hitboxes[#hitboxes + 1] = hbx
end

function hitbox.enableDraw()
    showHitbox = true
end

function hitbox.disableDraw()
    showHitbox = false
end

function hitbox.isDrawEnable()
    return showHitbox
end

function hitbox.getHitboxes()
    return hitboxes
end

function hitbox.setHitboxes(hitbx)
    hitboxes = hitbx
end

function hitbox.clear()
    hitboxes = nil
    hitboxes = {}
end

function hitbox.rayhit(x, y, dx, dy, _type)
    check(x, "number", 1)
    check(y, "number", 2)
    check(dx, "number", 3)
    check(dy, "number", 4)
    _type = _type or "all"

    local ray = {{x, y}, {x + dx, y + dy}}
    for i=1, #hitboxes do
        if hitboxes[i].getType() == _type or _type == "all" then
            local success, point = RayCast.intersectPolygon(ray, hitboxes[i].getPoints())
            if success then
                return true, point
            end
        end
    end
    return false
end

function hitbox.rayhitSimple(x, y, dx, dy, _type)
    check(x, "number", 1)
    check(y, "number", 2)
    check(dx, "number", 3)
    check(dy, "number", 4)
    _type =_type or "all"

    local ray = {{x, y}, {x + dx, y + dy}}
    for i=1, #hitboxes do
        if hitboxes[i].getType() == _type or _type == "all" then
            local success, point = RayCast.simpleIntersectPolygon(ray, hitboxes[i].getPoints())
            if success then
                return true
            end
        end
    end
    return false
end

function hitbox.rayhitCount(x, y, dx, dy, _type)
    check(x, "number", 1)
    check(y, "number", 2)
    check(dx, "number", 3)
    check(dy, "number", 4)
    _type = _type or "all"

    local count = 0
    local ray = {{x, y}, {x + dx, y + dy}}
    for i=1, #hitboxes do
        if hitboxes[i].getType() == _type or _type == "all" then
            count = count + RayCast.intersectPolygonCount(ray, hitboxes[i].getPoints())
        end
    end
    return count
end

function hitbox.draw()
    for i=1, #hitboxes do
        hitboxes[i].draw()
    end
end
local c = false
function hitbox.rectIntersect(a, b)
    local l1 = {x=a[1], y=a[2]}
    local r1 = {x=a[1] + a[3], y=a[2] + a[4]}

    local l2 = {x=b[1], y=b[2]}
    local r2 = {x=b[1] + b[3], y=b[2] + b[4]}

    if (l1.x > r2.x or l2.x > r1.x)  then
        return false
    end

    if (l1.y > r2.y or l2.y > r1.y)  then
        return false
    end

    return true
end

local function project(hitbx, axis)
    check(hitbx, "Hitbox", 1)
    check(axis, "Vector2D", 2)

    local vertices = hitbx.getPoints()
    axis = axis:normalize()
    local min = vertices[1]:dot(axis)
    local max = min
    for i=1, #vertices do
        local proj = vertices[i]:dot(axis)
        if proj < min then min = proj end
        if proj > max then max = proj end
    end
    return {min, max}
end

local function contains(n, range)
    local a, b = range[1], range[2]
    if b < a then
        a = b
        b = range[1]
    end
    return n >= a and n <= b
end

local function overlap(a_, b_)
	if contains(a_[1], b_) then return true
	elseif contains(a_[2], b_) then return true
	elseif contains(b_[1], a_) then return true
	elseif contains(b_[2], a_) then return true
	end
	return false
end

local function getOverlapDepth(a_, b_)
    local min1 = math.min(a_[2], b_[2])
    local max1 = math.max(a_[1], b_[1])
    local diff = min1 - max1
    return math.max(0, diff)
end

function hitbox.SAT(a, b)
    if hitbox.rectIntersect(a.getBoundingBox(), b.getBoundingBox()) then
        local poly_a = a.getPoints()
        local poly_b = b.getPoints()
        local mx = math.huge
        local axe = vector.new(0, 0)
        for i=1, #poly_a do
            local edge = poly_a[(i + 1 > #poly_a) and 1 or i + 1] - poly_a[i]
            local axis = edge:perp()
            local a__, b__ = project(a, axis), project(b, axis)
            local success = overlap(a__, b__)
            if not success then
                return false
            else
                local distance = getOverlapDepth(a__, b__)
                if distance < mx then
                    mx = distance
                    axe = axis
                end
            end
        end

        for i=1, #poly_b do
            local edge = poly_b[(i + 1 > #poly_b) and 1 or i + 1] - poly_b[i]
            local axis = edge:perp()
            local a__, b__ = project(a, axis), project(b, axis)
            local success = overlap(a__, b__)
            if not success then
                return false
            else
                local distance = getOverlapDepth(a__, b__)
                if distance < mx then
                    mx = distance
                    axe = axis
                end
            end
        end
        return true, mx, axe:normalize()
    end
    return false
end

function hitbox.collide(hitbx, _type)
    _type = _type or "all"
    for i=1, #hitboxes do
        if hitbx ~= hitboxes[i] then
            if hitboxes[i].getType() == _type or _type == "all" then
                local success, distance, axis = hitbox.SAT(hitbx, hitboxes[i])
                if success then
                    return true, distance, axis
                end
            end
        end
    end
    return false
end
