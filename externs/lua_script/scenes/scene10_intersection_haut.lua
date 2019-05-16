-- =========================================
-- =                MAP LABO               =
-- =========================================

local background = lsfml.sprite.create()
background:setTexture(assets["labo_intersection_haut"], false)

local door_box

local first = false
local torch1
local torch2
local torch3
local torch4
local hologram1
local hologram2
local hologram_break1
local hologram_break2
local robot1
local robot2
local robot3
local door
local canPass = false
local stopwatch = stopwatch.create()
local play_door = false

local sounds = {}
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
    soundmanager.setSounds(sounds)
    soundmanager.setLoop(true)
    soundmanager.play("robot2")
    if first == false or player:getNeedRestart(10) then
        torch1 = new(EntityProps(100, 850, assets["torch"], 27, 111, {{0, 95},{0, 111}, {55, 111}, {55, 95}}, 1))
        torch2 = new(EntityProps(100, 450, assets["torch_empty"], 27, 84, {{0, 95},{0, 84}, {55, 84}, {55, 95}}, 1))
        torch3 = new(EntityProps(1800, 850, assets["torch"], 27, 111, {{0, 95},{0, 111}, {55, 111}, {55, 95}}, 1))
        torch4 = new(EntityProps(1800, 450, assets["torch_empty"], 27, 84, {{0, 95},{0, 84}, {55, 84}, {55, 95}}, 1))
        hologram1 = new(EntityProps(1350, 400, assets["hologram"], 77, 155, {{0, 136},{0, 155}, {155, 155}, {155, 136}}, 1))
        hologram2 = new(EntityProps(450, 950, assets["hologram"], 77, 155, {{0, 136},{0, 155}, {155, 155}, {155, 136}}, 1))
        hologram_break1 = new(EntityProps(550, 350, assets["hologram_break"], 77, 39, {{0, 20},{0, 39}, {155, 39}, {155, 20}}, 1))
        hologram_break2 = new(EntityProps(1500, 900, assets["hologram_break"], 77, 39, {{0, 20},{0, 39}, {155, 39}, {155, 20}}, 1))
        robot1 = new(EntityTurret(800, 300))
        robot2 = new(EntityRobot2(400, 800))
        robot3 = new(EntityRobot2(1100, 800))
        robot1.setLevel(3 + player:get_nbr_restart())
        robot2.setLevel(5 + player:get_nbr_restart())
        robot3.setLevel(5 + player:get_nbr_restart())
        door = animation.create(assets["door"], {0, 0 , 400, 351})
        door:setPosition(965, 80)
        door:scale(0.38, 0.38)
        first = true
    end
    if player:getNeedRestart(10) then
        entities = {}
        player:setNeedRestart(10, false)
    end
    if (scene == "scene13_vertical") then
        player.setPosition(1030, 240)
    end
    if (scene == "scene11_angle_droit") then
        player.setPosition(30, 700)
    end
    if (scene == "scene9_horizontal") then
        player.setPosition(1900, 700)
    end
    world.setEntities(entities)
    if #entities == 0 then
        world.spawnEntity(player)
        world.spawnEntity(torch1)
        world.spawnEntity(torch2)
        world.spawnEntity(torch3)
        world.spawnEntity(torch4)
        world.spawnEntity(hologram1)
        world.spawnEntity(hologram2)
        world.spawnEntity(hologram_break1)
        world.spawnEntity(hologram_break2)
        world.spawnEntity(robot1)
        world.spawnEntity(robot2)
        world.spawnEntity(robot3)
    end
    if (hitb == nil) then
        HitBoxWall(0, 0, {{0, 0}, {0, 220}, {960, 220}, {960, 190}, {1115, 190}, {1115, 220}, {1920, 220}, {1920, 0}})
        HitBoxWall(0, 0, {{0, 1030}, {1890, 1030}})

        HitBoxWall(0, 0, {{1880, 0}, {1880, 600}, {1920, 600}, {1920, 0}})
        HitBoxWall(0, 0, {{1880, 760}, {1880, 1080}, {1920, 1080}, {1920, 760}})

        HitBoxWall(0, 0, {{30, 0}, {30, 600}, {-50, 600}, {-50, 0}})
        HitBoxWall(0, 0, {{30, 760}, {30, 1080}, {-50, 1080}, {-50, 760}})

        HitBoxWall(0, 0, {{-10, 0}, {-10, 1080}})
        HitBoxWall(0, 0, {{1920, 0}, {1920, 1080}})
        hitb = hitbox.getHitboxes()
    end
    hitbox.setHitboxes(hitb)
    if door_box == nil then
        door_box = new(Hitbox("hard", {takeDamage=false, doDamage=false}))
        door_box.setPoints({{0, 215}, {1920, 215}})
        door_box.setPosition(0, 0)
        hitbox.add(door_box)
    end
end

function unload()
    soundmanager.setLoop(false)
    soundmanager.stop("robot2")
    sounds = soundmanager.getSounds()
    soundmanager.clear()
    entities = world.getEntities()
    hitb = hitbox.getHitboxes()
    world.clearEntities()
    hitbox.clear()
end

function HitBoxWall(x_or, y_or, pts)
    local box = new(Hitbox("hard", {takeDamage=false, doDamage=false}))
    box.setPoints(pts)
    box.setPosition(x_or, y_or)
    hitbox.add(box)
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
        if x < 0 then
            player:plusNb_salle_pass()
            setScene("scene11_angle_droit")
        end
        if y < 200 then
            player:plusNb_salle_pass()
            setScene("scene13_vertical")
        end
        if x > 1910 then
            player:plusNb_salle_pass()
            setScene("scene9_horizontal")
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