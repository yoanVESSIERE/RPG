-- =========================================
-- =                MAP LABO               =
-- =========================================

local background = lsfml.sprite.create()
background:setTexture(assets["labo_vertical"], false)

local entities = {}
local hitb = nil
local door
local canPass = false
local stopwatch = stopwatch.create()
local play_door = false

function load(scene)
    if (scene == "scene14_escalier") then
        player.setPosition(1030, 200)
    end
    if (scene == "scene10_intersection_haut") then
        player.setPosition(1030, 1050)
    end
    world.setEntities(entities)
    if #entities == 0 then
        world.spawnEntity(player)
        door = animation.create(assets["door"], {0, 0 , 400, 351})
        door:setPosition(965, 80)
        door:scale(0.38, 0.38)
    end
    if player:getNeedRestart() then
        entities = {}
        player:setNeedRestart(false)
    end
    if (hitb == nil) then
        HitBoxWall(0, 0, {{0, 0}, {0, 220}, {960, 220}, {960, 190}, {1115, 190}, {1115, 220}, {1920, 220}, {1920, 0}})
        HitBoxWall(0, 0, {{910, 30}, {910, 1050}})
        HitBoxWall(0, 0, {{1170, 30}, {1170, 1050}})

        HitBoxWall(0, 0, {{0, 1030}, {970, 1030}, {970, 1100}, {0, 1100}})
        HitBoxWall(0, 0, {{1100, 1030}, {1920, 1030}, {1920, 1100}, {1100, 1100}})
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
            setScene("scene14_escalier")
        end
        if y > 1050 then
            player:plusNb_salle_pass()
            setScene("scene10_intersection_haut")
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