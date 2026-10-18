local GameOver = {}

local victory_sound = love.audio.newSource("assets/sounds/victory.wav", "static")

function GameOver:enter(winner)
    self.winner = winner
    victory_sound:play()
end

function GameOver:draw()
    local width, height = love.graphics.getDimensions()
    love.graphics.printf(self.winner .. " wins!", 0, height / 2 - 40, width, "center")
    love.graphics.printf("Press Q to close", 0, height / 2, width, "center")
end
function GameOver:keypressed(key, machine)
    if key == "q" then
        love.event.quit()
    end
end

return GameOver