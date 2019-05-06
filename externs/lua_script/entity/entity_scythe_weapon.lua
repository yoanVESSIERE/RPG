Class "EntityScytheWeapon" extends "Entity" [{

    local function initHitboxes()
        local box = new(Hitbox("scythe"))
        box.setPoints({{73, 130}, {164, 52}, {272, 15}, {377, 4}, {537, 22}, {657, 75}, {666, 172}, {632, 196}})
        box.setScale(0.25, 0.25)
        box.setOrigin(264, 565)
        box.setPosition(super.getPosition())
        super.addHitbox(box)
        local box2 = new(Hitbox("scythe"))
        box2.setPoints({{14, 337}, {85, 271}, {445, 280}, {514, 344}, {530, 443}, {264, 609}, {4, 430}})
        box2.setScale(0.25, 0.25)
        box2.setOrigin(264, 565)
        box2.setPosition(super.getPosition())
        super.addHitbox(box2)
    end

    function __EntityScytheWeapon(x, y)
        super(x, y)
        this.sprite = lsfml.sprite.create()
        this.sprite:setPosition(x, y)
        this.sprite:setTexture(assets["scythe"], false)
        this.sprite:setOrigin(264, 565)
        this.sprite:scale(0.25, 0.25)
        this.hit_entity = {}
        this.speed = 20
        this.clock = stopwatch.create()
        this.angle = 0
        this.revert = false
        initHitboxes()
    end

    function setPosition(x, y)
        check(x ,"number", 1)
        check(y ,"number", 2)

        super.setPosition(x, y)
        this.sprite:setPosition(x, y)
    end

    function move(x, y)
        check(x ,"number", 1)
        check(y ,"number", 2)

        super.move(x, y)
        this.sprite:move(x, y)
    end

    function draw()
        window:draw(this.sprite)
        super.drawHitbox()
    end

    function isRevert()
        return this.revert
    end

    function getSpeed()
        return this.speed
    end

    function update()
        super.update()
        this.angle = this.angle + 15
        this.setRotation(this.angle)
        this.sprite:setRotation(this.angle)
        local nx, ny = super.getPosition()
        local px, py = 0, 0
        if this.revert then
            px, py = player.getPosition()
        else
            px, py = lsfml.mouse.getPosition(window)
        end
        local dir = vector.new(px - nx, py - ny):normalize()
        local dist = math.abs(px - nx) + math.abs(py - ny)
        if dist > this.speed then
            this.move(dir.x * this.speed, dir.y * this.speed)
        end
        local entities = world.getEntitiesInHitbox(this.getHitboxs()[1], "enemy")
        for i=1, #entities do
            if not this.hit_entity[entities[i].getUUID()] then
                entities[i].hit(80 * player.getAttack() * DeltaTime, player)
                this.hit_entity[entities[i].getUUID()] = true
            end
        end
        entities = world.getEntitiesInHitbox(this.getHitboxs()[2], "enemy")
        for i=1, #entities do
            if not this.hit_entity[entities[i].getUUID()] then
                entities[i].hit(80 * player.getAttack() * DeltaTime, player)
                this.hit_entity[entities[i].getUUID()] = true
            end
        end
        if this.clock:getEllapsedTime() > 2000000 and not this.revert then
            this.revert = true
            this.hit_entity = nil
            this.hit_entity = {}
        end
    end

    function event(e)
        local event = e:getEvent()
        if event[1] == "key_pressed" and event[2] == keys.L then
            this.attack = "asmat_entity"
        end
    end
}]