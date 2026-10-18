local StateMachine = require("states.StateMachine")
local moonshine = require 'libraries.moonshine'

local stateMachine
local start_game_sound
local shader

function love.load()
    shader = moonshine(moonshine.effects.crt).chain(moonshine.effects.scanlines)
    shader.parameters = {
        crt = {distortionFactor = {1.035, 1.045}},
        scanlines = {opacity = 0.35, thickness = 2}
    }

    start_game_sound = love.audio.newSource("assets/sounds/start_game.wav", "static")
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
    if key == "return" and stateMachine.currentName == "mainMenu" then
        start_game_sound:play()
    end
    stateMachine:keypressed(key)
end