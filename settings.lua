
local Settings = {
    volume = 50,
    resolution = "1920x1080",
    game_points = 3,
    game_points_max = 5
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

    local game_points = tonumber(contents:match("game_points=(%d+)"))
    if game_points and game_points >= 1 and game_points <= Settings.game_points_max then
        Settings.game_points = game_points
    end

end

function Settings.save(volume, resolution, game_points)

    if type(volume) ~= "number" or volume < 0 or volume > 100 then
        return false, "Volume must be between 0 and 100"
    end
    if not allowed_resolutions[resolution] then
        return false, "Unsupported resolution"
    end
    if type(game_points) ~= "number"
        or game_points % 1 ~= 0
        or game_points < 1
        or game_points > Settings.game_points_max
    then
        return false, "Game points must be an integer between 1 and " .. Settings.game_points_max
    end

    local contents = string.format(
        "volume=%d\nresolution=%s\ngame_points=%d\n",
        math.floor(volume + 0.5),
        resolution,
        game_points
    )

    local ok, err = love.filesystem.write("settings.txt", contents)
    if not ok then
        return false, err
    end

    Settings.volume = math.floor(volume + 0.5)
    Settings.resolution = resolution
    Settings.game_points = game_points
    return true
end

return Settings