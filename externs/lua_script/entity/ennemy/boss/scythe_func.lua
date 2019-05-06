scythe_func = {
    function(x, dir, odir)
        local angle = math.floor(x / 90) * 90
        return odir.x + math.cos(math.rad(angle)), odir.y + math.sin(math.rad(angle))
    end,
    function(x, dir, odir)
        local nx, ny = math.cos(x / 360), math.sin(x / 360)
        local dx, dy = math.cos((x-1) / 360), math.sin((x-1) / 360)
        return dir.x + (nx - dx) * 2, dir.y + (ny - dy) * 2
    end,
    function(x, dir, odir)
        local sx = dir.x > 0 and 1 or -1
        local sy = dir.y > 0 and 1 or -1
        return dir.x + sx * (math.cos(math.rad(x)) - math.cos(math.rad(x-1))), dir.y + sy * (math.sin(math.rad(x)) - math.sin(math.rad(x-1)))
    end,
    function(x, dir, odir)
        return dir.x * math.cos(math.rad(x)), dir.y * math.sin(math.rad(x))
    end,
    function(x, dir, odir)
        return -odir.x, -odir.y
    end,
    function(x, dir)
        return dir.x, dir.y
    end,
}