Class "EntityBouleElec" extends "Entity" [{
    function __EntityBouleElec(x, y, dir, damage, speed)
        check(x, "number", 1)
        check(y, "number", 2)
        check(dir, "Vector2D", 3)
        check(damage, "number", 4)
        check(speed, "number", 5)

        super(x, y)
        this.angle = -math.deg(math.atan2(0, 1) - math.atan2(dir.y, dir.x))
        this.sprite = animation.create(assets["bouleelecAnimation"],{0, 0, 71, 281})
        this.sprite:setPosition(x, y)
        this.sprite:scale(1.5, 1.5)
        this.sprite:setOrigin(36, 36)
        this.sprite:setRotation(this.angle)
        this.clock = stopwatch.create()
        this.dir = dir:normalize()
        this.damage = damage
        this.speed = speed
        this.timeAnimation = 10000
        this.hit = {}
        local box = new(Hitbox("soft"))
        box.setPoints({{20, 20}, {50, 20}, {50, 50}, {20, 50}})
        box.setOrigin(36, 36)
        box.setPosition(super.getPosition())
        box.setRotation(this.angle)
        box.scale(1.5, 1.5)
        super.addHitbox(box)
    end

    function draw()
        super.draw()
        super.drawHitbox()

        if this.clock:getEllapsedTime() > this.timeAnimation then
            if (this.sprite:hasEnded()) then
                this.sprite:restart()
            end
            this.clock:restart()
            this.sprite:next()
        end
        this.sprite:draw()

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
                entities[i].hit(this.damage * DeltaTime * player.getAttack(), player)
                this.hit[entities[i].getUUID()] = true
            end
        end
    end
}]