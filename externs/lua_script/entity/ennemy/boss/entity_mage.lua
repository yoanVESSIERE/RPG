Class "EntityMageBoss" extends "EntityLiving" [{

    local function initHitboxes()
        local box = new(Hitbox("enemy"))
        box.setPoints({{0, 0}, {96, 0}, {96, 180}, {0, 180}})
        box.setPosition(super.getPosition())
        box.setOrigin(45, 192)
        super.addHitbox(box)
    end

    function __EntityMageBoss(x, y, clone)
        super(x, y)
        initHitboxes()
        if clone then
            super.setMaximumHealth(15)
            super.setHealth(15)
            this.mx = 15
        else
            super.setMaximumHealth(10000)
            super.setHealth(10000)
            this.mx = 10000
        end
        this.clone = clone
        this.sprite = animation.create(assets["mage"], {0, 0, 96, 180})
        this.sprite:setOrigin(45, 192)
        this.sprite:setPosition(x, y)
        this.anim = stopwatch.create()
        this.tp_attack = stopwatch.create()
        this.rayon_attack = stopwatch.create()
        this.wait = stopwatch.create()
        this.in_wait = false
        this.scale = 1
        this.form = 0
        this.phase = 1
        this.action = {act = "none", atk = "none"}
        this.rayon = {}
        super.setType("ennemy")
    end

    function look(px, py)
        check(px, "number", 1)
        check(py, "number", 2)

        local nx, ny = super.getPosition()
        local dir = vector.new(nx - px, ny - py):normalize()
        local angle = math.deg(math.atan2(0, 1) - math.atan2(dir.y, dir.x))
        if angle > -45 and angle < 45 then
            this.sprite:changeRect({0, 445, 96, 180})
        elseif angle > 45 and angle < 135 then
            this.sprite:changeRect({0, 222, 96, 180})
        elseif angle % 360 > 135 and angle % 360 < 225 then
            this.sprite:changeRect({0, 666, 96, 180})
        elseif angle % 360 > 225 and angle % 360 < 315 then
            this.sprite:changeRect({0, 0, 96, 180})
        end
    end


    function hit(damage, source)
        if super.isAlive() then
            super.hit(damage, source)
            local mx = this.getMaximumHealth()

            if not this.clone then
                if this.getHealth() < mx * 0.10 and this.phase < 7 then
                    this.phase = 7
                    bosshealth:setPhase(this.phase)
                elseif this.getHealth() < mx * 0.25 and this.phase < 6 then
                    this.phase = 6
                    bosshealth:setPhase(this.phase)
                elseif this.getHealth() < mx * 0.40 and this.phase < 5 then
                    this.phase = 5
                    bosshealth:setPhase(this.phase)
                elseif this.getHealth() < mx * 0.55 and this.phase < 4 then
                    this.phase = 4
                    bosshealth:setPhase(this.phase)
                elseif this.getHealth() < mx * 0.70 and this.phase < 3 then
                    this.phase = 3
                    bosshealth:setPhase(this.phase)
                elseif this.getHealth() < mx * 0.85 and this.phase < 2 then
                    this.phase = 2
                    bosshealth:setPhase(this.phase)
                end
            end
            if super.isDead() then
                -- for i=1, math.random(1, 4) do
                --     world.spawnEntity(new(EntityItem(itemstack.generateEquipment()))).setPosition(super.getPosition())
                -- end
                -- world.spawnEntity(new(EntityItem(itemstack.create(items["scythe"], 1)))).setPosition(super.getPosition())
                world.removeEntityByUUID(this.getUUID())
            end
        end
    end

    function teleport(x, y)
        check(x, "number", 1)
        check(y, "number", 2)

        if this.action.act == "none" then
            this.action.act = "teleport"
            this.action.tp_x = x
            this.action.tp_y = y
            this.action.tp_revert = false
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
        if this.isAlive() then
            if this.sprite:hasEnded() then
                this.sprite:restart()
            end
            this.sprite:draw()
            if this.anim:getEllapsedTime() > 100000 then
                this.sprite:next()
                this.anim:restart()
            end
            super.drawHitbox()
        end
    end

    function blackHole()
        if not this.clone then
            this.action.act = "teleport"
            this.action.tp_x = 1920 / 2
            this.action.tp_y = 1080 / 2
            this.action.blackhole = true
        end
    end

    function missile()
        if this.action.act == "none" then
            this.action.act = "missile"
        end
    end

    local function doTeleport()
        if this.action.act == "teleport" then
            if not this.action.tp_revert then
                this.scale = math.max(this.scale - 0.1, 0)
            else
                this.scale = math.min(this.scale + 0.1, 1)
            end
            this.sprite:setScale(this.scale, 1)
            if this.scale <= 0 and not this.action.tp_revert then
                this.setPosition(this.action.tp_x, this.action.tp_y)
                this.action.tp_revert = true
            elseif this.action.tp_revert and this.scale >= 1 then
                this.action.act = "none"
                this.action.tp_revert = false
            end
        end
    end

    function KageBunshin()
        if this.action.act == "none" and not this.clone then
            this.action.act = "KageBunshin"
        end
    end

    local function doKageBunshin()
        if this.action.act == "KageBunshin" and not this.clone then
            local nx, ny = super.getPosition()
            world.spawnEntity(new(EntityMageBoss(nx, ny, true))).teleport(math.random(200, 1800), math.random(300, 800))
            world.spawnEntity(new(EntityMageBoss(nx, ny, true))).teleport(math.random(200, 1800), math.random(300, 800))
            this.action.act = "none"
            this.teleport(math.random(200, 1800), math.random(300, 800))
        end
    end

    local function doBlackHole()
        if this.action.blackhole and not this.clone then
            if this.action.act == "none" then
                this.action.act = "blackhole"
                this.action.blackhole_entity = world.spawnEntity(new(EntityBlackHole(0.5* DeltaTime, math.max(5 * this.phase, 15), final)))
            end
            if this.action.act == "blackhole" then
                if this.action.blackhole_entity.asExpired() then
                    this.action.act = "none"
                    this.action.blackhole = false
                end
            end
        end
    end

    local function doTpAttack()
        if this.action.atk == "tpAttack" then
            if this.tp_attack:getEllapsedTime() > 5000000 then
                this.action.atk = "none"
                return
            end
            if this.action.act == "none" then
                local x, y = player.getPosition()
                y = y - 62.5
                local px, py = super.getPosition()
                local pos1 = vector.new(px, py)
                local pos2 = vector.new(x, y)
                local dir = pos2 - pos1
                world.spawnEntity(new(EntityBouleMagie(px, py, dir, 5, 20, final)))
                teleport(math.random(200, 1800), math.random(200, 800))
            end
        end
    end

    function laserForm()
        if this.action.act == "none" then
            this.action.act = "laser_form"
        end
    end

    function doLaserForm()
        if this.action.act == "laser_form" then
            for i=1, #mage_points[this.form + 1] do
                local data = mage_points[this.form + 1][i]
                world.spawnEntity(new(EntityLaserBeam(data[1], data[2], vector.new(data[3], data[4]), 1 * DeltaTime * this.phase, 2, data[5], data[6], data[7], final)))
            end
            this.form = (this.form + 1) % (math.min(#mage_points, this.phase))
            this.action.act = "none"
        end
    end

    local function doMissile()
        if this.action.act == "missile" then
            local nx, ny = super.getPosition()
            for i=1, this.phase * 2 do
                world.spawnEntity(new(EntityVortexMissile(math.random(1, 100) - 50 + nx, math.random(1, 100) - 50 + ny, 5 + this.phase * 2, 15 - this.phase, final)))
            end
            this.action.act = "none"
        end
    end

    function tpAttack()
        this.action.atk = "tpAttack"
        this.tp_attack:restart()
    end

    local function doLaser()
        if this.action.act == "laser" then
            if this.rayon_attack:getEllapsedTime() > 7000000 then
                this.action.act = "none"
                this.rayon_attack:restart()
                for i = 1, #this.rayon do
                    world.removeEntityByUUID(this.rayon[i]:getUUID())
                end
            end
        end
    end

    function laser()
        this.action.act = "laser"
        this.rayon_attack:restart()
        local x, y = super.getPosition()
        for i = 1, this.phase do
            this.rayon[i] = world.spawnEntity(new(EntityRayon(x, y - 90 , (360/this.phase) * i, 1 * DeltaTime * this.phase, final)))
        end
    end

    local funct_atk = {this.blackHole, this.tpAttack, this.laser, this.KageBunshin, this.missile, this.laserForm}
    function update()
        if this.isAlive() then
            super.update()
            this.look(player.getPosition())
            doTeleport()
            doBlackHole()
            doKageBunshin()
            doMissile()
            doLaserForm()
            doTpAttack()
            doLaser()
            if this.action.act == "none" and this.action.atk == "none" then
                if not this.in_wait then
                    this.wait:restart()
                    this.in_wait = true
                end
                if this.wait:getEllapsedTime() > 1500000 then
                    funct_atk[math.random(1, #funct_atk)]()
                    this.in_wait = false
                end
            end
        end
    end

    function event(e)

    end
}]