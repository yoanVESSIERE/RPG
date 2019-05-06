-- =========================================
-- =               DIALOGUE                =
-- =========================================

local dial = lsfml.sprite.create()

-- ===============================================
-- =               DIALOGUE_HOMME                =
-- ===============================================
local dialogue = lsfml.text.create()
local file_dial_homme = io.open("./assets/dialogue_script/dialogue_script_homme.txt", "r")
local nb_dialogue_homme = 1
local line_homme = {}
local already_aff_homme = {false}
local nb_read_to_do_homme = 7

for i = 1, 3 do
    line_homme[i] = file_dial_homme:read()
end
local line_hommes = line_homme[1].."\n"..line_homme[2].."\n"..line_homme[3]

-- ===============================================
-- =               DIALOGUE_QUETE                =
-- ===============================================
local file_dial_quete = io.open("./assets/dialogue_script/dialogue_script_quete.txt", "r")
local nb_dialogue_quete = 0
local line_quete = {}
local already_aff_quete = {false}
local nb_read_to_do_quete = 5

for i = 1, 3 do
    line_quete[i] = file_dial_quete:read()
end
local line_quetes = line_quete[1].."\n"..line_quete[2].."\n"..line_quete[3]

-- =============================================
-- =               DIALOGUE_END                =
-- =============================================
local file_dial_end = io.open("./assets/dialogue_script/dialogue_script_end.txt", "r")
local nb_dialogue_end = 0
local line_end = {}
local already_aff_end = {false}
local nb_read_to_do_end = 3

for i = 1, 3 do
    line_end[i] = file_dial_end:read()
end
local line_ends = line_end[1].."\n"..line_end[2].."\n"..line_end[3]

-- ==============================================
-- =               DIALOGUE_ROBOT               =
-- ==============================================
local file_dial_robot = io.open("./assets/dialogue_script/dialogue_script_robot.txt", "r")
local nb_dialogue_robot = 1
local line_robot = {}
local already_aff_robot = {false}
local nb_read_to_do_robot = 11

for i = 1, 3 do
    line_robot[i] = file_dial_robot:read()
end
local line_robots = line_robot[1].."\n"..line_robot[2].."\n"..line_robot[3]

--===============================================
local can_aff = false
local name
local quest

dialogue:setFont(assets["fsys"])
dialogue:setCharacterSize(30)
dialogue:setScale(1, 1)

dial:setPosition(500, 500)
dial:setTexture(assets["case_dial"], false)
dial:setScale(1, 1)

function next_homme()
    nb_dialogue_homme = nb_dialogue_homme + 1
    if nb_dialogue_homme > nb_read_to_do_homme then
        return true
    else
        return false
    end
end

function next_end()
    nb_dialogue_end = nb_dialogue_end + 1
    if nb_dialogue_end > nb_read_to_do_end then
        return true
    else
        return false
    end
end

function next_quete()
    nb_dialogue_quete = nb_dialogue_quete + 1
    if nb_dialogue_quete > nb_read_to_do_quete then
        return true
    else
        return false
    end
end

function next_robot()
    nb_dialogue_robot = nb_dialogue_robot + 1
    if nb_dialogue_robot > nb_read_to_do_robot then
        return true
    else
        return false
    end
end

function load(self)

end

function open(self)

end

function close(self)
    hud.close(self)
end

function set_Position(self, x, y)
    dial:setPosition(x, y)
end

function draw(self)
    window:draw(dial)
    if can_aff then
        window:draw(dialogue)
    end
end

function getQuest(self)
    return quest
end

function itIsRob(self, quete)
    name = "robot"
    if quest ~= 2 and quest ~= 3 then
        quest = quete
    end
end

function itIsHom(self, quete)
    name = "homme"
    if quest ~= 2 or quest ~= 3 then
        quest = quete
    end
end

function restart_dialogue()
    file_dial_homme:close()
    file_dial_homme = io.open("./assets/dialogue_script/dialogue_script_homme.txt", "r")
    nb_dialogue_homme = 1
    line_homme = {}
    already_aff_homme = {false}

    file_dial_robot:close()
    file_dial_robot = io.open("./assets/dialogue_script/dialogue_script_robot.txt", "r")
    nb_dialogue_robot = 1
    line_robot = {}
    already_aff_robot = {false}

    file_dial_quete:close()
    file_dial_quete = io.open("./assets/dialogue_script/dialogue_script_quete.txt", "r")
    nb_dialogue_quete = 0
    line_quete = {}
    already_aff_quete = {false}

    file_dial_end:close()
    file_dial_end = io.open("./assets/dialogue_script/dialogue_script_end.txt", "r")
    nb_dialogue_end = 0
    line_end = {}
    already_aff_end = {false}
end

function update(self)
    local x, y = dial:getPosition()
    local cx, cy = lsfml.text.getCenter(line_hommes, 30)
    dialogue:setPosition(x + 384 / 2.1 - cx / 3, y + 164 / 4 - cy / 1.5)
end

function event_homme_first(e)
    if nb_dialogue_homme == 0 then
        dialogue:setString(line_hommes)
        can_aff = true
    end
    if nb_dialogue_homme == 1 and not already_aff_homme[nb_dialogue_homme] then
        for i = 1, 3 do
            
            line_homme[i] = file_dial_homme:read()
        end
        
        line_hommes = line_homme[1].."\n"..line_homme[2].."\n"..line_homme[3]
        dialogue:setString(line_hommes)
        can_aff = true
        already_aff_homme[nb_dialogue_homme] = true
    end
    if nb_dialogue_homme == 2 and not already_aff_homme[nb_dialogue_homme] then
        for i = 1, 3 do
            
            line_homme[i] = file_dial_homme:read()
        end
        
        line_hommes = line_homme[1].."\n"..line_homme[2].."\n"..line_homme[3]
        dialogue:setString(line_hommes)
        can_aff = true
        already_aff_homme[nb_dialogue_homme] = true
    end
    if nb_dialogue_homme == 3 and not already_aff_homme[nb_dialogue_homme] then
        for i = 1, 3 do
            
            line_homme[i] = file_dial_homme:read()
        end
        
        line_hommes = line_homme[1].."\n"..line_homme[2].."\n"..line_homme[3]
        dialogue:setString(line_hommes)
        can_aff = true
        already_aff_homme[nb_dialogue_homme] = true
    end
    if nb_dialogue_homme == 4 and not already_aff_homme[nb_dialogue_homme] then
        for i = 1, 3 do
            
            line_homme[i] = file_dial_homme:read()
        end
        
        line_hommes = line_homme[1].."\n"..line_homme[2].."\n"..line_homme[3]
        dialogue:setString(line_hommes)
        can_aff = true
        already_aff_homme[nb_dialogue_homme] = true
    end
    if nb_dialogue_homme == 5 and not already_aff_homme[nb_dialogue_homme] then
        for i = 1, 3 do
            
            line_homme[i] = file_dial_homme:read()
        end
        
        line_hommes = line_homme[1].."\n"..line_homme[2].."\n"..line_homme[3]
        dialogue:setString(line_hommes)
        can_aff = true
        already_aff_homme[nb_dialogue_homme] = true
    end
    if nb_dialogue_homme == 6 and not already_aff_homme[nb_dialogue_homme] then
        for i = 1, 3 do
            
            line_homme[i] = file_dial_homme:read()
        end
        
        line_hommes = line_homme[1].."\n"..line_homme[2].."\n"..line_homme[3]
        dialogue:setString(line_hommes)
        can_aff = true
        already_aff_homme[nb_dialogue_homme] = true
    end
    if nb_dialogue_homme == 7 and not already_aff_homme[nb_dialogue_homme] then
        for i = 1, 3 do
            
            line_homme[i] = file_dial_homme:read()
        end
        
        line_hommes = line_homme[1].."\n"..line_homme[2].."\n"..line_homme[3]
        dialogue:setString(line_hommes)
        can_aff = true
        already_aff_homme[nb_dialogue_homme] = true
    end
end

function event_robot(e)
    if nb_dialogue_robot == 0 then
        dialogue:setString(line_robots)
        can_aff = true
    end
    if nb_dialogue_robot == 1 and not already_aff_robot[nb_dialogue_robot] then
        for i = 1, 3 do
            
            line_robot[i] = file_dial_robot:read()
        end
        
        line_robots = line_robot[1].."\n"..line_robot[2].."\n"..line_robot[3]
        dialogue:setString(line_robots)
        can_aff = true
        already_aff_robot[nb_dialogue_robot] = true
    end
    if nb_dialogue_robot == 2 and not already_aff_robot[nb_dialogue_robot] then
        for i = 1, 3 do
            
            line_robot[i] = file_dial_robot:read()
        end
        
        line_robots = line_robot[1].."\n"..line_robot[2].."\n"..line_robot[3]
        dialogue:setString(line_robots)
        can_aff = true
        already_aff_robot[nb_dialogue_robot] = true
    end
    if nb_dialogue_robot == 3 and not already_aff_robot[nb_dialogue_robot] then
        for i = 1, 3 do
            
            line_robot[i] = file_dial_robot:read()
        end
        
        line_robots = line_robot[1].."\n"..line_robot[2].."\n"..line_robot[3]
        dialogue:setString(line_robots)
        can_aff = true
        already_aff_robot[nb_dialogue_robot] = true
    end
    if nb_dialogue_robot == 4 and not already_aff_robot[nb_dialogue_robot] then
        for i = 1, 3 do
            
            line_robot[i] = file_dial_robot:read()
        end
        
        line_robots = line_robot[1].."\n"..line_robot[2].."\n"..line_robot[3]
        dialogue:setString(line_robots)
        can_aff = true
        already_aff_robot[nb_dialogue_robot] = true
    end
    if nb_dialogue_robot == 5 and not already_aff_robot[nb_dialogue_robot] then
        for i = 1, 3 do
            
            line_robot[i] = file_dial_robot:read()
        end
        
        line_robots = line_robot[1].."\n"..line_robot[2].."\n"..line_robot[3]
        dialogue:setString(line_robots)
        can_aff = true
        already_aff_robot[nb_dialogue_robot] = true
    end
    if nb_dialogue_robot == 6 and not already_aff_robot[nb_dialogue_robot] then
        for i = 1, 3 do
            
            line_robot[i] = file_dial_robot:read()
        end
        
        line_robots = line_robot[1].."\n"..line_robot[2].."\n"..line_robot[3]
        dialogue:setString(line_robots)
        can_aff = true
        already_aff_robot[nb_dialogue_robot] = true
    end
    if nb_dialogue_robot == 7 and not already_aff_robot[nb_dialogue_robot] then
        for i = 1, 3 do
            
            line_robot[i] = file_dial_robot:read()
        end
        
        line_robots = line_robot[1].."\n"..line_robot[2].."\n"..line_robot[3]
        dialogue:setString(line_robots)
        can_aff = true
        already_aff_robot[nb_dialogue_robot] = true
    end
    if nb_dialogue_robot == 8 and not already_aff_robot[nb_dialogue_robot] then
        for i = 1, 3 do
            
            line_robot[i] = file_dial_robot:read()
        end
        
        line_robots = line_robot[1].."\n"..line_robot[2].."\n"..line_robot[3]
        dialogue:setString(line_robots)
        can_aff = true
        already_aff_robot[nb_dialogue_robot] = true
    end
    if nb_dialogue_robot == 9 and not already_aff_robot[nb_dialogue_robot] then
        for i = 1, 3 do
            
            line_robot[i] = file_dial_robot:read()
        end
        
        line_robots = line_robot[1].."\n"..line_robot[2].."\n"..line_robot[3]
        dialogue:setString(line_robots)
        can_aff = true
        already_aff_robot[nb_dialogue_robot] = true
    end
    if nb_dialogue_robot == 10 and not already_aff_robot[nb_dialogue_robot] then
        for i = 1, 3 do
            
            line_robot[i] = file_dial_robot:read()
        end
        
        line_robots = line_robot[1].."\n"..line_robot[2].."\n"..line_robot[3]
        dialogue:setString(line_robots)
        can_aff = true
        already_aff_robot[nb_dialogue_robot] = true
    end
    if nb_dialogue_robot == 11 and not already_aff_robot[nb_dialogue_robot] then
        for i = 1, 3 do
            
            line_robot[i] = file_dial_robot:read()
        end
        
        line_robots = line_robot[1].."\n"..line_robot[2].."\n"..line_robot[3]
        dialogue:setString(line_robots)
        can_aff = true
        already_aff_robot[nb_dialogue_robot] = true
    end
    if nb_dialogue_robot == 12 and not already_aff_robot[nb_dialogue_robot] then
        for i = 1, 3 do
            
            line_robot[i] = file_dial_robot:read()
        end
        
        line_robots = line_robot[1].."\n"..line_robot[2].."\n"..line_robot[3]
        dialogue:setString(line_robots)
        can_aff = true
        already_aff_robot[nb_dialogue_robot] = true
    end
    if nb_dialogue_robot == 13 and not already_aff_robot[nb_dialogue_robot] then
        for i = 1, 3 do
            
            line_robot[i] = file_dial_robot:read()
        end
        
        line_robots = line_robot[1].."\n"..line_robot[2].."\n"..line_robot[3]
        dialogue:setString(line_robots)
        can_aff = true
        already_aff_robot[nb_dialogue_robot] = true
    end
    if nb_dialogue_robot == 14 and not already_aff_robot[nb_dialogue_robot] then
        for i = 1, 3 do
            
            line_robot[i] = file_dial_robot:read()
        end
        
        line_robots = line_robot[1].."\n"..line_robot[2].."\n"..line_robot[3]
        dialogue:setString(line_robots)
        can_aff = true
        already_aff_robot[nb_dialogue_robot] = true
    end
end

function event_homme_quest(e)
    if nb_dialogue_quete == 0 then
        dialogue:setString(line_quetes)
        can_aff = true
    end
    if nb_dialogue_quete == 1 and not already_aff_quete[nb_dialogue_quete] then
        for i = 1, 3 do
            
            line_quete[i] = file_dial_quete:read()
        end
        
        line_quetes = line_quete[1].."\n"..line_quete[2].."\n"..line_quete[3]
        dialogue:setString(line_quetes)
        can_aff = true
        already_aff_quete[nb_dialogue_quete] = true
    end
    if nb_dialogue_quete == 2 and not already_aff_quete[nb_dialogue_quete] then
        for i = 1, 3 do
            
            line_quete[i] = file_dial_quete:read()
        end
        
        line_quetes = line_quete[1].."\n"..line_quete[2].."\n"..line_quete[3]
        dialogue:setString(line_quetes)
        can_aff = true
        already_aff_quete[nb_dialogue_quete] = true
    end
    if nb_dialogue_quete == 3 and not already_aff_quete[nb_dialogue_quete] then
        for i = 1, 3 do
            
            line_quete[i] = file_dial_quete:read()
        end
        
        line_quetes = line_quete[1].."\n"..line_quete[2].."\n"..line_quete[3]
        dialogue:setString(line_quetes)
        can_aff = true
        already_aff_quete[nb_dialogue_quete] = true
    end
    if nb_dialogue_quete == 4 and not already_aff_quete[nb_dialogue_quete] then
        for i = 1, 3 do
            
            line_quete[i] = file_dial_quete:read()
        end
        
        line_quetes = line_quete[1].."\n"..line_quete[2].."\n"..line_quete[3]
        dialogue:setString(line_quetes)
        can_aff = true
        already_aff_quete[nb_dialogue_quete] = true
    end
    if nb_dialogue_quete == 5 and not already_aff_quete[nb_dialogue_quete] then
        for i = 1, 3 do
            
            line_quete[i] = file_dial_quete:read()
        end
        
        line_quetes = line_quete[1].."\n"..line_quete[2].."\n"..line_quete[3]
        dialogue:setString(line_quetes)
        can_aff = true
        already_aff_quete[nb_dialogue_quete] = true
    end
end

function event_homme_end(e)
    if nb_dialogue_end == 0 then
        dialogue:setString(line_ends)
        can_aff = true
    end
    if nb_dialogue_end == 1 and not already_aff_end[nb_dialogue_end] then
        for i = 1, 3 do
            
            line_end[i] = file_dial_end:read()
        end
        
        line_ends = line_end[1].."\n"..line_end[2].."\n"..line_end[3]
        dialogue:setString(line_ends)
        can_aff = true
        already_aff_end[nb_dialogue_end] = true
    end
    if nb_dialogue_end == 2 and not already_aff_end[nb_dialogue_end] then
        for i = 1, 3 do
            
            line_end[i] = file_dial_end:read()
        end
        
        line_ends = line_end[1].."\n"..line_end[2].."\n"..line_end[3]
        dialogue:setString(line_ends)
        can_aff = true
        already_aff_end[nb_dialogue_end] = true
    end
    if nb_dialogue_end == 3 and not already_aff_end[nb_dialogue_end] then
        for i = 1, 3 do
            
            line_end[i] = file_dial_end:read()
        end
        
        line_ends = line_end[1].."\n"..line_end[2].."\n"..line_end[3]
        dialogue:setString(line_ends)
        can_aff = true
        already_aff_end[nb_dialogue_end] = true
    end
end

function event(self, e)
    if file_dial_homme and name == "homme" and quest == 1 then
        event_homme_first(e)
    end
    if file_dial_quete and name == "homme" and quest == 2 then
        event_homme_quest(e)
    end
    if file_dial_end and name == "homme" and quest == 3 then
        event_homme_end(e)
    end
    if file_dial_robot and name == "robot" then
        event_robot(e)
    end
end