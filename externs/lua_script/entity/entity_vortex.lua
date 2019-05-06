Class "EntityVortex" extends "Entity" [{
    function __EntityVortex(x, y, dir, damage, speed, func, source)
        check(x, "number", 1)
        check(y, "number", 2)
        check(dir, "Vector2D", 3)
        check(damage, "number", 4)
        check(speed, "number", 5)
        check(func, "function", 5)

        super(x, y)
        this.source = source
        this.angle = 0
        this.count = 0
        this.lifetime = stopwatch.create()
        this.sprite = lsfml.sprite.create()
        this.sprite:setTexture(assets["vortex"], false)
        this.sprite:setPosition(x, y)
        this.sprite:scale(0.15, 0.15)
        this.sprite:setOrigin(194, 202)
        this.dir = dir:normalize()
        this.odir = dir:normalize()
        this.damage = damage
        this.speed = speed
        this.hit = false
        this.before1 = 0
        this.before2 = 0
        this.func = func
        local box = new(Hitbox("projectile"))
        box.setPoints({{0, 0}, {386, 0}, {386, 393}, {0, 393}})
        box.setOrigin(194, 202)
        box.setPosition(super.getPosition())
        box.setRotation(this.angle)
        box.setScale(0.15, 0.15)
        super.addHitbox(box)
    end

    function setDir(x, y)
        check(x, "number", 1)
        check(y, "number", 2)

        this.odir = vector.new(x, y):normalize()
    end

    function draw()
        super.draw()
        window:draw(this.sprite)
        super.drawHitbox()
    end

    function move(x, y)
        super.move(x, y)
        this.sprite:move(x, y)
    end

    function update()
        super.update()
        this.count = this.count + 1
        this.angle = this.angle + 1
        this.sprite:setRotation(this.angle)
        this.dir.x, this.dir.y = this.func(this.count, this.dir, this.odir)
        this.dir = this.dir:normalize()
        this.move(this.dir.x * this.speed * DeltaTime, this.dir.y * this.speed * DeltaTime)
        local nx, ny = super.getPosition()
        if this.lifetime:getEllapsedTime() > 5000000 or nx < 0 or nx > 1920 or ny < 0 or ny > 1080 then
            world.removeEntityByUUID(super.getUUID())
            return
        end
        if not this.hit then
            if hitbox.rectIntersect(super.getHitboxs()[1].getBoundingBox(), player.getHitboxs()[1].getBoundingBox()) then
                player.hit(this.damage * DeltaTime, this.source)
                this.hit = true
            end
        end
    end
}]