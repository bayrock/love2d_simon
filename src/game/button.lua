--[[
button.lua
Author: Bayrock (http://Devinity.org)
]]

local button = {}
function CreateButton(lbl, x, y, r, g , b, a, sound)
	local lbl = lbl or ""

	button[lbl] = {x = x, y = y, r = r, g = g, b = b, sound = sound,
	isOn = false, isHovered = false, isCorrect = false}
end

local function buttonIsHovered(x1,y1,w1,h1, mx,my)
	return mx > x1 and mx < x1 + w1 and my > y1 and my < y1 + h1
end

buttonseq = {}
local function NextInSequence()
	return buttonseq[1]
end

local w, h = 200, 200
function updateButtons()
	if GetSeqCount() < 1 then
		gamestate.push(sequence)
	end

	if gamestate.current() == sequence then return end

	local mx, my = love.mouse.getPosition()

	for lbl, v in pairs(GetAllButtons()) do
		if buttonIsHovered(v.x, v.y, w, h, mx, my) then
			v.isHovered = true
			if mouse then
				v.isOn = false
			else
				v.isOn = true
			end
		else
			v.isHovered = false
			v.isOn = false
		end

		if lbl == NextInSequence() then
			v.isCorrect = true
		else
			v.isCorrect = false
		end

		if not v.isOn then
			v.a = 100
		else
			v.a = 230
		end
	end
end

function drawButtons()
	for _, v in pairs(GetAllButtons()) do
		lg.setColor(v.r,v.g,v.b,v.a)

		lg.push() -- draw the button
		lg.rectangle('fill',v.x,v.y,w,h)
		lg.pop()
	end
end

function GetButton(lbl)
	return button[lbl] or nil
end

function GetAllButtons()
	return button
end

function checkSequence()
	for _, v in pairs(GetAllButtons()) do
		if v.isHovered and v.isCorrect then
			v.sound:play()
			print("correct")
			table.remove(buttonseq, 1)
		elseif v.isHovered and not v.isCorrect then
			v.sound:play()
			print("incorrect")
			highscore = GetSeqLength()
		 	seq = {} -- empty sequence
			gamestate.switch(menu)
		end
	end
end

function GetButtonSequence()
	return buttonseq
end

function GetSeqCount()
	return #buttonseq
end
