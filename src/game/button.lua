--[[
button.lua
Author: Bayrock (http://Devinity.org)
]]

local button = {}
function CreateButton(lbl, x, y, r, g , b, a)
	local lbl = lbl or ""

	button[lbl] = {x = x, y = y, r = r, g = g, b = b, isOn = false}
end

local mx = love.mouse.getPosition()
function updateButtons()
	for _, v in pairs(GetAllButtons()) do
		if not v.isOn then
			v.a = 100
		end
	end
end

function drawButtons()
	local w,h = windowWidth/2,windowHeight/2

	for _, v in pairs(GetAllButtons()) do
		lg.setColor(v.r,v.g,v.b,v.a)

		lg.push() -- draw the button
--	lg.scale(1,1)
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

--[[TODO

-- detect mouse
for lbl, v in pairs(GetAllButtons()) do
	if mx < v.x and mx > 0 then
		v.isOn = true
		print("Button "..lbl.." is on.")
	else
		v.isOn = false
	end
end

]]
