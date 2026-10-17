local Ball = {}
Ball.__index = Ball

function Ball.new(x, y, width, height, speed, up_key, down_key)
    local self = setmetatable({}, Ball)
    self.x = x
    self.y = y
    self.width = width or 20
    self.height = height or 20
    self.speed = speed or 420
    self.direction = {x = -1, y = 0}
    return self
end

function Ball:update(dt)
    self:wall_collision()
    self.x = self.x + self.direction.x * self.speed * dt
    self.y = self.y + self.direction.y * self.speed * dt
end

function Ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Ball:bounce_paddle(paddle, x_direction)
    local ball_center = self.y + self.height / 2
    local paddle_center = paddle.y + paddle.height / 2

    local y_direction = (ball_center - paddle_center) / (paddle.height / 2)
    y_direction = math.max(-1, math.min(1, y_direction))

    local length = math.sqrt(x_direction * x_direction + y_direction * y_direction)
    self.direction.x = x_direction / length
    self.direction.y = y_direction / length
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

function Ball:wall_collision()
    if self.y <= 0 or self.y + self.height >= love.graphics.getHeight() then
        self.direction.y = -self.direction.y
    end
end


return Ball