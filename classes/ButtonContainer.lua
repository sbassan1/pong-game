
local ButtonContainer = {}
ButtonContainer.__index = ButtonContainer

function ButtonContainer.new(buttons)
    local container = setmetatable({
        buttons = {},
        selected_index = 0,
        input_mode = "keyboard",
    }, ButtonContainer)

    for _, button in ipairs(buttons or {}) do
        container:add(button)
    end

    return container
end

function ButtonContainer:add(button)
    assert(type(button) == "table" and type(button.draw) == "function", "Expected a button")

    table.insert(self.buttons, button)
    if self.selected_index == 0 then
        self.selected_index = 1
    end
    self:updateSelection()

    return button
end

function ButtonContainer:updateSelection()
    for index, button in ipairs(self.buttons) do
        button.selected = self.input_mode == "keyboard" and index == self.selected_index
    end
end

function ButtonContainer:moveSelection(direction)
    if #self.buttons == 0 then
        return
    end

    self.selected_index = (self.selected_index - 1 + direction) % #self.buttons + 1
    self:updateSelection()
end

function ButtonContainer:keypressed(key, ...)
    self.input_mode = "keyboard"

    if key == "w" or key == "up" then
        self:moveSelection(-1)
    elseif key == "s" or key == "down" then
        self:moveSelection(1)
    elseif key == "return" or key == "kpenter" or key == "space" then
        local button = self.buttons[self.selected_index]
        if button then
            button:activate(nil, nil, nil, ...)
        end
    end

    self:updateSelection()
end

function ButtonContainer:mousemoved()
    self.input_mode = "mouse"
    self:updateSelection()
end

function ButtonContainer:mousepressed(x, y, mouse_button, ...)
    self.input_mode = "mouse"
    self:updateSelection()

    for _, button in ipairs(self.buttons) do
        if button:mousepressed(x, y, mouse_button, ...) then
            return true
        end
    end

    return false
end

function ButtonContainer:draw()
    local mouse_x, mouse_y = love.mouse.getPosition()

    for index, button in ipairs(self.buttons) do
        local highlighted
        if self.input_mode == "keyboard" then
            highlighted = index == self.selected_index
        else
            highlighted = button:contains(mouse_x, mouse_y)
        end
        button:draw(highlighted)
    end
end

return ButtonContainer
