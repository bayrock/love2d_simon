--[[
simon.lua
Author: Bayrock (http://Devinity.org)
]]

simon = {} -- simon state constructor
function simon:enter()
  for _, v in pairs(GetAllButtons()) do
    v.isOn = false -- untoggle buttons
    v.a = 100
  end

  if GetSeqLength() == 0 then
    for i= 1, 2 do
      ExtendSequence()
    end
  end

  played = false -- reset simon

  ExtendSequence() -- add color to sequence

  PlaySequence() -- play simon indicators
end

function simon:update(dt)
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

    gamestate.pop() -- pop to game state
  end
end

function simon:draw()
  drawButtons()
end
