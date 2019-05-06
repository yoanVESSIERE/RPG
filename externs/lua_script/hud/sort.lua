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
                    if player.getMana() >= spells_tab[selected_spell_name[1]]:getCost() then
                        status_sort[1] = "up"
                    else
                        assets["deny"]:play()
                    end
                elseif keyboard.keyPressed(controls.getControl("spell_2")) and spells_tab[selected_spell_name[2]] then
                    if player.getMana() >= spells_tab[selected_spell_name[2]]:getCost() then
                        status_sort[2] = "up"
                    else
                        assets["deny"]:play()
                    end
                elseif keyboard.keyPressed(controls.getControl("spell_3")) and spells_tab[selected_spell_name[3]] then
                    if player.getMana() >= spells_tab[selected_spell_name[3]]:getCost() then
                        status_sort[3] = "up"
                    else
                        assets["deny"]:play()
                    end
                elseif keyboard.keyPressed(controls.getControl("spell_4")) and spells_tab[selected_spell_name[4]] then
                    if player.getMana() >= spells_tab[selected_spell_name[4]]:getCost() then
                        status_sort[4] = "up"
                    else
                        assets["deny"]:play()
                    end
                elseif keyboard.keyPressed(controls.getControl("spell_5")) and spells_tab[selected_spell_name[5]] then
                    if player.getMana() >= spells_tab[selected_spell_name[5]]:getCost() then
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

-- =========================================
-- =             SORT EFFECT               =
-- =========================================

-- function douleurSpell()
--     if (player.getMana() < 10 or status_sort["douleurSpell"] == "down") then
--         if clock_sort["douleurSpell"]:getEllapsedTime() < cooldown_sort["douleurSpell"] then
--             assets["deny"]:play()
--         end
--         return
--     end
--     if (status_sort["douleurSpell"] == "up") then
--         player.removeMana(10)
--         status_sort["douleurSpell"] = "down"
--         cooldown_sort["douleurSpell"] = 20000000
--     end
--     --donne un status de degats renvoyé au joueurs so l'ennemi en prend aussi
-- end
--         player.activateSpell()
--         cooldown_used_spell = 2000000
--         status_cooldown_used_spell = true
--     end
--     --lance un éclair droit devant le joueur et si touche l'ennemi il prend des damages
-- end

-- function healSpell()
--     if (player.getMana() < 2 or status_sort["healSpell"] == "down") then
--         if clock_sort["healSpell"]:getEllapsedTime() < cooldown_sort["healSpell"] then
--             assets["deny"]:play()
--         end
--         return
--     end
--     if (status_sort["healSpell"] == "up") then
--         player.removeMana(2)
--         player.heal(30)
--         assets["heal"]:play()
--         status_sort["healSpell"] = "down"
--         cooldown_sort["healSpell"] = 10000000
--     end
-- end

-- function picSpell()
--     if (player.getMana() < 3 or status_sort["picSpell"] == "down") then
--         if clock_sort["picSpell"]:getEllapsedTime() < cooldown_sort["picSpell"] then
--             assets["deny"]:play()
--         end
--         return
--     end
--     if (status_sort["picSpell"] == "up") then
--         player.removeMana(3)
--         status_sort["picSpell"] = "down"
--         cooldown_sort["picSpell"] = 3000000
--     end
--     --Une lance energétique sort de la main du joueur a courte portée infligant des damages 
-- end

-- function rayonSpellEffect()
--     if (player.getMana() < 1) then
--         assets["deny"]:play()
--         return
--     end

--     if clock_sort["rayonSpell"]:getEllapsedTime() > 1000 then
--         clock_sort["rayonSpell"]:restart()
--         player.removeMana(1)
--     end
-- end

-- function rayonSpell()
--     rayon_spell = true
--     player.activateSpell()
--     -- un rayon de feu voir une boule de feu sort du joueur
-- end

-- function bouleelecSpell()
--     if (player.getMana() < 7 or status_sort["bouleelecSpell"] == "down") then
--         if clock_sort["bouleelecSpell"]:getEllapsedTime() < cooldown_sort["bouleelecSpell"] then
--             assets["deny"]:play()
--         end
--         return
--     end
--     if (status_sort["bouleelecSpell"] == "up") then
--         player.removeMana(7)
--         status_sort["bouleelecSpell"] = "down"
--         cooldown_sort["bouleelecSpell"] = 10000000
--     end
--     -- un boule d'electricity spawn a quelque case du joueur et attaque les ennemis proche
-- end

-- function dashSpell()
--     status, hor, ver = player.getStatus()
--     if (status == "idle" or player.getMana() < 1 or status_sort["dashSpell"] == "down") then
--         if clock_sort["dashSpell"]:getEllapsedTime() < cooldown_sort["dashSpell"] then
--         assets["deny"]:play()
--     end
--         return
--     end
--     if (status_sort["dashSpell"] == "up") then
--         player.removeMana(1)
--         assets["dash"]:play()
--         x, y = player.getPosition()
--         if (hor == "right") then
--             player.setPosition(x + 100, y)
--         end
--         if (hor == "left") then
--             player.setPosition(x - 100, y)
--         end
--         if (ver == "down") then
--             if (hor == "left") then
--                 player.setPosition(x - 70, y + 70)
--                 return
--             end
--             if (hor == "right") then
--                 player.setPosition(x + 70, y + 70)
--                 return
--             end
--             player.setPosition(x, y + 100)
--         end
--         if (ver == "up") then
--             if (hor == "left") then
--                 player.setPosition(x - 70, y - 70)
--                 return
--             end
--             if (hor == "right") then
--                 player.setPosition(x + 70, y - 70)
--                 return
--             end
--             player.setPosition(x, y - 100)
--         end
--         status_sort["dashSpell"] = "down"
--         cooldown_sort["dashSpell"] = 500000
--     end
-- end

-- function repulsionSpell()
--     if (player.getMana() < 4 or status_sort["repulsionSpell"] == "down") then
--         if clock_sort["repulsionSpell"]:getEllapsedTime() < cooldown_sort["repulsionSpell"] then
--             assets["deny"]:play()
--         end
--         return
--     end
--     if (status_sort["repulsionSpell"] == "up") then
--         player.removeMana(4)
--         status_sort["repulsionSpell"] = "down"
--         cooldown_sort["repulsionSpell"] = 5000000
--     end
--     -- repousse de quelque case les ennemis autour
-- end

-- function shieldSpell()
--     if (player.getMana() < 10) then
--         if clock_sort["shieldSpell"]:getEllapsedTime() < cooldown_sort["shieldSpell"] then
--             assets["deny"]:play()
--         end
--         return
--     end
--     if (status_sort["shieldSpell"] == "up" or status_sort["shieldSpell"] == "down") then
--         player.removeMana(10)
--         assets["shield"]:setVolume(200)
--         assets["shield"]:play()
--         player.addDefense(10)
--         status_sort["shieldSpell"] = "down"
--         cooldown_sort["shieldSpell"] = 13000000
--     end
--     -- donne un shield au joueur pour 10 seconde
-- end

-- function tempSpell()
--     if (player.getMana() < 15 or status_sort["tempSpell"] == "down") then
--         if clock_sort["tempSpell"]:getEllapsedTime() < cooldown_sort["tempSpell"] then
--             assets["deny"]:play()
--         end
--         return
--     end
--     if (status_sort["tempSpell"] == "up") then
--         player.removeMana(15)
--         assets["time"]:setVolume(100)
--         assets["time"]:play()
--         status_sort["tempSpell"] = "down"
--         cooldown_sort["tempSpell"] = 20000000
--     end
--     -- ralenti tout les ennemis dans la salle pour 5 seconde
-- end