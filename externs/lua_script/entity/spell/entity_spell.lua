-- =========================================
-- =             ENTITY SPELL              =
-- =========================================

Class "EntitySpell" extends "Entity" [{
    function __EntitySpell(info)
        check(info, "table", 1)

        super(info.pos_x or 0, info.pos_y or 0)

        if info.hitbox then
            this.box = new(Hitbox("soft", {takeDamage=false, doDamage=true}))
            this.box.setPoints(info.hitbox)
            this.box.setPosition(info.pos_x or 0, info.pos_y or 0)
            this.box.setOrigin(info.ox or 0, info.oy or 0)
            this.box.setScale(info.scale or 1, info.scale or 1)
            this.have_hitbox = true
        else
            this.have_hitbox = false
        end

        this.damage = info.damage or 0
        this.sprite = animation.create(info.spell, info.rect)
        this.sprite:setPosition(info.pos_x or 0, info.pos_y or 0)
        this.sprite:setOrigin(info.ox or 0, info.oy or 0)
        this.sprite:setScale(info.scale or 1, info.scale or 1)
        this.origin = {info.ox, info.oy}
        this.scale = info.scale or 1
        this.collidebox = info.rect
        this.timeAnimation = info.time or 10000
        this.pos_x_tp = info.pos_x_tp or 0
        this.pos_y_tp = info.pos_y_tp or 0
        this.clock = stopwatch.create()
        this.follow_player = info.follow_player or false
        this.one_animation = info.one_animation or true
        this.damage_loop = info.damage_loop or false
        this.once = false
        this.matrix = transform.trans(info.ox or 0, info.oy or 0) * transform.scale(info.scale or 1, info.scale or 1)
        this.one_animation = info.one_animation or false
        this.moving_x = 0
        this.moving_y = 0
        this.make_damage = false
        this.knockback = info.knockback or 0
    end

    function makeDamage()
        this.make_damage = true
    end

    function setTextureRect(rect)
        this.sprite:setTextureRect(table.unpack(rect))
    end

    function setTranslation(x, y)
        this.pos_x_tp = x
        this.pos_y_tp = y
    end

    function setOrigin(x, y)
        this.sprite:setOrigin(x, y)
        if this.have_hitbox then
            this.box.setOrigin(x, y)
        end
    end

    function moving(x, y)
        this.moving_x = x
        this.moving_y = y
    end

    function draw()
        if this.follow_player then
            local x, y = player.getPosition()
            this.setPosition(x + this.pos_x_tp, y + this.pos_y_tp)
            if this.have_hitbox then
                this.box.setPosition(x + this.pos_x_tp, y + this.pos_y_tp)
            end
        else
            this.move(this.moving_x, this.moving_y)
            if this.have_hitbox then
                this.box.move(this.moving_x, this.moving_y)
            end
        end

        if this.clock:getEllapsedTime() > this.timeAnimation then
            if this.one_animation and this.sprite:hasEnded() then
                world.removeEntityByUUID(super.getUUID())
                player.desactivateSpell()
                return
            end
            if (this.sprite:hasEnded()) then
                this.sprite:restart()
            end
            this.clock:restart()
            this.sprite:next()
        end
        this.sprite:draw()
    end

    function update()
        if player:isDead() then
            world.removeEntityByUUID(super.getUUID())
            return
        end
        if this.have_hitbox and this.make_damage then
            this.box.recompute()
            local entities = world.getEntitiesInHitbox(box, "enemy")
            for i = 1, #entities do
                if (class.isInstanceOf(entities[i], "EntityLiving")) then
                    local x, y = entities[i].getPosition()
                    local px, py = player.getPosition()
                    local pos_x = x - px
                    local pos_y = y - py
                    local total = math.abs(pos_x) + math.abs(pos_y)
                    entities[i].move((pos_x / total) * this.knockback, (pos_y / total) * this.knockback)
                    entities[i].hit(this.damage * DeltaTime * player.getAttack(), player)
                end
            end
            this.make_damage = false
        end
        if this.knockback ~= 0 then
            local entities = world.getEntitiesInHitbox(box, "projectile")
            for i = 1, #entities do
                    local x, y = entities[i].getPosition()
                    local px, py = player.getPosition()
                    local pos_x = x - px
                    local pos_y = y - py
                    local total = math.abs(pos_x) + math.abs(pos_y)
                    entities[i].setDir(pos_x, pos_y)
            end
        end
    end

    function move(x, y)
        super.move(x, y)
        this.sprite:move(x, y)
        if this.have_hitbox then
            this.box.move(x, y)
        end
    end

    function setPosition(x, y)
        super.setPosition(x, y)
        this.sprite:setPosition(x, y)
        if this.have_hitbox then
            this.box.setPosition(x, y)
        end
    end

    function setRotation(angle)
        this.sprite:setRotation(angle)
        this.matrix = this.matrix * transform.rotate(angle)
        if this.have_hitbox then
            this.box.setRotation(angle)
        end
    end

    function restart()
        this.clock:restart()
        this.sprite:restart()
        this.once = false
    end

    function hasEnded()
        return this.sprite:hasEnded()
    end

    function followPlayer(bool)
        this.follow_player = bool
    end

    function one_animation(bool)
        this.one_animation = bool
    end
}]

