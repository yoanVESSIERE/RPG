function getName(self)
    return "shieldSpell"
end

function getMaxCooldown(self)
    return 20
end

function cooldownStartAtEnd()
    return true
end

function getCost()
    return 0.3
end

function cast(self)
    local x, y = player.getPosition()
    player.removeMana(getCost())
    animationSpell["shieldSpell"].setPosition(x, y + 1)
    if animationSpell["shieldSpell"].hasEnded() then
        self:disable()
    end
end

function isInstant(self)
    return false
end

function enable(self)
    player.removeMana(getCost())
    assets["shield"]:play()
    player.activateSpell()
    animationSpell["shieldSpell"].restart()
    world.spawnEntity(animationSpell["shieldSpell"])
    player.setVulnerable(false)
end

function disable(self)
    world.removeEntityByUUID(animationSpell["shieldSpell"].getUUID())
    player.desactivateSpell()
    player.setVulnerable(true)
end