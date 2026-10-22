local OptionMenu = {}

local Button = require("classes.UI.Button")
local ButtonContainer = require("classes.UI.ButtonContainer")
local ArrowSelector = require("classes.UI.ArrowSelector")

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

    self.resolutionOptions = ArrowSelector.new(width/7, 2* height / 7, button_width, button_height, {
        "1366x768",
        "1920x1080",
        "1280x720"
    })

end

function OptionMenu:update(dt)

end

function OptionMenu:draw()
    local width, height = love.graphics.getDimensions()
    love.graphics.setFont(self.title_font)
    love.graphics.printf("Options", 0, height / 7, width, "center")

    love.graphics.setFont(self.button_font)
    self.buttons:draw()
    self.resolutionOptions:draw()
end

function OptionMenu:mousepressed(x, y, button, machine)
    self.buttons:mousepressed(x, y, button, machine)
    self.resolutionOptions:mousepressed(x, y, button)
end

function OptionMenu:keypressed(key, machine)
    self.buttons:keypressed(key, machine)

end

function OptionMenu:mousemoved()
    self.buttons:mousemoved()
end

return OptionMenu