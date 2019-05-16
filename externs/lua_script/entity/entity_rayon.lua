Class "EntityRayon" extends "Entity" [{
    function __EntityRayon(x, y, angle, damage, source)
        check(x, "number", 1)
        check(y, "number", 2)
        check(angle, "number", 3)
        check(damage, "number", 4)

        super(x, y - 2)
        this.angle = angle
        this.source = source
        this.sprite = lsfml.sprite.create()
        this.sprite:setTexture(assets["rayon"], false)
        this.sprite:setPosition(x, y - 2)
        this.sprite:scale(12, 4)
        this.sprite:setOrigin(8 - 15, 22)
        this.sprite:setRotation(this.angle)
        this.damage = damage
        this.speed = speed
        this.rotate = 1
        local box = new(Hitbox("projectile"))
        box.setPoints({{0, 0}, {199, 0}, {199, 44}, {0, 44}})
        box.setOrigin(8 - 15, 22)
        box.setPosition(super.getPosition())
        box.setRotation(this.angle)
        box.scale(12, 2)
        super.addHitbox(box)
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
        this.angle = this.angle + 0.5
        if this.angle > 360 then
            this.angle = 0
        end
        super.update()
        this.sprite:setRotation(this.angle)
        super.setRotation(this.angle)
        local success = hitbox.SAT(super.getHitboxs()[1], player.getHitboxs()[1])
        if success then
            player.hit(this.damage, this.source)
        end
    end
}]