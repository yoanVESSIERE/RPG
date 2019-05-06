-- =========================================
-- =               QUEST HUD                =
-- =========================================

local hud_quete = lsfml.sprite.create()
local text_quest_aquired = lsfml.text.create()
local text_quest_description = lsfml.text.create()
local text_quest_press = lsfml.text.create()

hud_quete:setTexture(assets["button_idle"], false)
hud_quete:setPosition(1415, 0)
hud_quete:setScale(1.2, 2.5)

text_quest_aquired:setCharacterSize(50)
text_quest_aquired:setFont(assets["fsys"])
text_quest_aquired:setPosition(1500, 10)
text_quest_aquired:setString("QUEST ACQUIRED")

text_quest_description:setCharacterSize(30)
text_quest_description:setFont(assets["fsys"])
text_quest_description:setPosition(1500, 100)
text_quest_description:setString("Tu doit trouver les 6\nmorceaux de parchemins\nqui sont quelque\npars dans cette structure\n Fais attention aux\ndangereux ennemis !!!")

text_quest_press:setCharacterSize(25)
text_quest_press:setFont(assets["fsys"])
text_quest_press:setPosition(1500, 320)
text_quest_press:setString("["..keyboard.getKeyName(controls.getControl("hide/show")).."] Hide/Show")

function load(self)

end

function open(self)

end

function close(self)

end

function restart()

end

function draw(self)
    window:draw(hud_quete)
    window:draw(text_quest_aquired)
    window:draw(text_quest_description)
    window:draw(text_quest_press)
end

function update(self)
    text_quest_press:setString("["..keyboard.getKeyName(controls.getControl("hide/show")).."] Hide/Show")
end

function event(self, e)
    local event = e:getEvent()
    if event[1] == "key_pressed" and event[2] == controls.getControl("hide/show") and player:getIsInQuest() then
        if self:isOpen() then
            hud.close(self)
        else
            hud.open(self)
        end
    end
end
