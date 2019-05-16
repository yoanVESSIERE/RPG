-- =========================================
-- =                MAP LABO               =
-- =========================================

local background = lsfml.sprite.create()
background:setTexture(assets["labo_pop"], false)

local door_box

local first = false
local door
local canPass = false
local stopwatch = stopwatch.create()
local play_door = false
local soucoupe


local entities = {}
local hitb = nil

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
    if first == false or player:getNeedRestart(12) then
        soucoupe = new(EntitySoucoupe(600, 600))
        door = animation.create(assets["door"], {0, 0 , 400, 351})
        door:setPosition(965, 80)
        door:scale(0.38, 0.38)
        first = true
    end
    if player:getNeedRestart(12) then
        entities = {}
        player:setNeedRestart(12, false)
    end
    if scene == "scene11_angle_droit" then
        player.setPosition(1050, 240)
    end
    world.setEntities(entities)
    if #entities == 0 then
        world.spawnEntity(soucoupe)
        world.spawnEntity(player)
        world.spawnEntity(robot1)
    end
    bosshealth:setEntity(soucoupe)
    if (hitb == nil) then
        HitBoxWall(0, 0, {{0, 0}, {0, 220}, {960, 220}, {960, 190}, {1115, 190}, {1115, 220}, {1920, 220}, {1920, 0}})
        HitBoxWall(0, 0, {{0, 1030}, {1890, 1030}})
        HitBoxWall(0, 0, {{30, 30}, {30, 1050}})
        HitBoxWall(0, 0, {{1880, 1050}, {1880, 40}})
        hitb = hitbox.getHitboxes()
    end
    hitbox.setHitboxes(hitb)
    local ents = world.getEntities()
    for i=1, #ents do
        if type(ents[i]) == "EntitySoucoupe" then
            bosshealth:setEntity(ents[i])
            break
        end
    end
end

function unload()
    soucoupe.setHealth(soucoupe.getMaximumHealth())
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
    if door_box == nil then
        door_box = new(Hitbox("hard", {takeDamage=false, doDamage=false}))
        door_box.setPoints({{0, 215}, {1920, 215}})
        door_box.setPosition(0, 0)
        hitbox.add(door_box)
    end
end

function draw()
    window:draw(background)
    if canPass then
        if stopwatch:getEllapsedTime() > 100000 then
            stopwatch:restart()
            door:next()
        end
    end
    door:draw()
end

function update()
    local x, y = player.getPosition()
    canPass = true
    for i=1, #entities do
        if entities[i].getType() == "ennemy" then
            canPass = false
        end
    end
    if canPass then
        if not play_door then
            assets["door_sound"]:play()
            play_door = true
            door_box.setType("soft")
        end
        if y < 200 then
            player:plusNb_salle_pass()
            setScene("scene11_angle_droit")
        end
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