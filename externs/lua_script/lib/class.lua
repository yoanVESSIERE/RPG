class = {}

function class.createFromFile(filename)
    local handle = io.open("./externs/lua_script/"..filename, "r")
    if handle then
        local code = handle:read("*all"):gsub("%[{", "[["):gsub("}%]", "]]")
        handle:close()
        local env = setmetatable({}, {__index = _G})
        local func, err = load(code, filename, "t", env)
        if func then
            local success, errmsg = pcall(func)
            if success then

            else
                error(errmsg, 3)
            end
        else
            error("[ERROR LOADING CLASS] "..err, 2)
        end
    end
end

function class.isInstanceOf(obj, _type)
    if type(obj) == _type then
        return true
    else
        local meta = getmetatable(obj)
        while (meta) do
            if meta and not meta.__superclass then
                return false
            end
            if meta.__superclass == _type then
                return true
            else
                if _G[meta.__superclass] then
                    meta = getmetatable(_G[meta.__superclass])
                else
                    return false
                end
            end
        end
    end
    return false
end

function class.isNew(obj)
    if class.isInstanceOf(obj, "Class") then
        local meta = getmetatable(obj)
        if meta.__isNew then
            return true
        else
            return false
        end
    end
end

function Class(className)
    _G.extends = function(superclass)
        return setmetatable({}, {
                __call=function(self, code)
                    local super = {}
                    for func_name, func_f in pairs(_G[superclass]) do
                        super[func_name] = func_f
                    end
                    local env = setmetatable({}, {__index = function(self, key)
                        if key == "super" then
                            return super
                        elseif key == "this" then
                            return self
                        else
                            return _G[key]
                        end
                    end})
                    local func, err = load(code, className, "t", env)
                    if func then
                        local success, err = pcall(func)
                        if success then
                            local cpenv = {}
                            for func_name, func_f in pairs(_G[superclass]) do
                                cpenv[func_name] = func_f
                            end
                            for k, v in pairs(env) do
                                if type(v) == "function" then
                                    cpenv[k] = v
                                end
                            end
                        _G[className] = setmetatable(cpenv, {
                            __call = function(self, ...)
                                return setmetatable({className=className, superclass=superclass, code=code, params={...}}, {__type = className, __superclass=superclass, code=code, params={...}, __isNew = true})
                            end,
                            __index = function(self, key)
                                if class[key] then
                                    return class[key]
                                else
                                    return rawget(self, key)
                                end
                            end,
                            __type = className,
                            __superclass = superclass,
                            })
                        else
                            error(err, 2)
                        end
                    else
                        error(err, 2)
                    end
                end
            })
    end
    return setmetatable({}, {
        __call=function(self, code)
            local env = setmetatable({}, {__index = _G})
            local func, err = load(code, className, "t", env)
            if func then
                local success, err = pcall(func)
                if success then
                    local cpenv = {}
                    for k, v in pairs(env) do
                        cpenv[k] = v
                    end
                    _G[className] = setmetatable(cpenv, {
                        __code = code,
                        __type = className,
                        __superclass = "Class",
                        __index = function(self, key)
                            if class[key] then
                                return class[key]
                            else
                                return rawget(self, key)
                            end
                        end,
                        __call = function(self, ...)
                            return setmetatable({className=className, superclass="Class", code=code, params={...}}, {__type = className, __superclass="Class", code=code, params={...}, __isNew = true})
                        end,
                        })
                else
                    error(err, 2)
                end
            else
                error(err, 2)
            end
        end
    })
end

function new(clazz, fenv)
    if clazz and class.isInstanceOf(clazz, "Class") and class.isNew(clazz) then
        if clazz.superclass then
            local cpenv = {}
            local super = setmetatable({}, {__call = function(self, ...)
                local meta = getmetatable(self)

                meta.__super = new(_G[clazz.superclass](...), cpenv)
                if not meta.__super then
                    error("Failed to Initialized Superclass '"..clazz.superclass.."', Missing Constructor for '"..clazz.superclass.."'", 3)
                end
                return meta.__super
            end,
            __index = function(self, key)
                local meta = getmetatable(self)

                if meta.__super then
                    return meta.__super[key]
                end
            end})
            local final = setmetatable({}, {__index = fenv})
            local env = setmetatable({}, {__index = function(self, key)
                local meta = getmetatable(self)
                if not meta.__this then
                    meta.__this = setmetatable({}, {__index = function(subself, key)
                        if rawget(self, key) then
                            return rawget(self, key)
                        else
                            return super[key]
                        end
                    end,
                    __newindex = function(subself, key, value)
                        self[key] = value
                    end})
                end
                if key == "super" then
                    return super
                elseif key == "this" then
                    return meta.__this
                elseif key == "final" then
                    return final
                else
                    return _G[key]
                end
            end})
            local func, err = load(clazz.code, clazz.className, "t", env)
            if func then
                local success, err = pcall(func)
                if success then
                    for k, v in pairs(env) do
                        if type(v) == "function" then
                            cpenv[k] = v
                        end
                    end
                    local cl = setmetatable(cpenv, {
                    __index = function(self, key)
                        local meta = getmetatable(self)
                        if class[key] then
                            return class[key]
                        elseif rawget(self, key) then
                            return rawget(self, key)
                        elseif meta.__super[key] then
                            return meta.__super[key]
                        else
                            if cpenv and rawget(cpenv, "__index") then
                                return rawget(cpenv, "__index")(self, key)
                            elseif super and rawget(super, "__index") then
                                return rawget(super, "__index")(self, key)
                            end
                        end
                    end,
                    __type = clazz.className,
                    __superclass = clazz.superclass,
                    __super = super,
                    __newindex = (cpenv and cpenv["__newindex"]) or (super and super["__newindex"]),
                    __add = (cpenv and cpenv["__add"]) or (super and super["__add"]),   
                    __sub = (cpenv and cpenv["__sub"]) or (super and super["__sub"]),
                    __mul = (cpenv and cpenv["__mul"]) or (super and super["__mul"]),
                    __div = (cpenv and cpenv["__div"]) or (super and super["__div"]),
                    __mod = (cpenv and cpenv["__mod"]) or (super and super["__mod"]),
                    __pow = (cpenv and cpenv["__pow"]) or (super and super["__pow"]),
                    __unm = (cpenv and cpenv["__unm"]) or (super and super["__unm"]),
                    __idiv = (cpenv and cpenv["__idiv"]) or (super and super["__idiv"]),
                    __band = (cpenv and cpenv["__band"]) or (super and super["__band"]),
                    __bor = (cpenv and cpenv["__bor"]) or (super and super["__bor"]),
                    __bxor = (cpenv and cpenv["__bxor"]) or (super and super["__bxor"]),
                    __bnot = (cpenv and cpenv["__bnot"]) or (super and super["__bnot"]),
                    __shl = (cpenv and cpenv["__shl"]) or (super and super["__shl"]),
                    __shr = (cpenv and cpenv["__shr"]) or (super and super["__shr"]),
                    __concat = (cpenv and cpenv["__concat"]) or (super and super["__concat"]),
                    __len = (cpenv and cpenv["__len"]) or (super and super["__len"]),
                    __eq = (cpenv and cpenv["__eq"]) or (super and super["__eq"]),
                    __lt = (cpenv and cpenv["__lt"]) or (super and super["__lt"]),
                    __le = (cpenv and cpenv["__le"]) or (super and super["__le"]),
                    __call = (cpenv and cpenv["__call"]) or (super and super["__call"]),
                    __tostring = (cpenv and cpenv["__tostring"]) or (super and super["__tostring"]),
                    __gc = (cpenv and cpenv["__gc"]) or (super and super["__gc"]),
                    })
                    if cl["__"..clazz.className] then
                        cl["__"..clazz.className](table.unpack(clazz.params))
                    else
                        error("Failed to Initialized Superclass '"..clazz.superclass.."', Missing Constructor for '"..clazz.superclass.."' in '"..clazz.className.."'", 3)
                    end
                    return cl
                else
                    error(err, 2)
                end
            else
                error(err, 2)
            end
        end
        local env = setmetatable({}, {__index = _G})
        local func, err = load(clazz.code, clazz.className, "t", env)
        if func then
            local success, err = pcall(func)
            if success then
                local cpenv = {}
                for k, v in pairs(env) do
                    cpenv[k] = v
                end
                local cl = setmetatable(cpenv,add {
                    __code = clazz.code,
                    __type = clazz.className,
                    __superclass = "Class",
                    __index = function(self, key)
                        if class[key] then
                            return class[key]
                        else
                            return rawget(self, key)
                        end
                    end,
                    })
                if cl["__"..clazz.className] then
                    cl["__"..clazz.className](table.unpack(clazz.params))
                end
                return cl
            else
                error(err, 2)
            end
        else
            error(err, 2)
        end
    end
end