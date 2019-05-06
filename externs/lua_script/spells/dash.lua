local distance = 240
local diag_dist = math.floor(math.sqrt(distance^2 / 2))

function getName(self)
    return "dashSpell"
end

function getMaxCooldown(self)
    return 2
end

function cooldownStartAtEnd()
    return false
end

function getCost()
    return 5
end

function isNotValid()
    local status, hor, ver = player.getStatus()
    if (status == "idle") then
        assets["deny"]:play()
        return true
    end
    return false
end

function cast(self)
    local status, hor, ver = player.getStatus()
    player.removeMana(getCost())
    assets["dash"]:play()
    local x = 0
    local y = 0
    
    if hor ~= "none" and ver ~= "none" then
        if hor == "right" then
            x = diag_dist
        else
            x = -diag_dist
        end
        if ver == "down" then
            y = diag_dist
        else
            y = -diag_dist
        end
    elseif hor ~= "none" then
        if hor == "right" then
            x = distance
        else
            x = -distance
        end
    elseif ver ~= "none" then
        if ver == "down" then
            y = distance
        else
            y = -distance
        end
    end
    player.move(x, y)
end

