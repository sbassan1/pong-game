local Paddle = require("classes.Paddle")
local Player = require("classes.Player")

local player1, player2
local width, height

function love.load()
    
    width, height = love.graphics.getDimensions()

    local paddle_width = 20
    local paddle_height = 100
    local margin = 40

    player1 = Player.new(Paddle.new(margin, height / 2 - paddle_height / 2, paddle_width, paddle_height, 500, "w", "s"), 0)
    player2 = Player.new(Paddle.new(width - margin - paddle_width, height / 2 - paddle_height / 2, paddle_width, paddle_height, 500, "up", "down"), 0)
end

function love.update(dt)
    player1:update(dt)
    player2:update(dt)
end

function love.draw()

    for i = 1, height, 30 do
        love.graphics.rectangle("fill", width / 2 - 5, i, 10, 15)
    end

    -- World Borders
    love.graphics.rectangle("fill", 0, 0, 5, height)
    love.graphics.rectangle("fill", width - 5, 0, 5, height)
    love.graphics.rectangle("fill", 0, 0, width, 5)
    love.graphics.rectangle("fill", 0, height-5, width, 5)

    love.graphics.print("Player 1 Points: " .. player1:getPoints(), 10, 10)
    love.graphics.print("Player 2 Points: " .. player2:getPoints(), width - 150, 10)

    player1:draw()
    player2:draw()
end
