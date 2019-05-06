-- =========================================
-- =               PLAYER HUD              =
-- =========================================

local health_bar = lsfml.sprite.create()
local stamina_bar = lsfml.sprite.create()
local empty_bar1 = lsfml.sprite.create()
local empty_bar2 = lsfml.sprite.create()
local sort_bar = lsfml.sprite.create()
local other_item = lsfml.sprite.create()
local empty_bar3 = lsfml.sprite.create()
local mana_bar = lsfml.sprite.create()
local hand1 = lsfml.sprite.create()
local hand2 = lsfml.sprite.create()
local touche = lsfml.sprite.create()
local touch_pos = {0, 0}
local touch_show = false
local scythe_left = lsfml.sprite.create()
local scythe_right = lsfml.sprite.create()
local scythe_right_text = lsfml.text.create()

scythe_right_text:setCharacterSize(24)
scythe_right_text:setPosition(705 - 74, 889 + 66 * 0.5 + 35)
scythe_right_text:setFont(assets["fsys"])

scythe_left:setTexture(assets["scythe_left"], false)
scythe_right:setTexture(assets["scythe_right"], false)

scythe_left:setPosition(705 - 158, 889 + 66 * 0.5 + 35)
scythe_right:setPosition(705 - 74, 889 + 66 * 0.5 + 35)

scythe_left:setOrigin(35, 35)
scythe_right:setOrigin(35, 35)

scythe_left:setRotation(-135)

local touch_text = lsfml.text.create()
local healtext = lsfml.text.create()
local manatext = lsfml.text.create()
local xptext = lsfml.text.create()
local staminatext = lsfml.text.create()

local spell1 = lsfml.text.create()
local spell2 = lsfml.text.create()
local spell3 = lsfml.text.create()
local spell4 = lsfml.text.create()
local spell5 = lsfml.text.create()

local xp_bar_empty = lsfml.sprite.create()
local xp_bar = lsfml.sprite.create()

xp_bar:setTexture(assets["xp_bar"], false)
xp_bar_empty:setTexture(assets["xp_bar_empty"], false)

xp_bar:setPosition(723, 889 - 73 * 0.43)
xp_bar_empty:setPosition(723, 889 - 73 * 0.43)

xp_bar:setScale(0.43, 0.43)
xp_bar_empty:setScale(0.43, 0.43)
xptext:setPosition(723 + 533 * 0.43, 889 - 73 * 0.43 + 48 * 0.43)
xptext:setCharacterSize(24)
xptext:setFont(assets["fsys"])
xptext:setString("0 / 100")

local csize = 24

spell1:setPosition(705 + 91, 889 + 28)
spell2:setPosition(705, 889)
spell3:setPosition(705, 889)
spell4:setPosition(705, 889)
spell5:setPosition(705, 889)
touch_text:setPosition(1140, 230)
healtext:setPosition(620 * 0.25, 174 * 0.25)
manatext:setPosition(620 * 0.25, 164 + 174 * 0.25)
staminatext:setPosition(620 * 0.25, 82 + 174 * 0.25)

touch_text:setCharacterSize(24)
healtext:setCharacterSize(24)
staminatext:setCharacterSize(24)
manatext:setCharacterSize(24)
spell1:setCharacterSize(csize)
spell2:setCharacterSize(csize)
spell3:setCharacterSize(csize)
spell4:setCharacterSize(csize)
spell5:setCharacterSize(csize)

touch_text:setFont(assets["fsys"])
healtext:setFont(assets["fsys"])
staminatext:setFont(assets["fsys"])
manatext:setFont(assets["fsys"])
spell1:setFont(assets["fsys"])
spell2:setFont(assets["fsys"])
spell3:setFont(assets["fsys"])
spell4:setFont(assets["fsys"])
spell5:setFont(assets["fsys"])

health_bar:setPosition(0, 0)
stamina_bar:setPosition(0, 82)
mana_bar:setPosition(0, 164)
empty_bar1:setPosition(0, 0)
empty_bar2:setPosition(0, 82)
empty_bar3:setPosition(0, 164)
sort_bar:setPosition(705, 889)
other_item:setPosition(1250, 900)
hand1:setPosition(1250 + 24, 900 + 24)
hand2:setPosition(1250 + 241 * 0.5 + 24, 900 + 24)

touche:setTexture(assets["hud_touche"], false)
health_bar:setTexture(assets["hud_health"], false)
stamina_bar:setTexture(assets["hud_stamina"], false)
mana_bar:setTexture(assets["hud_mana"], false)
empty_bar1:setTexture(assets["hud_empty_health_bar"], false)
empty_bar2:setTexture(assets["hud_empty_stamina_bar"], false)
empty_bar3:setTexture(assets["hud_empty_mana_bar"], false)
sort_bar:setTexture(assets["sort_bar"], false)
other_item:setTexture(assets["other_item"], false)

health_bar:setScale(0.25, 0.25)
mana_bar:setScale(0.25, 0.25)
stamina_bar:setScale(0.25, 0.25)
empty_bar1:setScale(0.25, 0.25)
empty_bar2:setScale(0.25, 0.25)
empty_bar3:setScale(0.25, 0.25)
sort_bar:setScale(0.5, 0.5)
other_item:setScale(0.5, 0.5)

function setInteractTouchPosition(self, x, y)
    check(x, "number", 2)
    check(y, "number", 3)

    touch_pos = {x, y}
end

function showInteractTouch(self, state)
    check(state, "boolean", 2)

    show_touch = state
end

function load(self)

end

function open(self)
    all_sort:open()
    bosshealth:open()
    temp_hud:open()
end

function close(self)
    all_sort:close()
    bosshealth:close()
    temp_hud:close()
end

function draw(self)
    window:draw(empty_bar1)
    window:draw(empty_bar2)
    window:draw(empty_bar3)
    window:draw(health_bar)
    window:draw(mana_bar)
    window:draw(stamina_bar)
    window:draw(xp_bar_empty)
    window:draw(xp_bar)
    window:draw(xptext)
    window:draw(sort_bar)
    window:draw(other_item)
    window:draw(hand1)
    window:draw(hand2)
    window:draw(spell1)
    window:draw(spell2)
    window:draw(spell3)
    window:draw(spell4)
    window:draw(spell5)
    window:draw(healtext)
    window:draw(manatext)
    window:draw(staminatext)
    if show_touch then
        window:draw(touche)
        window:draw(touch_text)
    end
    if player.hasScythe() then
        window:draw(scythe_left)
        window:draw(scythe_right)
        if player.isScytheBoomrangInCooldown() then
            window:draw(scythe_right_text)
        end
    end
end

local function update_stamina()
    local maxstamina = tostring(math.floor(player.getMaximumStamina()))
    local stamina = tostring(math.floor(player.getStamina()))
    local h = string.rep("0", #maxstamina-#stamina)..stamina
    local txt = h.." / "..maxstamina
    staminatext:setString(txt)
    local px, py = lsfml.text.getCenter(txt, 24)
    staminatext:setPosition(620 * 0.25 - px, 82 + 174 * 0.25 - py)
    stamina_bar:setTextureRect(0, 0, math.floor(player.getStamina() / player.getMaximumStamina() * 980), 328)
end

local function update_health()
    local maxhealth = tostring(math.floor(player.getMaximumHealth()))
    local health = tostring(math.floor(player.getHealth()))
    local h = string.rep("0", #maxhealth-#health)..health
    local txt = h.." / "..maxhealth
    healtext:setString(txt)
    local px, py = lsfml.text.getCenter(txt, 24)
    healtext:setPosition(620 * 0.25 - px, 174 * 0.25 - py)
    health_bar:setTextureRect(0, 0, math.floor(player.getHealth() / player.getMaximumHealth() * 980), 328)
end

local function update_mana()
    local maxmana = tostring(math.floor(player.getMaximumMana()))
    local mana = tostring(math.floor(player.getMana()))
    local h = string.rep("0", #maxmana-#mana)..mana
    local txt = h.." / "..maxmana
    manatext:setString(txt)
    local px, py = lsfml.text.getCenter(txt, 24)
    manatext:setPosition(620 * 0.25 - px, 164 + 174 * 0.25 - py)
    mana_bar:setTextureRect(0, 0, math.floor(player.getMana() / player.getMaximumMana() * 980), 328)
end

local function update_experience()
    local nextexp = tostring(math.floor(player.getNextExperienceStage()))
    local exp = tostring(math.floor(player.getExperience()))
    local h = string.rep("0", #nextexp-#exp)..exp
    local txt = h.." / "..nextexp
    xptext:setString(txt)
    local px, py = lsfml.text.getCenter(txt, 24)
    xptext:setPosition(723 + 533 * 0.43 - px, 889 - 73 * 0.43 + 48 * 0.43 - py)
    xp_bar:setTextureRect(0, 0, math.floor(player.getExperience() / player.getNextExperienceStage() * 1080), 80)
end

function update_interact_key()
    local key = keyboard.getKeyName(controls.getControl("action")):sub(1, 3)
    touch_text:setString(key)
    local px, py = lsfml.text.getCenter(key, 24)
    touch_text:setPosition(touch_pos[1] + 26 - px, touch_pos[2] + 27 - py)
    touche:setPosition(touch_pos[1], touch_pos[2])
end

function update_hand1()
    local item1 = player.getInventory():getItemInSlot(33)
    if item1 and item1:getStackSize() > 0 then
        hand1:setTexture(item1:getItem():getTexture(), false)
        hand1:setTextureRect(0, 0, 64, 64)
    else
        hand1:setTextureRect(0, 0, 0, 0)
    end
end

function update_hand2()
    local item2 = player.getInventory():getItemInSlot(34)
    if item2 and item2:getStackSize() > 0 then
        hand2:setTexture(item2:getItem():getTexture(), false)
        hand2:setTextureRect(0, 0, 64, 64)
    else
        hand2:setTextureRect(0, 0, 0, 0)
    end
end

function update_sort_bar()
    local t1 = keyboard.getKeyName(controls.getControl("spell_1"))
    local t2 = keyboard.getKeyName(controls.getControl("spell_2"))
    local t3 = keyboard.getKeyName(controls.getControl("spell_3"))
    local t4 = keyboard.getKeyName(controls.getControl("spell_4"))
    local t5 = keyboard.getKeyName(controls.getControl("spell_5"))

    spell1:setString(t1)
    spell2:setString(t2)
    spell3:setString(t3)
    spell4:setString(t4)
    spell5:setString(t5)

    local nx, ny = lsfml.text.getCenter(t1, csize)
    spell1:setPosition(705 + 118 * 0.5 - nx, 889 + 38 * 0.5 - ny)
    nx, ny = lsfml.text.getCenter(t2, csize)
    spell2:setPosition(705 + 307 * 0.5 - nx, 889 + 38 * 0.5 - ny)
    nx, ny = lsfml.text.getCenter(t3, csize)
    spell3:setPosition(705 + 497 * 0.5 - nx, 889 + 38 * 0.5 - ny)
    nx, ny = lsfml.text.getCenter(t4, csize)
    spell4:setPosition(705 + 693 * 0.5 - nx, 889 + 38 * 0.5 - ny)
    nx, ny = lsfml.text.getCenter(t5, csize)
    spell5:setPosition(705 + 879 * 0.5 - nx, 889 + 38 * 0.5 - ny)
end

function update(self)
    update_health()
    update_mana()
    update_stamina()
    update_interact_key()
    update_hand1()
    update_hand2()
    update_sort_bar()
    update_experience()
    scythe_left:setColor(255, 255, 255, 255)
    scythe_right:setColor(255, 255, 255, 255)
    if player.getScytheAttack() == "slash" or player.getScytheAttack() == "slash_attack" then
        scythe_left:setColor(75, 75, 75, 255)
    elseif player.getScytheAttack() == "scythe_launch" then
        scythe_left:setColor(75, 75, 75, 255)
        scythe_right:setColor(75, 75, 75, 255)
    end
    if player.isScytheBoomrangInCooldown() then
        scythe_right:setColor(75, 75, 75, 255)
        local cd = tostring(player.getScytheBoomrangCooldown()):sub(1, 4)
        scythe_right_text:setString(cd)
        local nx, ny = lsfml.text.getCenter(cd, 24)
        scythe_right_text:setPosition(705 - 74 - nx, 889 + 66 * 0.5 + 35 - ny)
    end
end

function event(self, e)

end
