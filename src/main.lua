--[[
main.lua
Author: Bayrock (http://Devinity.org)
]]

require("game.game")
gamestate = require("lib.gamestate")
timer = require("lib.timer")

function love.load()
	lg.setBackgroundColor(0, 0, 0)
	gamestate.registerEvents()
	gamestate.switch(menu)
	love.keyboard.setTextInput(false)
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
