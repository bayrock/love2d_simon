--[[
menu.lua
Author: Bayrock (http://Devinity.org)
]]

function font(size, font)
	return lg.newFont(font or "game/font/coders_crux.ttf", size)
end

menu = {} -- menu state constructor
function menu:init()
	local one = love.audio.newSource("game/sound/one.mp3")
	local two = love.audio.newSource("game/sound/two.mp3")
	local three = love.audio.newSource("game/sound/three.mp3")
	local four = love.audio.newSource("game/sound/four.mp3")

	local volume = love.audio.getVolume()
	love.audio.setVolume(volume * 0.40)

	CreateButton("green", 0, 0, 204, 255, 153, 255, one)
	CreateButton("pink", 200, 0, 255, 153, 204, 255, two)
	CreateButton("blue", 0, 200, 153, 204, 255, 255, three)
	CreateButton("yellow", 200, 200, 255, 255, 153, 255, four)
end

local alpha = 253
function menu:draw()
	drawButtons()

	local w,h = windowWidth, windowHeight
	lg.setFont(font(32))
	lg.setColor(0,0,0)
	lg.printf(projectName..version, 0, h/2 - 40, w, "center")
	lg.setColor(0,0,0, alpha)
	lg.printf("Press any key to play", 0, h/2, w, "center")
	lg.setColor(0,0,0)
	if highscore > 2 then
		lg.printf("Game over!", 0, h/2 + 60, w, "center")
		lg.printf("Highscore: "..highscore, 0, h/2 + 100, w, "center")
		lg.printf("Attempts: "..attempts, 0, h/2 + 120, w, "center")
	elseif attempts > 0 then
		lg.printf("Game over!", 0, h/2 + 60, w, "center")
	end
end

function menu:enter()
	alpha = 255

	for _, v in pairs(GetAllButtons()) do
		v.isOn = true
		v.a = 255
	end
end

local animate = false
local function anim(dt)
	if alpha >= 254 then
		animate = false
	elseif alpha <= 63 then
		animate = true
	end

	if animate then
		alpha = alpha + 90 * dt
	else
		alpha = alpha - 90 * dt
	end
end

function menu:update(dt)
	anim(dt)
end

function menu:keyreleased(key)
	buttonseq = {}
	gamestate.switch(game)
end
