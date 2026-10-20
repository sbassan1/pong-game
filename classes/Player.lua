
local Player = {}
Player.__index = Player

function Player.new(paddle, points)
    local self = setmetatable({}, Player)
    self.paddle = paddle
    self.points = points or 0
    return self
end

function Player:add_point()
    self.points = self.points + 1
end

function Player:get_points()
    return self.points
end

function Player:update(dt)
    local movement = self.paddle:get_keyboard_input()
    self.paddle:update(dt, movement)

    if love.keyboard.isDown('q') then
        love.event.quit()
    end
end

function Player:draw()
    self.paddle:draw()
end

return Player