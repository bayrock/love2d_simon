--[[
console.lua
Author: Bayrock
]]

local prints = {}
function print(txt, r, g, b)
	table.insert(prints, {txt, r, g, b})
end

console = {} -- console state constructor
function console:init()
	-- initialize
end

local carrot = ">"
function console:enter(from)
	self.from = from -- record previous state
	love.audio.stop()
	carrot = ">" -- reset carrot
	love.keyboard.setKeyRepeat(true)
	love.keyboard.setTextInput(true)
end

local tick = 0
local text = ""
function console:update(dt)
	if string.len(text) >= 1 then
		carrot = ">"
	else
		tick = tick + 1

		if tick == 1000 then
			carrot = ""
		elseif tick == 1500 then
			tick = 0
			carrot = ">"
		end
	end
end

function console:textinput(t)
	text = text..t
end

function console:display()
	lg.setColor(64, 64, 64, 200)
	lg.rectangle("fill", 0, 0, windowW, windowH)
	lg.setColor(255, 255, 255)
	lg.printf(carrot, 5, windowH - 30, windowW)
	lg.printf(text, 20, windowH - 30, windowW)

	for k, tbl in pairs(prints) do
		local txt = tbl[1]
		local r, g, b = tbl[2], tbl[3], tbl[4]

		if k > 15 then
			table.remove(prints, 1)
		end

		if r then -- color check
			lg.setColor(r, g, b)
		else
			lg.setColor(255, 255, 255)
		end

		lg.printf("> "..txt, 20, k * 20, windowW)
	end
end

function console:draw()
	self.from:draw()
	self:display()
end

function console:toggle(key)
	if key == "`" then
		love.keyboard.setTextInput(false)
		gamestate.pop()
		love.audio.resume()
	end
end

function console:input(key)
	if key == "backspace" then
		text = string.sub(text, 1, -2)
	elseif key == "return"
	and string.len(text) >= 1 then
		for id, tbl in pairs(self.commands) do
			local cmd = string.match(text, "^%w+") -- grab the first statement
			local args = string.match(text, "%s.+") -- grab the rest

			if id == cmd then
				local func = tbl[1]

				if args then
					text = "" -- reset the text field
					return func(args)
				else
					text = ""
					return func()
				end
			end
		end
		print(string.format("Invalid command: '%s'", text), 255, 102, 102)
		text = ""
	end
end

function console:keypressed(key)
	self:toggle(key)
	self:input(key)
end
