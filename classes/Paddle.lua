local Paddle = {}
Paddle.__index = Paddle

function Paddle.new(x, y, width, height, speed)
    local self = setmetatable({}, Paddle)
    self.x = x
    self.y = y
    self.width = width or 20
    self.height = height or 100
    self.speed = speed or 400
    return self
end

function Paddle:update(dt)
    -- Paddle movement logic will be handled here
end

function Paddle:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Paddle
