-- =========================================
-- =                CONTROLS               =
-- =========================================

controls = {}

local key_controls = {}

local controls_data = {}

function controls.addControl(name, key, text, desc)
    controls_data[#controls_data + 1] = {name=name, key=key, text=text, desc=desc}
    key_controls[name] = #controls_data
end

function controls.getControls()
    return controls_data
end

function controls.getControl(name)
    if key_controls[name] then
        return controls_data[key_controls[name]].key
    end
    return -2
end

function controls.setControl(name, key)
    if key_controls[name] then
        controls_data[key_controls[name]].key = key
        return true
    end
    return false
end

controls.addControl("inventory", keys.I, "Inventory", "")
controls.addControl("move_up", keys.Z, "Forward", "")
controls.addControl("move_left", keys.Q, "Left", "")
controls.addControl("move_down", keys.S, "Backward", "")
controls.addControl("move_right", keys.D, "Right", "")
controls.addControl("sprint", keys.LShift, "Sprint", "")
controls.addControl("spell_1", keys.Num1, "Spell 1", "")
controls.addControl("spell_2", keys.Num2, "Spell 2", "")
controls.addControl("spell_3", keys.Num3, "Spell 3", "")
controls.addControl("spell_4", keys.Num4, "Spell 4", "")
controls.addControl("spell_5", keys.Num5, "Spell 5", "")
controls.addControl("menu_spell", keys.M, "Spell Menu", "")
controls.addControl("action", keys.F, "Pickup/Interact", "")
controls.addControl("show_hitbox", keys.H, "Show Hitboxes", "")
controls.addControl("skip_all", keys.Space, "Skip Dialogue", "")
controls.addControl("hide/show", keys.J, "Hide/Show Quest", "")