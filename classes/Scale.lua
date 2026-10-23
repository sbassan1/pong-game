local Scale = {
    BASE_WIDTH = 1920,
    BASE_HEIGHT = 1080,
}

function Scale.getFactor()
    local window_width, window_height = love.graphics.getDimensions()
    return math.min(
        window_width / Scale.BASE_WIDTH,
        window_height / Scale.BASE_HEIGHT
    )
end

function Scale.getOffset()
    local window_width, window_height = love.graphics.getDimensions()
    local factor = Scale.getFactor()

    return (window_width - Scale.BASE_WIDTH * factor) / 2,
        (window_height - Scale.BASE_HEIGHT * factor) / 2
end

function Scale.begin()
    local factor = Scale.getFactor()
    local offset_x, offset_y = Scale.getOffset()

    love.graphics.push()
    love.graphics.translate(offset_x, offset_y)
    love.graphics.scale(factor, factor)
end

function Scale.finish()
    love.graphics.pop()
end

function Scale.toVirtual(x, y)
    local factor = Scale.getFactor()
    local offset_x, offset_y = Scale.getOffset()

    return (x - offset_x) / factor, (y - offset_y) / factor
end

return Scale
