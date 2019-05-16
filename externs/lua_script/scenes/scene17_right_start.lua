-- =========================================
-- =                MAP LABO               =
-- =========================================

local background = lsfml.sprite.create()
background:setTexture(assets["right_start"], false)
local par6 = itemstack.create(items.parchemin_6, 1)

local canP6 = true
local one = true

local first = false
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
local parchemin6
local robot1
local robot2
local robot3
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
    soundmanager.play("robot1")
    if first == false or player:getNeedRestart(16) then
        status1 = new(EntityProps(375, 339, assets["status"], 50, 150, {{0, 127}, {13, 147}, {23, 174}, {100, 174}, {62, 130}}, 1))
        status2 = new(EntityProps(186, 802, assets["status"], 50, 150, {{0, 127}, {13, 147}, {23, 174}, {100, 174}, {62, 130}}, 1))
        status3 = new(EntityProps(1355, 682, assets["status"], 50, 150, {{0, 127}, {13, 147}, {23, 174}, {100, 174}, {62, 130}}, 1))
        pot1_1 = new(EntityProps(264, 309, assets["pot1"], 38, 84, {{0, 74}, {0, 84}, {76, 84}, {55, 74}}, 1))
        pot1_2 = new(EntityProps(404, 968, assets["pot1"], 38, 84, {{0, 74}, {0, 84}, {76, 84}, {55, 74}}, 1))
        pot1_3 = new(EntityProps(1803, 488, assets["pot1"], 38, 84, {{0, 74}, {0, 84}, {76, 84}, {55, 74}}, 1))
        pot1_4 = new(EntityProps(1181, 488, assets["pot1"], 38, 84, {{0, 74}, {0, 84}, {76, 84}, {55, 74}}, 1))
        pot2_1 = new(EntityProps(1181, 241, assets["pot2"], 14, 56, {{0, 74}, {0, 56}, {25, 56}, {28, 74}}, 1))
        pot2_2 = new(EntityProps(807, 386, assets["pot2"], 14, 56, {{0, 74}, {0, 56}, {25, 56}, {28, 74}}, 1))
        pot2_3 = new(EntityProps(1175, 775, assets["pot2"], 14, 56, {{0, 74}, {0, 56}, {25, 56}, {28, 74}}, 1))
        pot2_4 = new(EntityProps(1518, 217, assets["pot2"], 14, 56, {{0, 74}, {0, 56}, {25, 56}, {28, 74}}, 1))
        pot3_1 = new(EntityProps(585, 227, assets["pot3"], 17, 56, {{0, 49}, {0, 56}, {35, 56}, {24, 49}}, 1))
        pot3_2 = new(EntityProps(548, 896, assets["pot3"], 17, 56, {{0, 49}, {0, 56}, {35, 56}, {24, 49}}, 1))
        pot3_3 = new(EntityProps(921, 735, assets["pot3"], 17, 56, {{0, 49}, {0, 56}, {35, 56}, {24, 49}}, 1))
        pot3_4 = new(EntityProps(1523, 517, assets["pot3"], 17, 56, {{0, 49}, {0, 56}, {35, 56}, {24, 49}}, 1))
        pot4_1 = new(EntityProps(1118, 249, assets["pot4"], 38, 80, {{0, 70}, {0, 80}, {76, 80}, {58, 70}}, 1))
        pot4_2 = new(EntityProps(1098, 875, assets["pot4"], 38, 80, {{0, 70}, {0, 80}, {76, 80}, {58, 70}}, 1))
        pot4_3 = new(EntityProps(1542, 916, assets["pot4"], 38, 80, {{0, 70}, {0, 80}, {76, 80}, {58, 70}}, 1))
        pot4_4 = new(EntityProps(1820, 860, assets["pot4"], 38, 80, {{0, 70}, {0, 80}, {76, 80}, {58, 70}}, 1))
        pot5_1 = new(EntityProps(595, 720, assets["pot5"], 17, 84, {{0, 74}, {0, 84}, {34, 84}, {31, 74}}, 1))
        pot5_2 = new(EntityProps(114, 320, assets["pot5"], 17, 84, {{0, 74}, {0, 84}, {34, 84}, {31, 74}}, 1))
        pot5_3 = new(EntityProps(1129, 244, assets["pot5"], 17, 84, {{0, 74}, {0, 84}, {34, 84}, {31, 74}}, 1))
        pot5_4 = new(EntityProps(739, 400, assets["pot5"], 17, 84, {{0, 74}, {0, 84}, {34, 84}, {31, 74}}, 1))
        if canP6 then
            parchemin6 = new(EntityProps(1550, 550, assets["parchemin_6"], 17, 0, {}, 1))
        end
        robot1 = new(EntityRobot1(700, 510))
        robot2 = new(EntityRobot1(400, 700))
        robot3 = new(EntityRobot1(600, 800))
        robot1.setLevel(8 + player:get_nbr_restart())
        robot2.setLevel(4 + player:get_nbr_restart())
        robot3.setLevel(2 + player:get_nbr_restart())
        first = true
    end
    if player:getNeedRestart(16) then
        entities = {}
        player:setNeedRestart(16, false)
    end
    if (scene == "scene15_start") then
        player.setPosition(30, 580)
    end
    if (scene == "scene18_boss") then
        player.setPosition(950, 200)
    end
    world.setEntities(entities)
    if #entities == 0 then
        world.spawnEntity(player)
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
        if canP6 then
            world.spawnEntity(parchemin6)
        end
        world.spawnEntity(robot1)
        world.spawnEntity(robot2)
        world.spawnEntity(robot3)
    end
    if (hitb == nil) then
        HitBoxWall(0, 0, {{0, 0}, {0, 160}, {900, 160}, {900, 135}, {1000, 135}, {1000, 160}, {1920, 160}, {1920, 0}})
        HitBoxWall(0, 0, {{0, 1030}, {1890, 1030}})
        HitBoxWall(0, 0, {{1880, 1050}, {1880, 40}})

        HitBoxWall(0, 0, {{-10, 0}, {-10, 1080}})
        hitb = hitbox.getHitboxes()
    end
    hitbox.setHitboxes(hitb)
end

function unload()
    soundmanager.setLoop(false)
    soundmanager.stop("robot1")
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
end

function update()
    local x, y = player.getPosition()
    local canPass = true
    for i=1, #entities do
        if entities[i].getType() == "ennemy" then
            canPass = false
        end
    end
    if x > 1450 and x < 1750 and y > 450 and y < 650 and keyboard.keyPressed(keys.F) and canP6 == true and canPass then
        world.removeEntityByUUID(parchemin6.getUUID())
        player.getInventory():insertItemStack(par6)
        canP6 = false
    end
    
    if canPass then
        if x > 900 and x < 1000 and y < 155 then
            player:plusNb_salle_pass()
            setScene("scene18_boss")
        end
        if x < 0 then
            player:plusNb_salle_pass()
            setScene("scene15_start")
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