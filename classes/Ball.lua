local Ball = {}
Ball.__index = Ball

function Ball.new(x, y, width, height, speed, up_key, down_key)
    local self = setmetatable({}, Ball)
    self.x = x
    self.y = y
    self.width = width or 20
    self.height = height or 20
    self.speed = speed or 420
    self.direction = {x = -1, y = 1}
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

function Ball:wall_collision()
    if self.y <= 0 or self.y + self.height >= love.graphics.getHeight() then
        self.direction.y = -self.direction.y
    end
end


return Ball