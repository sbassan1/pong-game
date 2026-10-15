local Paddle = require("classes.Paddle")

local player1, player2
local width, height

function love.load()
    width, height = love.graphics.getDimensions()
    
    local paddle_width = 20
    local paddle_height = 100
    local margin = 40

    -- Player 1 on the left (W / S)
    player1 = Paddle.new(margin, height / 2 - paddle_height / 2, paddle_width, paddle_height, 500, "w", "s")
    
    -- Player 2 on the right (Up / Down arrows)
    player2 = Paddle.new(width - margin - paddle_width, height / 2 - paddle_height / 2, paddle_width, paddle_height, 500, "up", "down")
end

function love.update(dt)
    player1:update(dt)
    player2:update(dt)
end

function love.draw()
    -- Draw title / instructions
    love.graphics.printf("Pong - Use W/S and Up/Down to move paddles", 0, 20, width, "center")

    -- Draw paddles
    player1:draw()
    player2:draw()
end
