Class "EntityLiving" extends "Entity" [{

    function __EntityLiving(x, y)
        super(x, y)
        this.max_health = 100
        this.health = 100
        this.alive = true
        this.stats = new(Stats())
        this.lvl = 1
        this.experience = 0
        this.next_exp_stage = 100
        this.health_x = 0
        this.health_y = 0
        this.lvl_text = lsfml.text.create()
        this.lvl_text:setCharacterSize(20)
        this.lvl_text:setFont(assets["fsys"])
        this.circle_lvl = lsfml.sprite.create()
        this.circle_lvl:setScale(0.5, 0.5)
        this.circle_lvl:setOrigin(35, 35)
        this.circle_lvl:setTexture(assets["circle"], false)
        this.empty_health_bar = lsfml.sprite.create()
        this.empty_health_bar:setTexture(assets["mob_health_empty"], false)
        this.empty_health_bar:setOrigin(520, 15)
        this.empty_health_bar:setScale(0.15, 0.5)
        this.health_bar = lsfml.sprite.create()
        this.health_bar:setTexture(assets["mob_health"], false)
        this.health_bar:setOrigin(520, 15)
        this.health_bar:setScale(0.15, 0.5)
        this.show_health = false
    end

    function getExperience()
        return this.experience
    end

    function addExperience(amount)
        check(amount, "number", 1)

        this.experience = this.experience + math.floor(amount)
        while this.experience > this.next_exp_stage do
            this.lvl = this.lvl + 1
            this.experience = this.experience - this.next_exp_stage
            this.next_exp_stage = this.next_exp_stage * 1.01 ^ this.lvl
            if final and final.onLevelUp then
                final.onLevelUp(this.lvl)
            end
        end
    end

    function getStats()
        return this.stats
    end

    function setHealthBarVisible(state)
        check(state, "boolean", 1)

        this.show_health = state
    end

    function isHealthBarVisible()
        return this.show_health
    end

    function setHealthBarOffset(x, y)
        check(x, "number", 1)
        check(y, "number", 2)

        this.health_x = x
        this.health_y = y
        local nx, ny = super.getPosition()
        this.empty_health_bar:setPosition(nx + this.health_x, ny + this.health_y)
        this.health_bar:setPosition(nx + this.health_x, ny + this.health_y)
        this.circle_lvl:setPosition(nx + this.health_x - 520 * 0.15 - 20, ny + this.health_y)
    end

    function getHealthBarOffset()
        return this.health_x, this.health_y
    end

    function setLevel(lvl)
        check(lvl, "number", 1)

        cassert(lvl >= 0, "Level must be positive", 3)
        this.lvl = lvl
    end

    function getNextExperienceStage()
        return this.next_exp_stage
    end

    function getLevel()
        return this.lvl
    end

    function setPosition(x, y)
        check(x, "number", 1)
        check(y, "number", 2)

        super.setPosition(x, y)
        this.empty_health_bar:setPosition(x + this.health_x, y + this.health_y)
        this.health_bar:setPosition(x + this.health_x, y + this.health_y)
        this.circle_lvl:setPosition(x + this.health_x - 520 * 0.15 - 20, y + this.health_y)
    end

    function move(x, y)
        check(x ,"number", 1)
        check(y ,"number", 2)

        local nx, ny = super.getPosition()
        local success1, point1 = hitbox.rayhit(nx, ny, x * 2, y * 2, "hard")
        if not success1 then
            super.move(x, y)
            this.health_bar:move(x, y)
            this.empty_health_bar:move(x, y)
            this.circle_lvl:move(x, y)
            return true, x, y
        end
        local dir = vector.new(x, y)
        dir = dir:normalize()
        local px, py = (point1[1] - dir.x) - nx, (point1[2] - dir.y) - ny
        super.move(px, py)
        this.health_bar:move(px, py)
        this.empty_health_bar:move(px, py)
        this.circle_lvl:move(px, py)
        return true, px, py
    end

    function getMaximumHealth()
        return this.max_health
    end

    function setMaximumHealth(health)
        check(health, "number", 1)

        if (health > 0) then
            this.max_health = health
            if this.health > this.max_health then
                this.health = this.max_health
            end
        else
            error("Health must be superior to 0", 2)
        end
    end

    function getHealth()
        return math.max(this.health, 0)
    end

    function setHealth(health)
        check(health, "number", 1)

        if (health <= 0) then
            this.alive = false
            this.health = math.max(health, 0)
        elseif this.alive then
            this.health = math.min(health, this.max_health)
        end
    end

    function isAlive()
        return this.alive
    end

    function isDead()
        return not this.alive
    end

    function kill()
        this.setHealth(-2147483647)
    end

    function respawn()
        this.alive = true
        this.health = this.max_health
    end

    function hit(damage, source)
        check(damage, "number", 1)

        if source == nil then
            error("Argument #2, Source cannot be nil", 2)
        end
        if (damage >= 0) then
            if this.isAlive() then
                this.setHealth(this.health - damage)
                if this.isDead() then
                    if class.isInstanceOf(source, "EntityLiving") then
                        if final and final.getExperience() then
                            source.addExperience(final.getExperience())
                        end
                    end
                end
            end
        else
            error("Damage can not be negative", 2)
        end
    end

    function heal(damage)
        check(damage, "number", 1)

        if (damage >= 0) then
            this.setHealth(this.health + damage)
        end
    end

    function canBePushed()
        return true
    end

    function drawHealth()
        if this.show_health then
            this.health_bar:setTextureRect(0, 0, math.floor(this.health / this.max_health * 989 + 26), 30)
            local x, y = super.getPosition()
            local nx, ny = lsfml.text.getCenter(tostring(this.lvl), 20)
            this.lvl_text:setPosition(x + this.health_x - 520 * 0.15 - 20 - nx, y + this.health_y - ny)
            this.lvl_text:setString(tostring(this.lvl))
            window:draw(this.empty_health_bar)
            window:draw(this.health_bar)
            window:draw(this.circle_lvl)
            window:draw(this.lvl_text)
        end
    end

    function update()
        super.update()
        -- if this.isAlive() and final.canBePushed() then
        --     local mvx, mvy = 0, 0
        --     local nx, ny = super.getPosition()
        --     for i=1, #push_rays do
        --         local success = hitbox.rayhitSimple(nx, ny, push_rays[i][1] * 10, push_rays[i][2] * 10, "push")
        --         if success then
        --             mvx, mvy = mvx - push_rays[i][1] * 10, mvy - push_rays[i][2] * 10
        --         end
        --     end
        --     final.move(mvx, mvy)
        -- end
    end

}]