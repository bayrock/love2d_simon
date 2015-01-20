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
    for k, v in pairs(GetSequence()) do
      local dupe = false

      if v == GetSeqKey(k - 1) then
        dupe = true
      else
        dupe = false
      end

      if not dupe then
        timer.add(dly, function() GetButton(v).isOn = true end)
        dly = dly + 2
        timer.add(dly, function() GetButton(v).isOn = false end)
        print(v)
      else
        timer.add(dly + 1, function() GetButton(v).isOn = true end)
        dly = dly + 4
        timer.add(dly - 1, function() GetButton(v).isOn = false end)
        print(v)
      end
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

function sequence:enter()
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

function GetSeqKey(key)
  return seq[key]
end


--[[TODO

-- add menu state
-- pop to sequence on game init
-- click sequence chain in order
-- add a loser state

]]
