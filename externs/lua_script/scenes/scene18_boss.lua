-- =========================================
-- =                MAP LABO               =
-- =========================================

local background = lsfml.sprite.create()
local boss_start = false
background:setTexture(assets["boss"], false)
local first = false
local entities = {}
local hitb = nil
local scythe

function load(scene)
    if player:getNb_salle_pass() > 6 then
        entities = {}
        first = false
        player:add_nbr_restart()
        player:restartNb_salle_pass()
        for i = 1, 17 do
            player:setNeedRestart(i, true)
        end
    end
    if first == false or player:getNeedRestart(17) then
        scythe = new(EntityScytheBoss(800, 800))
        first = true
    end
    if (scene == "scene17_right_start") then
        player.setPosition(950, 1050)
    end
    world.setEntities(entities)
    if #entities == 0 then
        world.spawnEntity(player)
        world.spawnEntity(scythe)
    end
    if player:getNeedRestart(17) then
        entities = {}
        player:setNeedRestart(17, false)
    end
    if (hitb == nil) then
        HitBoxWall(0, 0, {{0, 0}, {0, 220}, {1920, 220}, {1920, 0}})
        HitBoxWall(0, 0, {{30, 30}, {30, 1050}})
        HitBoxWall(0, 0, {{1910, 30}, {1910, 1050}})

        HitBoxWall(0, 0, {{0, 1030}, {880, 1030}, {880, 1100}, {0, 1100}})
        HitBoxWall(0, 0, {{1020, 1030}, {1920, 1030}, {1920, 1100}, {1020, 1100}})

        HitBoxWall(0, 0, {{0, 1080}, {1920, 1080}})
        hitb = hitbox.getHitboxes()
    end
    hitbox.setHitboxes(hitb)
    local ents = world.getEntities()
    for i=1, #ents do
        if type(ents[i]) == "EntityScytheBoss" then
            bosshealth:setEntity(ents[i])
            break
        end
    end
end

function unload()
    scythe.setPhase(1)
    scythe.setHealth(scythe.getMaximumHealth())
    entities = world.getEntities()
    hitb = hitbox.getHitboxes()
    world.clearEntities()
    hitbox.clear()
    bosshealth:setEntity(nil)
end

function HitBoxWall(x_or, y_or, pts)
    local box = new(Hitbox("hard", {takeDamage=false, doDamage=false}))
    box.setPoints(pts)
    box.setPosition(x_or, y_or)
    hitbox.add(box)
end

function draw()
    window:draw(background)
end

function update()
    local x, y = player.getPosition()
    local canPass = true
    for i=1, #entities do
        if entities[i].getType() == "ennemy" then
            canPass = false
        end
    end
    if x > 900 and x < 1000 and y > 1050 then
        setScene("scene17_right_start")
        player:plusNb_salle_pass()
    end

end


local hitbx = new(Hitbox())
local press = false
local px, py = 0, 0
function event(e)
    local event = e:getEvent()
    if event[1] == "mouse_pressed" and press == false and event[4] == mouse.RIGHT then
        px, py = event[2], event[3]
        press = true
        hitbx.addPoint(px, py)
    elseif event[1] == "mouse_released" and press and event[4] == mouse.RIGHT then
        press = false
    end
    if event[1] == "mouse_pressed" and event[4] == mouse.LEFT then
        if hitbx and #hitbx.getPoints() > 0 then
            local pts = hitbx.getPoints()
            hitbx.setOrigin(hitbx.getMiddlePoint())
            hitbox.add(hitbx)
            hitbx = new(Hitbox())
        end
    end
end