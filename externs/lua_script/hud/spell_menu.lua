-- =========================================
-- =                SPELL MENU             =
-- =========================================

function initMenuSpellSprite(spell)
    local tab = {}
    local j = 0
    local y = 0
    for i, v in pairs(spell) do
        tab[i] = lsfml.sprite.create()
        tab[i]:setTexture(v, false)
        tab[i]:setScale(0.5, 0.5)
        y = math.modf(j / 4)
        tab[i]:setPosition(625 + 64.5 + 156 * j - y * 156 * 4, 305 + 54 + y * 125)
        j = j + 1
    end
    return (tab)
end

local spell_info = {
    healSpell = {"Heal", "Vous soigne de\nquelque PV\n\nVoir que vous\netes capable de\ntant de chose \nvous rempli de \nDETERMINATION"},
    elecSpell = {"Elec","Lance un eclair\ndans la\ndirection que\nvous regardez\n\nVous n'avez rien\nn'as envier au \nseigneur\nPalpatine..."},
    picSpell = {"Sword", "Lance une epee\ndans la\ndirection que\nvous regardez\n\nVotre corps\npeut se moduler\npour former des\narmes,\nMAGINIFIQUE"},
    rayonSpell = {"Rayon", "Lance un rayon\ncontinu dans la\ndirection que\nvous regardez\n\nBeau rayon de\nlumiere, sous\nles projecteurs"},
    bouleelecSpell = {"Energy Ball", "Lance un projectile\ndans la\ndirection que\nvous regardez\n\nL'energie n'est\nqu'une forme\nirreelle prenant\ndifferentes formes"},
    dashSpell = {"Dash", "Vous projette\nvers la direction\ndans laquelle\nvous\nregardez\n\nComment ca on\na plagier\nl'image de League\nOf Leagend ?"},
    repulsionSpell = {"Repulsion", "Tout les ennemis\net projectiles\nautour de vous sont\nexpulsé\n\nUne onde de choc\ndigne des explosions\nnucleaire !"},
    shieldSpell = {"Shield", "Vous protege\nen continue (tant\nque vous appuiez\ndessus)\n\nQui aurais crus\nqu'un bouclier\npouvait prendre\nune forme\noctogonale ?"},
    tempSpell = {"Time", "Arrete le\ntemps pendant\nquelque seconde\n\nTo be continued ->\n (Ceci est une\nreference)"},

}
local spell = initMenuSpellSprite({
    healSpell = assets["healSpell"],
    elecSpell = assets["elecSpell"],
    picSpell = assets["picSpell"],
    rayonSpell = assets["rayonSpell"],
    bouleelecSpell = assets["bouleelecSpell"],
    dashSpell = assets["dashSpell"],
    repulsionSpell = assets["repulsionSpell"],
    shieldSpell = assets["shieldSpell"],
    tempSpell = assets["tempSpell"],
})

local help_spell = description.create(assets["info"], assets["fsys"])
help_spell:setPosition(1320, 305)
help_spell:setScale(0.34, 0.34)
local spell_menu = lsfml.sprite.create()
spell_menu:setTexture(assets["spell_hub"], false)
spell_menu:setScale(0.5, 0.5)
spell_menu:setPosition(625, 305)
help_spell:setCharacterSize(30)
local type = "menu_sort"
local index = menu_sort
local all_spell = spell
local old_pos_x = -1
local old_pos_y = -1
local origin_pos_x = -1
local origin_pos_y = -1
local selected_spell_name = nil
local selected_spell = nil
local spell_hub = spell_menu
local selected_spell_index = 0
local bool_spell = false
local spell_description = nil
local actually_set = nil

function event(self, e)
    check(self, "hud", 1)

    local event = e:getEvent()
    if event[1] == "mouse_move" then
        e:setCanceled(true)
    end
    if event[1] == "key_pressed" and event[2] == controls.getControl("menu_spell") then
        if self:isOpen() then
            self:close()
        else
            self:open()
        end
    end
    local mouse_x, mouse_y  = lsfml.mouse.getPosition(window)
    if self:isOpen() then
        spell_description = nil
        for i, v in pairs(all_spell) do
            local sprite_pos_x, sprite_pos_y = v:getPosition()
            if mouse_x > sprite_pos_x and mouse_x < sprite_pos_x + 71 and mouse_y > sprite_pos_y and mouse_y < sprite_pos_y + 71 then
                if old_pos_x == -1  or old_pos_y == -1 then
                    origin_pos_y = sprite_pos_y
                    origin_pos_x = sprite_pos_x
                    old_pos_x = mouse_x
                    old_pos_y = mouse_y
                    selected_spell = v
                    selected_spell_name = i
                    spell_description = i
                    break
                end
            end
        end
        if selected_spell ~= nill and not lsfml.mouse.isButtonPressed(mouse.LEFT) then
            selected_spell:setPosition(origin_pos_x, origin_pos_y)
            old_pos_x = -1
            old_pos_y = -1
            selected_spell = nil
        end
        if selected_spell ~= nil then
            selected_spell:move(mouse_x - old_pos_x, mouse_y - old_pos_y)
            old_pos_x = mouse_x
            old_pos_y = mouse_y
            local sprite_pos_x, sprite_pos_y = selected_spell:getPosition()
            bool_spell = false
            for i = 1, 5 do
                if mouse_x > 705 + 30.5 + (i - 1) * 93.5 and mouse_x < 705 + 101.5 + (i - 1) * 93.5 and mouse_y > 920 + 9.5 and mouse_y < 920 + 80.5 then 
                    bool_spell = true
                    selected_spell_index = i
                    break
                end
            end
            if not bool_spell then
                selected_spell_index = 0
            end
        end
    end
    if selected_spell_index ~= 0 and not lsfml.mouse.isButtonPressed(mouse.LEFT) then
        all_sort:changeSort(selected_spell_index, selected_spell_name, spell[selected_spell_name])
        selected_spell_index = 0
    end
end

function update(self)
    check(self, "hud", 1)
    
    if actually_set ~= spell_description then
        if spell_description then
            help_spell:setName(spell_info[spell_description][1])
            help_spell:setString(spell_info[spell_description][2])
        end
    end
end

function draw(self)
    check(self, "hud", 1)

    window:draw(spell_hub)
    if spell_description then
        help_spell:draw()
    end
    for i, v in pairs(all_spell) do
        window:draw(v)
    end
end