local MainMenu = {}

function MainMenu:enter()
end

function MainMenu:update(dt)
end

function MainMenu:draw()
    local width, height = love.graphics.getDimensions()
    love.graphics.printf("PONG", 0, height / 2 - 40, width, "center")
    love.graphics.printf("Press Enter to play", 0, height / 2, width, "center")
end

function MainMenu:keypressed(key, machine)
    if key == "return" then
        machine:switch("gameplay")
    end
end

return MainMenu