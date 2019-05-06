-- Class "Vector2D" [{
--     function __Vector2D(x, y)
--         this.x = x
--         this.y = y
--     end

--     function getX()
--         return this.x
--     end

--     function getY()
--         return this.y
--     end

--     function setX(x)
--         check(x, "number", 1)

--         this.x = x
--     end

--     function setY(y)
--         check(y, "number", 1)

--         this.y = y
--     end

--     function normalize()
--         local len = this.mag()
--         if len > 0 then
--             return new(Vector2D(this.x / len, this.y / len))
--         end
--     end

--     function __unm()
--         return new(Vector2D(-this.x, -this.y))
--     end

--     function __len(self)
--         return math.sqrt(this.x^2 + this.y^2)
--     end

--     function __eq(self, other)
--         if class.isInstanceOf(other, "Vector2D") then
--             return this.getX() == other.getX() and this.getY() == other.getY()
--         end
--         return false
--     end

--     function __tostring(self)
--         return "{"..this.getX()..", "..this.getY().."}"
--     end

--     function __concat(self, other)
--         return tostring(self)..tostring(other)
--     end

--     function __index(self, key)
--         if key == 1 or key == "x" then
--             return this.getX()
--         elseif key == 2 or key == "y" then
--             return this.getY()
--         end
--     end

--     function __newindex(self, key, value)
--         if key == 1 or key == "x" then
--             this.setX(value)
--         elseif key == 2 or key == "y" then
--             this.setY(value)
--         else
--             rawset(self, key, value)
--         end
--     end

--     function __add(self, other)
--         if class.isInstanceOf(other, "Vector2D") then
--             return new(Vector2D(this.x + other.getX(), this.y + other.getY()))
--         elseif type(other) == "number" then
--             return new(Vector2D(this.x + other, this.y + other))
--         end
--     end

--     function __sub(self, other)
--         if class.isInstanceOf(other, "Vector2D") then
--             return new(Vector2D(this.x - other.getX(), this.y - other.getY()))
--         elseif type(other) == "number" then
--             return new(Vector2D(this.x - other, this.y - other))
--         end
--     end

--     function __mul(self, other)
--         if type(other) == "number" then
--             return new(Vector2D(this.x * other, this.y * other))
--         end
--     end

--     function dot(other)
--         if class.isInstanceOf(other, "Vector2D") then
--             return this.x * other.getX() + this.y * other.getY()
--         end
--     end

--     function cross(other)
--         if class.isInstanceOf(other, "Vector2D") then
--             return this.x * other.gety() - this.y * other.getX()
--         end
--     end

--     function add(value)
--         return this.__add(this, value)
--     end

--     function sub(value)
--         return this.__sub(this, value)
--     end

--     function mul(value)
--         return this.__mul(this, value)
--     end

--     function mag(value)
--         return this.__len(this)
--     end

--     function perp()
--         return new(Vector2D(this.y, -this.x))
--     end
-- }]

Class "Line" [{
    function __Line(_start, _End)
        check(_start, "Vector2D", 1)
        check(_End, "Vector2D", 2)

        this._start = start
        this._End = _End
    end

    function getStart()
        return this._start
    end

    function getEnd()
        return this._End
    end

    function setStart(_start)
        check(_start, "Vector2D", 1)

        this._start = _start
    end

    function setEnd(_End)
        check(_End, "Vector2D", 1)

        this._End = _End
    end

    function __index(self, key)
        if key == 1 then
            return this._start
        elseif key == 2 then
            return this._End()
        end
    end
}]

Class "RayCast" [{
    function intersectLine(line1, line2)
        local b = {line1[2][1] - line1[1][1], line1[2][2] - line1[1][2]}
        local d = {line2[2][1] - line2[1][1], line2[2][2] - line2[1][2]}
        local bDotDPerp = b[1] * d[2] - b[2] * d[1]
        if (bDotDPerp == 0) then
            return false
        end

        local c = {line2[1][1] - line1[1][1], line2[1][2] - line1[1][2]}
        local t = (c[1] * d[2] - c[2] * d[1]) / bDotDPerp
        if (t < 0 or t > 1) then
            return false
        end

        local u = (c[1] * b[2] - c[2] * b[1]) / bDotDPerp
        if (u < 0 or u > 1) then
            return false
        end

        local intersection = {line1[1][1] + t * b[1], line1[1][2] + t * b[2]}

        return true, intersection
    end

    local function addIntersectPoint(list, ray, segment)
        local success, pt = intersectLine(ray, segment)
        if success then
            list[#list + 1] = pt
        end
    end

    function intersectPolygon(ray, polygon)
        local points = {}

        for i=1, #polygon do
            addIntersectPoint(points, ray, {polygon[i], polygon[(i + 1 > #polygon) and 1 or i + 1]})
        end
        if #points > 0 then
            local init = true
            local min = 0
            local index = 1
            for i=1, #points do
                dist = math.abs(ray[1][1] - points[i][1]) + math.abs(ray[1][2] - points[i][2])
                if init then
                    init = false
                    min = dist
                    index = i
                elseif dist < min then
                    min = dist
                    index = i
                end
            end
            return true, points[index]
        end
        return false
    end

    function simpleIntersectPolygon(ray, polygon)
        for i=1, #polygon do
            local success, pt = intersectLine(ray, {polygon[i], polygon[(i + 1 > #polygon) and 1 or i + 1]})
            if success then
                return true
            end
        end
        return false
    end

    function intersectPolygonCount(ray, polygon)
        local count = 0
        for i=1, #polygon do
            local success, pt = intersectLine(ray, {polygon[i], polygon[(i + 1 > #polygon) and 1 or i + 1]})
            if success then
                count = count + 1
            end
        end
        return count
    end
}]