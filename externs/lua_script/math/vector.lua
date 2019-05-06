vector = {}

function vector.dot(a, b)
    return a[1] * b[1] + a[2] * b[2]
end

function vector.cross(a, b)
    return a[1] * b[2] - b[1] * a[2]
end

function vector.perp(a)
    return vector.new(a[2], -a[1])
end

function vector.mul(a, b)
    if type(b) == "number" then
        return vector.new(a[1] * b, a[2] * b)
    end
end

function vector.div(a, b)
    if type(b) == "number" then
        return vector.new(a[1] / b, a[2] / b)
    end
end

function vector.mod(a, b)
    if type(b) == "number" then
        return vector.new(a[1] % b, a[2] % b)
    end
end

function vector.pow(a, b)
    if type(b) == "number" then
        return vector.new(a[1] ^ b, a[2] ^ b)
    end
end

function vector.add(a, b)
    if type(b) == "number" then
        return vector.new(a[1] + b, a[2] + b)
    elseif type(b) == "Vector2D" then
        return vector.new(a[1] + b[1], a[2] + b[2])
    end
end

function vector.sub(a, b)
    if type(b) == "number" then
        return vector.new(a[1] + b, a[2] + b)
    elseif type(b) == "Vector2D" then
        return vector.new(a[1] - b[1], a[2] - b[2])
    end
end

function vector.mag(a)
    return math.sqrt(a[1] ^ 2 + a[2] ^ 2)
end

function vector.normalize(a)
    local len = vector.mag(a)
    return vector.new(a[1] / len, a[2] / len)
end

function vector.equals(a, b)
    return a[1] == b[1] and a[2] == b[2]
end

function vector.neg(a)
    return vector.new(-a[1], -a[2])
end

function vector.new(x, y)
    return setmetatable({}, {
        __x = x,
        __y = y,
        __type = "Vector2D",
        __index = function(self, key)
            local meta = getmetatable(self)
            if key == 1 or key == "x" then
                return meta.__x
            elseif key == 2 or key == "y" then
                return meta.__y
            else
                return vector[key]
            end
        end,
        __newindex = function(self, key, value)
            local meta = getmetatable(self)
            if key == 1 or key == "x" then
                meta.__x = value
            elseif key == 2 or key == "y" then
                meta.__y = value
            end
        end,
        __tostring = function(self)
            return "{"..self[1]..", "..self[2].."}"
        end,
        __concat = function(self, other)
            return tostring(self)..tostring(other)
        end,
        __add = vector.add,
        __sub = vector.sub,
        __mul = vector.mul,
        __div = vector.div,
        __mod = vector.mod,
        __pow = vector.pow,
        __unm = vector.neg,
        __eq = vector.equals,
    })
end