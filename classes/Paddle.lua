local Paddle = {}
Paddle.__index = Paddle

function Paddle.new(x, y, width, height, speed, up_key, down_key)
    local self = setmetatable({}, Paddle)
    self.x = x
    self.y = y
    self.width = width or 20
    self.height = height or 100
    self.speed = speed or 400
    self.up_key = up_key or "w"
    self.down_key = down_key or "s"
    return self
end

function Paddle:update(dt)
    if love.keyboard.isDown(self.up_key) then
        self.y = self.y - self.speed * dt
    elseif love.keyboard.isDown(self.down_key) then
        self.y = self.y + self.speed * dt
    end

    -- Keep paddle within screen bounds
    local window_height = love.graphics.getHeight()
    if self.y < 0 then
        self.y = 0
    elseif self.y + self.height > window_height then
        self.y = window_height - self.height
    end
end

function Paddle:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Paddle
