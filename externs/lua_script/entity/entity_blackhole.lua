Class "EntityBlackHole" extends "Entity" [{
    function __EntityBlackHole(damage, speed, source)
        check(damage, "number", 1)
        check(speed, "number", 2)

        super(1920 / 2, 0)
        this.source = source
        this.angle = 0
        this.lifetime = stopwatch.create()
        this.sprite = lsfml.sprite.create()
        this.sprite:setTexture(assets["vortex"], false)
        this.sprite:setPosition(1920 / 2, 1080 / 2)
        this.sprite:scale(0.5, 0.5)
        this.sprite:setOrigin(194, 202)
        this.damage = damage
        this.speed = speed
        this.scale = 0.5
        local box = new(Hitbox("soft"))
        box.setPoints({{0, 0}, {386, 0}, {386, 393}, {0, 393}})
        box.setOrigin(194, 202)
        box.setPosition(1920 / 2, 1080 / 2)
        box.setRotation(this.angle)
        box.setScale(0.5, 0.5)
        super.addHitbox(box)
    end

    function asExpired()
        if this.lifetime:getEllapsedTime() > 5000000 then
            return true
        end
        return false
    end

    function draw()
        super.draw()
        window:draw(this.sprite)
        super.drawHitbox()
    end

    function update()
        super.update()
        if _G.freeze then
            if not this.lifetime:isPaused() then
                this.lifetime:pause()
            end
        else
            if this.lifetime:isPaused() then
                this.lifetime:start()
            end
        end
        this.angle = this.angle + this.speed * DeltaTime
        this.sprite:setRotation(this.angle)
        this.scale = this.scale + 0.02 * DeltaTime
        this.sprite:setScale(this.scale, this.scale)
        this.getHitboxs()[1].setScale(this.scale, this.scale)
        local nx, ny = 1920 / 2, 1080 / 2
        if this.lifetime:getEllapsedTime() > 5000000 then
            world.removeEntityByUUID(super.getUUID())
            return
        end
        if hitbox.rectIntersect(this.getHitboxs()[1].getBoundingBox(), player.getHitboxs()[1].getBoundingBox()) then
            local px, py = player.getPosition()
            local dist = math.abs(nx - px) + math.abs(ny - py)
            if dist > this.speed then
                local dir = vector.new(nx - px, ny - py):normalize() * this.speed
                player.move(dir.x, dir.y)
            end
            if dist < 200 then
                player.hit(this.damage * DeltaTime, source)
            end
        end
    end
}]