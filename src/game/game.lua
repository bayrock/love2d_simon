--[[
game.lua
Author: Bayrock (http://Devinity.org)
]]

require("game.menu")
require("game.button")
require("game.simon")
require("game.sequence")
require("game.console")
require("game.commands")

lg = love.graphics
windowW = lg.getWidth()
windowH = lg.getHeight()

math.random = love.math.random


--[[TODO
- Add options menu
- Add speed option
- Add sound option
]]

game = {} -- game state constructor
function game:enter()
	for _, v in pairs(GetAllButtons()) do
		v.isOn = false
		v.a = 100
	end
end

function game:update(dt)
	UpdateButtons()
	AnimateButtons(dt)
end

function game:debug()
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
	DrawButtons()
	self:debug()
end

function game:keypressed(key)
	if key == "`" then
		gamestate.push(console)
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
		CheckSequence()
	end
end
