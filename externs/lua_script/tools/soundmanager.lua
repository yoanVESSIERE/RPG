-- =========================================
-- =               SOUNDMANAGER            =
-- =========================================

local sounds = {}
soundmanager = {}

function soundmanager.add(category, soundbuff)
    check(category, "string", 1)
    check(soundbuff, "soundbuffer", 2)

    sounds[category] = sounds[category] or {}
    local sounds_cat = sounds[category]
    local mysound = lsfml.sound.create()
    mysound:setBuffer(soundbuff)
    local id = uuid.randomUUID()
    sounds[category][#sounds[category] + 1] = {mysound, id}
    return mysound, id
end

function soundmanager.remove(uuid, category)
    check(uuid, "string", 1)
    check(category, "string", 2)

    if category then
        if sounds[category] then
            for i=1, #sounds[category] do
                if sounds[category][i][2] == uuid then
                    table.remove(sounds[category], i)
                    return
                end
            end
        end
    end
end

function soundmanager.clear(category)
    cassert(type(category) == "nil" or type(category) == "string", "Category must be as string", 3)

    if category then
        sounds[category] = nil
        sounds[category] = {}
    else
        sounds = nil
        sounds = {}
    end
end

function soundmanager.getSounds()
    return sounds
end

function soundmanager.setSounds(sound)
    check(sound, "table", 1)

    sounds = sound
end

function soundmanager.setVolume(value, category)
    check(value, "number", 1)
    cassert(type(category) == "nil" or type(category) == "string", "Category must be as string", 3)

    if category then
        if sounds[category] then
            for i=1, #sounds[category] do
                sounds[category][i][1]:setVolume(value)
            end
        end
    else
        for k, v in pairs(sounds) do
            for i=1, #v do
                v[i][1]:setVolume(value)
            end
        end
    end
end

function soundmanager.play(category)
    cassert(type(category) == "nil" or type(category) == "string", "Category must be as string", 3)

    if category then
        if sounds[category] then
            for i=1, #sounds[category] do
                sounds[category][i][1]:play()
            end
        end
    else
        for k, v in pairs(sounds) do
            for i=1, #v do
                v[i][1]:play()
            end
        end
    end
end

function soundmanager.pause(category)
    cassert(type(category) == "nil" or type(category) == "string", "Category must be as string", 3)

    if category then
        if sounds[category] then
            for i=1, #sounds[category] do
                sounds[category][i][1]:pause()
            end
        end
    else
        for k, v in pairs(sounds) do
            for i=1, #v do
                v[i][1]:pause()
            end
        end
    end
end

function soundmanager.stop(category)
    cassert(type(category) == "nil" or type(category) == "string", "Category must be as string", 3)

    if category then
        if sounds[category] then
            for i=1, #sounds[category] do
                sounds[category][i][1]:stop()
            end
        end
    else
        for k, v in pairs(sounds) do
            for i=1, #v do
                v[i][1]:stop()
            end
        end
    end
end

function soundmanager.setLoop(bool, category)
    check(bool, "boolean", 1)
    cassert(type(category) == "nil" or type(category) == "string", "Category must be as string", 3)

    if category then
        if sounds[category] then
            for i=1, #sounds[category] do
                sounds[category][i][1]:setLoop(bool)
            end
        end
    else
        for k, v in pairs(sounds) do
            for i=1, #v do
                v[i][1]:setLoop(bool)
            end
        end
    end
end

function soundmanager.setPitch(value, category)
    check(value, "number", 1)
    cassert(type(category) == "nil" or type(category) == "string", "Category must be as string", 3)

    if category then
        if sounds[category] then
            for i=1, #sounds[category] do
                sounds[category][i][1]:setPitch(value)
            end
        end
    else
        for k, v in pairs(sounds) do
            for i=1, #v do
                v[i][1]:setPitch(value)
            end
        end
    end
end