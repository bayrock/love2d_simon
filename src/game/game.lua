--[[
game.lua
Author: Bayrock (http://Devinity.org)
]]

require("game.button")

windowWidth = love.graphics.getWidth()
windowHeight = love.graphics.getHeight()
lg = love.graphics

math.random = love.math.random

local function buttonTest()
	for lbl, v in pairs(GetAllButtons()) do -- run button test
		local rand = math.random(2)
		if rand == 2 then
			v.isOn = true
			print("Button "..lbl.." is on.")
		else
			print("Button "..lbl.." is off.")
		end
	end
end

game = {} -- game state constructor
function game:init()
	CreateButton("green", 0, 0, 204, 255, 153, 255)
	CreateButton("pink", 200, 0, 255, 153, 204, 255)
	CreateButton("blue", 0, 200, 153, 204, 255, 255)
	CreateButton("yellow", 200, 200, 255, 255, 153, 255)

	buttonTest()
end

function game:enter()
--	enter game
end

function game:update(dt)
	updateButtons()
end

local function drawDebug()
	if debug then
		lg.setColor(0, 0, 0)
		lg.print(projectName..version, 5, 5)
		lg.print("FPS: "..love.timer.getFPS( ), 5, 20)
		for _, v in pairs(GetAllButtons()) do
			-- create a point at button coords
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
