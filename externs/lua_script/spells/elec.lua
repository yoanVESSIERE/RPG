function getName(self)
    return "elecSpell"
end

function getMaxCooldown(self)
    return 5
end

function getCost()
    return 20
end

function cooldownStartAtEnd()
    return true
end

function isInstant(self)
    return true
end

function enable(self)

end

function disable(self)

end

function cast(self)
    world.spawnEntity(animationSpell["elecSpell"])
    animationSpell["elecSpell"].restart()
    player.removeMana(getCost())
    assets["elec"]:play()
    local status, hor, ver = player.getStatus()
    local x_player, y_player = player.getPosition()
    local size = 200
    local big = 80
    local w, h = 0, 0

    if (hor == "left") then
        w = -size * 1.5
        h = -big
        x_player = x_player - big / 2
        animationSpell["elecSpell"].setRotation(90)
    elseif (hor == "right") then
        w = size * 1.5
        h = -big
        x_player = x_player + big / 2
        animationSpell["elecSpell"].setRotation(-90)
    elseif (ver == "up" or (status == "idle" and idle == "up")) then
        w = big
        h = -size
        x_player = x_player - big / 2
        y_player = y_player - big * 2
        animationSpell["elecSpell"].setRotation(-180)
    elseif (ver == "down" or (status == "idle" and idle == "down")) then
        x_player = x_player - big / 2
        w = big
        h = size
        animationSpell["elecSpell"].setRotation(0)
    end
    player.activateSpell()
    animationSpell["elecSpell"].makeDamage()
end