-- =========================================
-- =               TEMP HUD                =
-- =========================================

local time = animation.create(assets["tempAnimation"], {0, 0, 573, 573})
time:setPosition(600, 125)
time:setScale(1.5, 1.5)
local clock = stopwatch.create()
local is_activate = false

function load(self)

end

function open(self)

end

function close(self)

end

function restart()
    is_activate = true
    time:restart()
end

function draw(self)
    if is_activate then
        if clock:getEllapsedTime() > 625000 then
            clock:restart()
            time:next()
            if time:hasEnded() then
                is_activate = false
            end
        end
        time:draw()
    end
end

function update(self)

end

function event(self, e)

end
