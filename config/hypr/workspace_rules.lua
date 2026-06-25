local monitor_1 = "DP-1"
local monitor_2 = "DP-2"
local monitor_3 = "HDMI-A-1"
local rule = hl.workspace_rule

-- "Smart gaps" / "No gaps when only"
rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })

-- Assign workspaces to monitors
local function assign(ws, monitor)
  rule({ workspace = tostring(ws),      monitor = monitor })
  rule({ workspace = tostring(ws + 10), monitor = monitor })
end

for i = 1, 10 do
  assign(i, monitor_1)
  if i > 5 and i < 9 then
    assign(i, monitor_2)
  elseif i > 8 then
    assign(i, monitor_3)
  end
end
