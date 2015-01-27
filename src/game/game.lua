--[[
game.lua
Author: Bayrock (http://Devinity.org)
]]

require("game.menu")
require("game.button")
require("game.sequence")

lg = love.graphics
windowWidth = lg.getWidth()
windowHeight = lg.getHeight()

math.random = love.math.random

game = {} -- game state constructor
function game:update(dt)
	updateButtons()
end

local function drawDebug()
	if debug then
		lg.setColor(0, 0, 0)
		lg.print(projectName..version, 5, 5)
		lg.print("FPS: "..love.timer.getFPS(), 5, 20)
		for _, v in pairs(GetAllButtons()) do
			lg.point(v.x, v.y)
		end
	end
end

function game:draw()
	drawButtons()
	drawDebug()
end

function game:keypressed(key)
	if key == "`" and not debug or key == "/" and not debug then
		debug = true
		print("Debug overlay enabled")
	elseif key == "`" and debug or key == "/" and debug then
		debug = false
	 	print("Debug overlay disabled")
	end
end

function game:mousepressed(x, y, btn)
	if btn == "l" and not mouse then
		mouse = true
	end
end

function game:mousereleased(x, y, btn)
	if btn == "l" and mouse then
		mouse = false
		checkSequence()
	end
end
