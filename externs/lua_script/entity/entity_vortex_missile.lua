Class "EntityVortexMissile" extends "Entity" [{
    function __EntityVortexMissile(x, y, damage, speed, source)
        check(x, "number", 1)
        check(y, "number", 2)
        check(damage, "number", 4)
        check(speed, "number", 5)

        super(x, y)
        this.source = source
        this.angle = 0
        this.lifetime = stopwatch.create()
        this.sprite = lsfml.sprite.create()
        this.sprite:setTexture(assets["vortex2"], false)
        this.sprite:setPosition(x, y)
        this.sprite:scale(0.15, 0.15)
        this.sprite:setOrigin(194, 202)
        this.damage = damage
        this.speed = speed
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
        this.angle = this.angle + 1
        this.sprite:setRotation(this.angle)
        local px, py = player.getPosition()
        local nx, ny = super.getPosition()
        local dir = vector.new(px - nx, py - ny):normalize()
        this.move(dir.x * this.speed * DeltaTime, dir.y * this.speed * DeltaTime)
        if this.lifetime:getEllapsedTime() > 5000000 or nx < 0 or nx > 1920 or ny < 0 or ny > 1080 then
            world.removeEntityByUUID(super.getUUID())
            return
        end
        if hitbox.rectIntersect(super.getHitboxs()[1].getBoundingBox(), player.getHitboxs()[1].getBoundingBox()) then
            player.hit(this.damage * DeltaTime, this.source)
            world.removeEntityByUUID(super.getUUID())
            return
        end
    end
}]