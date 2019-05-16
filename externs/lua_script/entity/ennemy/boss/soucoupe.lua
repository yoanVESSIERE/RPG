Class "EntitySoucoupe" extends "EntityLiving" [{

    local function initHitboxes()
        local box = new(Hitbox("enemy", {takeDamage=true, doDamage=true}))
        box.setPoints({{126, 0}, {251, 50}, {126, 88}, {2, 50}})
        box.setScale(2, 2)
        box.setOrigin(124, 86)
        box.setPosition(super.getPosition())
        super.addHitbox(box)
    end

    function __EntitySoucoupe(x, y)
        super(x, y)
        super.setMaximumHealth(1000)
        super.setHealth(1000)
        this.sprite = animation.create(assets["soucoupe"], {0, 0, 249, 86})
        this.sprite:setPosition(x, y)
        this.sprite:setOrigin(124, 86)
        this.sprite:scale(2, 2)

        this.box_verify = new(Hitbox("soft", {takeDamage=false, doDamage=true}))
        this.box_verify.setPoints({{91, 77}, {167, 77}, {167, 121}, {91, 121}})
        this.box_verify.setScale(2, 2)
        this.box_verify.setOrigin(124, 86)
        this.box_verify.setPosition(super.getPosition())

        this.clock = stopwatch.create()
        this.clock_move = stopwatch.create()
        this.big_attack = false
        this.clock_big_attack = stopwatch.create()
        this.clock_attack = stopwatch.create()
        this.speed = 35
        this.selectioned_move = 1
        this.move_x = 0
        this.move_y = 0
        this.dir_x = 0
        this.dir_y = 0
        this.time = 3000000
        this.selected_time_attack = 0
        this.nb_laser = 0
        this.safe = 0
        this.safe2 = 180
        this.spawn = true
        initHitboxes()
        super.setType("ennemy")
    end

    function getExperience()
        return 500
    end

    function setPosition(x, y)
        check(x ,"number", 1)
        check(y ,"number", 2)

        super.setPosition(x, y)
        this.sprite:setPosition(x, y)
    end

    function move(x, y)

    end

    function move_s(x, y)
        check(x ,"number", 1)
        check(y ,"number", 2)

        local success, nx, ny = super.move(x, y)
        if success then
            this.sprite:move(nx, ny)
            this.box_verify.move(x, y)
        end
    end

    function laser(x, y)
        local px, py = super.getPosition()
        py = py - 86
        local pos2 = vector.new(x, y)
        world.spawnEntity(new(EntityLaser(px, py, pos2, 5, 20, final)))
    end

    function hit(damage, source)
        if super.isAlive() then
            super.hit(damage, source)
            if super.isDead() then
                for i=1, math.random(1, 4) do
                    world.spawnEntity(new(EntityItem(itemstack.generateEquipment()))).setPosition(super.getPosition())
                end
                if not player:getInventory():hasItemInInventory("parchemin_5") then
                    world.spawnEntity(new(EntityItem(itemstack.create(items["parchemin_5"], 1)))).setPosition(super.getPosition())
                end
                world.removeEntityByUUID(this.getUUID())
            end
        end
    end

    function laser_to_coord(x, y)
        local px, py = super.getPosition()
        py = py - 150
        local pos1 = vector.new(px, py)
        local pos2 = vector.new(x, y)
        local dir = pos2 - pos1
        world.spawnEntity(new(EntityLaser(px, py, dir, 8, 15, final)))
    end

    function draw()
        if super.isAlive() then
            if this.clock:getEllapsedTime() > 100000 then
                this.clock:restart()
                this.sprite:next()
                if this.sprite:hasEnded() then
                    this.sprite:restart()
                end
            end
            this.sprite:draw()
            super.drawHitbox()
            super.drawHealth()
        end
    end

    function update()
        local x_player, y_player = player.getPosition()
        local sprite_x, sprite_y = super.getPosition()

        if player:isDead() then
            return
        end
        if super.getHealth() > 0.66 * super.getMaximumHealth() then
            this.time = 3000000
            this.sprite:changeRect({0, 0, 249, 86})
        elseif super.getHealth() > 0.33 * super.getMaximumHealth() and super.getHealth() < 0.66 * super.getMaximumHealth() then
            this.sprite:changeRect({0, 86, 249, 86})
            this.time = 2500000
        elseif super.getHealth() < 0.33 * super.getMaximumHealth() then
            this.time = 2000000
            this.sprite:changeRect({0, 172, 249, 86})
        end
        if this.big_attack and sprite_y < 320 then
            this.time = 10000
            if this.selected_time_attack == 1 and this.clock_attack:getEllapsedTime() > 25000 then
                laser_to_coord(960, 540)
                this.clock_attack:restart()
            elseif this.clock_attack:getEllapsedTime() > 25000 and this.selected_time_attack == 2 then
                laser_to_coord(sprite_x, sprite_y + 10)
                this.clock_attack:restart()
            elseif this.clock_attack:getEllapsedTime() > 25000 and this.selected_time_attack == 3 then
                laser_to_coord(0, sprite_x - 150)
                laser_to_coord(1920, sprite_x - 150)
                this.clock_attack:restart()
            elseif this.clock_attack:getEllapsedTime() > 25000 and this.selected_time_attack == 4 then
                laser_to_coord(1920, sprite_x - 150)
                laser_to_coord(0, sprite_x - 150)
                if not(this.move_x > 500 and sprite_x < 1200 and sprite_x > 1000) and not(this.move_x < 500 and sprite_x < 1000 and sprite_x > 800) then
                    laser_to_coord(sprite_x, sprite_y + 10)
                end
                this.clock_attack:restart()
            end
            if this.clock_big_attack:getEllapsedTime() > 5000000 then
                this.big_attack = false
            end
        elseif this.big_attack and sprite_y > 320 then
            this.clock_big_attack:restart()
        end
        if (this.move_x > sprite_x -  this.speed and this.move_x < sprite_x + this.speed and this.move_y > sprite_y -  this.speed and this.move_y < sprite_y +  this.speed) or (this.move_x == 0 and this.move_y == 0) then
            if (this.dir_x ~= 0 and this.dir_y ~= 0) then
                this.dir_x = 0
                this.dir_y = 0
                this.clock_move:restart()
                if math.random(1, 5) == 3 and not this.big_attack then
                    this.box_verify.recompute()
                    local entities = world.getEntitiesInHitbox(this.box_verify, "enemy")
                    if #entities < 2 then
                        world.spawnEntity(new(EntityTurret(sprite_x, sprite_y + 100)))
                        assets["soucoupe_turret"]:play()
                    end
                elseif super.getHealth() < 0.66 * super.getMaximumHealth() and math.random(1, 5) == 3 and not this.big_attack then
                    this.big_attack = true
                    this.clock_big_attack:restart()
                    this.clock_attack:restart()
                    this.nb_laser = 0
                    this.selectioned_move = 1
                    this.selected_time_attack = this.selected_time_attack + 1
                    if this.selected_time_attack > 4 then
                        this.selected_time_attack = 1
                    end
                    return
                elseif not this.big_attack then
                    for angle = 1, 360, 2 do
                        if not(angle > this.safe and angle < this.safe + 15) and not(angle > this.safe2 and angle < this.safe2 + 15) then
                            laser(math.cos(math.rad(angle)), math.sin(math.rad(angle)))
                        end
                    end
                    this.safe2 = this.safe2 + 30
                    this.safe = this.safe + 30
                    if this.safe > 360 then
                        this.safe = 0
                    end
                    if this.safe2 > 360 then
                        this.safe2 = 0
                    end
                end
            end
            if (this.clock_move:getEllapsedTime() > this.time or this.spawn) then
                local res_x, res_y
                this.spawn = false
                if not this.big_attack then
                    res_x, res_y = soucoupe_func[math.random(1, #soucoupe_func)]()
                    while this.move_x == res_x and res_y == this.move_y do
                        res_x, res_y = soucoupe_func[math.random(1, #soucoupe_func)]()
                    end
                else
                    res_x, res_y = soucoupe_func[this.selectioned_move]()
                    if this.selectioned_move == 4 then
                        this.selectioned_move = 1
                    else
                        this.selectioned_move = 4
                    end
                end
                this.move_x = res_x
                this.move_y = res_y
                this.dir_x = this.move_x - sprite_x
                this.dir_y = this.move_y - sprite_y
                local total = math.abs(this.dir_x) + math.abs(this.dir_y)
                this.dir_x = (this.dir_x / total) * this.speed
                this.dir_y = (this.dir_y / total) * this.speed
            end
        end
        move_s(this.dir_x, this.dir_y)
    end

    function event(e)

    end

}]