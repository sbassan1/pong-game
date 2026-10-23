local StateMachine = require("states.StateMachine")
local moonshine = require 'libraries.moonshine'
local Settings = require("settings")

local stateMachine
local shader

function love.load()
    Settings.load()

    local width, height = Settings.resolution:match("^(%d+)x(%d+)$")
    local mode_set, mode_error = love.window.setMode(tonumber(width), tonumber(height), {
        resizable = false,
        fullscreen = false,
    })
    if not mode_set then
        print("Could not apply saved resolution: " .. tostring(mode_error))
    end
    love.audio.setVolume(Settings.volume / 100)

    shader = moonshine(moonshine.effects.crt).chain(moonshine.effects.scanlines)
    shader.parameters = {
        crt = {distortionFactor = {1.035, 1.045}},
        scanlines = {opacity = 0.35, thickness = 2}
    }

    stateMachine = StateMachine.new({
        mainMenu = require("states.MainMenu"),
        gameplay = require("states.Gameplay"),
        gameOver = require("states.GameOver"),
        options = require("states.OptionMenu"),
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

function love.mousereleased(x, y, button)
    stateMachine:mousereleased(x, y, button)
end
