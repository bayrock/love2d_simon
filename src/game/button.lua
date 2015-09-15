--[[
button.lua
Author: Bayrock
]]

local button = {}
function CreateButton(lbl, x, y, r, g , b, a, sound)
	local lbl = lbl or ""

	button[lbl] = {x = x, y = y, r = r, g = g, b = b, sound = sound,
	isOn = false, isHovered = false, isCorrect = false}
end

local function IsHovered(x1,y1,w1,h1, mx,my)
	return mx > x1 and mx < x1 + w1 and my > y1 and my < y1 + h1
end

local buttonseq = {}
local function NextInSequence()
	return buttonseq[1]
end

function ClearButtonSequence()
	buttonseq = {}
end

function GetButtonSequence()
	return buttonseq
end

local w, h = 200, 200
function UpdateButtons()
	if #buttonseq < 1 then
		gamestate.push(simon) -- push simon state
	end

	if gamestate.current() == simon then return end

	local mx, my = love.mouse.getPosition()

	for lbl, v in pairs(GetAllButtons()) do
		if IsHovered(v.x, v.y, w, h, mx, my) then
			v.isHovered = true
			if mouse then
				v.isOn = true
			else
				v.isOn = false
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
	end
end

function DrawButtons()
	for _, v in pairs(GetAllButtons()) do
		lg.setColor(v.r,v.g,v.b,v.a)

		lg.push() -- draw the button
		lg.rectangle('fill',v.x,v.y,w,h)
		lg.pop()
	end
end

function AnimateButtons(dt)
	for _, v in pairs(GetAllButtons()) do
		if v.isHovered
		and v.a < 254
		and not v.isOn then
			v.a = v.a + 400 * dt
		elseif v.isOn then
			v.a = 100
		elseif v.a > 100 then
			v.a = v.a - 400 * dt
		end
	end
end

function GetButton(lbl)
	return button[lbl] or nil
end

function GetAllButtons()
	return button
end
