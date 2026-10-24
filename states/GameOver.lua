local GameOver = {}

local Button = require("classes.UI.Button")
local ButtonContainer = require("classes.UI.ButtonContainer")
local Scale = require("classes.Scale")

local victory_sound = love.audio.newSource("assets/sounds/victory.wav", "static") -- https://pixabay.com/es/sound-effects/pel%C3%ADculas-y-efectos-especiales-victory-85561/
local title_font = love.graphics.newFont("assets/fonts/game_over.ttf", 200)
local button_font = love.graphics.newFont("assets/fonts/game_over.ttf", 100)

function GameOver:enter(winner, machine)
    self.winner = winner
    victory_sound:play()


    local width, height = Scale.BASE_WIDTH, Scale.BASE_HEIGHT
    local button_width, button_height = 360, 90

    self.buttons = ButtonContainer.new()

    self.buttons:add(Button.new(
        (width - button_width) / 2,
        4 * height / 6,
        button_width,
        button_height,
        function(_, _, _, _, machine)
            machine:switch("gameplay")
        end,
        "Rematch"
    ))

    self.buttons:add(Button.new(
        (width - button_width) / 2,
        4 * height / 6 + 100,
        button_width,
        button_height,
        function(_, _, _, _, machine)
            local pause_sound = love.audio.newSource("assets/sounds/pause_sound.wav", "static") -- https://samplefocus.com/samples/retro-buzzer-hit-sfx?search_id=222244974
            pause_sound:play()
            machine:switch("mainMenu")
        end,
        "Main Menu"
    ))

    self.buttons:add(Button.new(
        (width - button_width) / 2,
        4 * height / 6 + 200,
        button_width,
        button_height,
        function(_, _, _, _, machine)
            love.event.quit()
        end,
        "Quit"
    ))

end

function GameOver:draw()
    local width, height = Scale.BASE_WIDTH, Scale.BASE_HEIGHT

    love.graphics.setFont(title_font)
    love.graphics.printf(self.winner .. " wins!", 0, height / 2 - 160, width, "center")

    love.graphics.setFont(button_font)
    self.buttons:draw()
end

function GameOver:mousepressed(x, y, button, machine)
    self.buttons:mousepressed(x, y, button, machine)
end

function GameOver:keypressed(key, machine)
    self.buttons:keypressed(key, machine)
    if key == "q" then
        love.event.quit()
    end
end

function GameOver:mousemoved()
    self.buttons:mousemoved()
end

return GameOver