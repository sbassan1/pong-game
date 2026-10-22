local MainMenu = {}

local Button = require("classes.Button")

function MainMenu:enter()
    self.title_font = love.graphics.newFont("assets/fonts/game_over.ttf", 200)
    self.button_font = love.graphics.newFont("assets/fonts/game_over.ttf", 80)

    local width, height = love.graphics.getDimensions()
    local button_width, button_height = 360, 90

    self.play_button = Button.new(
        (width - button_width) / 2,
        height / 2 + 100,
        button_width,
        button_height,
        function(_, _, _, _, machine)
            machine:switch("gameplay")
        end,
        "Click to play"
    )
    self.quit_button = Button.new(
        (width - button_width) / 2,
        height / 2 + 200,
        button_width,
        button_height,
        function(_, _, _, _, machine)
            love.event.quit()
        end,
        "Quit"
    )


end

function MainMenu:update(dt)
end

function MainMenu:draw()
    local width, height = love.graphics.getDimensions()
    love.graphics.setFont(self.title_font)
    love.graphics.printf("PONG", 0, height / 2 - 180, width, "center")

    love.graphics.setFont(self.button_font)
    self.play_button:draw()
    self.quit_button:draw()
end

function MainMenu:mousepressed(x, y, button, machine)
    self.play_button:mousepressed(x, y, button, machine)
    self.quit_button:mousepressed(x, y, button, machine)
end

function MainMenu:keypressed(key, machine)
    if key == "return" then
        love.graphics.setNewFont(20)
        machine:switch("gameplay")
    end
end

return MainMenu