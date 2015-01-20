--[[
button.lua
Author: Bayrock (http://Devinity.org)
]]

local button = {}
function CreateButton(lbl, x, y, r, g , b, a, w, h)
	local lbl = lbl or ""

	button[lbl] = {x = x, y = y, r = r, g = g, b = b, w = w, h = h,
	isOn = false, isHovered = false, isPressed = false}
end

local function buttonIsHovered(x1,y1,w1,h1, mx,my)
	return mx > x1 and mx < x1 + w1 and my > y1 and my < y1 + h1
end

function updateButtons()
	if gamestate.current() == sequence then return end

	local mx, my = love.mouse.getPosition()

	for _, v in pairs(GetAllButtons()) do
		if buttonIsHovered(v.x, v.y, v.w, v.h, mx, my) then
			v.isHovered = true
			if mouse then
				v.isPressed = true
				v.isOn = false
			else
				v.isPressed = false
				v.isOn = true
			end
		else
			v.isHovered = false
			v.isOn = false
		end

		if not v.isOn then
			v.a = 100
		else
			v.a = 255
		end
	end
end

function drawButtons()
	for _, v in pairs(GetAllButtons()) do
		lg.setColor(v.r,v.g,v.b,v.a)

		lg.push() -- draw the button
		lg.rectangle('fill',v.x,v.y,v.w,v.h)
		lg.pop()
	end
end

function GetButton(lbl)
	return button[lbl] or nil
end

function GetAllButtons()
	return button
end
