

width, height = love.graphics.getDimensions()

function love.load()

end

function love.draw()
	love.graphics.printf("Text test", 0, height / 2 - 6, width, "center")
end
