-- =========================================
-- =                MAP LABO               =
-- =========================================

local background = lsfml.sprite.create()
background:setTexture(assets["left_start"], false)
local par3 = itemstack.create(items.parchemin_3, 1)
local par4 = itemstack.create(items.parchemin_4, 1)

local canP3 = true
local canP4 = true
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
local parchemin3
local parchemin4
local robot1
local robot2
local robot3
local robot4

local entities = {}
local hitb = nil

function load(scene)
    if player:getNb_salle_pass() > 6 then
        entities = {}
        first = false
        player:restartNb_salle_pass()
        for i = 1, 17 do
            player:setNeedRestart(i, true)
        end
    end
    if first == false or player:getNeedRestart(15) then
        status1 = new(EntityProps(1699, 354, assets["status"], 50, 150, {{0, 127}, {13, 147}, {23, 174}, {100, 174}, {62, 130}}, 1))
        status2 = new(EntityProps(1535, 792, assets["status"], 50, 150, {{0, 127}, {13, 147}, {23, 174}, {100, 174}, {62, 130}}, 1))
        status3 = new(EntityProps(1063, 313, assets["status"], 50, 150, {{0, 127}, {13, 147}, {23, 174}, {100, 174}, {62, 130}}, 1))
        pot1_1 = new(EntityProps(1805, 286, assets["pot1"], 38, 84, {{0, 74}, {0, 84}, {76, 84}, {55, 74}}, 1))
        pot1_2 = new(EntityProps(1419, 291, assets["pot1"], 38, 84, {{0, 74}, {0, 84}, {76, 84}, {55, 74}}, 1))
        pot1_3 = new(EntityProps(730, 351, assets["pot1"], 38, 84, {{0, 74}, {0, 84}, {76, 84}, {55, 74}}, 1))
        pot1_4 = new(EntityProps(245, 959, assets["pot1"], 38, 84, {{0, 74}, {0, 84}, {76, 84}, {55, 74}}, 1))
        pot2_1 = new(EntityProps(975, 834, assets["pot2"], 14, 56, {{0, 74}, {0, 56}, {25, 56}, {28, 74}}, 1))
        pot2_2 = new(EntityProps(87, 815, assets["pot2"], 14, 56, {{0, 74}, {0, 56}, {25, 56}, {28, 74}}, 1))
        pot2_3 = new(EntityProps(628, 236, assets["pot2"], 14, 56, {{0, 74}, {0, 56}, {25, 56}, {28, 74}}, 1))
        pot2_4 = new(EntityProps(1198, 374, assets["pot2"], 14, 56, {{0, 74}, {0, 56}, {25, 56}, {28, 74}}, 1))
        pot3_1 = new(EntityProps(511, 392, assets["pot3"], 17, 56, {{0, 49}, {0, 56}, {35, 56}, {24, 49}}, 1))
        pot3_2 = new(EntityProps(374, 332, assets["pot3"], 17, 56, {{0, 49}, {0, 56}, {35, 56}, {24, 49}}, 1))
        pot3_3 = new(EntityProps(461, 879, assets["pot3"], 17, 56, {{0, 49}, {0, 56}, {35, 56}, {24, 49}}, 1))
        pot3_4 = new(EntityProps(1318, 808, assets["pot3"], 17, 56, {{0, 49}, {0, 56}, {35, 56}, {24, 49}}, 1))
        pot4_1 = new(EntityProps(1582, 302, assets["pot4"], 38, 80, {{0, 70}, {0, 80}, {76, 80}, {58, 70}}, 1))
        pot4_2 = new(EntityProps(1290, 429, assets["pot4"], 38, 80, {{0, 70}, {0, 80}, {76, 80}, {58, 70}}, 1))
        pot4_3 = new(EntityProps(851, 235, assets["pot4"], 38, 80, {{0, 70}, {0, 80}, {76, 80}, {58, 70}}, 1))
        pot4_4 = new(EntityProps(748, 893, assets["pot4"], 38, 80, {{0, 70}, {0, 80}, {76, 80}, {58, 70}}, 1))
        pot5_1 = new(EntityProps(292, 291, assets["pot5"], 17, 84, {{0, 74}, {0, 84}, {34, 84}, {31, 74}}, 1))
        pot5_2 = new(EntityProps(1528, 961, assets["pot5"], 17, 84, {{0, 74}, {0, 84}, {34, 84}, {31, 74}}, 1))
        pot5_3 = new(EntityProps(188, 334, assets["pot5"], 17, 84, {{0, 74}, {0, 84}, {34, 84}, {31, 74}}, 1))
        pot5_4 = new(EntityProps(1750, 927, assets["pot5"], 17, 84, {{0, 74}, {0, 84}, {34, 84}, {31, 74}}, 1))
        if one then
            parchemin3 = new(EntityProps(600, 30, assets["parchemin_3"], 17, 0, {}, 1))
            parchemin4 = new(EntityProps(200, 600, assets["parchemin_4"], 17, 0, {}, 1))
        end
        robot1 = new(EntityRobot2(300, 400))
        robot2 = new(EntityRobot2(200, 500))
        robot3 = new(EntityRobot2(300, 600))
        robot4 = new(EntityRobot2(400, 500))
        first = true
    end
    if player:getNeedRestart(15) then
        entities = {}
        player:setNeedRestart(15, false)
    end
    if (scene == "scene15_start") then
        player.setPosition(1900, 630)
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
            world.spawnEntity(parchemin3)
            world.spawnEntity(parchemin4)
            one = false
        end
        world.spawnEntity(robot1)
        world.spawnEntity(robot2)
        world.spawnEntity(robot3)
        world.spawnEntity(robot4)
    end
    if (hitb == nil) then
        HitBoxWall(0, 0, {{0, 0}, {0, 160}, {1920, 160}, {1920, 0}})
        HitBoxWall(0, 0, {{0, 1030}, {1890, 1030}})
        HitBoxWall(0, 0, {{30, 30}, {30, 1050}})
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
    local x, y = player.getPosition()
    local canPass = true
    for i=1, #entities do
        if entities[i].getType() == "ennemy" then
            canPass = false
        end
    end
    if x > 500 and x < 700 and y < 300 and keyboard.keyPressed(keys.F) and canP3 == true and canPass then
        world.removeEntityByUUID(parchemin3.getUUID())
        player.getInventory():insertItemStack(par3)
        canP3 = false
    end
    if x > 100 and x < 300 and y > 500 and y < 700 and keyboard.keyPressed(keys.F) and canP4 == true and canPass then
        world.removeEntityByUUID(parchemin4.getUUID())
        player.getInventory():insertItemStack(par4)
        canP4 = false
    end
    
    if canPass then
        if x > 1910 then
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