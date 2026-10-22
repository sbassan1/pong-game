local OptionMenu = {}

local Button = require("classes.Button")
local ButtonContainer = require("classes.ButtonContainer")

function OptionMenu:enter()

    self.title_font = love.graphics.newFont("assets/fonts/game_over.ttf", 200)
    self.button_font = love.graphics.newFont("assets/fonts/game_over.ttf", 80)

    local width, height = love.graphics.getDimensions()
    local button_width, button_height = 360, 90

    self.buttons = ButtonContainer.new()
    
    self.buttons:add(Button.new(
        (width - button_width) / 2,
        6 * height / 7,
        button_width,
        button_height,
        function(_, _, _, _, machine)
            machine:switch("mainMenu")
        end,
        "Return to Main Menu"
    ))

end

function OptionMenu:update(dt)

end

function OptionMenu:draw()
    local width, height = love.graphics.getDimensions()
    love.graphics.setFont(self.title_font)
    love.graphics.printf("Options", 0, height / 7, width, "center")

    love.graphics.setFont(self.button_font)
    self.buttons:draw()
end

function OptionMenu:mousepressed(x, y, button, machine)
    self.buttons:mousepressed(x, y, button, machine)
end

function OptionMenu:keypressed(key, machine)
    self.buttons:keypressed(key, machine)
end

function OptionMenu:mousemoved()
    self.buttons:mousemoved()
end

return OptionMenu