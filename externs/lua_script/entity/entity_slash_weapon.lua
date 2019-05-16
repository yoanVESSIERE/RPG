Class "EntitySlashWeapon" extends "Entity" [{
    function __EntitySlashWeapon(x, y, dir, damage, speed, source, size)
        check(x, "number", 1)
        check(y, "number", 2)
        check(dir, "Vector2D", 3)
        check(damage, "number", 4)
        check(speed, "number", 5)

        super(x, y)
        this.source = source
        this.angle = -math.deg(math.atan2(0, 1) - math.atan2(dir.y, dir.x))
        this.sprite = lsfml.sprite.create()
        this.sprite:setTexture(assets["slash"], false)
        this.sprite:setPosition(x, y)
        this.sprite:setScale(1.25 * size, 2 * size)
        this.sprite:setOrigin(48, 147 / 2)
        this.sprite:setRotation(this.angle)
        this.dir = dir:normalize()
        this.damage = damage
        this.speed = speed
        this.hit = {}
        local box = new(Hitbox("projectile"))
        box.setPoints({{0, 0}, {47, 24}, {61, 48}, {66, 73}, {61, 100}, {47, 120}, {0, 147}})
        box.setOrigin(48, 147 / 2)
        box.setPosition(super.getPosition())
        box.setRotation(this.angle)
        box.setScale(1.25 * size, 2 * size)
        super.addHitbox(box)
        assets["slash_sound"]:setVolume(math.floor((size - 0.5 / 1.5) * 75) + 25)
        assets["slash_sound"]:play()
    end

    function setDir(x, y)
        check(x, "number", 1)
        check(y, "number", 2)

        this.dir = vector.new(x, y):normalize()
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
        this.move(this.dir.x * this.speed * DeltaTime, this.dir.y * this.speed * DeltaTime)
        local nx, ny = super.getPosition()
        if nx < 0 or nx > 1920 or ny < 0 or ny > 1920 then
            world.removeEntityByUUID(super.getUUID())
            return
        end
        local entities = world.getEntitiesInHitbox(super.getHitboxs()[1], "enemy")
        for i=1, #entities do
            if class.isInstanceOf(entities[i], "EntityLiving") and not this.hit[entities[i].getUUID()] then
                entities[i].hit(this.damage * player.getAttack() * DeltaTime, this.source)
                this.hit[entities[i].getUUID()] = true
            end
        end
    end
}]