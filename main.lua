local StateMachine = require("states.StateMachine")
local moonshine = require 'libraries.moonshine'
local Settings = require("settings")
local Scale = require("classes.Scale")

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
        Scale.begin()
        stateMachine:draw()
        Scale.finish()
    end)
end

function love.resize(width, height)
    if shader then
        shader.resize(width, height)
    end
end

function love.keypressed(key)
    stateMachine:keypressed(key)
end

function love.mousepressed(x, y, button)
    x, y = Scale.toVirtual(x, y)
    stateMachine:mousepressed(x, y, button)
end

function love.mousemoved(x, y, dx, dy)
    x, y = Scale.toVirtual(x, y)
    local factor = Scale.getFactor()
    dx, dy = dx / factor, dy / factor
    stateMachine:mousemoved(x, y, dx, dy)
end

function love.mousereleased(x, y, button)
    x, y = Scale.toVirtual(x, y)
    stateMachine:mousereleased(x, y, button)
end
