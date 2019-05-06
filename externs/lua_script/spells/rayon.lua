local is_idle = false

function getName(self)
    return "rayonSpell"
end

function getMaxCooldown(self)
    return 1.5
end

function getCost()
    return 0.1
end

function cooldownStartAtEnd()
    return true
end

function cast(self)
    if player.getMana() <= 0 then
        self:disable()
        return
    end
    player.removeMana(getCost())
    if assets["rayon_start"]:getStatus() == "stopped" and assets["rayon_idle"]:getStatus() ~= "playing" then
        assets["rayon_idle"]:setLoop(true)
        assets["rayon_idle"]:play()
    end
    if animationSpell["rayonSpell"].hasEnded() and not is_idle then
        world.removeEntityByUUID(animationSpell["rayonSpell"].getUUID())
        world.spawnEntity(animationSpell["rayonIdleAnimation"])
        animationSpell["rayonIdleAnimation"].restart()
        is_idle = true
    end
    local status, hor, ver, idle = player.getStatus()
    local x_player, y_player = player.getPosition()
    local size = 250
    local big = 70
    local w, h = 0, 0

    if (hor == "left") then
        w = -size * 1.5
        h = -big
        x_player = x_player - big / 2
    elseif (hor == "right") then
        w = size * 1.5
        h = -big
        x_player = x_player + big / 2
    elseif (ver == "up" or (status == "idle" and idle == "up")) then
        w = big
        h = -size
        x_player = x_player - big / 2
        y_player = y_player - big * 2
    elseif (ver == "down" or (status == "idle" and idle == "down")) then
        x_player = x_player - big / 2
        w = big
        h = size
    end
    animationSpell["rayonIdleAnimation"].makeDamage()
    animationSpell["rayonEndAnimation"].makeDamage()
    animationSpell["rayonSpell"].makeDamage()
end

function isInstant(self)
    return false
end

function enable(self)
    local status, hor, ver , idle = player.getStatus()
    assets["rayon_start"]:play()
    player.removeMana(getCost() * 0.5)
    
    if (hor == "left") then
        animationSpell["rayonSpell"].setRotation(90)
        animationSpell["rayonIdleAnimation"].setRotation(90)
        animationSpell["rayonEndAnimation"].setRotation(90)
        animationSpell["rayonEndAnimation"].setOrigin(0, 0)
        animationSpell["rayonSpell"].setOrigin(0, 0)
        animationSpell["rayonIdleAnimation"].setOrigin(0, 0)
        animationSpell["rayonSpell"].setTranslation(-28, -85)
        animationSpell["rayonEndAnimation"].setTranslation(-28, -85)
        animationSpell["rayonIdleAnimation"].setTranslation(-28, -85)
    elseif (hor == "right") then
        animationSpell["rayonSpell"].setRotation(-90)
        animationSpell["rayonIdleAnimation"].setRotation(-90)
        animationSpell["rayonEndAnimation"].setRotation(-90)
        animationSpell["rayonEndAnimation"].setOrigin(0, 0)
        animationSpell["rayonSpell"].setOrigin(0, 0)
        animationSpell["rayonIdleAnimation"].setOrigin(0, 0)
        animationSpell["rayonSpell"].setTranslation(40, -25)
        animationSpell["rayonEndAnimation"].setTranslation(40, -25)
        animationSpell["rayonIdleAnimation"].setTranslation(40, -25)
    elseif (ver == "up" or (status == "idle" and idle == "up")) then
        animationSpell["rayonSpell"].setRotation(180)
        animationSpell["rayonIdleAnimation"].setRotation(180)
        animationSpell["rayonEndAnimation"].setRotation(180)
        animationSpell["rayonEndAnimation"].setOrigin(0, 0)
        animationSpell["rayonSpell"].setOrigin(0, 0)
        animationSpell["rayonIdleAnimation"].setOrigin(0, 0)
        animationSpell["rayonSpell"].setTranslation(40, -50)
        animationSpell["rayonEndAnimation"].setTranslation(40, -50)
        animationSpell["rayonIdleAnimation"].setTranslation(40, -50)
    elseif (ver == "down" or (status == "idle" and idle == "down")) then
        animationSpell["rayonEndAnimation"].setOrigin(9.5, 20)
        animationSpell["rayonSpell"].setOrigin(9.5, 20)
        animationSpell["rayonIdleAnimation"].setOrigin(9.5, 20)
        animationSpell["rayonSpell"].setRotation(0)
        animationSpell["rayonIdleAnimation"].setRotation(0)
        animationSpell["rayonEndAnimation"].setRotation(0)
        animationSpell["rayonSpell"].setTranslation(15, 20)
        animationSpell["rayonEndAnimation"].setTranslation(15, 20)
        animationSpell["rayonIdleAnimation"].setTranslation(15, 20)
    end
    world.spawnEntity(animationSpell["rayonSpell"])
    player.activateSpell()
    is_idle = false
    animationSpell["rayonSpell"].restart()

end

function disable(self)
    player.removeMana(getCost() * 0.5)
    assets["rayon_idle"]:setLoop(false)
    assets["rayon_end"]:play()
    world.removeEntityByUUID(animationSpell["rayonIdleAnimation"].getUUID())
    if not is_idle then
        world.removeEntityByUUID(animationSpell["rayonSpell"].getUUID())
    end
    world.spawnEntity(animationSpell["rayonEndAnimation"])
    animationSpell["rayonEndAnimation"].restart()
    is_finish = true
end

function getCost(self)
    return 0.2
end
