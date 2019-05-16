-- =========================================
-- =              INVENTORY HUD            =
-- =========================================

local px = 980 - 1337 * 0.75 / 2
local py = 540 - 940 * 0.75 / 2

local inventory = lsfml.sprite.create()
local stats = lsfml.sprite.create()
local attack = lsfml.text.create()
local defense = lsfml.text.create()
local parade = lsfml.text.create()
local speed = lsfml.text.create()

attack:setCharacterSize(48)
defense:setCharacterSize(48)
parade:setCharacterSize(48)
speed:setCharacterSize(48)

attack:setPosition(100 * 0.5, py + 260 * 0.5 - 48 / 1.25)
defense:setPosition(100 * 0.5, py + 370 * 0.5 - 48 / 1.25)
parade:setPosition(100 * 0.5, py + 480 * 0.5 - 48 / 1.25)
speed:setPosition(100 * 0.5, py + 590 * 0.5 - 48 / 1.25)

attack:setFont(assets["fsys"])
defense:setFont(assets["fsys"])
parade:setFont(assets["fsys"])
speed:setFont(assets["fsys"])

local px = 960 - 1337 * 0.75 / 2
local py = 540 - 940 * 0.75 / 2
local item_info = nil
local help_item = description.create(assets["info"], assets["fsys"])
help_item:setPosition(1500, py)
help_item:setScale(0.40, 0.40)
help_item:setCharacterSize(35)
local slots = {}

inventory:scale(0.75, 0.75)
inventory:setPosition(px, py)
inventory:setTexture(assets["inventory_hud"], false)
stats:setPosition(940 * 0.5, py)
stats:setScale(-0.50, 0.50)
stats:setTexture(assets["stats"], false)

function load(self)
    for y = 0, 3 do
        for x = 1, 7 do
            slots[#slots + 1] = inv_slot.create(px + (44 + (128 + 24) * x) * 0.75, py + (72 + (144 + 24) * y) * 0.75, 128, 144, 64, 64)
        end
    end
    slots[#slots + 1] = inv_slot.create(px + 44 * 0.75, py + (72 + (144 + 24) * 0) * 0.75, 128, 144, 64, 64, {type="equipement", subtype="helmet"})
    slots[#slots + 1] = inv_slot.create(px + 44 * 0.75, py + (72 + (144 + 24) * 1) * 0.75, 128, 144, 64, 64, {type="equipement", subtype="chestplate"})
    slots[#slots + 1] = inv_slot.create(px + 44 * 0.75, py + (72 + (144 + 24) * 2) * 0.75, 128, 144, 64, 64, {type="equipement", subtype="pant"})
    slots[#slots + 1] = inv_slot.create(px + 44 * 0.75, py + (72 + (144 + 24) * 3) * 0.75, 128, 144, 64, 64, {type="equipement", subtype="boot"})
    for x = 3, 4 do
        local sprite = lsfml.sprite.create()
        slots[#slots + 1] = inv_slot.create(px + (44 + (128 + 24) * x) * 0.75, py + (72 + (144 + 24) * 4) * 0.75, 128, 144, 64, 64)
    end
    local dt = {}
    for k, v in pairs(items) do
        dt[#dt + 1] = k
    end
    -- for i=1, #slots - 6 do
        -- if math.random(1, 2) == 1 then
            -- local item = items[dt[math.random(#dt - 4, #dt)]]
            -- slots[1]:setItemStack(itemstack.create(items["boots3"], math.random(1, item:getMaxStackSize())))
    --     end
    -- end
end

function open(self)

end

function close(self)

end

function getSlotCount()
    return #slots
end

function setItemInSlot(self, slot, itemstack)
    check(slot, "number", 2)
    cassert(type(itemstack) == "nil" and type(itemstack) == "itemstack", "itemstack must be an itemstack", 3)

    if slot > 0 and slot <= #slots then
        slots[slot]:setItemStack(itemstack)
    else
        error("slot must be between 1 and "..#slots, 2)
    end
end

function getItemInSlot(self, slot)
    check(self, "hud", 1)
    check(slot, "number", 2)

    if slot > 0 and slot <= #slots then
        return slots[slot]:getItemStack()
    else
        error("slot must be between 1 and "..#slots, 2)
    end
end

function insertItemStack(self, itemstack)
    if itemstack then
        local found = false
        for i=1, #slots do
            if (slots[i]:getItemStack() and slots[i]:getItemStack() == itemstack) and slots[i]:itemMeetRequirement(itemstack) then
                slots[i]:getItemStack():pack(itemstack)
                slots[i]:setItemStack(slots[i]:getItemStack())
                found = true
            end
        end
        for i=1, #slots do
            if slots[i]:isEmpty() and slots[i]:itemMeetRequirement(itemstack) then
                slots[i]:setItemStack(itemstack)
                return true
            end
        end
        return found
    end
    return false
end

function isIn(self, x, y)
    return x > px and x < px + 1337 * 0.75 and y > py and y < py + 940 * 0.75
end

function getSlotAt(self, x, y)
    for i=1, #slots do
        if slots[i]:isIn(x, y) then
            return slots[i]
        end
    end
end

function hasItemInInventory(self, name)
    check(self, "hud", 1)
    check(name, "string", 2)

    for i=1, #slots do
        local itemstack = slots[i]:getItemStack()
        if itemstack and itemstack:getItem() and itemstack:getItem():getName() == name then
            return true
        end
    end
    return false
end

function getSlots(self)
    return slots
end

function draw(self)
    window:draw(inventory)
    if item_info then
        help_item:draw()
    end
    for i=1, #slots do
        slots[i]:draw()
    end
    window:draw(stats)
    window:draw(attack)
    window:draw(defense)
    window:draw(parade)
    window:draw(speed)
end

function update(self)
    local att_str = "+"..tostring(math.floor(player.getAttack() * 100) - 100).."%"
    local def_str = "+"..tostring(math.floor(player.getDefense() * 100) - 100).."%"
    local par_str = "+"..tostring(math.floor(player.getParade() * 100) - 100).."%"
    local spe_str = "+"..tostring(math.floor(player.getSpeed()))
    attack:setString("Attack: "..string.rep(" ", 6 - #att_str)..att_str)
    defense:setString("Defense: "..string.rep(" ", 5 - #def_str)..def_str)
    parade:setString("Parade: "..string.rep(" ", 6 - #par_str)..par_str)
    speed:setString("Speed: "..string.rep(" ", 7 - #spe_str)..spe_str)
end

function event(self, e)
    local event = e:getEvent()
    if event[1] == "key_pressed" and event[2] == controls.getControl("inventory") then
        if self:isOpen() then
            self:close()
        else
            self:open()
        end
        e:setCanceled(true)
    end
    if self:isOpen() then
        for i=1, #slots do
            slots[i]:event(self, e)
            if e:isCanceled() then
                break
            end
        end
    end
    if event[1] == "mouse_move" then
        e:setCanceled(true)
    end
    local mouse_x, mouse_y  = lsfml.mouse.getPosition(window)
    item_info = false
    for i=1, #slots do
        if slots[i]:isIn(mouse_x, mouse_y) then
            local item_stack = slots[i]:getItemStack()
            if item_stack and item_stack:getStackSize() > 0 then
                item_info = true
                help_item:setName(tostring(item_stack:getUserdata().name or item_stack:getItem():getName()))
                local stat = item_stack:getStats()
                help_item:setString("Rarity : "..string.rep(" ", 10 - #(stat.rarity or "Unknown"))..(stat.rarity or "Unknown").."\nDamage : "..string.rep(" ", 9 - #tostring(stat.damage or 0)).."+"..tostring(stat.damage or 0).."\nDefense : "..string.rep(" ", 8 - #tostring(stat.defense or 0)).."+"..tostring(stat.defense or 0).."\nSpeed : "..string.rep(" ", 10 - #tostring(stat.speed or 0)).."+"..tostring(stat.speed or 0).."\nParade : "..string.rep(" ", 9 - #tostring(stat.parade or 0)).."+"..tostring(stat.parade or 0).."\nHealth : "..string.rep(" ", 9 - #tostring(stat.max_health or 0)).."+"..tostring(stat.max_health or 0).."\nMana : "..string.rep(" ", 11 - #tostring(stat.max_mana or 0)).."+"..tostring(stat.max_mana or 0).."\nStamina : "..string.rep(" ", 8 - #tostring(stat.max_stamina or 0)).."+"..tostring(stat.max_stamina or 0).."\n\n"..tostring(item_stack:getUserdata().desc or ""))
                break
            end
        end
    end
end