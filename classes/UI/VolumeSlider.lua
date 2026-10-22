
local VolumeSlider = {}
VolumeSlider.__index = VolumeSlider

function VolumeSlider.new(x, y, width, height)

    return setmetatable({
        x = x,
        y = y,
        size_x = width,
        size_y = height,
        percentage = 50,
        dragging = false,
    }, VolumeSlider)

    
end

function VolumeSlider:contains(x, y)
    return x >= self.x
        and x <= self.x + self.size_x
        and y >= self.y
        and y <= self.y + self.size_y
end

function VolumeSlider:mousepressed(x, y, mouse_button)
    if mouse_button ~= 1 or not self:contains(x, y) then
        return false
    end

    self.dragging = true
    self:updateFromMouseX(x)
    return true
end

function VolumeSlider:mousemoved(x)
    if not self.dragging then
        return
    end

    self:updateFromMouseX(x)
end

function VolumeSlider:mousereleased(_, _, mouse_button)
    if mouse_button == 1 then
        self.dragging = false
    end
end

function VolumeSlider:updateFromMouseX(x)
    local percentage = ((x - self.x) / self.size_x) * 100
    self:setPercentage(percentage)
end

function VolumeSlider:setPercentage(percentage)
    self.percentage = math.max(0, math.min(100, percentage))
end

function VolumeSlider:draw()
    local font = love.graphics.getFont()
    local filled_width = self.size_x * self.percentage / 100
    local marker_x = self.x + filled_width

    love.graphics.push("all")

    love.graphics.rectangle("line", self.x, self.y, self.size_x, self.size_y)

    love.graphics.setColor(0.7, 0.7, 0.7, 1)
    love.graphics.rectangle("fill", self.x, self.y, filled_width, self.size_y)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.line(marker_x, self.y, marker_x, self.y + self.size_y)

    love.graphics.printf(
        "Volume",
        self.x,
        self.y - (self.size_y + font:getHeight()) / 2,
        self.size_x,
        "center"
    )
    love.graphics.printf(
        string.format("%d%%", math.floor(self.percentage + 0.5)),
        self.x,
        self.y + (self.size_y - font:getHeight()) / 2,
        self.size_x,
        "center"
    )

    love.graphics.pop()
end

return VolumeSlider
