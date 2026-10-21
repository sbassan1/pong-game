local Button = {}
Button.__index = Button

function Button.new(x, y, width, height, event, label)
    assert(type(event) == "function", "Button event must be a function")

    return setmetatable({
        x = x,
        y = y,
        size_x = width,
        size_y = height,
        event = event,
        label = label or "",
    }, Button)
end

function Button:contains(x, y)
    return x >= self.x
        and x <= self.x + self.size_x
        and y >= self.y
        and y <= self.y + self.size_y
end


function Button:mousepressed(x, y, mouse_button, ...)
    if mouse_button ~= 1 or not self:contains(x, y) then
        return false
    end

    self.event(self, x, y, mouse_button, ...)
    return true
end

function Button:draw()
    local mouse_x, mouse_y = love.mouse.getPosition()
    local hovered = self:contains(mouse_x, mouse_y) 
    local font = love.graphics.getFont()

    love.graphics.push("all")
    if hovered then
        love.graphics.setColor(0.25, 0.25, 0.25, 1)
    else
        love.graphics.setColor(0.1, 0.1, 0.1, 1)
    end
    love.graphics.rectangle("fill", self.x, self.y, self.size_x, self.size_y)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("line", self.x, self.y, self.size_x, self.size_y)
    love.graphics.printf(
        self.label,
        self.x,
        self.y + (self.size_y - font:getHeight()) / 2,
        self.size_x,
        "center"
    )
    love.graphics.pop()
end

return Button
