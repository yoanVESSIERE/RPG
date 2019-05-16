-- =========================================
-- =                SORT                   =
-- =========================================

function initCd()
    local tab = {}

    for i = 1, 5 do
        tab[i] = lsfml.text.create()
        tab[i]:setFont(assets["fsys"])
        tab[i]:setPosition(710 + 30.5 + 93.5 * (i - 1), 920 + 16.5)
        tab[i]:setString("")
    end
    return tab
end

local selected_spell_sprite = {}
local selected_spell_name = {}
local cd = initCd()
local status_sort = {"down", "down", "down", "down", "down"}

function changeSort(self, index, sort, sprite)
    check(self, "hud", 1)
    check(index, "number", 2)
    check(sort, "string", 3)
    check(sprite, "sprite", 4)

    for i = 1, 5 do
        if selected_spell_name[i] and selected_spell_name[i] == sort then
            selected_spell_name[i] = nil
            selected_spell_sprite[i] = nil
        end
    end
    selected_spell_sprite[index] = sprite:copy()
    selected_spell_sprite[index]:setPosition(705 + 30.5 + 93.5 * (index - 1), 920 + 9.5)
    selected_spell_name[index] = sort
end

function event(self, e)
    check(self, "hud", 1)

    status_sort = {"down", "down", "down", "down", "down"}
    if player.isAlive() then
        if not isPaused() then
            if menu_spell:isClose() then
                if keyboard.keyPressed(controls.getControl("spell_1")) and spells_tab[selected_spell_name[1]] then
                    if player.getMana() >= spells_tab[selected_spell_name[1]]:getCost() and not player.isInSpell() then
                        status_sort[1] = "up"
                    elseif player.isInSpell() and spells_tab[selected_spell_name[1]]:getStatus() == "enable" then 
                        status_sort[1] = "up"
                    else
                        assets["deny"]:play()
                    end
                elseif keyboard.keyPressed(controls.getControl("spell_2")) and spells_tab[selected_spell_name[2]] then
                    if player.getMana() >= spells_tab[selected_spell_name[2]]:getCost() and not player.isInSpell() then
                        status_sort[2] = "up"
                    elseif player.isInSpell() and spells_tab[selected_spell_name[2]]:getStatus() == "enable" then 
                        status_sort[2] = "up"
                    else
                        assets["deny"]:play()
                    end
                elseif keyboard.keyPressed(controls.getControl("spell_3")) and spells_tab[selected_spell_name[3]] then
                    if player.getMana() >= spells_tab[selected_spell_name[3]]:getCost() and not player.isInSpell() then
                        status_sort[3] = "up"
                    elseif player.isInSpell() and spells_tab[selected_spell_name[3]]:getStatus() == "enable" then 
                        status_sort[3] = "up"
                    else
                        assets["deny"]:play()
                    end
                elseif keyboard.keyPressed(controls.getControl("spell_4")) and spells_tab[selected_spell_name[4]] then
                    if player.getMana() >= spells_tab[selected_spell_name[4]]:getCost() and not player.isInSpell() then
                        status_sort[4] = "up"
                    elseif player.isInSpell() and spells_tab[selected_spell_name[4]]:getStatus() == "enable" then 
                        status_sort[4] = "up"
                    else
                        assets["deny"]:play()
                    end
                elseif keyboard.keyPressed(controls.getControl("spell_5")) and spells_tab[selected_spell_name[5]] then
                    if player.getMana() >= spells_tab[selected_spell_name[5]]:getCost() and not player.isInSpell() then
                        status_sort[5] = "up"
                    elseif player.isInSpell() and spells_tab[selected_spell_name[5]]:getStatus() == "enable" then 
                        status_sort[5] = "up"
                    else
                        assets["deny"]:play()
                    end
                end
            end
        end
    end
end

function update(self)
    check(self, "hud", 1)

    if not player.isAlive() then
        status_sort = {"down", "down", "down", "down", "down"}
    end
    if not isPaused() then
        for i = 1, 5 do
            if status_sort[i] == "up" and spells_tab[selected_spell_name[i]] then
                if (spells_tab[selected_spell_name[i]]:isInstant()) then
                    spells_tab[selected_spell_name[i]]:cast()
                    status_sort[i] = "down"
                elseif player.getMana() >= spells_tab[selected_spell_name[i]]:getCost() then
                    spells_tab[selected_spell_name[i]]:enable()
                end
            elseif spells_tab[selected_spell_name[i]] and not spells_tab[selected_spell_name[i]]:isInstant() then
                spells_tab[selected_spell_name[i]]:disable()
            end
        end
        for i = 1, 5 do
            if selected_spell_name[i] and spells_tab[selected_spell_name[i]] and spells_tab[selected_spell_name[i]]:isInCooldown() and spells_tab[selected_spell_name[i]]:getMaxCooldown() ~= 0 then
                local full_number = tostring(spells_tab[selected_spell_name[i]]:getCooldown())
                cd[i]:setString(string.sub(full_number, 1, 4))
                local color = math.ceil(255 / spells_tab[selected_spell_name[i]]:getCooldown())
                if color > 255 then
                    color = 255
                end
                selected_spell_sprite[i]:setColor(color, color, color, 255)
            end
        end
    end
end

function draw(self)
    check(self, "hud", 1)

    for i = 1, 5 do
        if selected_spell_sprite[i] and spells_tab[selected_spell_name[i]] then
            window:draw(selected_spell_sprite[i])
            if spells_tab[selected_spell_name[i]]:isInCooldown() then
            window:draw(cd[i])
            end
        end
    end
end