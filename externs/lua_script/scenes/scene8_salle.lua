-- =========================================
-- =                MAP LABO               =
-- =========================================

local background = lsfml.sprite.create()
background:setTexture(assets["labo_pop"], false)

local first = false
local tube_bleu_casser 
local tube_bleu_transform1 
local tube_bleu_transform2 
local tube_bleu_homme1 
local tube_bleu_homme2 
local tube_bleu_femme1 
local tube_bleu_femme2 
local tube_vert_homme1 
local tube_vert_homme2 
local tube_vert_femme1 
local tube_vert_femme2
local robot1
local robot2
local robot3
local robot4
local robot5
local robot6
local robot7
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
        player:restartNb_salle_pass()
        for i = 1, 17 do
            player:setNeedRestart(i, true)
        end
    end
    if first == false or player:getNeedRestart(8) then
        tube_bleu_casser = new(EntityProps(600, 700, assets["tube_bleu_casser"], 126, 156, {{8, 148},{0, 248}, {162, 248}, {162, 148}}, 1))
        tube_bleu_transform1 = new(EntityProps(200, 900, assets["tube_bleu_transform"], 65, 204, {{6, 153},{0, 204}, {131, 204}, {125, 153}}, 1.2))
        tube_bleu_transform2 = new(EntityProps(1300, 400, assets["tube_bleu_transform"], 65, 204, {{6, 153},{0, 204}, {131, 204}, {125, 153}}, 1.2))
        tube_bleu_homme1 = new(EntityProps(300, 300, assets["tube_bleu_homme"], 78, 244, {{8, 183},{0, 244}, {157, 244}, {150, 183}}, 1))
        tube_bleu_homme2 = new(EntityProps(900, 1000, assets["tube_bleu_homme"], 78, 244, {{8, 183},{0, 244}, {157, 244}, {150, 183}}, 1))
        tube_bleu_femme1 = new(EntityProps(1600, 700, assets["tube_bleu_femme"], 78, 247, {{8, 185},{0, 247}, {159, 247}, {151, 185}}, 1))
        tube_bleu_femme2 = new(EntityProps(1400, 950, assets["tube_bleu_femme"], 78, 247, {{8, 185},{0, 247}, {159, 247}, {151, 185}}, 1))
        tube_vert_homme1 = new(EntityProps(1750, 980, assets["tube_vert_homme"], 80, 248, {{7, 186},{0, 248}, {160, 248}, {153, 186}}, 1))
        tube_vert_homme2 = new(EntityProps(800, 420, assets["tube_vert_homme"], 80, 248, {{7, 186},{0, 248}, {160, 248}, {153, 186}}, 1))
        tube_vert_femme1 = new(EntityProps(1650, 350, assets["tube_vert_femme"], 78, 248, {{8, 186},{0, 248}, {159, 248}, {151, 186}}, 1))
        tube_vert_femme2 = new(EntityProps(350, 550, assets["tube_vert_femme"], 78, 248, {{8, 186},{0, 248}, {159, 248}, {151, 186}}, 1))
        robot1 = new(EntityTurret(640, 450))
        robot2 = new(EntityTurret(1435, 450))
        robot3 = new(EntityTurret(640, 850))
        robot4 = new(EntityTurret(1435, 850))
        robot5 = new(EntityTurret(879, 654))
        robot6 = new(EntityTurret(1198, 654))
        robot7 = new(EntityTurret(1035, 700))
        door = animation.create(assets["door"], {0, 0 , 400, 351})
        door:setPosition(965, 80)
        door:scale(0.38, 0.38)
        first = true
    end
    if player:getNeedRestart(8) then
        entities = {}
        player:setNeedRestart(8, false)
    end
    if scene == "scene7_angle_droit" then
        player.setPosition(1050, 210)
    end
    world.setEntities(entities)
    if #entities == 0 then
        world.spawnEntity(player)
        world.spawnEntity(tube_bleu_casser)
        world.spawnEntity(tube_bleu_transform1)
        world.spawnEntity(tube_bleu_transform2)
        world.spawnEntity(tube_bleu_homme1)
        world.spawnEntity(tube_bleu_homme2)
        world.spawnEntity(tube_bleu_femme1)
        world.spawnEntity(tube_bleu_femme2)
        world.spawnEntity(tube_vert_homme1)
        world.spawnEntity(tube_vert_homme2)
        world.spawnEntity(tube_vert_femme1)
        world.spawnEntity(tube_vert_femme2)
        world.spawnEntity(robot1)
        world.spawnEntity(robot2)
        world.spawnEntity(robot3)
        world.spawnEntity(robot4)
        world.spawnEntity(robot5)
        world.spawnEntity(robot6)
        world.spawnEntity(robot7)
    end
    if (hitb == nil) then
        HitBoxWall(0, 0, {{0, 0}, {0, 220}, {960, 220}, {960, 190}, {1115, 190}, {1115, 220}, {1920, 220}, {1920, 0}})
        HitBoxWall(0, 0, {{0, 1030}, {1890, 1030}})
        HitBoxWall(0, 0, {{30, 30}, {30, 1050}})
        HitBoxWall(0, 0, {{1880, 1050}, {1880, 40}})
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
        end
        if y < 200 then
            player:plusNb_salle_pass()
            setScene("scene7_angle_droit")
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