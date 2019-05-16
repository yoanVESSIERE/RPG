function getName(self)
    return "bouleelecSpell"
end

function getMaxCooldown(self)
    return 0.25
end

function cooldownStartAtEnd()
    return true
end

function getCost()
    return 6
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
   
    local x_player, y_player = player.getPosition()
    local status, hor, ver , idle = player.getStatus()
    local pos1 = vector.new(x_player, y_player)
    player.removeMana(getCost())
    assets["bouleelec"]:play()

    if (hor == "left") then
        local pos2 = vector.new(x_player - 5, y_player)
        local dir = pos2 - pos1
        world.spawnEntity(new(EntityBouleElec(x_player + 15, y_player - 70, dir, 3, 20)))
    elseif (hor == "right") then
        local pos2 = vector.new(x_player + 5, y_player)
        local dir = pos2 - pos1
        world.spawnEntity(new(EntityBouleElec(x_player + 15, y_player - 70, dir, 3, 20)))
    elseif (ver == "up" or (status == "idle" and idle == "up")) then
        local pos2 = vector.new(x_player, y_player - 5)
        local dir = pos2 - pos1
        world.spawnEntity(new(EntityBouleElec(x_player, y_player - 70, dir, 3, 20)))
    elseif (ver == "down" or (status == "idle" and idle == "down")) then
        local pos2 = vector.new(x_player, y_player + 5)
        local dir = pos2 - pos1
        world.spawnEntity(new(EntityBouleElec(x_player, y_player - 70, dir, 3, 20)))
    end
end
