local OptionMenu = {}

local Button = require("classes.UI.Button")
local ButtonContainer = require("classes.UI.ButtonContainer")
local ArrowSelector = require("classes.UI.ArrowSelector")
local VolumeSlider = require("classes.UI.VolumeSlider")
local Settings = require("settings")

function OptionMenu:enter(volume, resolution)

    self.title_font = love.graphics.newFont("assets/fonts/game_over.ttf", 200)
    self.button_font = love.graphics.newFont("assets/fonts/game_over.ttf", 80)

    local width, height = love.graphics.getDimensions()
    local button_width, button_height = 360, 90


    self.volumeOption = VolumeSlider.new(width - (2 * width/7), 2* height / 7, button_width, button_height)
    self.volumeOption:setPercentage(volume or Settings.volume)

    self.resolutionOptions = ArrowSelector.new(width/7, 2* height / 7, button_width, button_height,
    "Resolution",
    {
        "1366x768",
        "1920x1080",
        "1280x720"
    })

    resolution = resolution or Settings.resolution
    for index, option in ipairs(self.resolutionOptions.options) do
        if option == resolution then
            self.resolutionOptions.selected_index = index
            break
        end
    end

    self.buttons = ButtonContainer.new()

    self.buttons:add(Button.new(
        ((width - button_width) / 2) + (button_width),
        6 * height / 7,
        button_width,
        button_height,
        function(_, _, _, _, machine)
            machine:switch("mainMenu")
        end,
        "Return to Main Menu"
    ))

    self.buttons:add(Button.new(
        ((width - button_width) / 2) - (button_width) ,
        6 * height / 7,
        button_width,
        button_height,
        function(_, _, _, _, machine)
            local resolution = self.resolutionOptions:obtainSelected()
            local width, height = resolution:match("^(%d+)x(%d+)$")
            width, height = tonumber(width), tonumber(height)

            if not width or not height then
                print("Invalid resolution: " .. tostring(resolution))
                return
            end

            local volume = self.volumeOption.percentage
            local ok, err = love.window.setMode(width, height, {
                resizable = false,
                fullscreen = false,
            })

            if not ok then
                print("Could not change resolution: " .. tostring(err))
                return
            end

            love.audio.setVolume(volume / 100)

            local saved, save_error = Settings.save(
                volume,
                self.resolutionOptions:obtainSelected()
            )
            if not saved then
                print("Could not save settings: " .. tostring(save_error))
            end

            machine:switch("options", volume, self.resolutionOptions:obtainSelected())
        end,
        "Apply"
    ))

end

function OptionMenu:update(dt)

end

function OptionMenu:draw()
    local width, height = love.graphics.getDimensions()
    love.graphics.setFont(self.title_font)
    love.graphics.printf("Options", 0, height / 7, width, "center")

    love.graphics.setFont(self.button_font)
    self.buttons:draw()
    self.resolutionOptions:draw()
    self.volumeOption:draw()
end

function OptionMenu:mousepressed(x, y, button, machine)
    self.buttons:mousepressed(x, y, button, machine)
    self.resolutionOptions:mousepressed(x, y, button)
    self.volumeOption:mousepressed(x, y, button)
end

function OptionMenu:keypressed(key, machine)
    self.buttons:keypressed(key, machine)

end

function OptionMenu:mousemoved(x, y, dx, dy)
    self.buttons:mousemoved()
    self.volumeOption:mousemoved(x, y, dx, dy)
end

function OptionMenu:mousereleased(x, y, button)
    self.volumeOption:mousereleased(x, y, button)
end

return OptionMenu
