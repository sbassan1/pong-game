local StateMachine = require("states.StateMachine")

local stateMachine
local start_game_sound

function love.load()
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
    stateMachine:draw()
end

function love.keypressed(key)
    if key == "return" and stateMachine.currentName == "mainMenu" then
        start_game_sound:play()
    end
    stateMachine:keypressed(key)
end