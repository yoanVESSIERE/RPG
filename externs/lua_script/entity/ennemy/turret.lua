Class "EntityTurret" extends "EntityLiving" [{

    local function initHitboxes()
        local box = new(Hitbox("enemy", {takeDamage=true, doDamage=true}))
        box.setPoints({{24, 24}, {51, 24}, {51, 78}, {24, 78}})
        box.setScale(3, 3)
        box.setOrigin(39, 78)
        box.setPosition(super.getPosition())
        super.addHitbox(box)
    end

    function __EntityTurret(x, y)
        super(x, y)
        super.setHealthBarVisible(true)
        super.setHealthBarOffset(0, - 156)
        super.setMaximumHealth(5)
        super.setHealth(5)
        this.sprite = animation.create(assets["turret"], {0, 0, 78, 78})
        this.sprite:setPosition(x, y)
        this.sprite:setOrigin(39, 78)
        this.sprite:scale(2, 2)

        this.attack = animation.create(assets["laser"], {0, 0, 46, 19})
        this.attack:setOrigin(9, 9)
        this.attack:scale(1, 1)

        this.clock = stopwatch.create()
        this.clock_attack = stopwatch.create()
        this.status = "idle"
        this.speed = 2
        this.max_distance = 750
        this.last_animation = false
        this.is_attack = false
        super.setType("ennemy")
        initHitboxes()
    end

    function getExperience()
        return 10
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

    function laser()
        local x, y = player.getPosition()
        y = y - 62.5
        local px, py = this.attack:getPosition()
        local pos1 = vector.new(px, py)
        local pos2 = vector.new(x, y)
        local dir = pos2 - pos1
        local damage = 1 + this.getLevel() * 2 / 100
        world.spawnEntity(new(EntityLaser(px, py, dir, 1 * damage, 40, final, 1, 1)))
    end

    function draw()
        if super.isAlive() then
            this.sprite:draw()
            super.drawHealth()
            super.drawHitbox()
            super.drawHealth()
            if this.is_attack then
                if this.clock_attack:getEllapsedTime() > 20000 and _G.freeze ~= true then
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
        else
            world.spawnEntity(new(EntityItem(itemstack.create(items.metal_scrap, 5)))).setPosition(super.getPosition())
            world.removeEntityByUUID(this.getUUID())
        end
    end

    function update()
        local x, y = player.getPosition()
        local sprite_x, sprite_y = super.getPosition()
        local dir_x, dir_y
        local hitbox = super.getHitboxs()

        if this.is_attack then
            return
        end
        local dir_x = x - sprite_x
        local dir_y = y - sprite_y
        if math.abs(dir_x) > math.abs(dir_y) then
            if dir_x > 0 and this.status ~= "right" then
                this.status = "right"
                this.sprite:changeRect({0, 156, 78, 78})
            elseif dir_x < 0 and this.status ~= "left" then
                this.status = "left"
                this.sprite:changeRect({0, 234, 78, 78})
            end
        else
            if dir_y > 0 and this.status ~= "down" then
                this.status = "down"
                this.sprite:changeRect({0, 0, 78, 78})
            elseif dir_y < 0 and this.status ~= "up" then
                this.status = "up"
                this.sprite:changeRect({0, 78, 78, 78})
            end
        end
        local total = math.abs(dir_x) + math.abs(dir_y)
        if total < this.max_distance + 250 then
            this.sprite:setAnimationFrame(1)
        else
            this.sprite:setAnimationFrame(2)
        end
        if not this.is_attack and total < this.max_distance then
            this.clock_attack:restart()
            this.is_attack = true
            if this.status == "down" then
                this.attack:setPosition(sprite_x, sprite_y - 80)
                this.attack:setRotation(90)
            elseif this.status == "up" then
                this.attack:setPosition(sprite_x + 3, sprite_y - 130)
                this.attack:setRotation(-90)
            elseif this.status == "right" then
                this.attack:setPosition(sprite_x + 30, sprite_y - 90)
                this.attack:setRotation(0)
            elseif this.status == "left" then
                this.attack:setPosition(sprite_x - 30, sprite_y - 90)
                this.attack:setRotation(180)
            end
        end
    end 

    function event(e)

    end

}]