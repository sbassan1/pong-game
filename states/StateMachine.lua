local StateMachine = {}
StateMachine.__index = StateMachine

function StateMachine.new(states)
    return setmetatable({
        states = states,
        current = nil,
        currentName = nil,
    }, StateMachine)
end

function StateMachine:switch(name, ...)
    local nextState = assert(self.states[name], "Unknown state: " .. name)

    if self.current and self.current.exit then
        self.current:exit()
    end

    self.current = nextState
    self.currentName = name

    if self.current.enter then
        self.current:enter(...)
    end
end

function StateMachine:update(dt)
    if self.current and self.current.update then
        self.current:update(dt, self)
    end
end

function StateMachine:draw()
    if self.current and self.current.draw then
        self.current:draw()
    end
end

function StateMachine:keypressed(key)
    if self.current and self.current.keypressed then
        self.current:keypressed(key, self)
    end
end

function StateMachine:mousepressed(x, y, button)
    if self.current and self.current.mousepressed then
        self.current:mousepressed(x, y, button, self)
    end
end

function StateMachine:mousemoved(x, y, dx, dy)
    if self.current and self.current.mousemoved then
        self.current:mousemoved(x, y, dx, dy, self)
    end
end

return StateMachine