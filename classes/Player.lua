
local Player = {}
Player.__index = Player

function Player.new(paddle, points)
    local self = setmetatable({}, Player)
    self.paddle = paddle
    self.points = points or 0
    return self
end

function Player:addPoint()
    self.points = self.points + 1
end

function Player:getPoints()
    return self.points
end

function Player:update(dt)
    self.paddle:update(dt)

    if love.keyboard.isDown('q') then
        love.event.quit()
    end

end

function Player:draw()
    self.paddle:draw()
end

return Player