
local Settings = {
    volume = 50,
    resolution = "1920x1080",
}

local allowed_resolutions = {
    ["1366x768"] = true,
    ["1920x1080"] = true,
    ["1280x720"] = true,
}

function Settings.load()
    local contents = love.filesystem.read("settings.txt")
    if not contents then
        return
    end

    local volume = tonumber(contents:match("volume=(%d+)"))
    if volume then
        Settings.volume = math.max(0, math.min(100, volume))
    end

    local resolution = contents:match("resolution=(%d+x%d+)")
    if resolution and allowed_resolutions[resolution] then
        Settings.resolution = resolution
    end
    
end

function Settings.save(volume, resolution)
    if type(volume) ~= "number" or volume < 0 or volume > 100 then
        return false, "Volume must be between 0 and 100"
    end
    if not allowed_resolutions[resolution] then
        return false, "Unsupported resolution"
    end

    local contents = string.format(
        "volume=%d\nresolution=%s\n",
        math.floor(volume + 0.5),
        resolution
    )

    local ok, err = love.filesystem.write("settings.txt", contents)
    if not ok then
        return false, err
    end

    Settings.volume = math.floor(volume + 0.5)
    Settings.resolution = resolution
    return true
end

return Settings