local StateMachine = require("states.StateMachine")

local stateMachine

function love.load()
    stateMachine = StateMachine.new({
        mainMenu = require("states.MainMenu"),
        gameplay = require("states.Gameplay"),
        gameOver = require("states.GameOver"),
    })

    stateMachine:switch("mainMenu")
end

function love.update(dt)
    stateMachine:update(dt)
end

function love.draw()
    stateMachine:draw()
end

function love.keypressed(key)
    stateMachine:keypressed(key)
end