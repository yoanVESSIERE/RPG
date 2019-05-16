Class "EntityRobot2" extends "EntityLiving" [{

    local function initHitboxes()
        local box = new(Hitbox("enemy", {takeDamage=true, doDamage=true}))
        box.setPoints({{163, 20}, {743, 20}, {743, 831}, {163, 831}})
        box.setScale(0.20, 0.20)
        box.setOrigin(451, 875)
        box.setPosition(super.getPosition())
        super.addHitbox(box)
    end

    function __EntityRobot2(x, y)
        super(x, y)
        super.setHealthBarVisible(true)
        super.setHealthBarOffset(0, -875 * 0.25)
        super.setMaximumHealth(100)
        super.setHealth(100)
        this.sprite = animation.create(assets["robot2"], {0, 0, 902, 875})
        this.sprite:setPosition(x, y)
        this.sprite:setOrigin(451, 875)
        this.sprite:scale(0.20, 0.20)
        this.sounds, this.sound_id = soundmanager.add("robot2", assets["robot2_sound"])
        this.sounds:setVolume(30)
        this.sounds:setLoop(true)
        this.sounds:play()
        this.attack = animation.create(assets["laser"], {0, 0, 46, 19})
        this.attack:setOrigin(9, 9)
        this.attack:scale(3, 3)

        this.clock = stopwatch.create()
        this.clock_attack = stopwatch.create()
        this.status = "idle"
        this.speed = 1.2
        this.max_distance = 110
        this.last_animation = false
        this.is_attack = false
        super.setType("ennemy")
        initHitboxes()
    end

    function getExperience()
        return 50 * this.getLevel()
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

    function hit(damage, source)
        super.hit(damage, source)
        if this.isDead() then
            if math.random(0, 100) < 20 then
                for i=1, math.random(1, 2) do
                    world.spawnEntity(new(EntityItem(itemstack.generateEquipment()))).setPosition(super.getPosition())
                end
            end
            world.spawnEntity(new(EntityItem(itemstack.create(items.metal_scrap, 5)))).setPosition(super.getPosition())
            world.removeEntityByUUID(this.getUUID())
            this.sounds:setLoop(false)
            this.sounds:stop()
            soundmanager.remove(this.sound_id, "robot2")
        end
    end

    function laser()
        local x, y = player.getPosition()
        y = y - 62.5
        local px, py = this.attack:getPosition()
        local pos1 = vector.new(px, py)
        local pos2 = vector.new(x, y)
        local dir = pos2 - pos1
        local damage = 1 + this.getLevel() * 2 / 100
        world.spawnEntity(new(EntityLaser(px, py, dir, 5 * damage, 20, final)))
    end

    function draw()
        if super.isAlive() then
            if this.clock:getEllapsedTime() > 100000 and _G.freeze ~= true then
                this.clock:restart()
                this.sprite:next()
                if this.sprite:hasEnded() then
                    this.sprite:restart()
                end
            end
            this.sprite:draw()
            super.drawHitbox()
            super.drawHealth()

            if this.is_attack then
                if this.clock_attack:getEllapsedTime() > 80000 and _G.freeze ~= true then
                    this.clock_attack:restart()
                    this.attack:next()
                    if this.attack:hasEnded() then
                        this.attack:restart()
                        this.is_attack = false
                        laser()
                    end
                end
                this.attack:draw()
            end

        elseif not this.last_animation then
            assets["robot2_sound"]:setLoop(false)
            this.sprite:changeRect({0, 3756, 520, 470})
            this.last_animation = true
            this.clock:restart()
        end
        if this.last_animation then
            if this.clock:getEllapsedTime() > 80000 then
                this.clock:restart()
                this.sprite:next()
            end
            assets["robot2_sound"]:setLoop(false)
            assets["robot2_sound"]:setVolume(0)
            this.sprite:draw()
            super.drawHitbox()
            super.drawHealth()
        end
        super.drawHealth()
    end

    function update()
        local x, y = player.getPosition()
        local sprite_x, sprite_y = super.getPosition()
        local dir_x, dir_y
        local hitbox = super.getHitboxs()

        if not player.isAlive() then
            return
        end
        if this.is_attack then
            this.attack:setPosition(sprite_x, sprite_y - 190)
        end
        local dir_x = x - sprite_x
        local dir_y = y - sprite_y
        if math.abs(dir_x) > math.abs(dir_y) then
            if dir_x > 0 and this.status ~= "right" then
                this.status = "right"
                this.sprite:changeRect({0, 875, 902, 875})
            elseif dir_x < 0 and this.status ~= "left" then
                this.status = "left"
                this.sprite:changeRect({0, 0, 902, 875})
            end
        else
            if dir_y > 0 and this.status ~= "down" then
                this.status = "down"
                this.sprite:changeRect({0, 1800, 902, 875})
            elseif dir_y < 0 and this.status ~= "up" then
                this.status = "up"
                this.sprite:changeRect({0, 2700, 902, 875})
            end
        end
        local total = math.abs(dir_x) + math.abs(dir_y)
        if total > this.max_distance then
            move((dir_x / total) * this.speed, (dir_y / total) * this.speed)
        elseif (total < this.max_distance - this.speed) then
            move((-dir_x / total) * this.speed, (-dir_y / total) * this.speed)
        end
        if not this.is_attack and total < this.max_distance + 400 and total > this.max_distance - 20 then
            this.clock_attack:restart()
            this.is_attack = true
            if this.status == "down" then
                this.attack:setRotation(90)
            elseif this.status == "up" then
                this.attack:setRotation(-90)
            elseif this.status == "right" then
                this.attack:setRotation(0)
            elseif this.status == "left" then
                this.attack:setRotation(180)
            end
        end
    end 

    function event(e)

    end

}]