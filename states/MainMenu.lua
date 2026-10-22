local MainMenu = {}

local Button = require("classes.UI.Button")
local ButtonContainer = require("classes.UI.ButtonContainer")

function MainMenu:enter()
    self.title_font = love.graphics.newFont("assets/fonts/game_over.ttf", 200)
    self.button_font = love.graphics.newFont("assets/fonts/game_over.ttf", 80)

    local width, height = love.graphics.getDimensions()
    local button_width, button_height = 360, 90

    self.buttons = ButtonContainer.new()
    self.buttons:add(Button.new(
        (width - button_width) / 2,
        height / 2 + 100,
        button_width,
        button_height,
        function(_, _, _, _, machine)
            machine:switch("gameplay")
        end,
        "Click to play"
    ))
    self.buttons:add(Button.new(
        (width - button_width) / 2,
        height / 2 + 200,
        button_width,
        button_height,
        function(_, _, _, _, machine)
            machine:switch("options")
        end,
        "Options"
    ))

    self.buttons:add(Button.new(
        (width - button_width) / 2,
        height / 2 + 300,
        button_width,
        button_height,
        function(_, _, _, _, machine)
            love.event.quit()
        end,
        "Quit"
    ))


end

function MainMenu:update(dt)
end

function MainMenu:draw()
    local width, height = love.graphics.getDimensions()
    love.graphics.setFont(self.title_font)
    love.graphics.printf("PONG", 0, height / 2 - 180, width, "center")

    love.graphics.setFont(self.button_font)
    self.buttons:draw()
end

function MainMenu:mousepressed(x, y, button, machine)
    self.buttons:mousepressed(x, y, button, machine)
end

function MainMenu:keypressed(key, machine)
    self.buttons:keypressed(key, machine)
end

function MainMenu:mousemoved()
    self.buttons:mousemoved()
end

return MainMenu