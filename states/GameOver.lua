local GameOver = {}

local Button = require("classes.Button")

local victory_sound = love.audio.newSource("assets/sounds/victory.wav", "static") -- https://pixabay.com/es/sound-effects/pel%C3%ADculas-y-efectos-especiales-victory-85561/
local title_font = love.graphics.newFont("assets/fonts/game_over.ttf", 200)
local button_font = love.graphics.newFont("assets/fonts/game_over.ttf", 100)

function GameOver:enter(winner)
    self.winner = winner
    victory_sound:play()


    local width, height = love.graphics.getDimensions()
    local button_width, button_height = 360, 90

    self.quit_button = Button.new(
        (width - button_width) / 2,
        height / 2 + 100,
        button_width,
        button_height,
        function(_, _, _, _, machine)
            love.event.quit()
        end,
        "Quit"
    )

end

function GameOver:draw()
    local width, height = love.graphics.getDimensions()

    love.graphics.setFont(title_font)
    love.graphics.printf(self.winner .. " wins!", 0, height / 2 - 160, width, "center")

    love.graphics.setFont(button_font)
    self.quit_button:draw()
end

function GameOver:mousepressed(x, y, button, machine)
    self.quit_button:mousepressed(x, y, button, machine)
end


return GameOver