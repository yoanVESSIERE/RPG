Class "EntityScytheBoss" extends "EntityLiving" [{

    local function initHitboxes()
        local box = new(Hitbox("enemy", {takeDamage=true, doDamage=true}))
        box.setPoints({{73, 130}, {164, 52}, {272, 15}, {377, 4}, {537, 22}, {657, 75}, {666, 172}, {632, 196}})
        box.setScale(0.5, 0.5)
        box.setOrigin(264, 565)
        box.setPosition(super.getPosition())
        super.addHitbox(box)
        local box2 = new(Hitbox("enemy", {takeDamage=true}))
        box2.setPoints({{14, 337}, {85, 271}, {445, 280}, {514, 344}, {530, 443}, {264, 609}, {4, 430}})
        box2.setScale(0.5, 0.5)
        box2.setOrigin(264, 565)
        box2.setPosition(super.getPosition())
        super.addHitbox(box2)
    end

    function __EntityScytheBoss(x, y)
        super(x, y)
        super.setMaximumHealth(3000)
        super.setHealth(3000)
        this.sprite = lsfml.sprite.create()
        this.sprite:setPosition(x, y)
        this.sprite:setTexture(assets["scythe"], false)
        this.sprite:setOrigin(264, 565)
        this.sprite:scale(0.5, 0.5)
        this.attack = "idle"
        this.hit_entity = false
        this.revert = false
        this.dir = 0
        this.speed = 2
        this.max_distance = 300
        this.func = 1
        this.cooldown = false
        this.clock = stopwatch.create()
        this.phase = 1
        initHitboxes()
        super.setType("ennemy")
    end


    function hit(damage, source)
        if super.isAlive() and this.attack ~= "asmat_entity" then
            super.hit(damage, source)
            local mx = this.getMaximumHealth()

            if this.getHealth() < mx * 0.15 and this.phase < 5 then
                this.phase = 5
                bosshealth:setPhase(this.phase)
            elseif this.getHealth() < mx * 0.33 and this.phase < 4 then
                this.phase = 4
                bosshealth:setPhase(this.phase)
            elseif this.getHealth() < mx * 0.50 and this.phase < 3 then
                this.phase = 3
                bosshealth:setPhase(this.phase)
            elseif this.getHealth() < mx * 0.75 and this.phase < 2 then
                this.phase = 2
                bosshealth:setPhase(this.phase)
            end
            if super.isDead() then
                for i=1, math.random(1, 4) do
                    world.spawnEntity(new(EntityItem(itemstack.generateEquipment()))).setPosition(super.getPosition())
                end
                world.spawnEntity(new(EntityItem(itemstack.create(items["scythe"], 1)))).setPosition(super.getPosition())
                world.spawnEntity(new(EntityItem(itemstack.create(items["parchemin_5"], 1)))).setPosition(super.getPosition())
                world.removeEntityByUUID(this.getUUID())
            end
        end
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

        local success, nx, ny = super.move(x, y)
        if success then
            this.sprite:move(nx, ny)
        end
    end

    function draw()
        window:draw(this.sprite)
        super.drawHitbox()
    end

    function slash()
        if this.dir == 0 then
            local nx, ny = player.getPosition()
            local px, py = super.getPosition()
            this.dir = nx - px > 0 and 1 or -1
        end
        if this.dir == -1 then
            this.sprite:setScale(-0.5, 0.5)
            super.setScale(-0.5, 0.5)
        else
            this.sprite:setScale(0.5, 0.5)
            super.setScale(0.5, 0.5)
        end
        local angle = super.getRotation()
        if angle % 360 == 180 then
            this.revert = true
        elseif angle % 360 == 0 then
            if this.revert == true then
                this.attack = "idle"
                super.setRotation(0)
                this.sprite:setRotation(0)
                this.revert = false
                this.cooldown = true
                this.clock:restart()
                this.hit_entity = false
                this.dir = 0
                return
            end
        end
        local step = this.dir == 1 and 10 or -10
        if this.revert then
            step = -step
        end
        super.setRotation(angle + step)
        this.sprite:setRotation(angle + step)
        local hit = super.getHitboxs()
        for i=1, #hit do
            local success, dist, axis = hitbox.SAT(hit[i], player.getHitboxs()[1])
            if success then
                local pos = axis * dist
                player.move(pos.x, pos.y)
                if not this.hit_entity then
                    player.hit((this.phase < 4 and 20 or 40) * DeltaTime, final)
                    this.hit_entity = true
                end
                return
            end
        end
    end

    function slash_entity()
        if this.dir == 0 then
            local nx, ny = player.getPosition()
            local px, py = super.getPosition()
            this.dir = nx - px > 0 and 1 or -1
        end
        if this.dir == -1 then
            this.sprite:setScale(-0.5, 0.5)
            super.setScale(-0.5, 0.5)
        else
            this.sprite:setScale(0.5, 0.5)
            super.setScale(0.5, 0.5)
        end
        local angle = super.getRotation()
        if angle % 360 == 180 then
            this.revert = true
        elseif angle % 360 == 0 then
            if this.revert == true then
                this.attack = "idle"
                super.setRotation(0)
                this.sprite:setRotation(0)
                this.revert = false
                this.hit_entity = false
                this.dir = 0
                this.cooldown = true
                this.clock:restart()
                return
            end
        elseif angle % 360 == 90 or angle % 360 == 270 then
            if not this.revert then
                local matrix = super.getHitboxs()[1].getTransform()
                local px, py = matrix(392, 0)
                local pos1 = vector.new(px, py)
                local pos2 = vector.new(player.getPosition())
                local dir = pos2 - pos1
                local damage = 1 + this.getLevel() * 2 / 100
                world.spawnEntity(new(EntitySlash(px, py, dir, (this.phase < 4 and 10 or 20) * damage, 20, final)))
            end
        end
        local step = this.dir == 1 and 10 or -10
        if this.revert then
            step = -step
        end
        super.setRotation(angle + step)
        this.sprite:setRotation(angle + step)
        local hit = super.getHitboxs()
        for i=1, #hit do
            local success, dist, axis = hitbox.SAT(hit[i], player.getHitboxs()[1])
            if success then
                local pos = axis * dist
                player.move(pos.x, pos.y)
                if not this.hit_entity then
                    local damage = 1 + this.getLevel() * 2 / 100
                    player.hit((this.phase < 4 and 20 or 40) * DeltaTime * damage, final)
                    this.hit_entity = true
                end
                return
            end
        end
    end

    function asmat_entity()
        if this.dir == 0 then
            local nx, ny = player.getPosition()
            local px, py = super.getPosition()
            this.dir = nx - px > 0 and 1 or -1
        end
        this.sprite:setScale(0.5, 0.5)
        super.setScale(0.5, 0.5)
        local angle = super.getRotation()
        if not this.revert then
            this.setRotation(angle - 0.5)
            this.sprite:setRotation(angle - 0.5)
            if angle - 0.5 <= -45 then
                this.revert = true
            end
        end
        if this.revert then
            if angle > 360 * 5 then
                this.angle = 0
                this.attack = "idle"
                this.func = this.func + 1
                if this.func > #scythe_func then
                    this.func = 1
                end
                this.cooldown = true
                this.clock:restart()
                super.setRotation(0)
                this.sprite:setRotation(0)
                this.revert = false
                this.hit_entity = false
                this.dir = 0
                return
            end
            local matrix = super.getHitboxs()[1].getTransform()
            local px, py = matrix(392, 0)
            local pos2 = vector.new(px, py)
            local pos1 = vector.new(super.getPosition())
            local dir = pos2 - pos1
            local damage = 1 + this.getLevel() * 2 / 100
            world.spawnEntity(new(EntityVortex(px, py, dir, (this.phase < 4 and 20 or 40) * damage, 5, scythe_func[this.func], final)))
            local step = 15
            super.setRotation(angle + step)
            this.sprite:setRotation(angle + step)
            local hit = super.getHitboxs()
            local success, dist, axis = hitbox.SAT(hit[1], player.getHitboxs()[1])
            if success then
                local pos = axis * dist
                player.move(pos.x, pos.y)
                player.hit((this.phase < 4 and 20 or 40) * DeltaTime, final)
                this.hit_entity = true
                return
            end
        end
    end

    function update()
        super.update()
        if this.attack == "idle" and player.isAlive() then
            local x, y = player.getPosition()
            local sprite_x, sprite_y = super.getPosition()
            local dir_x, dir_y
            local hitbox = super.getHitboxs()
            sprite_y = sprite_y
            dir_x = x - sprite_x
            dir_y = y - sprite_y
            local total = math.sqrt(dir_x^2 + dir_y^2)
            if total > this.max_distance then
                move((dir_x / total) * this.speed, (dir_y / total) * this.speed)
            elseif (total < this.max_distance - this.speed) then
                move((-dir_x / total) * this.speed, (-dir_y / total) * this.speed)
            end
            if not this.cooldown then
                if (total < 400) then
                    this.attack = "slash"
                elseif total > 500 then
                    this.attack = "slash_entity"
                end
                if this.attack ~= "idle" then
                    local chance = (super.getHealth() < super.getMaximumHealth() * 0.5 and 33 or (super.getHealth() < super.getMaximumHealth() * 0.75 and 15 or 0))
                    local rng = math.random(1, 100)
                    if this.attack ~= "idle" and rng < chance then
                        this.attack = "asmat_entity"
                    end
                end
            end
        end
        local delay = 2000000
        if this.phase == 4 then
            delay = 1500000
        elseif this.phase == 5 then
                delay = 1000000
        end
        if this.clock:getEllapsedTime() > delay then
            this.cooldown = false
        end
        if super.isAlive() and not this.cooldown then
            if this.attack == "slash" then
                slash()
            elseif this.attack == "slash_entity" then
                slash_entity()
            elseif this.attack == "asmat_entity" then
                asmat_entity()
            end
        end
    end

    function event(e)

    end
}]