Class "EntityLaserBeam" extends "Entity" [{
    function __EntityLaserBeam(x, y, dir, damage, speed, mvx, mvy, in_angle, source)
        check(x, "number", 1)
        check(y, "number", 2)
        check(dir, "Vector2D", 3)
        check(damage, "number", 4)
        check(speed, "number", 5)
        check(mvx, "number", 6)
        check(mvy, "number", 7)
        check(in_angle, "number", 8)

        super(x, y)
        this.in_angle = in_angle
        this.source = source
        this.lifetime = stopwatch.create()
        this.angle = math.deg(math.atan2(0, 1) - math.atan2(dir.y, dir.x))
        this.sprite = lsfml.sprite.create()
        this.sprite:setTexture(assets["laser_beam"], false)
        this.sprite:setPosition(x, y)
        this.sprite:scale(4, 1)
        this.sprite:setOrigin(0, 16)
        this.sprite:setRotation(this.angle)
        this.dir = dir:normalize()
        this.damage = damage
        this.speed = speed
        this.mvx = mvx
        this.mvy = mvy
        local box = new(Hitbox("projectile"))
        box.setPoints({{0, 0}, {580, 0}, {580, 32}, {0, 32}})
        box.setOrigin(0, 16)
        box.setPosition(super.getPosition())
        box.setScale(4, 1)
        box.setRotation(this.angle)
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
        this.angle = this.angle + this.in_angle
        this.sprite:setRotation(this.angle)
        super.setRotation(this.angle)
        this.sprite:move(this.mvx * this.speed * DeltaTime, this.mvy * this.speed * DeltaTime)
        super.move(this.mvx * this.speed * DeltaTime, this.mvy * this.speed * DeltaTime)
        if this.lifetime:getEllapsedTime() > 5000000 then
            world.removeEntityByUUID(super.getUUID())
            return
        end
        if not this.hit then
            if hitbox.SAT(super.getHitboxs()[1], player.getHitboxs()[1]) then
                player.hit(this.damage * DeltaTime, this.source)
            end
        end
    end
}]