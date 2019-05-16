Class "EntityRobot3" extends "EntityLiving" [{

    local function initHitboxes()
        local box = new(Hitbox("enemy", {takeDamage=true, doDamage=true}))
        box.setPoints({{163, 20}, {743, 20}, {743, 831}, {163, 831}})
        box.setScale(0.20, 0.20)
        box.setOrigin(451, 875)
        box.setPosition(super.getPosition())
        super.addHitbox(box)
    end

    function __EntityRobot3(x, y)
        super(x, y)
        super.setHealthBarVisible(true)
        super.setHealthBarOffset(0, -875 * 0.25)
        super.setMaximumHealth(200)
        super.setHealth(200)
        this.sprite = animation.create(assets["robot3"], {0, 0, 73, 63})
        this.sprite:setPosition(x, y)
        this.sprite:setOrigin(32.5, 64)
        this.sprite:scale(3, 3)

        this.clock = stopwatch.create()
        this.clock_attack = stopwatch.create()
        this.status = "right"
        this.speed = 2
        this.max_distance = 110
        this.last_animation = false
        this.is_attack = false
        super.setType("ennemy")
        initHitboxes()
    end

    function getExperience()
        return 100 * this.getLevel()
    end

    function hit(damage, source)
        super.hit(damage, source)
        if this.isDead() then
            if math.random(0, 100) < 25 then
                for i=1, math.random(1, 2) do
                    world.spawnEntity(new(EntityItem(itemstack.generateEquipment()))).setPosition(super.getPosition())
                end
            end
            world.spawnEntity(new(EntityItem(itemstack.create(items.metal_scrap, 5)))).setPosition(super.getPosition())
            world.removeEntityByUUID(this.getUUID())
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
        if super.isAlive() then
            if this.clock:getEllapsedTime() > 200000 and _G.freeze ~= true then
                this.clock:restart()
                this.sprite:next()
                if this.sprite:hasEnded() then
                    this.sprite:restart()
                end
            end
            this.sprite:draw()
            super.drawHitbox()
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
        local dir_x = x - sprite_x
        local dir_y = y - sprite_y
        if math.abs(dir_x) > math.abs(dir_y) then
            if dir_x > 0 and this.status ~= "right" then
                this.status = "right"
                this.sprite:changeRect({0, 128, 73, 64})
            elseif dir_x < 0 and this.status ~= "left" then
                this.status = "left"
                this.sprite:changeRect({0, 64, 73, 64})
            end
        else
            if dir_y > 0 and this.status ~= "down" then
                this.status = "down"
                this.sprite:changeRect({0, 0, 73, 64})
            elseif dir_y < 0 and this.status ~= "up" then
                this.status = "up"
                this.sprite:changeRect({0, 192, 73, 64})
            end
        end
        local total = math.abs(dir_x) + math.abs(dir_y)
        if total > this.max_distance then
            move((dir_x / total) * this.speed, (dir_y / total) * this.speed)
        elseif this.clock_attack:getEllapsedTime() > 1000000 then
            player.hit(30 * (1 + this.getLevel() * 2 / 100) * DeltaTime, final)
            this.clock_attack:restart()
        end
    end 

    function event(e)

    end

}]