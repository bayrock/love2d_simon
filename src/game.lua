--[[
game.lua
Author: Bayrock (http://Devinity.org)
]]

require("button")

windowWidth = love.graphics.getWidth()
windowHeight = love.graphics.getHeight()
lg = love.graphics

game = {} -- game state constructor
function game:init()
	CreateButton("green", 60, 60, 204, 255, 153)
	CreateButton("pink", 110, 110, 255, 153, 204)
	CreateButton("blue", 160, 160, 153, 204, 255)
	CreateButton("yellow", 210, 210, 255, 255, 153)
end

--[[
local alter = 25
for i = 1, 10 do -- create 10 test buttons
	CreateButton("btn"..i, 10 + alter, 10 + alter, 100, 100 , 100)
	alter = alter + 25
	print(GetButton("btn"..i).x, GetButton("btn"..i).y, "Toggled: "..tostring(GetButton("btn"..i).isOn)) -- print button data
end
]]

function game:enter()
	-- enter game
end

function game:update(dt)
--	updateButtons()
end

local function drawDebug()
	if debug then
		lg.print(projectName..version, 5, 5)
		lg.print("FPS: "..love.timer.getFPS( ), 5, 20)
		for lbl, v in pairs(GetAllButtons()) do
			-- creates a point at button coordinates
			lg.point(GetButton(lbl).x, GetButton(lbl).y)
		end
	end
end

function game:draw()
	drawButtons()
	lg.setColor(0, 0, 0)
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
