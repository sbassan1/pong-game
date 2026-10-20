local GameOver = {}

local victory_sound = love.audio.newSource("assets/sounds/victory.wav", "static") -- https://pixabay.com/es/sound-effects/pel%C3%ADculas-y-efectos-especiales-victory-85561/
local font = love.graphics.newFont('assets/fonts/game_over.ttf', 200)

function GameOver:enter(winner)
    love.graphics.setFont(font)
    self.winner = winner
    victory_sound:play()
end

function GameOver:draw()
    local width, height = love.graphics.getDimensions()
    love.graphics.printf(self.winner .. " wins!", 0, height / 2 - 160 , width, "center")
    love.graphics.printf("Press Q to close", 0, height / 2 + 60 , width, "center")
end
function GameOver:keypressed(key, machine)
    if key == "q" then
        love.event.quit()
    end
end

return GameOver