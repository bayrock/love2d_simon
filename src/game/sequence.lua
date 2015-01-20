--[[
sequence.lua
Author: Bayrock (http://Devinity.org)
]]

local seq = {}
function ExtendSequence()
local rand = math.random(4)
  if rand == 1 then
    table.insert(seq, "green")
  elseif rand == 2 then
    table.insert(seq, "pink")
  elseif rand == 3 then
    table.insert(seq, "blue")
  else
    table.insert(seq, "yellow")
  end
end

local played = false
function PlaySequence()
  if not played then
    local dly
    dly = 2

    print("Started sequence:")
    for _, v in pairs(GetSequence()) do
      timer.add(dly, function() GetButton(v).isOn = true end)
      dly = dly + 2
      timer.add(dly, function() GetButton(v).isOn = false GetButton(v).a = 100 end)
      print(v)
    end

    if dly >= GetSeqLength() * 2 then
      timer.add(dly, function() played = true print("Finished sequence") end)
    end
  end
end

sequence = {}-- sequence state constructor
function sequence:init()
  for i= 1, 2 do
    ExtendSequence()
  end
end

function sequence:enter(from)
  for _, v in pairs(GetAllButtons()) do
    v.isOn = false
    v.a = 100
  end

  played = false -- reset sequence

  ExtendSequence() -- add color to sequence

  PlaySequence() -- play sequence indicators
end

function sequence:update(dt)
  timer.update(dt)

  for _, v in pairs(GetAllButtons()) do
    if not v.isOn then
      v.a = 100
    else
      v.a = 255
    end
  end

  if played then
    gamestate.pop()
  end
end

function sequence:draw()
  drawButtons()
end

function GetSequence()
  return seq
end

function GetSeqLength()
  return #seq
end

--[[TODO

-- create sequence helpers
-- push/pop to sequence state

]]
