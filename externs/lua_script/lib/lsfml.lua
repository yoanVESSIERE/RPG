-- =========================================
-- =                 LSFML                 =
-- =========================================

local olsfml = lsfml
local otype = _G.type
function _G.type(var)
    local meta = getmetatable(var)
    if meta then
        if rawget(meta, "__type") then
            return rawget(meta, "__type")
        end
    end
    return otype(var)
end

function check(var, Type, index)
    if var ~= nil and Type ~= nil and index ~= nil then
        if type(var) ~= Type then
            error("Argument #"..index.." Expected "..Type..", Got "..type(var), 3)
        end
    else
        print(var, Type, index)
        print(debug.traceback())
        error("Missing Parameter for check(var, Type, index)", 3)
    end
end

-- =========================================
-- =            LSFML CLASSES              =
-- =========================================

_G.lsfml = {}
lsfml.clock = {}
lsfml.sprite = {}
lsfml.text = {}
lsfml.window = {}
lsfml.shader = {}
lsfml.texture = {}
lsfml.font = {}
lsfml.keyboard = {}
lsfml.mouse = {}
lsfml.music = {}
lsfml.vertexarray = {}
lsfml.vertex = {}
lsfml.sound = {}
lsfml.soundbuffer = {}

-- =======================
-- =       CLOCK         =
-- =======================

function lsfml.clock.create()
    local function stringify(self)
        return tostring(self:getEllapsedTime())
    end
    return setmetatable({}, {
        __index = lsfml.clock,
        __type = "clock",
        __ptr = olsfml.clock_create(),
        __gc = function(self)
            local meta = getmetatable(self)
            olsfml.clock_destroy(meta.__ptr)
        end,
        __tostring = stringify,
    })
end

function lsfml.clock.restart(clock)
    check(clock, "clock", 1)

    local meta = getmetatable(clock)
    olsfml.clock_restart(meta.__ptr)
end

function lsfml.clock.getEllapsedTime(clock)
    check(clock, "clock", 1)

    local meta = getmetatable(clock)
    return olsfml.clock_getEllapsedTime(meta.__ptr)
end

function lsfml.clock.destroy(clock)
    check(clock, "clock", 1)

    local meta = getmetatable(clock)
    olsfml.clock_destroy(meta.__ptr)
end

function lsfml.clock.copy(clock)
    check(clock, "clock", 1)

    local function stringify(self)
        return tostring(self:getEllapsedTime())
    end
    local meta = getmetatable(clock)
    return setmetatable({}, {
        __index = lsfml.clock,
        __type = "clock",
        __ptr = olsfml.clock_copy(meta.__ptr),
        __gc = function(self)
            local meta = getmetatable(self)
            olsfml.clock_destroy(meta.__ptr)
        end,
        __tostring = stringify,
    })
end

-- =======================
-- =       WINDOW        =
-- =======================

function lsfml.window.clear(window, r, g, b)
    check(window, "window", 1)
    check(r, "number", 2)
    check(g, "number", 3)
    check(b, "number", 4)

    local meta = getmetatable(window)
    olsfml.window_clear(meta.__ptr, r, g, b)
end

function lsfml.window.setMouseCursorVisible(window, visible)
    check(window, "window", 1)
    check(visible, "boolean", 2)

    local meta = getmetatable(window)
    olsfml.window_setMouseCursorVisible(meta.__ptr, visible)
end

function lsfml.window.close(window)
    check(window, "window", 1)

    local meta = getmetatable(window)
    olsfml.window_close(meta.__ptr)
end

function lsfml.window.draw(window, shape, renderstate)
    check(window, "window", 1)
    if type(renderstate) ~= "renderState" and type(renderstate) ~= "nil" then
        error("Argument #3 Expected [renderState, nil], Got "..type(renderstate), 2)
    end

    local meta = getmetatable(window)
    local render_meta = getmetatable(renderstate)
    if type(shape) == "circleShape" then
        local shape_meta = getmetatable(shape)
        olsfml.window_drawConvexShape(meta.__ptr, shape_meta.__ptr, renderstate and render_meta.__ptr or nil)
    elseif type(shape) == "convexShape" then
        local shape_meta = getmetatable(shape)
        olsfml.window_drawConvexShape(meta.__ptr, shape_meta.__ptr, renderstate and render_meta.__ptr or nil)
    elseif type(shape) == "vertexarray" then
        local shape_meta = getmetatable(shape)
        olsfml.window_drawVertexArray(meta.__ptr, shape_meta.__ptr, renderstate and render_meta.__ptr or nil)
    elseif type(shape) == "shape" then
        local shape_meta = getmetatable(shape)
        olsfml.window_drawShape(meta.__ptr, shape_meta.__ptr, renderstate and render_meta.__ptr or nil)
    elseif type(shape) == "sprite" then
        local shape_meta = getmetatable(shape)
        olsfml.window_drawSprite(meta.__ptr, shape_meta.__ptr, renderstate and render_meta.__ptr or nil)
    elseif type(shape) == "text" then
        local shape_meta = getmetatable(shape)
        olsfml.window_drawText(meta.__ptr, shape_meta.__ptr, renderstate and render_meta.__ptr or nil)
    elseif type(shape) == "rectangleShape" then
        local shape_meta = getmetatable(shape)
        olsfml.window_drawRectangleShape(meta.__ptr, shape_meta.__ptr, renderstate and render_meta.__ptr or nil)
    else
        error("Argument #2 Expected [circleShape, convexShape, vertexArray, shape, sprite, text, rectangleShape], Got "..type(shape), 2)
    end
end

function lsfml.window.setFramerateLimit(window, framerate)
    check(window, "window", 1)
    check(framerate, "number", 2)

    local meta = getmetatable(window)
    olsfml.window_setFramerateLimit(meta.__ptr, framerate)
end

function lsfml.window.setMouseCursorGrabbed(window, grabbed)
    check(window, "window", 1)
    check(framerate, "boolean", 2)

    local meta = getmetatable(window)
    olsfml.window_setMouseCursorGrabbed(meta.__ptr, grabbed)
end

function lsfml.window.getSize(window)
    check(window, "window", 1)

    local meta = getmetatable(window)
    return olsfml.window_getSize(meta.__ptr)
end

-- =======================
-- =       SHADER        =
-- =======================

function lsfml.shader.bind(shader)
    check(shader, "shader", 1)

    local meta = getmetatable(window)
    return olsfml.shader_bind(meta.__ptr)
end

function lsfml.shader.createFromFile(vertexShader, fragmentShader)
    check(vertexShader, "string", 1)
    check(fragmentShader, "string", 2)

    return setmetatable({}, {
        __index = lsfml.shader,
        __type = "shader",
        __ptr = olsfml.shader_createFromFile(vertexShader, fragmentShader),
        __gc = function(self)
            local meta = getmetatable(self)
            olsfml.shader_destroy(meta.__ptr)
        end,
    })
end

function lsfml.shader.createFromMemory(vertexShader, fragmentShader)
    check(vertexShader, "string", 1)
    check(fragmentShader, "string", 2)

    return setmetatable({}, {
        __index = lsfml.shader,
        __type = "shader",
        __ptr = olsfml.shader_createFromMemory(vertexShader, fragmentShader),
        __gc = function(self)
            local meta = getmetatable(self)
            olsfml.shader_destroy(meta.__ptr)
        end,
    })
end

function lsfml.shader.destroy(shader)
    check(shader, "shader", 1)

    local meta = getmetatable(shader)
    olsfml.shader_destroy(meta.__ptr)
end

function lsfml.shader.isAvailable()
    return olsfml.shader_isAvailable()
end

function lsfml.shader.setColorParameter(shader, name, color)
    check(shader, "shader", 1)
    check(name, "string", 2)
    check(color, "table", 3)

    local ctable = {}
    for i=1, 4 do
        ctable[i] = tonumber(color[i]) or 255
    end
    local meta = getmetatable(shader)
    olsfml.shader_setColorParameter(meta.__ptr, name, ctable)
end

function lsfml.shader.setTextureParameter(shader, name, texture)
    check(shader, "shader", 1)
    check(name, "string", 2)
    check(texture, "texture", 3)

    local meta = getmetatable(shader)
    local meta_t = getmetatable(texture)
    olsfml.shader_setTextureParameter(meta.__ptr, name, meta_t.__ptr)
end

function lsfml.shader.setFloatParameter(shader, name, val)
    check(shader, "shader", 1)
    check(name, "string", 2)
    check(val, "number", 3)

    local meta = getmetatable(shader)
    olsfml.shader_setFloatParameter(meta.__ptr, name, val)
end

function lsfml.shader.setFloat2Parameter(shader, name, x, y)
    check(shader, "shader", 1)
    check(name, "string", 2)
    check(x, "number", 3)
    check(y, "number", 4)

    local meta = getmetatable(shader)
    olsfml.shader_setFloat2Parameter(meta.__ptr, name, x, y)
end

function lsfml.shader.setFloat3Parameter(shader, name, x, y, z)
    check(shader, "shader", 1)
    check(name, "string", 2)
    check(x, "number", 3)
    check(y, "number", 4)
    check(z, "number", 5)

    local meta = getmetatable(shader)
    olsfml.shader_setFloat3Parameter(meta.__ptr, name, x, y, z)
end

function lsfml.shader.setFloat4Parameter(shader, name, x, y, z, w)
    check(shader, "shader", 1)
    check(name, "string", 2)
    check(x, "number", 3)
    check(y, "number", 4)
    check(z, "number", 5)
    check(w, "number", 6)

    local meta = getmetatable(shader)
    olsfml.shader_setFloat2Parameter(meta.__ptr, name, x, y, z, w)
end

function lsfml.shader.setCurrentTextureParameter(shader, name)
    check(shader, "shader", 1)
    check(name, "string", 2)

    local meta = getmetatable(shader)
    olsfml.shader_setCurrentTextureParameter(meta.__ptr, name)
end

function lsfml.shader.setTransformParameter(shader, name, transform)
    check(shader, "shader", 1)
    check(name, "string", 2)
    check(transform, "transform", 3)

    local meta = getmetatable(shader)
    local meta_t = getmetatable(transform)
    olsfml.shader_setTransformParameter(meta.__ptr, name, meta_t.__ptr)
end

-- =======================
-- =      TEXTURE        =
-- =======================

function lsfml.texture.bind(texture)
    check(texture, "texture", 1)

    local meta = getmetatable(texture)
    olsfml.texture_bind(meta.__ptr)
end

function lsfml.texture.copy(texture)
    check(texture, "texture", 1)

    local meta = getmetatable(texture)
    return setmetatable({}, {
        __index = lsfml.texture,
        __type = "texture",
        __ptr = olsfml.texture_copy(meta.__ptr),
        __gc = function(self)
            local meta = getmetatable(self)
            olsfml.texture_destroy(meta.__ptr)
        end,
    })
end

function lsfml.texture.copyFromImage(image)
    check(image, "image", 1)

    local meta = getmetatable(image)
    return setmetatable({}, {
        __index = lsfml.texture,
        __type = "texture",
        __ptr = olsfml.texture_copyFromImage(meta.__ptr),
        __gc = function(self)
            local meta = getmetatable(self)
            olsfml.texture_destroy(meta.__ptr)
        end,
    })
end

function lsfml.texture.create(width, height)
    check(width, "number", 1)
    check(height, "number", 2)

    return setmetatable({}, {
        __index = lsfml.texture,
        __type = "texture",
        __ptr = olsfml.texture_create(width, height),
        __gc = function(self)
            local meta = getmetatable(self)
            olsfml.texture_destroy(meta.__ptr)
        end,
    })
end

function lsfml.texture.createFromFile(filename, rect)
    check(filename, "string", 1)
    check(rect, "table", 2)

    return setmetatable({}, {
        __index = lsfml.texture,
        __type = "texture",
        __ptr = olsfml.texture_createFromFile(filename, {x=rect[1], y=rect[2], width=rect[3], height=rect[4]}),
        __gc = function(self)
            local meta = getmetatable(self)
            olsfml.texture_destroy(meta.__ptr)
        end,
    })
end

function lsfml.texture.createFromImage(image, rect)
    check(image, "image", 1)
    check(rect, "table", 2)

    local meta = getmetatable(image)
    return setmetatable({}, {
        __index = lsfml.texture,
        __type = "texture",
        __ptr = olsfml.texture_createFromImage(meta.__ptr, {x=rect[1], y=rect[2], width=rect[3], height=rect[4]}),
        __gc = function(self)
            local meta = getmetatable(self)
            olsfml.texture_destroy(meta.__ptr)
        end,
    })
end

function lsfml.texture.destroy(texture)
    check(texture, "texture", 1)

    local meta = getmetatable(texture)
    olsfml.texture_destroy(meta.__ptr)
end

function lsfml.texture.getMaximumSize()
    return olsfml.texture_getMaximumSize()
end

function lsfml.texture.getSize(texture)
    check(texture, "texture", 1)

    local meta = getmetatable(texture)
    return olsfml.texture_getSize(meta.__ptr)
end

function lsfml.texture.isRepeated(texture)
    check(texture, "texture", 1)

    local meta = getmetatable(texture)
    return olsfml.texture_isRepeated(meta.__ptr)
end

function lsfml.texture.isSmooth(texture)
    check(texture, "texture", 1)

    local meta = getmetatable(texture)
    return olsfml.texture_isSmooth(meta.__ptr)
end

function lsfml.texture.setSmooth(texture, bool)
    check(texture, "texture", 1)
    check(bool, "boolean", 2)

    local meta = getmetatable(texture)
    olsfml.texture_setSmooth(meta.__ptr, bool)
end

function lsfml.texture.setRepeated(texture, bool)
    check(texture, "texture", 1)
    check(bool, "boolean", 2)

    local meta = getmetatable(texture)
    olsfml.texture_setRepeated(meta.__ptr, bool)
end

function lsfml.texture.updateFromImage(texture, image)
    check(texture, "texture", 1)
    check(image, "image", 2)

    local meta = getmetatable(texture)
    local meta_i = getmetatable(image)
    olsfml.texture_updateFromImage(meta.__ptr, meta_i.__ptr)
end

-- =======================
-- =       MUSIC         =
-- =======================

function lsfml.music.createFromFile(string)
    check(string, "string", 1)

    return setmetatable({}, {
        __index = lsfml.music,
        __type = "music",
        __ptr = olsfml.music_createFromFile(string),
        __gc = function(self)
            local meta = getmetatable(self)
            olsfml.music_destroy(meta.__ptr)
        end,
    })
end

function lsfml.music.destroy(music)
    check(music, "music", 1)

    local meta = getmetatable(music)
    olsfml.music_destroy(meta.__ptr)
end

function lsfml.music.getDuration(music)
    check(music, "music", 1)

    local meta = getmetatable(music)
    return olsfml.music_getDuration(meta.__ptr)
end

function lsfml.music.getVolume(music)
    check(music, "music", 1)

    local meta = getmetatable(music)
    return olsfml.music_getVolume(meta.__ptr)
end

function lsfml.music.pause(music)
    check(music, "music", 1)

    local meta = getmetatable(music)
    olsfml.music_pause(meta.__ptr)
end

function lsfml.music.play(music)
    check(music, "music", 1)

    local meta = getmetatable(music)
    olsfml.music_play(meta.__ptr)
end

function lsfml.music.stop(music)
    check(music, "music", 1)

    local meta = getmetatable(music)
    olsfml.music_stop(meta.__ptr)
end

function lsfml.music.setVolume(music, number)
    check(music, "music", 1)
    check(number, "number", 2)

    local meta = getmetatable(music)
    olsfml.music_setVolume(meta.__ptr, number)
end

function lsfml.music.setPosition(music, x, y)
    check(music, "music", 1)
    check(x, "number", 2)
    check(y, "number", 3)

    local meta = getmetatable(music)
    olsfml.music_setPosition(meta.__ptr, {x=x, y=y})
end

function lsfml.music.getPosition(music)
    check(music, "music", 1)

    local meta = getmetatable(music)
    return olsfml.music_getPosition(meta.__ptr)
end

function lsfml.music.setLoop(music, boolean)
    check(music, "music", 1)
    check(boolean, "boolean", 2)

    local meta = getmetatable(music)
    return olsfml.music_setLoop(meta.__ptr, boolean)
end

-- =======================
-- =       SPRITE        =
-- =======================

function lsfml.sprite.create()
    return setmetatable({}, {
        __index = lsfml.sprite,
        __type = "sprite",
        __ptr = olsfml.sprite_create(),
        __gc = function(self)
            local meta = getmetatable(self)
            olsfml.sprite_destroy(meta.__ptr)
        end,
    })
end

function lsfml.sprite.destroy(sprite)
    check(sprite, "sprite", 1)

    local meta = getmetatable(sprite)
    olsfml.sprite_destroy(meta.__ptr)
end

function lsfml.sprite.setColor(sprite, r, g, b, a)
    check(sprite, "sprite", 1)
    check(r, "number", 2)
    check(g, "number", 3)
    check(b, "number", 4)
    check(a, "number", 5)

    local meta = getmetatable(sprite)
    olsfml.sprite_setColor(meta.__ptr, r, g, b, a)
end

function lsfml.sprite.setTexture(sprite, texture, boolean)
    check(sprite, "sprite", 1)
    check(texture, "texture", 2)
    check(boolean, "boolean", 3)

    local meta = getmetatable(sprite)
    local meta_t = getmetatable(texture)
    olsfml.sprite_setTexture(meta.__ptr, meta_t.__ptr, boolean)
end

function lsfml.sprite.getPosition(sprite)
    check(sprite, "sprite", 1)

    local meta = getmetatable(sprite)
    return olsfml.sprite_getPosition(meta.__ptr)

end

function lsfml.sprite.move(sprite, x, y)
    check(sprite, "sprite", 1)
    check(x, "number", 2)
    check(y, "number", 3)

    local meta = getmetatable(sprite)
    olsfml.sprite_move(meta.__ptr, {x=x, y=y})
end

function lsfml.sprite.setPosition(sprite, x, y)
    check(sprite, "sprite", 1)
    check(x, "number", 2)
    check(y, "number", 3)

    local meta = getmetatable(sprite)
    olsfml.sprite_setPosition(meta.__ptr, {x=x, y=y})
end

function lsfml.sprite.setScale(sprite, x, y)
    check(sprite, "sprite", 1)

    local meta = getmetatable(sprite)
    olsfml.sprite_setScale(meta.__ptr, {x=x ,y=y})
end

function lsfml.sprite.getScale(sprite)
    check(sprite, "sprite", 1)

    local meta = getmetatable(sprite)
    return olsfml.sprite_getScale(meta.__ptr)
end

function lsfml.sprite.setRotation(sprite, nb)
    check(sprite, "sprite", 1)
    check(nb, "number", 2)

    local meta = getmetatable(sprite)
    olsfml.sprite_setRotation(meta.__ptr, nb)
end

function lsfml.sprite.rotate(sprite, nb)
    check(sprite, "sprite", 1)
    check(nb, "number", 2)

    local meta = getmetatable(sprite)
    olsfml.sprite_rotate(meta.__ptr, nb)
end

function lsfml.sprite.getRotation(sprite)
    check(sprite, "sprite", 1)

    local meta = getmetatable(sprite)
    return olsfml.sprite_getRotation(meta.__ptr)
end

function lsfml.sprite.getOrigin(sprite)
    check(sprite, "sprite", 1)

    local meta = getmetatable(sprite)
    return olsfml.sprite_getOrigin(meta.__ptr)
end

function lsfml.sprite.scale(sprite, x, y)
    check(sprite, "sprite", 1)
    check(x, "number", 2)
    check(y, "number", 3)

    local meta = getmetatable(sprite)
    olsfml.sprite_scale(meta.__ptr, {x=x, y=y})
end

function lsfml.sprite.setOrigin(sprite, x, y)
    check(sprite, "sprite", 1)
    check(x, "number", 2)
    check(y, "number", 3)

    local meta = getmetatable(sprite)
    olsfml.sprite_setOrigin(meta.__ptr, {x=x, y=y})
end

function lsfml.sprite.setTextureRect(sprite, x, y, width, height)
    check(sprite, "sprite", 1)
    check(x, "number", 2)
    check(y, "number", 3)
    check(width, "number", 4)
    check(height, "number", 5)

    local meta = getmetatable(sprite)
    olsfml.sprite_setTextureRect(meta.__ptr, {x=math.floor(x), y=math.floor(y), width=math.floor(width), height=math.floor(height)})
end

function lsfml.sprite.copy(sprite)
    check(sprite, "sprite", 1)

    local meta = getmetatable(sprite)
    return setmetatable({}, {
        __index = lsfml.sprite,
        __type = "sprite",
        __ptr = olsfml.sprite_copy(meta.__ptr),
        __gc = function(self)
            local meta = getmetatable(self)
            olsfml.sprite_destroy(meta.__ptr)
        end,
    })
end

-- =======================
-- =       VERTEX        =
-- =======================

function lsfml.vertex.create()
    function get_index(self, key)
        local meta = getmetatable(self)
        if key == "x" then return olsfml.vertex_getX(meta.__ptr) end
        if key == "y" then return olsfml.vertex_getY(meta.__ptr) end
        if key == "tx" then return olsfml.vertex_getTX(meta.__ptr) end
        if key == "ty" then return olsfml.vertex_getTY(meta.__ptr) end
        if key == "r" then return olsfml.vertex_getR(meta.__ptr) end
        if key == "g" then return olsfml.vertex_getG(meta.__ptr) end
        if key == "b" then return olsfml.vertex_getB(meta.__ptr) end
        if key == "a" then return olsfml.vertex_getA(meta.__ptr) end
    end
    function set_index(self, key, value)
        check(value, "number", 2)
        local meta = getmetatable(self)
        if key == "x" then olsfml.vertex_setX(meta.__ptr, value) end
        if key == "y" then olsfml.vertex_setY(meta.__ptr, value) end
        if key == "tx" then olsfml.vertex_setTX(meta.__ptr, value) end
        if key == "ty" then olsfml.vertex_setTY(meta.__ptr, value) end
        if key == "r" then olsfml.vertex_setR(meta.__ptr, value) end
        if key == "g" then olsfml.vertex_setG(meta.__ptr, value) end
        if key == "b" then olsfml.vertex_setB(meta.__ptr, value) end
        if key == "a" then olsfml.vertex_setA(meta.__ptr, value) end
    end
    function stringify(self)
        return "{position = {"..self.x..", "..self.y.."}, texture = {"..self.tx..", "..self.ty.."}, color = {"..self.r..", "..self.g..", "..self.b..", "..self.a.."}}"
    end
    return setmetatable({}, {
        __index = get_index,
        __new_index = set_index,
        __type = "vertex",
        info.pos_x or 0,
        info.pos_y or 0,
        __ptr = olsfml.vertex_create(),
        __gc = function(self)
            local meta = getmetatable(self)
            olsfml.vertex_destroy(meta.__ptr)
        end,
        __tostring = stringify,
    })
end

function lsfml.vertex.destroy(vertex)
    check(vertex, "vertex", 1)

    local meta = getmetatable(vertex)
    olsfml.vertex_destroy(meta.__ptr)
end

-- =======================
-- =    VERTEXARRAY      =
-- =======================

function lsfml.vertexarray.create()
    return setmetatable({}, {
        __index = lsfml.vertexarray,
        __type = "vertexarray",
        __ptr = olsfml.vertexarray_create(),
        __gc = function(self)
            local meta = getmetatable(self)
            olsfml.vertexarray_destroy(meta.__ptr)
        end,
    })
end

function lsfml.vertexarray.destroy(vertexarray)
    check(vertexarray, "vertexarray", 1)

    local meta = getmetatable(vertexarray)
    olsfml.vertexarray_destroy(meta.__ptr)
end

function lsfml.vertexarray.append(vertexarray, vertex)
    check(vertexarray, "vertexarray", 1)
    local meta = getmetatable(vertexarray)
    if type(vertex) == "vertex" then
        local meta_v = getmetatable(vertex)
        olsfml.vertexarray_append(meta.__ptr, meta_v.__ptr)
    elseif type(vertex) == "table" then
        olsfml.vertexarray_append(meta.__ptr, vertex)
    else
        error("Vertex must be a vertex or a table", 2)
    end
end

function lsfml.vertexarray.clear(vertexarray)
    check(vertexarray, "vertexarray", 1)

    local meta = getmetatable(vertexarray)
    olsfml.vertexarray_clear(meta.__ptr)
end

function lsfml.vertexarray.copy(vertexarray)
    check(vertexarray, "vertexarray", 1)

    local meta = getmetatable(vertexarray)
    return setmetatable({}, {
        __index = lsfml.vertexarray,
        __type = "vertexarray",
        __ptr = olsfml.vertexarray_copy(meta.__ptr),
        __gc = function(self)
            local meta = getmetatable(self)
            olsfml.vertexarray_destroy(meta.__ptr)
        end,
    })
end

function lsfml.vertexarray.getBounds(vertexarray)
    check(vertexarray, "vertexarray", 1)

    local meta = getmetatable(vertexarray)
    return olsfml.vertexarray_getBounds(meta.__ptr)
end

function lsfml.vertexarray.getPrimitiveType(vertexarray)
    check(vertexarray, "vertexarray", 1)

    local meta = getmetatable(vertexarray)
    return olsfml.vertexarray_getPrimitiveType(meta.__ptr)
end

function lsfml.vertexarray.getVertex(vertexarray, number)
    check(vertexarray, "vertexarray", 1)
    check(number, "number", 2)

    local meta = getmetatable(vertexarray)
    return olsfml.vertexarray_getVertex(meta.__ptr, number)
end

function lsfml.vertexarray.getVertexCount(vertexarray)
    check(vertexarray, "vertexarray", 1)

    local meta = getmetatable(vertexarray)
    return olsfml.vertexarray_getVertexCount(meta.__ptr)
end

function lsfml.vertexarray.resize(vertexarray, number)
    check(vertexarray, "vertexarray", 1)
    check(number, "number", 2)

    local meta = getmetatable(vertexarray)
    olsfml.vertexarray_resize(meta.__ptr, number)
end

function lsfml.vertexarray.setPrimitiveType(vertexarray, primitive)
    check(vertexarray, "vertexarray", 1)
    check(primitive, "number", 2)

    local meta = getmetatable(vertexarray)
    olsfml.vertexarray_setPrimitiveType(meta.__ptr, primitive)
end

-- =======================
-- =        TEXT         =
-- =======================


function lsfml.text.create()
    return setmetatable({}, {
        __index = lsfml.text,
        __type = "text",
        __ptr = olsfml.text_create(),
        __gc = function(self)
            local meta = getmetatable(self)
            olsfml.text_destroy(meta.__ptr)
        end,
    })
end

function lsfml.text.getCenter(text, csize)
    check(text, "string", 1)
    check(csize, "number", 2)

    return (#text * csize) / 4, csize / 1.25
end

function lsfml.text.destroy(text)
    check(text, "text", 1)

    local meta = getmetatable(text)
    olsfml.text_destroy(meta.__ptr)
end

function lsfml.text.getPosition(text)
    check(text, "text", 1)

    local meta = getmetatable(text)
    return olsfml.text_getPosition(meta.__ptr)
end

function lsfml.text.setScale(text, x, y)
    check(text, "text", 1)
    check(x, "number", 2)
    check(y, "number", 3)

    local meta = getmetatable(text)
    olsfml.text_setScale(meta.__ptr, {x=x, y=y})
end

function lsfml.text.setPosition(text, x, y)
    check(text, "text", 1)
    check(x, "number", 2)
    check(y, "number", 3)

    local meta = getmetatable(text)
    olsfml.text_setPosition(meta.__ptr, {x=x, y=y})
end

function lsfml.text.move(text, x, y)
    check(text, "text", 1)
    check(x, "number", 2)
    check(y, "number", 3)

    local meta = getmetatable(text)
    olsfml.text_move(meta.__ptr, {x=x, y=y})
end

function lsfml.text.rotate(text, number)
    check(text, "text", 1)
    check(number, "number", 2)

    local meta = getmetatable(text)
    olsfml.text_rotate(meta.__ptr, number)
end

function lsfml.text.scale(text, x, y)
    check(text, "text", 1)
    check(x, "number", 2)
    check(y, "number", 3)

    local meta = getmetatable(text)
    olsfml.text_scale(meta.__ptr, {x=x, y=y})
end

function lsfml.text.setRotation(text, x, y)
    check(text, "text", 1)
    check(x, "number", 2)
    check(y, "number", 3)

    local meta = getmetatable(text)
    olsfml.text_setRotation(meta.__ptr, {x=x, y=y})
end

function lsfml.text.getOrigin(text)
    check(text, "text", 1)

    local meta = getmetatable(text)
    return olsfml.text_getOrigin(meta.__ptr)
end

function lsfml.text.getScale(text)
    check(text, "text", 1)

    local meta = getmetatable(text)
    return olsfml.text_getScale(meta.__ptr)
end

function lsfml.text.setOrigin(text, x, y)
    check(text, "text", 1)
    check(x, "number", 2)
    check(y, "number", 3)

    local meta = getmetatable(text)
    olsfml.text_setOrigin(meta.__ptr, {x=x, y=y})
end

function lsfml.text.getRotation(text)
    check(text, "text", 1)

    local meta = getmetatable(text)
    return olsfml.text_getRotation(meta.__ptr)
end

function lsfml.text.setString(text, string)
    check(text, "text", 1)
    check(string, "string", 2)

    local meta = getmetatable(text)
    olsfml.text_setString(meta.__ptr, string)
end

function lsfml.text.setFont(text, font)
    check(text, "text", 1)
    check(font, "font", 2)

    local meta = getmetatable(text)
    local meta_f = getmetatable(font)
    olsfml.text_setFont(meta.__ptr, meta_f.__ptr)
end

function lsfml.text.setCharacterSize(text, number)
    check(text, "text", 1)
    check(number, "number", 2)

    local meta = getmetatable(text)
    olsfml.text_setCharacterSize(meta.__ptr, number)
end

function lsfml.text.getString(text)
    check(text, "text", 1)

    local meta = getmetatable(text)
    return olsfml.text_getString(meta.__ptr)
end

-- =======================
-- =        FONT         =
-- =======================

function lsfml.font.createFromFile(string)
    check(string, "string", 1)

    return setmetatable({}, {
        __index = lsfml.font,
        __type = "font",
        __ptr = olsfml.font_createFromFile(string),
        __gc = function(self)
            local meta = getmetatable(self)
            olsfml.font_destroy(meta.__ptr)
        end,
    })
end

function lsfml.font.destroy(font)
    check(font, "font", 1)

    local meta = getmetatable(font)
    olsfml.font_destroy(meta.__ptr)
end


-- =======================
-- =      KEYBOARD       =
-- =======================

function lsfml.keyboard.keyPressed(number)
    check(number, "number", 1)

    return olsfml.keyboard_keyPressed(number)
end

-- =======================
-- =       MOUSE         =
-- =======================

function lsfml.mouse.getPosition(window)
    check(window, "window", 1)

    local meta = getmetatable(window)
    return olsfml.mouse_getPosition(meta.__ptr)
end

function lsfml.mouse.setPosition(window, x, y)
    check(window, "window", 1)
    check(x, "number", 2)
    check(y, "number", 3)

    local meta = getmetatable(window)
    olsfml.mouse_setPosition(meta.__ptr, x, y)
end

function lsfml.mouse.isButtonPressed(number)
    check(number, "number", 2)

    return olsfml.mouse_isButtonPressed(number)
end

-- =======================
-- =       SOUND         =
-- =======================

function lsfml.sound.create()
    return setmetatable({}, {
        __index = lsfml.sound,
        __type = "sound",
        __ptr = olsfml.sound_create(),
        __gc = function(self)
            local meta = getmetatable(self)
            olsfml.sound_destroy(meta.__ptr)
        end,
    })
end

function lsfml.sound.createFromFile(filename)
    check(filename, "string", 1)

    local sound = olsfml.sound_create()
    local soundbuf = olsfml.soundbuffer_createFromFile(filename)
    olsfml.sound_setBuffer(sound, soundbuf)
    return setmetatable({}, {
        __index = lsfml.sound,
        __type = "sound",
        __ptr = sound,
        __gc = function(self)
            local meta = getmetatable(self)
            olsfml.sound_destroy(meta.__ptr)
        end,
    })
end

function lsfml.sound.copy(sound)
    check(sound, "sound", 1)

    local meta = getmetatable(sound)
    return setmetatable({}, {
        __index = lsfml.sound,
        __type = "sound",
        __ptr = olsfml.sound_copy(meta.__ptr),
        __gc = function(self)
            local meta = getmetatable(self)
            olsfml.sound_destroy(meta.__ptr)
        end,
    })
end

function lsfml.sound.getAttenuation(sound)
    check(sound, "sound", 1)

    local meta = getmetatable(sound)
    return olsfml.sound_getAttenuation(meta.__ptr)
end

function lsfml.sound.destroy(sound)
    check(sound, "sound", 1)

    local meta = getmetatable(sound)
    olsfml.sound_destroy(meta.__ptr)
end

function lsfml.sound.getBuffer(sound)
    check(sound, "sound", 1)

    local meta = getmetatable(sound)
    return setmetatable({}, {
        __index = lsfml.sound,
        __type = "sound",
        __ptr = olsfml.sound_getBuffer(meta.__ptr),
        __gc = function(self)
            local meta = getmetatable(self)
            olsfml.sound_destroy(meta.__ptr)
        end,
    })
end

function lsfml.sound.getIsRelativeToListener(sound)
    check(sound, "sound", 1)

    local meta = getmetatable(sound)
    return olsfml.sound_getIsRelativeToListener(meta.__ptr)
end

function lsfml.sound.getLoop(sound)
    check(sound, "sound", 1)

    local meta = getmetatable(sound)
    return olsfml.sound_getLoop(meta.__ptr)
end

function lsfml.sound.getMinDistance(sound)
    check(sound, "sound", 1)

    local meta = getmetatable(sound)
    return olsfml.sound_getMinDistance(meta.__ptr)
end

function lsfml.sound.getPitch(sound)
    check(sound, "sound", 1)

    local meta = getmetatable(sound)
    return olsfml.sound_getPitch(meta.__ptr)
end

function lsfml.sound.getPlayingOffset(sound)
    check(sound, "sound", 1)

    local meta = getmetatable(sound)
    return olsfml.sound_getPlayingOffset(meta.__ptr)
end

function lsfml.sound.getVolume(sound)
    check(sound, "sound", 1)

    local meta = getmetatable(sound)
    return olsfml.sound_getVolume(meta.__ptr)
end

function lsfml.sound.getPosition(sound)
    check(sound, "sound", 1)

    local meta = getmetatable(sound)
    return olsfml.sound_getPosition(meta.__ptr)
end

function lsfml.sound.getStatus(sound)
    check(sound, "sound", 1)

    local meta = getmetatable(sound)
    return olsfml.sound_getStatus(meta.__ptr)
end

function lsfml.sound.isPlaying(sound)
    check(sound, "sound", 1)

    local meta = getmetatable(sound)
    return olsfml.sound_getStatus(meta.__ptr) == "playing"
end

function lsfml.sound.isPaused(sound)
    check(sound, "sound", 1)

    local meta = getmetatable(sound)
    return olsfml.sound_getStatus(meta.__ptr) == "paused"
end

function lsfml.sound.isStopped(sound)
    check(sound, "sound", 1)

    local meta = getmetatable(sound)
    return olsfml.sound_getStatus(meta.__ptr) == "stopped"
end

function lsfml.sound.pause(sound)
    check(sound, "sound", 1)

    local meta = getmetatable(sound)
    olsfml.sound_pause(meta.__ptr)
end

function lsfml.sound.play(sound)
    check(sound, "sound", 1)

    local meta = getmetatable(sound)
    olsfml.sound_play(meta.__ptr)
end

function lsfml.sound.stop(sound)
    check(sound, "sound", 1)

    local meta = getmetatable(sound)
    olsfml.sound_stop(meta.__ptr)
end

function lsfml.sound.setBuffer(sound, soundbuf)
    check(sound, "sound", 1)
    check(soundbuf, "soundbuffer", 2)

    local meta = getmetatable(sound)
    local meta_s = getmetatable(soundbuf)
    olsfml.sound_setBuffer(meta.__ptr, meta_s.__ptr)
end

function lsfml.sound.setLoop(sound, bool)
    check(sound, "sound", 1)
    check(bool, "boolean", 2)

    local meta = getmetatable(sound)
    olsfml.sound_setLoop(meta.__ptr, bool)
end

function lsfml.sound.setMinDistance(sound, dst)
    check(sound, "sound", 1)
    check(dst, "number", 2)

    local meta = getmetatable(sound)
    olsfml.sound_setMinDistance(meta.__ptr, dst)
end

function lsfml.sound.setPitch(sound, pitch)
    check(sound, "sound", 1)
    check(pitch, "number", 2)

    local meta = getmetatable(sound)
    olsfml.sound_setPitch(meta.__ptr, pitch)
end

function lsfml.sound.setPlayingOffset(sound, offset)
    check(sound, "sound", 1)
    check(offset, "number", 2)

    local meta = getmetatable(sound)
    olsfml.sound_setPlayingOffset(meta.__ptr, offset)
end

function lsfml.sound.setPosition(sound, x, y, z)
    check(sound, "sound", 1)
    check(x, "number", 2)
    check(y, "number", 3)
    check(z, "number", 4)

    local meta = getmetatable(sound)
    olsfml.sound_setPosition(meta.__ptr, x, y, z)
end

function lsfml.sound.setRelativeToListener(sound, bool)
    check(sound, "sound", 1)
    check(bool, "boolean", 2)

    local meta = getmetatable(sound)
    olsfml.sound_setRelativeToListener(meta.__ptr, bool)
end

function lsfml.sound.setAttenuation(sound, attenuation)
    check(sound, "sound", 1)
    check(attenuation, "number", 2)

    local meta = getmetatable(sound)
    olsfml.sound_setAttenuation(meta.__ptr, attenuation)
end

function lsfml.sound.setVolume(sound, volume)
    check(sound, "sound", 1)
    check(volume, "number", 2)

    local meta = getmetatable(sound)
    olsfml.sound_setVolume(meta.__ptr, volume)
end

-- =======================
-- =     SOUNDBUFFER     =
-- =======================

function lsfml.soundbuffer.createFromFile(file)
    check(file, "string", 1)

    return setmetatable({}, {
        __index = lsfml.soundbuffer,
        __type = "soundbuffer",
        __ptr = olsfml.soundbuffer_createFromFile(file),
        __gc = function(self)
            local meta = getmetatable(self)
            olsfml.soundbuffer_destroy(meta.__ptr)
        end,
    })
end

function lsfml.soundbuffer.destroy(soundbuf)
    check(soundbuf, "soundbuffer", 1)

    olsfml.soundbuffer_destroy(soundbuf)
end

-- =======================
-- =     MOUSE MACROS    =
-- =======================

mouse = {
    LEFT = 0,
    RIGHT = 1,
    MIDDLE = 2
}

-- =======================
-- =     KEYS MACROS     =
-- =======================

keys = {
	Unknown = -1,
	A = 0,
	B = 1,
	C = 2,
	D = 3,
	E = 4,
	F = 5,
	G = 6,
	H = 7,
	I = 8,
	J = 9,
	K = 10,
	L = 11,
	M = 12,
	N = 13,
	O = 14,
	P = 15,
	Q = 16,
	R = 17,
	S = 18,
	T = 19,
	U = 20,
	V = 21,
	W = 22,
	X = 23,
	Y = 24,
	Z = 25,
	Num0 = 26,
	Num1 = 27,
	Num2 = 28,
	Num3 = 29,
	Num4 = 30,
	Num5 = 31,
	Num6 = 32,
	Num7 = 33,
	Num8 = 34,
	Num9 = 35,
	Escape = 36,
	LControl = 37,
	LShift = 38,
	LAlt = 39,
	LSystem = 40,
	RControl = 41,
	RShift = 42,
	RAlt = 43,
	RSystem = 44,
	Menu = 45,
	LBracket = 46,
	RBracket = 47,
	Semicolon = 48,
	Comma = 49,
	Period = 50,
	Quote = 51,
	Slash = 52,
	Backslash = 53,
	Tilde = 54,
	Equal = 55,
	Hyphen = 56,
	Space = 57,
	Enter = 58,
	Backspace = 59,
	Tab = 60,
	PageUp = 61,
	PageDown = 62,
	End = 63,
	Home = 64,
	Insert = 65,
	Delete = 66,
	Add = 67,
	Subtract = 68,
	Multiply = 69,
	Divide = 70,
	Left = 71,
	Right = 72,
	Up = 73,
	Down = 74,
	Numpad0 = 75,
	Numpad1 = 76,
	Numpad2 = 77,
	Numpad3 = 78,
	Numpad4 = 79,
	Numpad5 = 80,
	Numpad6 = 81,
	Numpad7 = 82,
	Numpad8 = 83,
	Numpad9 = 84,
	F1 = 85,
	F2 = 86,
	F3 = 87,
	F4 = 88,
	F5 = 89,
	F6 = 90,
	F7 = 91,
	F8 = 92,
	F9 = 93,
	F10 = 94,
	F11 = 95,
	F12 = 96,
	F13 = 97,
	F14 = 98,
	F15 = 99,
	Pause = 100,
	KeyCount = 101,
	Dash = 102,
	BackSpace = 103,
	BackSlash = 104,
	SemiColon = 105,
	Return = 106,
}

primitiveType = {
    Points = 0,
    Lines = 1,
    LineStrip = 2,
    Triangles = 3,
    TriangleStrip = 4,
    TriangleFan = 5,
    Quads = 6,
    LinesStrip = 7,
    TrianglesStrip = 8,
    TrianglesFan = 9,
}