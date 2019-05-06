Class "EntityRobot1" extends "EntityLiving" [{

    local function initHitboxes()
        local box = new(Hitbox("enemy", {takeDamage=true, doDamage=true}))
        box.setPoints({{0, 0}, {540, 0}, {540, 460}, {0, 460}})
        box.setScale(0.25, 0.25)
        box.setOrigin(270, 462)
        box.setPosition(super.getPosition())
        super.addHitbox(box)
    end

    function __EntityRobot1(x, y)
        super(x, y)
        super.setHealthBarVisible(true)
        super.setHealthBarOffset(0, -464 * 0.25)
        super.setMaximumHealth(100)
        super.setHealth(100)
        this.sprite = animation.create(assets["robot1"], {0, 0, 540, 462})
        this.sprite:setPosition(x, y)
        this.sprite:setOrigin(270, 462)
        this.sprite:scale(0.25, 0.25)
        assets["robot1_sound"]:setVolume(30)
        assets["robot1_sound"]:setLoop(true)
        assets["robot1_sound"]:play()
        this.attack = animation.create(assets["laser"], {0, 0, 46, 19})
        this.attack:setOrigin(9, 9)
        this.attack:scale(3, 3)

        this.clock = stopwatch.create()
        this.clock_attack = stopwatch.create()
        this.status = "right"
        this.speed = 2
        this.max_distance = 500
        this.last_animation = false
        this.is_attack = false
        super.setType("ennemy")
        initHitboxes()
    end

    function setPosition(x, y)
        check(x ,"number", 1)
        check(y ,"number", 2)

        super.setPosition(x, y)
        this.sprite:setPosition(x, y)
    end

    function getExperience()
        return 25
    end

    function move(x, y)
        check(x ,"number", 1)
        check(y ,"number", 2)

        local success, nx, ny = super.move(x, y)
        if success then
            this.sprite:move(nx, ny)
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
                if this.sprite:getAnimationFrame() == 4 then
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
            this.sprite:changeRect({0, 2000, 455, 455})
            this.last_animation = true
            this.clock:restart()
        end
        if this.last_animation then
            assets["robot1_sound"]:setLoop(false)
            assets["robot1_sound"]:setVolume(0)
            if this.clock:getEllapsedTime() > 10000 then
                this.clock:restart()
                this.sprite:next()
                if this.sprite:hasEnded() then
                    if math.random(0, 100) < 10 then
                        for i=1, math.random(1, 2) do
                            world.spawnEntity(new(EntityItem(itemstack.generateEquipment()))).setPosition(super.getPosition())
                        end
                    end
                    world.spawnEntity(new(EntityItem(itemstack.create(items.metal_scrap, 5)))).setPosition(super.getPosition())
                    world.removeEntityByUUID(this.getUUID())
                end
            end
            this.sprite:draw()
            super.drawHitbox()
            super.drawHealth()
        end
    end

    function update()
        local x, y = player.getPosition()
        local sprite_x, sprite_y = super.getPosition()
        local dir_x, dir_y
        local hitbox = super.getHitboxs()

        if this.is_attack or not player.isAlive() then
            return
        end
        local dir_x = x - sprite_x
        local dir_y = y - sprite_y
        if math.abs(dir_x) > math.abs(dir_y) then
            if dir_x > 0 and this.status ~= "right" then
                this.status = "right"
                this.sprite:changeRect({0, 0, 540, 462})
                this.sprite:setOrigin(270, 462)
                hitbox[1].setScale(0.25, 0.25)
                hitbox[1].setOrigin(270, 462)
            elseif dir_x < 0 and this.status ~= "left" then
                this.status = "left"
                this.sprite:changeRect({0, 462, 540, 462})
                this.sprite:setOrigin(270, 462)
                hitbox[1].setScale(0.25, 0.25)
                hitbox[1].setOrigin(270, 462)
            end
        else
            if dir_y > 0 and this.status ~= "down" then
                this.status = "down"
                this.sprite:changeRect({0, 1460, 341, 540})
                this.sprite:setOrigin(170, 540)
                hitbox[1].setScale(0.17, 0.30)
                hitbox[1].setOrigin(270, 440)
            elseif dir_y < 0 and this.status ~= "up" then
                this.status = "up"
                this.sprite:changeRect({0, 920, 341, 540})
                this.sprite:setOrigin(170, 540)
                hitbox[1].setScale(0.17, 0.30)
                hitbox[1].setOrigin(270, 440)
            end
        end
        local total = math.abs(dir_x) + math.abs(dir_y)
        if total > this.max_distance then
            move((dir_x / total) * this.speed, (dir_y / total) * this.speed)
        elseif (total < this.max_distance - this.speed) then
            move((-dir_x / total) * this.speed, (-dir_y / total) * this.speed)
        end
        if not this.is_attack and total < this.max_distance + 300 and total > this.max_distance - 20 then
            this.clock_attack:restart()
            this.is_attack = true
            if this.status == "down" then
                this.attack:setPosition(sprite_x - 3, sprite_y - 60)
                this.attack:setRotation(90)
            elseif this.status == "up" then
                this.attack:setPosition(sprite_x + 3, sprite_y - 150)
                this.attack:setRotation(-90)
            elseif this.status == "right" then
                this.attack:setPosition(sprite_x + 45, sprite_y - 65)
                this.attack:setRotation(0)
            elseif this.status == "left" then
                this.attack:setPosition(sprite_x - 45, sprite_y - 70)
                this.attack:setRotation(180)
            end
        end
    end 

    function event(e)

    end

}]