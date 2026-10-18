local MainMenu = {}

local title_font, subtitle_font

function MainMenu:enter()
    title_font = love.graphics.newFont('assets/fonts/game_over.ttf', 200)
    subtitle_font = love.graphics.newFont('assets/fonts/game_over.ttf', 120)
end

function MainMenu:update(dt)
end

function MainMenu:draw()
    local width, height = love.graphics.getDimensions()
    love.graphics.setFont(title_font)
    love.graphics.printf("PONG", 0, height / 2 - 120, width, "center")
    love.graphics.setFont(subtitle_font)
    love.graphics.printf("Press Enter to play", 0, height / 2 - 30, width, "center")
end

function MainMenu:keypressed(key, machine)
    if key == "return" then
        love.graphics.setNewFont(13)
        machine:switch("gameplay")
    end
end

return MainMenu