local Gameplay = {}

local Paddle = require("classes.Paddle")
local Player = require("classes.Player")
local Ball = require("classes.Ball")
local Scale = require("classes.Scale")

local player1, player2, ball
local match_points = 1 -- Points required to win the game
local width, height
local paddle_width, paddle_height, paddle_speed
local margin = 40

local default_pause_duration = 1.5 -- Duration of pause in seconds

local pause_sound = love.audio.newSource("assets/sounds/pause_sound.wav", "static") -- https://samplefocus.com/samples/retro-buzzer-hit-sfx?search_id=222244974
local start_game_sound = love.audio.newSource("assets/sounds/start_game.wav", "static") -- https://samplefocus.com/samples/select-retro-videogame-sfx?search_id=222245023

local font = love.graphics.newFont('assets/fonts/game_over.ttf', 65)

function Gameplay:enter()
    width, height = Scale.BASE_WIDTH, Scale.BASE_HEIGHT
    paddle_width = width * (10/760)
    paddle_height = height * (5/38)
    paddle_speed = width * 0.4

    love.graphics.setFont(font)
    self.paused = false
    self.pause_timer = nil
    start_game_sound:play()
    ball = Ball.new(width/2, height/2-10, paddle_width, paddle_width, paddle_speed)
    player1 = Player.new(Paddle.new(margin, height / 2 - paddle_height / 2, paddle_width, paddle_height, paddle_speed, "w", "s"), 0)
    player2 = Player.new(Paddle.new(width - margin - paddle_width, height / 2 - paddle_height / 2, paddle_width, paddle_height, paddle_speed, "up", "down"), 0)
end


function Gameplay:update(dt, machine)
    -- Pause logic 
    if self.paused then
        if self.pause_timer then
            self.pause_timer = self.pause_timer - dt

            if self.pause_timer <= 0 then
                self.paused = false
                self.pause_timer = nil
            end
        end
        return
    end

    -- Game physics updates
    player1:update(dt)
    player2:update(dt)
    ball:update(dt)

    -- Collision detection for paddles and ball
    player1.paddle:check_ball_collision(ball, 1)
    player2.paddle:check_ball_collision(ball, -1)

    -- Point scoring logic
    local goal = ball:reaches_goal()
    if goal ~= 0 then
        if goal == 1 then
            player1:add_point()
        else
            player2:add_point()
        end
        ball:reset(goal)
    end

    -- Winning condition logic
    self:game_end(machine)
end

function Gameplay:game_end(machine)
    if player1:get_points() >= match_points then
        machine:switch("gameOver", "Player 1")
    elseif player2:get_points() >= match_points then
        machine:switch("gameOver", "Player 2")
    end
end

function Gameplay:draw()

    -- World borders and middle line
    love.graphics.rectangle("fill", 0, 0, 5, height)
    love.graphics.rectangle("fill", width - 5, 0, 5, height)
    love.graphics.rectangle("fill", 0, 0, width, 5)
    love.graphics.rectangle("fill", 0, height-5, width, 5)

    for i = 1, height, 30 do
        love.graphics.rectangle("fill", width / 2 - 5, i, 10, 15)
    end


    -- Score display 
    love.graphics.print("Player 1 Points: " .. player1:get_points(), 10, 10)
    love.graphics.print("Player 2 Points: " .. player2:get_points(), width - 220, 10)

    -- Game object rendering
    ball:draw()
    player1:draw()
    player2:draw()

    -- Pause overlay display
    if self.paused then
        love.graphics.setColor(0, 0, 0, 0.6)
        love.graphics.rectangle("fill", 0, 0, width, height)
        love.graphics.setColor(1, 1, 1, 1)

        if self.pause_timer then
            love.graphics.printf("Resuming...", 0, height / 2 - 30, width, "center")
        else
            love.graphics.printf("Game Paused", 0, height / 2 - 30, width, "center")
            love.graphics.printf("Press Escape to resume", 0, height / 2 + 10, width, "center")
        end
    end

end

function Gameplay:keypressed(key)
    if key ~= "escape" then
        return
    end
    pause_sound:play()

    if not self.paused then  -- If the game is not paused, pause it and set the pause timer to nil
        self.paused = true
        self.pause_timer = nil

    elseif not self.pause_timer then -- If the game is paused and the pause timer is not set, set it to resume after a delay
        pause_sound:play()
        self.pause_timer = default_pause_duration
    end
end

return Gameplay