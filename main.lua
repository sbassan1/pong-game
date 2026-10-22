local StateMachine = require("states.StateMachine")
local moonshine = require 'libraries.moonshine'

local stateMachine
local shader

function love.load()
    shader = moonshine(moonshine.effects.crt).chain(moonshine.effects.scanlines)
    shader.parameters = {
        crt = {distortionFactor = {1.035, 1.045}},
        scanlines = {opacity = 0.35, thickness = 2}
    }

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
    shader(function()
        stateMachine:draw()
    end)
end

function love.keypressed(key)
    stateMachine:keypressed(key)
end

function love.mousepressed(x, y, button)
    stateMachine:mousepressed(x, y, button)
end

function love.mousemoved(x, y, dx, dy)
    stateMachine:mousemoved(x, y, dx, dy)
end