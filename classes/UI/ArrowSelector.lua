
local ArrowSelector = {}
ArrowSelector.__index = ArrowSelector

function ArrowSelector.new(x, y, width, height, label ,options)
    return setmetatable({
        x = x,
        y = y,
        size_x = width,
        size_y = height,
        label = label,
        options = options,
        selected_index = 1,
    }, ArrowSelector)
end

function ArrowSelector:obtainSelected()
    return self.options[self.selected_index]
end

function ArrowSelector:mousepressed(x, y, mouse_button)
    if mouse_button ~= 1 then
        return false
    end

    local within_height = y >= self.y and y <= self.y + self.size_y
    if not within_height then
        return false
    end

    local clicked_left = x >= self.x - self.size_y and x < self.x
    local clicked_right = x >= self.x + self.size_x
        and x <= self.x + self.size_x + self.size_y

    if clicked_left then
        if self.selected_index > 1 then
            self.selected_index = self.selected_index - 1
        end
        return true
    elseif clicked_right then
        if self.selected_index < #self.options then
            self.selected_index = self.selected_index + 1
        end
        return true
    end

    return false
end

function ArrowSelector:draw()
    local font = love.graphics.getFont()
    local arrow_width = self.size_y
    local left = self.x - arrow_width
    local right = self.x + self.size_x
    
    -- Drawing the boxes and label 
    love.graphics.rectangle("line", left, self.y, self.size_x + 2 * arrow_width, self.size_y)
    love.graphics.line(self.x, self.y, self.x, self.y + self.size_y)
    love.graphics.line(right, self.y, right, self.y + self.size_y)

    love.graphics.printf(
        self.label,
        self.x,
        self.y - (self.size_y + font:getHeight()) / 2,
        self.size_x,
        "center"
    )

    love.graphics.printf(
        "<",
        left,
        self.y + (self.size_y - font:getHeight()) / 2,
        arrow_width,
        "center"
    )
    love.graphics.printf(
        tostring(self:obtainSelected()),
        self.x,
        self.y + (self.size_y - font:getHeight()) / 2,
        self.size_x,
        "center"
    )
    love.graphics.printf(
        ">",
        right,
        self.y + (self.size_y - font:getHeight()) / 2,
        arrow_width,
        "center"
    )
end

return ArrowSelector
