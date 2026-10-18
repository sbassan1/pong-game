local Ball = {}
Ball.__index = Ball

local DEFAULT_SPEED = 400
local speed_increase_factor = 1.15
local time_to_reset = 1 -- time in seconds

local ball_collision_sound = love.audio.newSource("assets/sounds/ball_collision.wav", "static")
local ball_collision_sounds = {ball_collision_sound}


local function play_collision_sound()
    local sound
    for _, candidate in ipairs(ball_collision_sounds) do
        if not candidate:isPlaying() then
            sound = candidate
            break
        end
    end

    if not sound then
        sound = ball_collision_sound:clone()
        table.insert(ball_collision_sounds, sound)
    end

    sound:setPitch(0.5 + love.math.random() * 1.2)
    sound:play()
end

function Ball.new(x, y, width, height, speed, up_key, down_key)
    local self = setmetatable({}, Ball)
    self.x = x
    self.y = y
    self.width = width or 20
    self.height = height or 20
    self.speed = speed or 420
    self.direction = {x = -1, y = 0} -- Initial direction of ball
    return self
end

function Ball:update(dt)
    if self.reset_timer then
        self.reset_timer = self.reset_timer - dt
        if self.reset_timer <= 0 then
            self.reset_timer = nil
            self.speed = DEFAULT_SPEED
        end
        return
    end

    self:wall_collision()
    self.x = self.x + self.direction.x * self.speed * dt
    self.y = self.y + self.direction.y * self.speed * dt
end

function Ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

-- Aditional methods for Ball class

function Ball:set_direction(x, y)
    local length = math.sqrt(x * x + y * y)
    if length == 0 then return end

    self.direction.x = x / length
    self.direction.y = y / length
end

function Ball:bounce_paddle(paddle, x_direction)
    local ball_center = self.y + self.height / 2
    local paddle_center = paddle.y + paddle.height / 2

    local y_direction = (ball_center - paddle_center) / (paddle.height / 2)
    y_direction = math.max(-1, math.min(1, y_direction))

    self:set_direction(x_direction, y_direction)
    self.speed = self.speed * speed_increase_factor -- Increase speed by 25% on each paddle hit

    play_collision_sound()

end

function Ball:reaches_goal()
    if self.x <= 15 then
        return -1
    else 
        if self.x + self.width >= love.graphics.getWidth() - 15 then
            return 1
        end
    end
    return 0
end

function Ball:reset(direction)
    self.x = love.graphics.getWidth() / 2 - self.width / 2
    self.y = love.graphics.getHeight() / 2 - self.height / 2

    self.speed = 0
    self.reset_timer = time_to_reset
    self:set_direction(direction, 0)
end

function Ball:wall_collision()
    if self.y <= 0 or self.y + self.height >= love.graphics.getHeight() then
        self.direction.y = -self.direction.y
        play_collision_sound()
    end
end


return Ball