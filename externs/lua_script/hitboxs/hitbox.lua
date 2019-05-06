-- =========================================
-- =                 HITBOX                =
-- =========================================

Class "Hitbox" [{
    function __Hitbox(type, userdata)
        this.points = points or {}
        this.compute_points = {}
        this.angle = 0
        this.x = 0
        this.y = 0
        this.scale_x = 1
        this.scale_y = 1
        this.offset_x = 0
        this.offset_y = 0
        this.varray = lsfml.vertexarray.create()
        varray:setPrimitiveType(primitiveType.LineStrip)
        this.modify = true
        this.modify_mesh = true
        this.uuid = uuid.randomUUID()
        this.type = type or "hard"
        this.userdata = userdata or {}
        this.bx = math.huge
        this.by = math.huge
        this.bw = -math.huge
        this.bh = -math.huge
    end

    function getType()
        return this.type
    end

    function getUserdata()
        return this.userdata
    end

    function setType(type)
        this.type = type
    end

    function setPoints(points)
        check(points, "table", 1)

        this.bx = math.huge
        this.by = math.huge
        this.bw = -math.huge
        this.bh = -math.huge
        local pts = {}
        for i=1, #points do
            this.bx = math.min(points[i][1], this.bx)
            this.by = math.min(points[i][2], this.by)
            this.bw = math.max(points[i][1], this.bw)
            this.bh = math.max(points[i][2], this.bh)
            pts[i] = vector.new(points[i][1], points[i][2])
        end
        this.points = pts
        this.modify = true
        this.modify_mesh = true
    end

    function getBoundingBox()
        return {this.bx, this.by, this.bw - this.bx, this.bh - this.by}
    end

    function getTransform()
        local angle  = -this.angle * math.pi / 180.0
        local cosine = math.cos(angle)
        local sine = math.sin(angle)
        local sxc = this.scale_x * cosine
        local syc = this.scale_y * cosine
        local sxs = this.scale_x * sine
        local sys = this.scale_y * sine
        local tx = -this.offset_x * sxc - this.offset_y * sys + this.x
        local ty = this.offset_x * sxs - this.offset_y * syc + this.y;
        local matrix = transform.make({{sxc, sys, tx},
                                       {-sxs, syc, ty},
                                       {0.0, 0.0, 1.0}})
        return matrix
    end

    function recompute()
        if this.modify then
            this.bx = math.huge
            this.by = math.huge
            this.bw = -math.huge
            this.bh = -math.huge
            this.compute_points = nil
            this.compute_points = {}
            local matrix = this.getTransform()
            for i=1, #this.points do
                this.compute_points[i] = vector.new(matrix(this.points[i][1], this.points[i][2]))
                this.bx = math.min(this.compute_points[i][1], this.bx)
                this.by = math.min(this.compute_points[i][2], this.by)
                this.bw = math.max(this.compute_points[i][1], this.bw)
                this.bh = math.max(this.compute_points[i][2], this.bh)
            end
            this.modify = false
        end
    end

    function recompute_mesh()
        recompute()
        if _G.hitbox.isDrawEnable() then
            if this.modify_mesh and #this.compute_points > 0 then
                varray:clear()
                for i=1, #this.compute_points do
                    varray:append({x=this.compute_points[i][1], y=this.compute_points[i][2], r=255, g=255, b=255, a=255, tx=0, ty=0})
                end
                varray:append({x=this.compute_points[1][1], y=this.compute_points[1][2], r=255, g=255, b=255, a=255, tx=0, ty=0})
                -- local pos = this.getBoundingBox()
                -- varray:append({x=pos[1], y=pos[2], r=255, g=255, b=255, a=255, tx=0, ty=0})
                -- varray:append({x=pos[1] + pos[3], y=pos[2], r=255, g=255, b=255, a=255, tx=0, ty=0})
                -- varray:append({x=pos[1] + pos[3], y=pos[2] + pos[4], r=255, g=255, b=255, a=255, tx=0, ty=0})
                -- varray:append({x=pos[1], y=pos[2] + pos[4], r=255, g=255, b=255, a=255, tx=0, ty=0})
                -- varray:append({x=pos[1], y=pos[2], r=255, g=255, b=255, a=255, tx=0, ty=0})
                this.modify_mesh = false
            end
        end
    end

    function addPoint(x, y)
        this.bx = math.min(x, this.bx)
        this.by = math.min(y, this.by)
        this.bw = math.max(x, this.bh)
        this.bh = math.max(y, this.bw)
        this.points[#this.points + 1] = vector.new(x, y)
        this.modify = true
        this.modify_mesh = true
    end

    function setRotation(angle)
        this.angle = angle
        this.modify = true
        this.modify_mesh = true
    end

    function setPosition(x, y)
        this.x = x
        this.y = y
        this.modify = true
        this.modify_mesh = true
    end

    function move(x, y)
        this.x = this.x + x
        this.y = this.y + y
        this.modify = true
        this.modify_mesh = true
    end

    function rotate(angle)
        this.angle = this.angle + angle
        this.modify = true
        this.modify_mesh = true
    end

    function scale(x, y)
        this.scale_x = this.scale_x + x
        this.scale_y = this.scale_y + y
        this.modify = true
        this.modify_mesh = true
    end

    function setScale(x, y)
        this.scale_x = x
        this.scale_y = y
        this.modify = true
        this.modify_mesh = true
    end

    function setOrigin(x, y)
        this.offset_x = x
        this.offset_y = y
        this.modify = true
        this.modify_mesh = true
    end

    function clearPoints()
        this.points = {}
        this.modify = true
        this.modify_mesh = true
        this.bx = math.huge
        this.by = math.huge
        this.bw = -math.huge
        this.bh = -math.huge
    end

    function getOrigin()
        return this.offset_x, this.offset_y
    end

    function getPosition()
        return this.x, this.y
    end

    function getRotation()
        return this.angle
    end

    function getScale()
        return this.scale_x, this.scale_y
    end

    function reset()
        this.matrix = transform.trans(0, 0)
        this.modify = true
    end

    function getMiddlePoint()
        recompute()
        local nx, ny = 0, 0
        for i=1, #this.compute_points do
            nx = nx + this.compute_points[i][1]
            ny = ny + this.compute_points[i][2]
        end
        return math.floor(nx / #this.compute_points), math.floor(ny / #this.compute_points)
    end

    function getPoints()
        recompute()
        return this.compute_points
    end

    function draw()
        recompute_mesh()
        if hitbox.isDrawEnable() then
            window:draw(this.varray)
        end
    end

    function getUUID()
        return this.uuid
    end

    function __eq(self, other)
        return class.isInstanceOf(other, "Hitbox") and this.getUUID() == other.getUUID()
    end
}]