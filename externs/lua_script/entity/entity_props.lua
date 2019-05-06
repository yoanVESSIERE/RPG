Class "EntityProps" extends "Entity" [{

    local function initHitboxes(x_or, y_or, pts, scx)
        local box = new(Hitbox("hard", {takeDamage=false, doDamage=false}))
        box.setPoints(pts)
        box.setScale(scx, scx)
        box.setOrigin(x_or, y_or)
        box.setPosition(super.getPosition())
        super.addHitbox(box)
        hitbox.add(box)
    end

    function __EntityProps(x, y, sprite, x_or, y_or, pts, scx)
        super(x, y)
        this.exist = true
        this.sprite = lsfml.sprite.create()
        this.sprite:setPosition(x, y)
        this.sprite:setTexture(sprite, false)
        this.sprite:setOrigin(x_or, y_or)
        this.sprite:scale(scx, scx)
        initHitboxes(x_or, y_or, pts, scx)
    end

    function move(x, y)
        check(x ,"number", 1)
        check(y ,"number", 2)

        local nx, ny = super.getPosition()
        local success1, point1 = hitbox.rayhit(nx, ny, x * 2, y * 2, "hard")
        if not success1 then
            super.move(x, y)
            return true, x, y
        end
        local dir = new(Vector2D(x, y))
        dir = dir.normalize()
        local px, py = (point1[1] - dir.x) - nx, (point1[2] - dir.y) - ny
        super.move(px, py)
        return true, px, py
    end

    function isExist()
        return this.exist
    end

    function kill()
        this.exist = false
    end

    function draw()
        if this.exist then
            window:draw(this.sprite)
            super.drawHitbox()
        end
    end


    function update()

    end
}]