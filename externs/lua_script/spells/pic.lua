function getName(self)
    return "picSpell"
end

function getMaxCooldown(self)
    return 4
end

function getCost()
    return 10
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
    world.spawnEntity(animationSpell["picSpell"])
    animationSpell["picSpell"].restart()
    player.removeMana(getCost())
    assets["pic"]:play()
    local status, hor, ver , idle = player.getStatus()
    
    if (hor == "left") then
        animationSpell["picSpell"].setRotation(0)
    elseif (hor == "right") then
        animationSpell["picSpell"].setRotation(180)
    elseif (ver == "up" or (status == "idle" and idle == "up")) then
        animationSpell["picSpell"].setRotation(90)
    elseif (ver == "down" or (status == "idle" and idle == "down")) then
        animationSpell["picSpell"].setRotation(-90)
    end

    animationSpell["picSpell"].makeDamage()
    player.activateSpell()
end
