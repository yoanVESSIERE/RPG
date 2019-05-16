function getName(self)
    return "tempSpell"
end

function getMaxCooldown(self)
    return 30
end

function cooldownStartAtEnd()
    return false
end

function getCost()
    return 100
end

function cast(self)
    player.removeMana(getCost())
    assets["time"]:play()
    _G.freeze = true
    _G.freezetime:restart()
    temp_hud:restart()
end

function isInstant(self)
    return true
end

function enable(self)

end

function disable(self)

end