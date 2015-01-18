--[[
button.lua
Author: Bayrock (http://Devinity.org)
]]

local button = {}
function CreateButton(lbl, x, y, r, g , b, rotate)
	local lbl = lbl or ""

	button[lbl] = {x = x, y = y, r = r, g = g, b = b, isOn = false, rotate = rotate or nil}
end

local mx,my = love.mouse.getPosition()
function updateButtons()
	for lbl, v in pairs(GetAllButtons()) do

		if button[lbl].x == mx
		or button[lbl].y == my then
			button[lbl].isOn = true
			print("Button "..lbl.." is on.")
			break
		else
			button[lbl].isOn = false
		end

	end
end

function drawButtons()
	local x1,y1,x2,y2,x3,y3 = 0,0,100,0,50,100

	for lbl, v in pairs(GetAllButtons()) do
		lg.setColor(button[lbl].r,button[lbl].g,button[lbl].b)

		lg.push() -- draw the player
		lg.translate(button[lbl].x,button[lbl].y)
		lg.scale(1,1)
		lg.rotate(v.rotate or math.pi)
		lg.polygon('fill',x1,y1,x2,y2,x3,y3)
		lg.pop()
	end
end

function GetButton(lbl)
	return button[lbl] or nil
end

function GetAllButtons()
	return button
end

--[[TODO

local r2, b2, g2 = button[lbl].r + 50, button[lbl].b + 50, button[lbl].g + 50
if button[lbl].isOn then
	-- illuminate button
end

]]
