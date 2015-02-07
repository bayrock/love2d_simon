--[[
sequence.lua
Author: Bayrock (http://Devinity.org)
]]

local sequence = {} -- stores sequence
function ExtendSequence()
  local rand = math.random(4)

  if rand == 1 then
    table.insert(sequence, "green")
  elseif rand == 2 then
    table.insert(sequence, "pink")
  elseif rand == 3 then
    table.insert(sequence, "blue")
  else
    table.insert(sequence, "yellow")
  end
end

played = false
function PlaySequence()
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
        dly = dly + 1.5
        timer.add(dly, function() GetButton(v).isOn = false end)
      else
        timer.add(dly + 0.5, function() GetButton(v).isOn = true
          GetButton(v).sound:play() end)
        dly = dly + 2
        timer.add(dly, function() GetButton(v).isOn = false end)
      end
    end

    timer.add(dly, function() played = true end)
  end
end

function checkSequence()
  for _, v in pairs(GetAllButtons()) do
    if v.isHovered and v.isCorrect then
      v.sound:play()
      table.remove(buttonseq, 1)
    elseif v.isHovered and not v.isCorrect then
      v.sound:play()
      attempts = attempts + 1 -- increase attempts

      local score = GetSeqLength() - 1
      if highscore < score then
        highscore = score -- set highscore
      end

      sequence = {} -- empty sequence
      gamestate.switch(menu) -- switch to menu state
    end
  end
end

function ConstructSequence()
  return sequence
end

function GetSeqLength()
  return #sequence
end

function GetSeqKey(key)
  return sequence[key]
end
