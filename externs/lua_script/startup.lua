-- =========================================
-- =           MYRPG VARIABLES             =
-- =========================================

assets = {}
local paused = false
local pstate = false
local scenes = {}
local scene_name = "main_menu"

-- =========================================
-- =                 LOADING               =
-- =========================================

local odofile = dofile
function dofile(filename)
    if filename then
        return odofile("./externs/lua_script/"..filename)
    else
        return odofile()
    end
end

function setPaused(state)
    check(state, "boolean", 1)

    paused = state
end

function isPaused()
    return paused
end

local function loadScene(name)
    check(name, "string", 1)
    local handle = io.open("./externs/lua_script/"..name)
    if handle then
        local code = handle:read("*all")
        local env = setmetatable({}, {__index = _G})
        local func, err = load(code, name, "t", env)
        if func then
            local s, e = pcall(func)
            if s then
                local name = name:match("([^/]+).lua$")
                scenes[name] = {}
                for k, v in pairs(env) do
                    scenes[name][k] = v
                end
            else
                print(name..({e:match(":.+")})[1])
            end
        else
            error("[SCENE LOADER ERROR] "..err, 2)
        end
        handle:close()
    else
        error("File not found '"..name.."'", 2)
    end
end
prevScene = "main_menu"
function setScene(name)
    if name ~= "main_menu" then
        player_hud:open()
    end
    if scenes[scene_name] and scenes[scene_name].unload then
        if name ~= "options_menu" or scene_name == "main_menu" then
            scenes[scene_name].unload()
        end
        prevScene = scene_name
        prevDeadScene = scene_name
    end
    if scenes[name] and scenes[name].load then
        if scene_name ~= "options_menu" or name == "main_menu" then
            local pre = scene_name
            scene_name = name
            scenes[name].load(pre)
        end
    end
    scene_name = name
end

function getScene()
    return scene_name
end

function updateProgress()
    coroutine.yield()
end

math.randomseed(os.time())
local owindow = window

dofile("tools/keyboard.lua")
dofile("entity/ennemy/boss/mage_func.lua")
dofile("entity/ennemy/boss/scythe_func.lua")
dofile("entity/ennemy/boss/soucoupe_func.lua")
transform = dofile("tools/transform.lua")
dofile("tools/soundmanager.lua")
dofile("lib/class.lua")
dofile("lib/lsfml.lua")
dofile("tools/stopwatch.lua")
dofile("math/vector.lua")
dofile("tools/description.lua")
dofile("tools/animation.lua")
dofile("tools/event.lua")
dofile("tools/uuid.lua")
dofile("world/world.lua")
class.createFromFile("hitboxs/hitbox.lua")
dofile("hitboxs/hitboxs.lua")
dofile("controls.lua")
dofile("tools/button.lua")
dofile("spells/spell.lua")
dofile("tools/hud.lua")
dofile("tools/item.lua")
dofile("tools/itemstack.lua")
dofile("tools/inventory_slot.lua")
dofile("quete/quete.lua")

-- =========================================
-- =             LOADING CLASSES           =
-- =========================================

class.createFromFile("helpers/ray_caster.lua")
class.createFromFile("entity/entity.lua")
class.createFromFile("entity/entity_laser.lua")
class.createFromFile("entity/entity_boule_magie.lua")
class.createFromFile("entity/entity_blackhole.lua")
class.createFromFile("entity/entity_rayon.lua")
class.createFromFile("entity/entity_slash.lua")
class.createFromFile("entity/entity_laser_beam.lua")
class.createFromFile("entity/entity_slash_weapon.lua")
class.createFromFile("entity/entity_scythe_weapon.lua")
class.createFromFile("entity/entity_boule_elec.lua")
class.createFromFile("entity/entity_vortex.lua")
class.createFromFile("entity/entity_vortex_missile.lua")
class.createFromFile("stats/stats.lua")
class.createFromFile("entity/entity_living.lua")
class.createFromFile("entity/entity_pnj.lua")
class.createFromFile("entity/entity_item.lua")
class.createFromFile("entity/entity_blackhole.lua")
class.createFromFile("entity/entity_player.lua")
class.createFromFile("entity/entity_props.lua")
class.createFromFile("entity/ennemy/robot1.lua")
class.createFromFile("entity/ennemy/robot2.lua")
class.createFromFile("entity/ennemy/robot3.lua")
class.createFromFile("entity/ennemy/turret.lua")
class.createFromFile("entity/ennemy/boss/soucoupe.lua")
class.createFromFile("entity/ennemy/boss/entity_scythe.lua")
class.createFromFile("entity/ennemy/boss/entity_mage.lua")
class.createFromFile("entity/spell/entity_spell.lua")
class.createFromFile("entity/spell/rayon_spell.lua")

-- =========================================
-- =             LOADING SPELLS            =
-- =========================================
freeze = false
freezetime = stopwatch.create()
spells_tab = {
    healSpell = spell.createFromFile("spells/heal.lua"),
    bouleelecSpell = spell.createFromFile("spells/bouleelec.lua"),
    douleurSpell = spell.createFromFile("spells/douleur.lua"),
    dashSpell = spell.createFromFile("spells/dash.lua"),
    elecSpell = spell.createFromFile("spells/elec.lua"),
    picSpell = spell.createFromFile("spells/pic.lua"),
    rayonSpell = spell.createFromFile("spells/rayon.lua"),
    repulsionSpell = spell.createFromFile("spells/repulsion.lua"),
    shieldSpell = spell.createFromFile("spells/shield.lua"),
    tempSpell = spell.createFromFile("spells/temp.lua"),
}

-- =======================
-- =        FONTS        =
-- =======================


assets["fsys"] = lsfml.font.createFromFile("./assets/fonts/fsys.ttf")

-- =========================================
-- =             LOADING ASSETS            =
-- =========================================

window = setmetatable({}, {
    __index = lsfml.window,
    __gc = lsfml.window.destroy,
    __ptr = owindow,
    __type = "window",
})

assets["loading_bar"] = lsfml.texture.createFromFile("./assets/menu/loading_bar.png", {0, 0, 2427, 170})
assets["black"] = lsfml.texture.createFromFile("./assets/menu/black.png", {0, 0, 1920, 1080})
assets["loading"] = lsfml.texture.createFromFile("./assets/menu/loading_screen.png", {0, 0, 7840, 196})
local text = lsfml.text.create()
text:setFont(assets["fsys"])
text:setCharacterSize(200)
text:setString("Enter The Lab")
text:setPosition(350, 50)

local percent = lsfml.text.create()
percent:setFont(assets["fsys"])
percent:setCharacterSize(120)
percent:setPosition(960, 1080)

local background = lsfml.sprite.create()
local loading_bar = lsfml.sprite.create()
local loading_anim = animation.create(assets["loading"], {0, 0 , 195.65, 196})
loading_anim:setPosition(800, 450)
loading_anim:scale(1.5, 1.5)
background:setTexture(assets["black"], false)
loading_bar:setTexture(assets["loading_bar"], false)
loading_bar:setPosition(0, 920)
loading_bar:scale(0.79, 0.5)

local stopwatch = stopwatch.create()
local watch = stopwatch.create()
local prec = 0
function loading(count, total)
    if (count - prec) / total > 0.02 then
        window:draw(background)
        loading_bar:setTextureRect(0, 0, count / total * 2427, 170)
        window:draw(loading_bar)
        local perc = (math.floor((count / total * 100)*100)/100).."%"
        local nx, ny = lsfml.text.getCenter(perc, 120)
        percent:setPosition(960 - nx, 800 - ny)
        percent:setString(perc)
        window:draw(text)
        window:draw(percent)
        loading_anim:next()
        if loading_anim:hasEnded() then
            loading_anim:restart()
        end
        loading_anim:draw()
        window:display()
        prec = count
    end
end

function loadingAssets()
    local handle = io.open("./externs/lua_script/assets.lua", "r")
    if handle then
        local code = handle:read("*all")
        handle:close()

        local total = 0
        for k, v in code:gmatch("updateProgress") do
            total = total + 1
        end
        local func, err = load(code, "Loading Assets", "t", _G)
        if func then
            local assets_load = coroutine.create( func )
            local count = 0
            while coroutine.status(assets_load) ~= "dead" do
                count = count + 1
                loading(count, total)
                coroutine.resume( assets_load )
            end
        else
            error(err)
        end
    end
end

loadingAssets()

-- =========================================
-- =        LOADING SPELL ANIMATION        =
-- =========================================

animationSpell = {
    rayonSpell = new(EntitySpell({
        hitbox = {{0, 0}, {19, 0}, {19, 114}, {0, 114}},
        damage = 0.3,
        spell = assets["rayonAnimation"],
        rect = {0, 0, 19, 114},
        ox = 0,
        oy = 0,
        follow_player = true,
        one_animation = false,
        scale = 3,
        time = 10000,
    })),
    rayonIdleAnimation = new(EntitySpell({
        hitbox = {{0, 0}, {19, 0}, {19, 114}, {0, 114}},
        damage = 0.3,
        spell = assets["rayonIdleAnimation"],
        rect = {0, 114, 19, 114},
        ox = 0,
        oy = 0,
        follow_player = true,
        one_animation = false,
        scale = 3,
        time = 10000,
    })),
    rayonEndAnimation = new(EntitySpell({
        hitbox = {{0, 0}, {19, 0}, {19, 114}, {0, 114}},
        damage = 0.3,
        spell = assets["rayonEndAnimation"],
        rect = {0, 228, 19, 114},
        ox = 0,
        oy = 0,
        follow_player = true,
        one_animation = true,
        scale = 3,
        time = 10000,
    })),
    shieldSpell = new(EntitySpell({
        spell = assets["shieldAnimation"],
        rect = {0, 0, 686, 655},
        ox = 343,
        oy = 555,
        time = 200000,
        scale = 0.25,
        follow_player = false,
        one_animation = true,
    })),
    healSpell = new(EntitySpell({
        spell = assets["healAnimation"],
        rect = {0, 0, 192, 192},
        ox = 96,
        oy = 0,
        time = 100000,
        scale = 1.5,
        follow_player = true,
        one_animation = true,
        pos_x_tp = 0,
        pos_y_tp = -240,
    })),
    picSpell = new(EntitySpell({
        hitbox = {{0, 0}, {457, 0}, {457, 224}, {0, 224}},
        damage = 15,
        spell = assets["picAnimation"],
        rect = {0, 0, 457, 224},
        ox = 457,
        oy = 112,
        time = 100000,
        scale = 1,
        follow_player = true,
        one_animation = true,
        pos_x_tp = 0,
        pos_y_tp = -50,
    })),
    elecSpell = new(EntitySpell({
        hitbox = {{0, 0}, {83, 0}, {83, 249}, {0, 249}},
        damage = 20,
        spell = assets["elecAnimation"],
        rect = {0, 0, 83, 249},
        ox = 41.5,
        oy = 0,
        time = 50000,
        scale = 1.25,
        follow_player = true,
        one_animation = true,
        pos_x_tp = 15,
        pos_y_tp = -60,
    })),
    -- tempSpell = new(EntitySpell({
    --     spell = assets["tempAnimation"],
    --     rect = {0, 0, 573, 573},
    --     time = 400000,
    --     pos_y = 100,
    --     pos_x = 600,
    --     scale = 1.5,
    --     follow_player = false,
    --     one_animation = true,
    -- })),
    repulsionSpell = new(EntitySpell({
        hitbox = {{0, 0}, {900, 0}, {900, 900}, {0, 900}},
        rect = {0, 0, 900, 900},
        spell = assets["repulsionAnimation"],
        damage = 5,
        knockback = 300,
        ox = 450,
        oy = 0,
        time = 80000,
        pos_y = 0,
        pos_x = 0,
        scale = 0.40,
        follow_player = true,
        one_animation = true,
        pos_x_tp = 0,
        pos_y_tp = - 250,
    }))

}

-- =========================================
-- =              LOADING ITEMS            =
-- =========================================

dofile("items.lua")

-- =========================================
-- =               LOAD HUD                =
-- =========================================

player_hud = hud.createFromFile("hud/player_hud.lua", nil, false)
all_sort = hud.createFromFile("hud/sort.lua", nil, false)
bosshealth = hud.createFromFile("hud/boss_health.lua", nil, false)
menu_spell = hud.createFromFile("hud/spell_menu.lua", nil, true)
option_menu = hud.createFromFile("hud/option_hud.lua", nil, true)
temp_hud = hud.createFromFile("hud/temp_hud.lua", nil, false)
dialogue_hud = hud.createFromFile("hud/dialogue.lua", nil, true)
quete_hud = hud.createFromFile("hud/hud_quete.lua", nil, true)


-- =========================================
-- =                 SCENES                =
-- =========================================

loadScene("menu/respawn.lua")
loadScene("menu/loading.lua")
loadScene("menu/howtoplay_menu.lua")
loadScene("menu/main_menu.lua")
loadScene("menu/options_menu.lua")
loadScene("scenes/test_player.lua")
loadScene("scenes/scene2_angle_g.lua")
loadScene("scenes/scene3_intersection_bas.lua")
loadScene("scenes/scene4_angle_haut_gauche.lua")
loadScene("scenes/scene5_intersection_bas.lua")
loadScene("scenes/scene6_salle.lua")
loadScene("scenes/scene7_angle_droit.lua")
loadScene("scenes/scene8_salle.lua")
loadScene("scenes/scene9_horizontal.lua")
loadScene("scenes/scene10_intersection_haut.lua")
loadScene("scenes/scene11_angle_droit.lua")
loadScene("scenes/scene12_salle.lua")
loadScene("scenes/scene13_vertical.lua")
loadScene("scenes/scene14_escalier.lua")

loadScene("scenes/scene15_start.lua")
loadScene("scenes/scene16_left_start.lua")
loadScene("scenes/scene17_right_start.lua")
loadScene("scenes/scene18_boss.lua")

loadScene("scenes/last_scene.lua")
loadScene("scenes/fin.lua")

-- =========================================
-- =           MYRPG GAME-LOGIC            =
-- =========================================

player = new(EntityPlayer({
    pos_x = 1037,
    pos_y = 684,
    texture = assets["player"],
    speed = 5,
}))

-- Called at the beginning of the program
function init()

    setScene("main_menu")
end

-- Called each time we need to draw a frame
function draw()
    if scenes[scene_name] then
        scenes[scene_name].draw()
        if world.isRenderEnabled() then
            hitbox.draw()
            world.draw()
        end
        if hud.isRenderEnabled() then
            for i=1, #hudorder do
                if hudorder[i]:isOpen() then
                    hudorder[i]:draw()
                end
            end
        end
    else
        error("Scene not found '"..scene_name.."'", 2)
    end
end

-- Called each time we need to update the game-logic
function update()
    stopwatch.update()
    if pstate ~= isPaused() then
        if isPaused() then
            _G.game_pause()
        else
            _G.game_resume()
        end
        pstate = isPaused()
    end
    if scenes[scene_name] then
        if not isPaused() then
            scenes[scene_name].update()
            for i=1, #spells do
                spells[i]:update()
            end
            if not freeze then
                if world.isUpdateEnabled() then
                    world.update()
                end
            else
                if world.isUpdateEnabled() then
                    player.update()
                end
                if freezetime:getEllapsedTime() > 5000000 then
                    freeze = false
                end
            end
        end
        for i=1, #hudorder do
            if hudorder[i]:isOpen() then
                hudorder[i]:update()
            end
        end
    else
        error("Scene not found '"..scene_name.."'", 2)
    end
end

-- Called when an event is produced
function event(...)
    local evt = {...}
    local e = event_helper.create(...)
    if evt[1] == "close" then
        window:close()
        return
    end
    if evt[1] == "key_pressed" and evt[2] == controls.getControl("show_hitbox") then
        if hitbox.isDrawEnable() then
            hitbox.disableDraw()
        else
            hitbox.enableDraw()
        end
    end
    if evt[1] == "key_pressed" and evt[2] == keys.Escape and getScene() ~= "options_menu" then
        local found = false
        for i=#hudorder, 1, -1 do
            local meta = getmetatable(hudorder[i])
            if hudorder[i]:isOpen() and hudorder[i]:canBeClosed() then
                hudorder[i]:close()
                found = true
                break
            end
        end
        if found == false then
            option_menu:open()
        end
    end
    if scenes[scene_name] then
        scenes[scene_name].event(e)
        if world.isEventEnabled() then
            world.event(e)
            local hzindex = {}
            for i=1, #hudorder do
                hzindex[i] = hudorder[i]
            end
            local eHUD = event_helper.create(...)
            if #hudorder > 0 and hudorder[#hudorder]:canBeClosed() then
                hudorder[#hudorder]:event(eHUD)
            end
            for i=1, #huds do
                if not eHUD:isCanceled() then
                    local found = false
                    for j=1, #hzindex do
                        if huds[i]:getUUID() == hzindex[j]:getUUID() and huds[i]:canBeClosed() then
                            found = true
                            break
                        end
                    end
                    if found == false then
                        huds[i]:event(eHUD)
                        if eHUD:isCanceled() then
                            break
                        end
                    end
                end
            end
        end
    else
        error("Scene not found '"..scene_name.."'", 2)
    end
end

function game_pause()
    if assets["time"]:isPlaying() then
        assets["time"]:pause()
    end
    if assets["alarm"]:isPlaying() then
        assets["alarm"]:pause()
    end
    if assets["slash_sound"]:isPlaying() then
        assets["slash_sound"]:pause()
    end
    -- if assets["robot1_sound"]:isPlaying() then
    --     assets["robot2_sound"]:pause()
    -- end
    -- if assets["robot2_sound"]:isPlaying() then
    --     assets["robot2_sound"]:pause()
    -- end
    if assets["scythe_ulti"]:isPlaying() then
        assets["scythe_ulti"]:pause()
    end
    if assets["mage_teleport"]:isPlaying() then
        assets["mage_teleport"]:pause()
    end
    if assets["door_sound"]:isPlaying() then
        assets["door_sound"]:pause()
    end
    if assets["laser_sound"]:isPlaying() then
        assets["laser_sound"]:pause()
    end
end

function game_resume()
    if assets["time"]:isPaused() then
        assets["time"]:play()
    end
    if assets["alarm"]:isPaused() then
        assets["alarm"]:play()
    end
    if assets["slash_sound"]:isPaused() then
        assets["slash_sound"]:play()
    end
    -- if assets["robot1_sound"]:isPaused() then
    --     assets["robot2_sound"]:play()
    -- end
    -- if assets["robot2_sound"]:isPaused() then
    --     assets["robot2_sound"]:play()
    -- end
    if assets["scythe_ulti"]:isPaused() then
        assets["scythe_ulti"]:play()
    end
    if assets["mage_teleport"]:isPaused() then
        assets["mage_teleport"]:play()
    end
    if assets["door_sound"]:isPaused() then
        assets["door_sound"]:play()
    end
    if assets["laser_sound"]:isPaused() then
        assets["laser_sound"]:play()
    end
end