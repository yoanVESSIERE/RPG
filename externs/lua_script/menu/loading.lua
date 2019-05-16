-- =============================================
-- =                LOADING SCREEN             =
-- =============================================
local stopwatch = stopwatch.create()
local watch = stopwatch.create()
local background = lsfml.sprite.create()
local loading_anim = animation.create(assets["loading"], {0, 0 , 195.65, 196})
loading_anim:setPosition(800, 450)
loading_anim:scale(1.5, 1.5)
background:setTexture(assets["black"], false)

function load()
    world.renderDisable()
    world.updateDisable()
    world.eventDisable()
    hud.renderDisable()
end

function unload()
    world.eventEnable()
    world.updateEnable()
    world.renderEnable()
    hud.renderEnable()
end

function draw()
    window:draw(background)
    if stopwatch:getEllapsedTime() > 16500 then
        stopwatch:restart()
        loading_anim:next()
    end
    loading_anim:draw()
    if loading_anim:hasEnded() then
        loading_anim:restart()
    end
    if watch:getEllapsedTime() > 3000000 then
        setScene("main_menu")
    end
end

function update()

end

function event(e)

end