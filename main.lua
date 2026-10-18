local Paddle = require("classes.Paddle")
local Player = require("classes.Player")
local Ball = require("classes.Ball")

local player1, player2, ball
local width, height = love.graphics.getDimensions()

local paddle_width = 20
local paddle_height = 100
local margin = 40

function love.load()
    ball = Ball.new(width/2, height/2-10)
    player1 = Player.new(Paddle.new(margin, height / 2 - paddle_height / 2, paddle_width, paddle_height, 500, "w", "s"), 0)
    player2 = Player.new(Paddle.new(width - margin - paddle_width, height / 2 - paddle_height / 2, paddle_width, paddle_height, 500, "up", "down"), 0)
end

function love.update(dt)

    -- Game physics updates
    player1:update(dt)
    player2:update(dt)
    ball:update(dt)

    -- Colission detection for paddles and ball
    player1.paddle:check_ball_collision(ball, 1)
    player2.paddle:check_ball_collision(ball, -1)

    -- Point scoring logic
    local goal = ball:reaches_goal()
    if goal ~= 0 then
        if goal == 1 then
            player2:addPoint()
        else
            player1:addPoint()
        end
        ball:reset(goal)
    end

    -- Winning condition logic
    if player1:getPoints() >= 10 then
        print("Player 1 wins!")
        love.event.quit()
    else
        if player2:getPoints() >= 10 then
            print("Player 2 wins!")
            love.event.quit()
        end
    end

end

function love.draw()

    -- World borders and middle line
    love.graphics.rectangle("fill", 0, 0, 5, height)
    love.graphics.rectangle("fill", width - 5, 0, 5, height)
    love.graphics.rectangle("fill", 0, 0, width, 5)
    love.graphics.rectangle("fill", 0, height-5, width, 5)

    for i = 1, height, 30 do
        love.graphics.rectangle("fill", width / 2 - 5, i, 10, 15)
    end


    -- Score display 
    love.graphics.print("Player 1 Points: " .. player1:getPoints(), 10, 10)
    love.graphics.print("Player 2 Points: " .. player2:getPoints(), width - 150, 10)

    -- Game object rendering
    ball:draw()
    player1:draw()
    player2:draw()
end
