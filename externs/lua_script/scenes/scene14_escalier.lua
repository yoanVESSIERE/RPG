-- =========================================
-- =                MAP LABO               =
-- =========================================

local background = lsfml.sprite.create()
background:setTexture(assets["labo_escalier"], false)

local door_box

local first = false
local geant_tapis_gauche
local grand_tapis_droite
local moyen_tapis_haut_droite
local petit_tapis_bas_gauche
local status1
local status2
local status3
local pot1_1
local pot1_2
local pot1_3
local pot1_4
local pot2_1
local pot2_2
local pot2_3
local pot2_4
local pot3_1
local pot3_2
local pot3_3
local pot3_4
local pot4_1
local pot4_2
local pot4_3
local pot4_4
local pot5_1
local pot5_2
local pot5_3
local pot5_4
local robot1
local robot2
local robot3
local robot4
local robot5
local robot6
local door
local canPass = false
local stopwatch = stopwatch.create()
local play_door = false

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
    if first == false or player:getNeedRestart(13) then
        geant_tapis_gauche = new(EntityProps(250, 300, assets["geant_tapis_gauche"], 0, 0, {}, 1))
        grand_tapis_droite = new(EntityProps(1300, 250, assets["grand_tapis_droite"], 0, 0, {}, 1))
        moyen_tapis_haut_droite = new(EntityProps(1100, 650, assets["moyen_tapis_haut_droite"], 0, 0, {}, 1))
        petit_tapis_bas_gauche = new(EntityProps(250, 700, assets["petit_tapis_bas_gauche"], 0, 0, {}, 1))
        status1 = new(EntityProps(600, 600, assets["status"], 50, 150, {{0, 127}, {13, 147}, {23, 174}, {100, 174}, {62, 130}}, 1))
        status2 = new(EntityProps(1400, 450, assets["status"], 50, 150, {{0, 127}, {13, 147}, {23, 174}, {100, 174}, {62, 130}}, 1))
        status3 = new(EntityProps(1300, 800, assets["status"], 50, 150, {{0, 127}, {13, 147}, {23, 174}, {100, 174}, {62, 130}}, 1))
        pot1_1 = new(EntityProps(300, 500, assets["pot1"], 38, 84, {{0, 74}, {0, 84}, {76, 84}, {55, 74}}, 1))
        pot1_2 = new(EntityProps(400, 800, assets["pot1"], 38, 84, {{0, 74}, {0, 84}, {76, 84}, {55, 74}}, 1))
        pot1_3 = new(EntityProps(1200, 800, assets["pot1"], 38, 84, {{0, 74}, {0, 84}, {76, 84}, {55, 74}}, 1))
        pot1_4 = new(EntityProps(1600, 450, assets["pot1"], 38, 84, {{0, 74}, {0, 84}, {76, 84}, {55, 74}}, 1))
        pot2_1 = new(EntityProps(500, 650, assets["pot2"], 14, 56, {{0, 74}, {0, 56}, {25, 56}, {28, 74}}, 1))
        pot2_2 = new(EntityProps(300, 400, assets["pot2"], 14, 56, {{0, 74}, {0, 56}, {25, 56}, {28, 74}}, 1))
        pot2_3 = new(EntityProps(1500, 350, assets["pot2"], 14, 56, {{0, 74}, {0, 56}, {25, 56}, {28, 74}}, 1))
        pot2_4 = new(EntityProps(300, 800, assets["pot2"], 14, 56, {{0, 74}, {0, 56}, {25, 56}, {28, 74}}, 1))
        pot3_1 = new(EntityProps(414, 488, assets["pot3"], 17, 56, {{0, 49}, {0, 56}, {35, 56}, {24, 49}}, 1))
        pot3_2 = new(EntityProps(1654, 344, assets["pot3"], 17, 56, {{0, 49}, {0, 56}, {35, 56}, {24, 49}}, 1))
        pot3_3 = new(EntityProps(1512, 459, assets["pot3"], 17, 56, {{0, 49}, {0, 56}, {35, 56}, {24, 49}}, 1))
        pot3_4 = new(EntityProps(1376, 859, assets["pot3"], 17, 56, {{0, 49}, {0, 56}, {35, 56}, {24, 49}}, 1))
        pot4_1 = new(EntityProps(659, 427, assets["pot4"], 38, 80, {{0, 70}, {0, 80}, {76, 80}, {58, 70}}, 1))
        pot4_2 = new(EntityProps(387, 411, assets["pot4"], 38, 80, {{0, 70}, {0, 80}, {76, 80}, {58, 70}}, 1))
        pot4_3 = new(EntityProps(300, 607, assets["pot4"], 38, 80, {{0, 70}, {0, 80}, {76, 80}, {58, 70}}, 1))
        pot4_4 = new(EntityProps(408, 617, assets["pot4"], 38, 80, {{0, 70}, {0, 80}, {76, 80}, {58, 70}}, 1))
        pot5_1 = new(EntityProps(507, 534, assets["pot5"], 17, 84, {{0, 74}, {0, 84}, {34, 84}, {31, 74}}, 1))
        pot5_2 = new(EntityProps(686, 523, assets["pot5"], 17, 84, {{0, 74}, {0, 84}, {34, 84}, {31, 74}}, 1))
        pot5_3 = new(EntityProps(494, 816, assets["pot5"], 17, 84, {{0, 74}, {0, 84}, {34, 84}, {31, 74}}, 1))
        pot5_4 = new(EntityProps(404, 905, assets["pot5"], 17, 84, {{0, 74}, {0, 84}, {34, 84}, {31, 74}}, 1))
        robot1 = new(EntityTurret(200, 600))
        robot2 = new(EntityTurret(650, 800))
        robot3 = new(EntityTurret(600, 300))
        robot4 = new(EntityTurret(800, 400))
        robot5 = new(EntityTurret(1000, 400))
        robot6 = new(EntityTurret(1500, 850))
        robot1.setLevel(5 + player:get_nbr_restart())
        robot2.setLevel(5 + player:get_nbr_restart())
        robot3.setLevel(5 + player:get_nbr_restart())
        robot4.setLevel(5 + player:get_nbr_restart())
        robot5.setLevel(5 + player:get_nbr_restart())
        robot6.setLevel(5 + player:get_nbr_restart())
        door = animation.create(assets["door"], {0, 0 , 400, 351})
            door:setPosition(880, 80)
            door:scale(0.38, 0.38)
    end
    if player:getNeedRestart(13) then
        entities = {}
        player:setNeedRestart(13, false)
    end
    if (scene == "scene15_start") then
        player.setPosition(980, 250)
    end
    if (scene == "scene13_vertical") then
        player.setPosition(980, 1050)
    end
    world.setEntities(entities)
    if #entities == 0 then
        world.spawnEntity(player)
        world.spawnEntity(geant_tapis_gauche)
        world.spawnEntity(grand_tapis_droite)
        world.spawnEntity(moyen_tapis_haut_droite)
        world.spawnEntity(petit_tapis_bas_gauche)
        world.spawnEntity(status1)
        world.spawnEntity(status2)
        world.spawnEntity(status3)
        world.spawnEntity(pot1_1)
        world.spawnEntity(pot1_2)
        world.spawnEntity(pot1_3)
        world.spawnEntity(pot1_4)
        world.spawnEntity(pot2_1)
        world.spawnEntity(pot2_2)
        world.spawnEntity(pot2_3)
        world.spawnEntity(pot2_4)
        world.spawnEntity(pot3_1)
        world.spawnEntity(pot3_2)
        world.spawnEntity(pot3_3)
        world.spawnEntity(pot3_4)
        world.spawnEntity(pot4_1)
        world.spawnEntity(pot4_2)
        world.spawnEntity(pot4_3)
        world.spawnEntity(pot4_4)
        world.spawnEntity(pot5_1)
        world.spawnEntity(pot5_2)
        world.spawnEntity(pot5_3)
        world.spawnEntity(pot5_4)
        world.spawnEntity(robot1)
        world.spawnEntity(robot2)
        world.spawnEntity(robot3)
        world.spawnEntity(robot4)
        world.spawnEntity(robot5)
        world.spawnEntity(robot6)
    end
    if (hitb == nil) then
        HitBoxWall(0, 0, {{0, 0}, {0, 220}, {880, 220}, {880, 190}, {1030, 190}, {1030, 220}, {1920, 220}, {1920, 0}})
        HitBoxWall(0, 0, {{30, 30}, {30, 1050}})
        HitBoxWall(0, 0, {{1880, 1050}, {1880, 40}})

        HitBoxWall(0, 0, {{0, 1030}, {880, 1030}, {880, 1100}, {0, 1100}})
        HitBoxWall(0, 0, {{1050, 1030}, {1920, 1030}, {1920, 1100}, {1050, 1100}})

        HitBoxWall(0, 0, {{0, 1080}, {1920, 1080}})
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
            door_box.setType("soft")
        end
    end
    if canPass then
        if not play_door then
            assets["door_sound"]:play()
            play_door = true
        end
        if y < 200 then
            player:plusNb_salle_pass()
            setScene("scene15_start")
        end
        if y > 1050 then
            player:plusNb_salle_pass()
            setScene("scene13_vertical")
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