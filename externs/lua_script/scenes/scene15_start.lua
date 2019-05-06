-- =========================================
-- =                MAP LABO               =
-- =========================================

local background = lsfml.sprite.create()
background:setTexture(assets["start_cave"], false)
local par1 = itemstack.create(items.parchemin_1, 1)
local par2 = itemstack.create(items.parchemin_2, 1)
local canP1 = true
local canP2 = true
local one = true

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
local first_load = false
local parchemin1
local parchemin2
local entities = {}
local hitb = nil
local robot1

function load(scene)
    if player:getNb_salle_pass() > 6 then
        entities = {}
        first = false
        player:restartNb_salle_pass()
        for i = 1, 17 do
            player:setNeedRestart(i, true)
        end
    end
    if first_load == false or player:getNeedRestart(14) then
        status1 = new(EntityProps(368, 209, assets["status"], 50, 150, {{0, 127}, {13, 147}, {23, 174}, {100, 174}, {62, 130}}, 1))
        status2 = new(EntityProps(87, 815, assets["status"], 50, 150, {{0, 127}, {13, 147}, {23, 174}, {100, 174}, {62, 130}}, 1))
        status3 = new(EntityProps(1638, 804, assets["status"], 50, 150, {{0, 127}, {13, 147}, {23, 174}, {100, 174}, {62, 130}}, 1))
        pot1_1 = new(EntityProps(1805, 286, assets["pot1"], 38, 84, {{0, 74}, {0, 84}, {76, 84}, {55, 74}}, 1))
        pot1_2 = new(EntityProps(1419, 291, assets["pot1"], 38, 84, {{0, 74}, {0, 84}, {76, 84}, {55, 74}}, 1))
        pot1_3 = new(EntityProps(500, 225, assets["pot1"], 38, 84, {{0, 74}, {0, 84}, {76, 84}, {55, 74}}, 1))
        pot1_4 = new(EntityProps(245, 959, assets["pot1"], 38, 84, {{0, 74}, {0, 84}, {76, 84}, {55, 74}}, 1))
        pot2_1 = new(EntityProps(975, 834, assets["pot2"], 14, 56, {{0, 74}, {0, 56}, {25, 56}, {28, 74}}, 1))
        pot2_2 = new(EntityProps(1535, 792, assets["pot2"], 14, 56, {{0, 74}, {0, 56}, {25, 56}, {28, 74}}, 1))
        pot2_3 = new(EntityProps(1829, 374, assets["pot2"], 14, 56, {{0, 74}, {0, 56}, {25, 56}, {28, 74}}, 1))
        pot2_4 = new(EntityProps(1198, 374, assets["pot2"], 14, 56, {{0, 74}, {0, 56}, {25, 56}, {28, 74}}, 1))
        pot3_1 = new(EntityProps(511, 392, assets["pot3"], 17, 56, {{0, 49}, {0, 56}, {35, 56}, {24, 49}}, 1))
        pot3_2 = new(EntityProps(83, 399, assets["pot3"], 17, 56, {{0, 49}, {0, 56}, {35, 56}, {24, 49}}, 1))
        pot3_3 = new(EntityProps(461, 879, assets["pot3"], 17, 56, {{0, 49}, {0, 56}, {35, 56}, {24, 49}}, 1))
        pot3_4 = new(EntityProps(1318, 808, assets["pot3"], 17, 56, {{0, 49}, {0, 56}, {35, 56}, {24, 49}}, 1))
        pot4_1 = new(EntityProps(1582, 302, assets["pot4"], 38, 80, {{0, 70}, {0, 80}, {76, 80}, {58, 70}}, 1))
        pot4_2 = new(EntityProps(1290, 429, assets["pot4"], 38, 80, {{0, 70}, {0, 80}, {76, 80}, {58, 70}}, 1))
        pot4_3 = new(EntityProps(851, 235, assets["pot4"], 38, 80, {{0, 70}, {0, 80}, {76, 80}, {58, 70}}, 1))
        pot4_4 = new(EntityProps(748, 893, assets["pot4"], 38, 80, {{0, 70}, {0, 80}, {76, 80}, {58, 70}}, 1))
        pot5_1 = new(EntityProps(1046, 900, assets["pot5"], 17, 84, {{0, 74}, {0, 84}, {34, 84}, {31, 74}}, 1))
        pot5_2 = new(EntityProps(671, 182, assets["pot5"], 17, 84, {{0, 74}, {0, 84}, {34, 84}, {31, 74}}, 1))
        pot5_3 = new(EntityProps(188, 334, assets["pot5"], 17, 84, {{0, 74}, {0, 84}, {34, 84}, {31, 74}}, 1))
        pot5_4 = new(EntityProps(335, 731, assets["pot5"], 17, 84, {{0, 74}, {0, 84}, {34, 84}, {31, 74}}, 1))
        if one then
            parchemin1 = new(EntityProps(1800, 840, assets["parchemin_1"], 107, 0, {}, 1))
            parchemin2 = new(EntityProps(600, 100, assets["parchemin_2"], 98, 62, {}, 1))
        end
        robot1 = new(EntityRobot1(200, 600))
        first_load = true
    end
    if player:getNeedRestart(14) then
        entities = {}
        player:setNeedRestart(14, false)
    end
    if (scene == "scene14_escalier") then
        player.setPosition(990, 250)
    end
    if (scene == "scene16_left_start") then
        player.setPosition(30, 580)
    end
    if (scene == "scene17_right_start") then
        player.setPosition(1900, 580)
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
        if one then
            world.spawnEntity(parchemin1)
            world.spawnEntity(parchemin2)
            one = false
        end
        world.spawnEntity(robot1)
    end
    if (hitb == nil) then
        HitBoxWall(0, 0, {{0, 0}, {0, 160}, {940, 160}, {940, 135}, {1030, 135}, {1030, 160}, {1920, 160}, {1920, 0}})
        HitBoxWall(0, 0, {{0, 1030}, {1890, 1030}})

        HitBoxWall(0, 0, {{-10, 0}, {-10, 1080}})
        HitBoxWall(0, 0, {{1920, 0}, {1920, 1080}})
        hitb = hitbox.getHitboxes()
    end
    hitbox.setHitboxes(hitb)
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
end

function update()
    local canPass = true
    for i=1, #entities do
        if entities[i].getType() == "ennemy" then
            canPass = false
        end
    end
    local x, y = player.getPosition()
    if x > 500 and x < 700 and y < 300 and keyboard.keyPressed(controls.getControl("action")) and canP1 == true and canPass then
        world.removeEntityByUUID(parchemin2.getUUID())
        player.getInventory():insertItemStack(par2)
        canP1 = false
    end
    if x > 1700 and x < 1900 and y < 900 and y > 700 and keyboard.keyPressed(controls.getControl("action")) and canP2 == true and canPass then
        world.removeEntityByUUID(parchemin1.getUUID())
        player.getInventory():insertItemStack(par1)
        canP2 = false
    end
    if canPass then
        if x < 0 then
            player:plusNb_salle_pass()
            setScene("scene16_left_start")
        end
        if y < 155 then
            player:plusNb_salle_pass()
            setScene("scene14_escalier")
        end
        if x > 1910 then
            player:plusNb_salle_pass()
            setScene("scene17_right_start")
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