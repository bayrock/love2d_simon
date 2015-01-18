--[[
main.lua
Author: Bayrock (http://Devinity.org)
]]

require("game")
gamestate = require ("lib.gamestate")

function love.load()
	love.graphics.setBackgroundColor(255, 255, 255)
	gamestate.registerEvents()
	gamestate.switch(game)
	print("Loaded "..projectName..version)
end

function love.keyreleased(key)
	if key == "escape" then
		love.event.quit()
	end
end

function love.quit()
	print("Exiting...")
end
