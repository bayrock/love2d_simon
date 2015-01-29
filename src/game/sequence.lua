--[[
sequence.lua
Author: Bayrock (http://Devinity.org)
]]

seq = {}
local function ExtendSequence()
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
local function PlaySequence()
  if not played then
    local dly
    dly = 2

    for k, v in pairs(ConstructSequence()) do
      local dupe = false

      if v == GetSeqKey(k - 1) then
        dupe = true
      else
        dupe = false
      end

      if not dupe then
        timer.add(dly, function() GetButton(v).isOn = true
          GetButton(v).sound:play() end)
        dly = dly + 2
        timer.add(dly, function() GetButton(v).isOn = false end)
      else
        timer.add(dly + 0.5, function() GetButton(v).isOn = true
          GetButton(v).sound:play() end)
        dly = dly + 2.5
        timer.add(dly, function() GetButton(v).isOn = false end)
      end
    end

    if dly >= GetSeqLength() * 2 then
      timer.add(dly, function() played = true end)
    end
  end
end

sequence = {}-- sequence state constructor
function sequence:enter()
  for _, v in pairs(GetAllButtons()) do
    v.isOn = false -- untoggle buttons
    v.a = 100
  end

  if GetSeqLength() == 0 then
    for i= 1, 2 do
      ExtendSequence()
    end
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
    for _, v in pairs(ConstructSequence()) do
      table.insert(buttonseq, v) -- fill sequence
    end

    gamestate.pop() -- pop sequence
  end
end

function sequence:draw()
  drawButtons()
end

function ConstructSequence()
  return seq
end

function GetSeqLength()
  return #seq
end

function GetSeqKey(key)
  return seq[key]
end
