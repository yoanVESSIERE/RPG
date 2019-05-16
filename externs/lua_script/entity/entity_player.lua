-- =========================================
-- =             ENTITY PLAYER             =
-- =========================================

Class "EntityPlayer" extends "EntityLiving" [{
    function __EntityPlayer(info)
        check(info, "table", 1)

        super(info.pos_x or 0, info.pos_y or 0)

        super.setHealthBarVisible(true)
        super.setHealthBarOffset(0, -500 * 0.25)
        this.sprite = lsfml.sprite.create()
        this.sprite:setTexture(info.texture, false)
        this.sprite:setPosition(info.pos_x or 0, info.pos_y or 0)
        this.sprite:setScale(0.25, 0.25)
        this.sprite:setOrigin(220 / 2, 500)
        this.sprite:setTextureRect(0, 2000, 220, 500)
        this.clock = stopwatch.create()
        this.scythe = lsfml.sprite.create()
        this.scythe:setPosition(super.getPosition())
        this.scythe:setTexture(assets["scythe"], false)
        this.scythe:setOrigin(264, 565)
        this.scythe:setScale(0.25, 0.25)
        this.pos_rect = {4, 150000, 0, 2000, 220, 500}
        super.setMaximumHealth(info.max_health or 100)
        super.setHealth(info.health or 100)
        super.getStats().setDefense(info.defense or 1)
        super.getStats().setAttack(info.attack or 1)
        super.getStats().setParade(info.parade or 1)
        super.getStats().setSpeed(info.speed or 20)
        this.scythe_in_cd = false
        this.scythe_launch_cd = stopwatch.create()
        this.scythe_time = stopwatch.create()
        this.scythe_attack = "none"
        super.setLevel(info.level or 1)
        this.stamina = info.stamina or 100
        this.max_stamina = info.max_stamina or 100
        this.mana = info.mana or 250
        this.max_mana = info.max_mana or 250
        this.luck = info.luck or 1
        this.base_health = super.getMaximumHealth()
        this.status = "idle"
        this.status_idle = "down"
        this.status_vertical = "none"
        this.status_horizontal = "none"
        this.inventory = hud.createFromFile("hud/inventory_hud.lua")
        this.is_sprinting = false
        local box = new(Hitbox("player"))
        box.setPoints({{0, 0}, {220, 0}, {220, 220}, {0, 220}})
        box.setOrigin(220 / 2, 220)
        box.setScale(0.25, 0.25)
        box.setPosition(super.getPosition())
        super.addHitbox(box)
        this.isInQuest = false
        this.charging = false
        this.nb_salle_pass = 0
        this.needRestart = {false}
        this.nbr_restart = 0
    end

    function add_nbr_restart(self)
        this.nbr_restart = this.nbr_restart + 1
    end

    function get_nbr_restart(self)
        return this.nbr_restart
    end

    function setNeedRestart(self, i, need)
        this.needRestart[i] = need
    end

    function getNeedRestart(self, i, need)
        return this.needRestart[i]
    end

    function getNb_salle_pass(self)
        return this.nb_salle_pass
    end

    function plusNb_salle_pass(self)
        this.nb_salle_pass = this.nb_salle_pass + 1
    end

    function restartNb_salle_pass(self)
        assets["alarm"]:play()
        this.nb_salle_pass = 0
    end

    function getIsInQuest()
        return this.isInQuest
    end

    function setIsInQuest(quest)
        this.isInQuest = quest
    end

    function isInSpell()
        if this.status == "spell" then
            return true
        else
            return false
        end
    end

    function activateSpell()
        if this.status == "spell" then
            return
        end
        this.is_sprinting = false
        if this.status_horizontal == "left" then
            this.pos_rect = {4, 150000, 0, 4992, 300, 500}
            this.clock:restart()
            this.sprite:setTextureRect(table.unpack(this.pos_rect, 3))
        elseif this.status_horizontal == "right" then
            this.pos_rect = {4, 150000, 0, 4492, 300, 500}
            this.clock:restart()
            this.sprite:setTextureRect(table.unpack(this.pos_rect, 3))
        elseif this.status_vertical == "up" or (this.status == "idle" and this.status_idle == "up") then
            this.pos_rect = {4, 150000, 0, 5992, 199, 500}
            this.clock:restart()
            this.sprite:setTextureRect(table.unpack(this.pos_rect, 3))
        elseif this.status_vertical == "down" or (this.status == "idle" and this.status_idle == "down") then
            this.pos_rect = {4, 150000, 0, 5492, 199, 500}
            this.clock:restart()
            this.sprite:setTextureRect(table.unpack(this.pos_rect, 3))
        end
        this.status = "spell"
    end

    function desactivateSpell()
        if this.status == "spell" then
            this.status = "idle"
            this.status_idle = "down"
            this.pos_rect = {4, 150000, 0, 2000, 220, 500}
            this.clock:restart()
            this.sprite:setTextureRect(table.unpack(this.pos_rect, 3))
        end
    end

    function getMana()
        return math.max(this.mana, 0)
    end

    function getMaximumMana()
        local equipment = this.getEquipement()
        local mana = 0
        for i=1, 4 do
            if equipment[i] and equipment[i]:getStackSize() > 0 then
                mana = mana + (equipment[i]:getStats() and equipment[i]:getStats().max_mana or 0)
            end
        end
        return this.max_mana + mana
    end

    function getStatus()
        -- this.status -> the actual animation   (idle, run_right, run_left, left, right, up, down, death)
        -- this.status_horizontal -> the horizontal direction   (right, left, none)
        -- this.status_vertical -> the vertical direction   (up, down, none)
        return this.status, this.status_horizontal, this.status_vertical, this.status_idle
    end

    function setMana(mana)
        check(mana, "number", 1)

        cassert(mana >= 0, "The mana must be positive", 3)
        cassert(mana <= this.getMaximumMana(), "The mana cant exceed the max mana", 3)
        this.mana = mana
    end

    function addMana(mana)
        check(mana, "number", 1)

        cassert(mana >= 0, "The added mana must be positive", 3)
        this.mana = this.mana + mana
        if this.mana > this.getMaximumMana() then this.mana = this.getMaximumMana() end
    end

    function removeMana(mana)
        check(mana, "number", 1)

        cassert(mana >= 0, "The removed mana must be positive", 3)
        this.mana = this.mana - mana
        if this.mana < 0 then this.mana = 0 end
    end

    function getMaximumStamina()
        local equipment = this.getEquipement()
        local stamina = 0
        for i=1, 4 do
            if equipment[i] and equipment[i]:getStackSize() > 0 then
                stamina = stamina + (equipment[i]:getStats() and equipment[i]:getStats().max_stamina or 0)
            end
        end
        return this.max_stamina + stamina + math.min(this.getLevel() * 5, 100)
    end

    function setMaximumStamina(stamina)
        check(stamina ,"number", 1)

        assert(stamina > 0, "The Maximum stamina must be positive", 3)
        this.max_stamina = stamina
        if this.stamina > this.getMaximumStamina() then this.stamina = this.getMaximumStamina() end
    end

    function getStamina()
        return math.max(this.stamina, 0)
    end

    function setStamina(stamina)
        check(stamina, "number", 1)

        cassert(stamina > 0, "The stamina must be positive", 3)
        cassert(stamina <= this.getMaximumStamina(), "The stamina cant exceed the max stamina", 3)
        this.stamina = stamina
    end

    function addStamina(stamina)
        check(stamina, "number", 1)

        cassert(stamina > 0, "The added stamina must be positive", 3)
        this.stamina = this.stamina + stamina
        if this.stamina > this.getMaximumStamina() then this.stamina = this.getMaximumStamina() end
    end

    function removeStamina(stamina)
        check(stamina, "number", 1)

        cassert(stamina > 0, "The removed stamina must be positive", 3)
        this.stamina = this.stamina - stamina
        if this.stamina < 0 then this.stamina = 0 end
    end

    ---------------------------------

    function getInventory(self)
        return this.inventory
    end

    function getEquipement()
        return {this.inventory:getItemInSlot(29), this.inventory:getItemInSlot(30),
                this.inventory:getItemInSlot(31), this.inventory:getItemInSlot(32)}
    end
    ---------------------------------

    function hit(damage, source)
        local defense = this.getDefense()
        local rng = math.random( 0, 100 ) / 100
        if rng > this.getParade() - 1 then
            super.hit(damage * (1 - (defense - 1)), source)
            if super.isDead() then
                if this.scythe_attack == "scythe_launch" and this.my_scythe then
                    world.removeEntityByUUID(this.my_scythe.getUUID())
                    this.scythe_attack = "none"
                end
            end
        end
    end

    function getDefense()
        local equipment = this.getEquipement()
        local defense = 0
        for i=1, 4 do
            if equipment[i] and equipment[i]:getStackSize() > 0 then
                defense = defense + (equipment[i]:getStats() and equipment[i]:getStats().defense or 0)
            end
        end
        return defense / 100 + this.getStats().getDefense()
    end

    function getAttack()
        local equipment = this.getEquipement()
        local damage = 0
        for i=1, 4 do
            if equipment[i] and equipment[i]:getStackSize() > 0 then
                damage = damage + (equipment[i]:getStats() and equipment[i]:getStats().damage or 0)
            end
        end
        return 1 + this.getLevel() * 2 / 100 + (this.hasScythe() and 0.5 or 0)
    end

    function getParade()
        local equipment = this.getEquipement()
        local parade = 0
        for i=1, 4 do
            if equipment[i] and equipment[i]:getStackSize() > 0 then
                parade = parade + (equipment[i]:getStats() and equipment[i]:getStats().parade or 0)
            end
        end
        return parade / 100 + this.getStats().getParade() + math.min(this.getLevel() * 0.5, 10) / 100
    end

    function getSpeed()
        local equipment = this.getEquipement()
        local speed = 0
        for i=1, 4 do
            if equipment[i] and equipment[i]:getStackSize() > 0 then
                speed = speed + (equipment[i]:getStats() and equipment[i]:getStats().speed or 0)
            end
        end
        return speed + this.getStats().getSpeed() + math.min(this.getLevel() * 0.25, 5)
    end

    function respawn()
        if super.isDead() then
            this.status = "respawn"
            super.respawn()
            setScene("test_player")
            this.setPosition(550, 680)
            this.mana = this.getMaximumMana()
            this.stamina = this.getMaximumStamina()
            this.addExperience(-math.floor(this.getExperience()) / 2)
            this.stamina = this.max_stamina
            this.pos_rect = {12, 30000, 2640, 2500, 220, 500}
            this.clock:restart()
            this.sprite:setTextureRect(table.unpack(this.pos_rect, 3))
        end
    end

    function setPosition(x, y)
        check(x ,"number", 1)
        check(y ,"number", 2)

        super.setPosition(x, y)
        this.sprite:setPosition(x, y)
        this.scythe:setPosition(x, y)
    end

    function move(x, y)
        check(x ,"number", 1)
        check(y ,"number", 2)

        local success, nx, ny = super.move(x, y)
        if success then
            this.sprite:move(nx, ny)
            this.scythe:move(nx, ny)
        end
    end

    function isSprinting()
        return this.is_sprinting
    end

    function hasScythe()
        local item1 = player.getInventory():getItemInSlot(33)
        local item2 = player.getInventory():getItemInSlot(34)
        if item1 and item1:getStackSize() > 0 and item1:getItem():getName() == "scythe" then
            return true
        end
        if item2 and item2:getStackSize() > 0 and item2:getItem():getName() == "scythe" then
            return true
        end
        return false
    end

    function event(e)
        super.event()
        local event = e:getEvent()
        if event[1] == "key_pressed" then
            if event[2] == controls.getControl("action") then
                local x, y = super.getPosition()
                local w, h = 50, 50
                local entities = world.getEntitiesInRect(x - w, y - h, w * 2,h * 2)
                for i=1, #entities do
                    if type(entities[i]) == "EntityItem" then
                        if this.getInventory():insertItemStack(entities[i].getItemStack()) then
                            world.removeEntityByUUID(entities[i].getUUID())
                            break
                        end
                    end
                end
            end
        elseif event[1] == "mouse_released" then
            if this.hasScythe() then
                if event[4] == mouse.LEFT and this.scythe_attack == "slash" then
                    local nx, ny = super.getPosition()
                    local px, py = lsfml.mouse.getPosition(window)
                    local pos = vector.new(px - nx, py - ny)
                    this.scythe_attack = "slash_attack"
                    this.dir_slash = 0
                    if this.dir_slash == 0 then
                        local nx, ny = player.getPosition()
                        local px, py = lsfml.mouse.getPosition(window)
                        this.dir_slash = nx - px > 0 and 1 or -1
                        this.vec_slash = vector.new(px - nx, py - ny)
                    end
                    this.size_slash = this.scythe_time:getEllapsedTime() / 1000000
                    this.size_slash = math.max(math.min(this.size_slash, 2), 0.5)
                    if this.dir_slash == -1 then
                        this.scythe_angle = -45
                        this.scythe:setRotation(-45)
                        this.scythe:setScale(0.5 * this.size_slash, 0.5 * this.size_slash)
                    else
                        this.scythe_angle = 45
                        this.scythe:setRotation(45)
                        this.scythe:setScale(-0.5 * this.size_slash, 0.5 * this.size_slash)
                    end
                    this.charging = false
                    assets["spell_charging"]:stop()
                elseif event[4] == mouse.RIGHT then

                end
            end
        elseif event[1] == "mouse_pressed" and hud.areAllClosed() and player.isAlive() then
            if this.hasScythe() then
                if event[4] == mouse.LEFT and this.scythe_attack == "none" then
                    this.scythe_time:restart()
                    this.scythe_attack = "slash"
                elseif event[4] == mouse.RIGHT and this.scythe_attack == "none" and not this.scythe_in_cd then
                    this.scythe_time:restart()
                    this.scythe_attack = "scythe_launch"
                    this.my_scythe = world.spawnEntity(new(EntityScytheWeapon(super.getPosition())))
                end
            end
        end
    end

    function computeMaxHealth()
        local equipment = this.getEquipement()
        local health = 0
        for i=1, 4 do
            if equipment[i] and equipment[i]:getStackSize() > 0 then
                health = health + (equipment[i]:getStats() and equipment[i]:getStats().max_health or 0)
            end
        end
        this.setMaximumHealth(health + this.base_health + math.min(this.getLevel() * 9, 180))
    end

    function onLevelUp()
        computeMaxHealth()
        this.setHealth(this.getMaximumHealth())
        this.setMana(this.getMaximumMana())
        this.setStamina(this.getMaximumStamina())
    end

    local function slashAttack()
        if this.isAlive() and this.scythe_attack == "slash_attack" then
            if this.dir_slash == -1 then
                this.scythe_angle = this.scythe_angle + 15
                this.scythe:setScale(0.5 * this.size_slash, 0.5 * this.size_slash)
            else
                this.scythe_angle = this.scythe_angle - 15
                this.scythe:setScale(-0.5 * this.size_slash, 0.5 * this.size_slash)
            end
            this.scythe:setRotation(this.scythe_angle)
            if this.scythe_angle % 360 == 90 or this.scythe_angle % 360 == 270 then
                local nx, ny = super.getPosition()
                world.spawnEntity(new(EntitySlashWeapon(nx, ny, this.vec_slash, 20 * player.getAttack(), 20, final, this.size_slash)))
            elseif this.scythe_angle % 360 == 180 then
                this.scythe_attack = "none"
            end
        end
    end

    function isScytheBoomrangInCooldown()
        return this.scythe_in_cd
    end

    function getScytheBoomrangCooldown()
        return math.max(5000000 - this.scythe_launch_cd:getEllapsedTime(), 0) / 1000000
    end

    function getScytheAttack()
        return this.scythe_attack
    end

    function update()
        super.update()
        slashAttack()
        if this.scythe_in_cd then
            if this.scythe_launch_cd:getEllapsedTime() > 5000000 then
                this.scythe_in_cd = false
            end
        end
        if this.scythe_attack == "scythe_launch" then
            if this.my_scythe and this.my_scythe.isRevert() then
                local nx, ny = super.getPosition()
                local px, py = this.my_scythe.getPosition()
                local dist = math.abs(px - nx) + math.abs(py - ny)
                if dist < this.my_scythe.getSpeed() then
                    world.removeEntityByUUID(this.my_scythe.getUUID())
                    this.scythe_attack = "none"
                    this.scythe_launch_cd:restart()
                    this.scythe_in_cd = true
                end
            end
        end
        computeMaxHealth()
        if this.status == "respawn" then
            return
        end
        local speed = this.getSpeed() * DeltaTime
        if this.is_sprinting == true and this.status ~= "idle" then
            this.stamina = this.stamina - 1 * DeltaTime
            speed = speed * 2
        elseif this.getMaximumStamina() > this.stamina and (not keyboard.keyPressed(controls.getControl("sprint")) or this.status == "idle") then
            this.stamina = this.stamina + 1 * DeltaTime
        end
        if this.getMaximumMana() > this.mana and this.status ~= "spell" then
            this.mana = this.mana + 0.3 * DeltaTime
        end
        if super.isDead() then
            if (this.status ~= "death") then
                this.status = "death"
                this.pos_rect = {12, 30000, 0, 2500, 220, 500}
                this.clock:restart()
                this.sprite:setTextureRect(table.unpack(this.pos_rect, 3))
                setScene("respawn")
            end
        end
        if this.status == "spell" then
            return
        end
        if keyboard.keyPressed(controls.getControl("move_up")) and this.getHealth() > 0 then
            if (this.status ~= "up" and this.status ~= "left" and this.status ~= "right" and this.status ~= "run_right" and this.status ~= "run_left") then
                this.status = "up"
                this.pos_rect = {7, 250000 / speed, 0, 1000, 220, 500}
                this.clock:restart()
                this.sprite:setTextureRect(table.unpack(this.pos_rect, 3))
            end
            if this.status ~= "death" and this.status ~= "respawn" then
                this.move(0, -speed)
                this.status_vertical = "up"
            end
        elseif keyboard.keyPressed(controls.getControl("move_down")) and this.getHealth() > 0 then
            if (this.status ~= "down" and this.status ~= "left" and this.status ~= "right" and this.status ~= "run_right" and this.status ~= "run_left") then
                this.status = "down"
                this.pos_rect = {7, 250000 / speed, 0, 1500, 220, 500}
                this.clock:restart()
                this.sprite:setTextureRect(table.unpack(this.pos_rect, 3))
            end
            if this.status ~= "death" and this.status ~= "respawn" then
                this.move(0, speed)
                this.status_vertical = "down"
            end
        else
            this.status_vertical = "none"
        end
        if keyboard.keyPressed(controls.getControl("move_right")) and this.getHealth() > 0 and this.is_sprinting then
            if (this.status ~= "run_right") then
                this.status = "run_right"
                this.pos_rect = {5, 250000 / speed, 0, 3000, 219, 500}
                this.clock:restart()
                this.sprite:setTextureRect(table.unpack(this.pos_rect, 3))
            end
            if this.status ~= "death" and this.status ~= "respawn" then
                this.move(speed, 0)
                this.status_horizontal = "right"
            end
        elseif keyboard.keyPressed(controls.getControl("move_left")) and this.getHealth() > 0 and this.is_sprinting then
            if (this.status ~= "run_left") then
                this.status = "run_left"
                this.pos_rect = {5, 250000 / speed, 0, 3500, 219, 500}
                this.clock:restart()
                this.sprite:setTextureRect(table.unpack(this.pos_rect, 3))
            end
            if this.status ~= "death" and this.status ~= "respawn" then
                this.move(-speed, 0)
                this.status_horizontal = "left"
            end
        elseif keyboard.keyPressed(controls.getControl("move_right")) and this.getHealth() > 0 then
            if (this.status ~= "right") then
                this.status = "right"
                this.pos_rect = {15, 250000 / speed, 0, 0, 220, 500}
                this.clock:restart()
                this.sprite:setTextureRect(table.unpack(this.pos_rect, 3))
            end
            if this.status ~= "death" and this.status ~= "respawn" then
                this.status_horizontal = "right"
                this.move(speed, 0)
            end
        elseif keyboard.keyPressed(controls.getControl("move_left")) and this.getHealth() > 0 then
            if (this.status ~= "left") then
                this.status = "left"
                this.pos_rect = {15, 250000 / speed, 0, 500, 220, 500}
                this.clock:restart()
                this.sprite:setTextureRect(table.unpack(this.pos_rect, 3))
            end
            if this.status ~= "death" and this.status ~= "respawn" then
                this.status_horizontal = "left"
                this.move(-speed, 0)
            end
        else
            this.status_horizontal = "none"
        end
        if (this.status == "left" or this.status == "run_left") and not keyboard.keyPressed(controls.getControl("move_left")) and this.getHealth() > 0 then
            this.status = "idle"
            this.status_idle = "down"
            if this.status_idle == "down" then
                this.pos_rect = {4, 150000, 0, 2000, 220, 500}
            else
                this.pos_rect = {4, 150000, 0, 3992, 220, 500}
            end
            this.clock:restart()
            this.sprite:setTextureRect(table.unpack(this.pos_rect, 3))
        end
        if (this.status == "right" or this.status == "run_right") and not keyboard.keyPressed(controls.getControl("move_right")) and this.getHealth() > 0 then
            this.status = "idle"
            this.status_idle = "down"
            if this.status_idle == "down" then
                this.pos_rect = {4, 150000, 0, 2000, 220, 500}
            else
                this.pos_rect = {4, 150000, 0, 3992, 220, 500}
            end
            this.clock:restart()
            this.sprite:setTextureRect(table.unpack(this.pos_rect, 3))
        end
        if this.status_horizontal == "none" and this.status_vertical == "none" and this.getHealth() > 0 then
            if this.status ~= "idle" then
                if (this.status == "up") then
                    this.status_idle = "up"
                else
                    this.status_idle = "down"
                end
                this.status = "idle"
                if this.status_idle == "down" then
                    this.pos_rect = {4, 150000, 0, 2000, 220, 500}
                else
                    this.pos_rect = {4, 150000, 0, 3992, 220, 500}
                end
                this.clock:restart()
                this.sprite:setTextureRect(table.unpack(this.pos_rect, 3))
            end
        end
        this.is_sprinting = keyboard.keyPressed(controls.getControl("sprint")) and this.getHealth() > 0 and this.stamina > 0
    end

    function draw()
        super.draw()
        time = this.pos_rect[2]

        if this.is_sprinting == true and this.status ~= "idle" then
            time = time * 1.25
        end
        if this.clock:getEllapsedTime() > time * DeltaTime then
            if this.status ~= "respawn" then
                this.pos_rect[3] = this.pos_rect[3] + this.pos_rect[5]
                if this.pos_rect[3] > this.pos_rect[5] * (this.pos_rect[1] - 1) and  this.status ~= "death" then
                    this.pos_rect[3] = 0
                end
            elseif this.status == "respawn" then
                this.pos_rect[3] = this.pos_rect[3] - this.pos_rect[5]
                if this.pos_rect[3] < 0 then
                    this.status = "idle"
                    this.status_idle = "down"
                    this.pos_rect = {4, 150000, 0, 2000, 220, 500}
                end
            end
            this.sprite:setTextureRect(table.unpack(this.pos_rect, 3))
            this.clock:restart()
        end
        if this.isAlive() then
            if this.scythe_attack == "slash" then
                local dir = 0
                if dir == 0 then
                    local nx, ny = player.getPosition()
                    local px, py = lsfml.mouse.getPosition(window)
                    dir = nx - px > 0 and 1 or -1
                end
                local size = this.scythe_time:getEllapsedTime() / 1000000
                size = math.max(math.min(size, 2), 0.5)
                if dir == -1 then
                    this.scythe:setRotation(-45)
                    this.scythe:setScale(0.5 * size, 0.5 * size)
                else
                    this.scythe:setRotation(45)
                    this.scythe:setScale(-0.5 * size, 0.5 * size)
                end
                if size > 0.5 and not this.charging then
                    assets["spell_charging"]:play()
                    this.charging = true
                end
            end
            if this.scythe_attack ~= "none" and this.scythe_attack ~= "scythe_launch" then
                window:draw(this.scythe)
            end
        end
        window:draw(this.sprite)
        this.drawHitbox()
        this.drawHealth()
    end
}]