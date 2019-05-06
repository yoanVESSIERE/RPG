Class "Entity" [{
    function __Entity(x, y)
        this.x = x
        this.y = y
        this.angle = 0
        this.scale_x = 0
        this.scale_y = 0
        this.uuid = uuid.randomUUID()
        this.hitbox = {}
        this.type = "neutral"
    end

    function setType(typ)
        this.type = typ
    end

    function getType()
        return this.type
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

    function setPosition(x, y)
        check(x, "number", 1)
        check(y, "number", 2)

        this.x = x
        this.y = y
        for i=1, #this.hitbox do
            this.hitbox[i].setPosition(this.x, this.y)
        end
    end

    function setRotation(angle)
        check(angle, "number", 1)

        this.angle = angle
        for i=1, #this.hitbox do
            this.hitbox[i].setRotation(this.angle)
        end
    end

    function setScale(x, y)
        check(x, "number", 1)
        check(y, "number", 2)

        this.scale_x = x
        this.scale_y = y
        for i=1, #this.hitbox do
            this.hitbox[i].setScale(this.scale_x, this.scale_y)
        end
    end

    function move(x, y)
        check(x, "number", 1)
        check(y, "number", 2)

        this.x = this.x + x
        this.y = this.y + y
        for i=1, #this.hitbox do
            this.hitbox[i].setPosition(this.x, this.y)
        end
    end

    function getUUID()
        return this.uuid
    end

    function addHitbox(hitbx)
        check(hitbx, "Hitbox", 1)

        this.hitbox[#this.hitbox + 1] = hitbx
    end

    function clearHitboxs()
        this.hitbox = nil
        this.hitbox = {}
    end

    function drawHitbox()
        for i=1, #this.hitbox do
            this.hitbox[i].draw()
        end
    end

    function draw()

    end

    function update()

    end

    function event()

    end

    function getHitboxs()
        return this.hitbox
    end
}]