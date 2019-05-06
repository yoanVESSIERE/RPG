function getName(self)
    return "healSpell"
end

function getMaxCooldown(self)
    return 20
end

function cooldownStartAtEnd()
    return false
end

function getCost()
    return 25
end

function cast(self)
    world.spawnEntity(animationSpell["healSpell"])
    player.removeMana(getCost())
    assets["heal"]:play()
    player.heal(40)
    animationSpell["healSpell"].restart()
end

function isInstant(self)
    return true
end

function enable(self)

end

function disable(self)

end