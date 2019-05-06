function quete()
    local inventory = player:getInventory()
    local slots = inventory:getSlot_tab()
    local itemstack = {}
    local item = {}
    local nb_parchemin = 0
    for i=1, #slots do
        itemstack[i] = inventory:getItemInSlot(i)
        if itemstack[i] ~= nil then
            item[i] = itemstack[i]:getItem()
            item[i] = item[i]:getName()
            if item[i] == "parchemin_1" or item[i] == "parchemin_2" or item[i] == "parchemin_3" or item[i] == "parchemin_4" or item[i] == "parchemin_5" or item[i] == "parchemin_6" then
                nb_parchemin = nb_parchemin + 1
            end
        end
    end
    return nb_parchemin
end