-- =========================================
-- =            BOSS HEALTH HUD            =
-- =========================================

local health_bar = lsfml.sprite.create()
local empty_bar1 = lsfml.sprite.create()
local text = lsfml.text.create()
local text_name = lsfml.text.create()
local csize = 50
local info = {x = 960 - 426, y = 0, width = 426 * 2, height = 33 * 2}
text:setFont(assets["fsys"])
text:setCharacterSize(csize)
text:setString("")
local ent = nil
local phase = 1

health_bar:setPosition(960 - 426, 0)
empty_bar1:setPosition(960 - 426, 0)

health_bar:setTexture(assets["boss_health1"], false)
empty_bar1:setTexture(assets["empty_boss_health"], false)

health_bar:setScale(2, 2)
empty_bar1:setScale(2, 2)

function load(self)

end

function setEntity(self, entity)
    if class.isInstanceOf(entity, "EntityLiving") or entity == nil then
        ent = entity
        phase = 1
        health_bar:setTexture(assets["boss_health"..phase], false)
    else
        error("Entity must be an instance of EntityLiving", 2)
    end
end

function getEntity()
    return ent
end

function setPhase(self, lvl)
    if lvl < 0 then
        lvl = 1
    elseif lvl > 7 then
        lvl = 7
    end
    phase = lvl
    health_bar:setTexture(assets["boss_health"..phase], false)
end

function getPhase()
    return phase
end

function open(self)

end

function close(self)

end

function draw(self)
    if ent and ent.isAlive() then
        window:draw(empty_bar1)
        window:draw(health_bar)
        window:draw(text)
    end
end

function update(self)
    if ent and ent.isAlive() then
        local maxhealth = tostring(math.floor(ent.getMaximumHealth()))
        local perc = math.floor(ent.getHealth() / ent.getMaximumHealth() * 100)
        local health = tostring(math.floor(ent.getHealth()))
        local h = string.rep("0", #maxhealth-#health)..health
        local txt = h.." / "..maxhealth.." ("..string.rep("0", 3 - #tostring(perc))..perc.."%)"
        text:setString(txt)
        text:setPosition(info.x + info.width / 2 - (#txt * csize) / 4, info.y + info.height / 2 - csize / 1.25)
        health_bar:setTextureRect(0, 0, math.floor(ent.getHealth() / ent.getMaximumHealth() * (390 - 33)) + 33, 33)
    else
        ent = nil
    end
end

function event(self, e)

end
