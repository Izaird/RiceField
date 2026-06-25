local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "hyprlauncher"

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

local bind = hl.bind
local dsp = hl.dsp

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
bind(mainMod .. " + T", dsp.exec_cmd(terminal))
local closeWindowBind = bind(mainMod .. " + Q", dsp.window.close())
-- closeWindowBind:set_enabled(false)
-- bind(mainMod .. " + M", dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
bind(mainMod .. " + E", dsp.exec_cmd(fileManager))
bind(mainMod .. " + V", dsp.window.float({ action = "toggle" }))
bind(mainMod .. " + R", dsp.exec_cmd(menu))
bind(mainMod .. " + P", dsp.window.pseudo())
bind(mainMod .. " + J", dsp.layout("togglesplit"))    -- dwindle only

-- Move focus with mainMod + arrow keys
bind(mainMod .. " + left",  dsp.focus({ direction = "left" }))
bind(mainMod .. " + right", dsp.focus({ direction = "right" }))
bind(mainMod .. " + up",    dsp.focus({ direction = "up" }))
bind(mainMod .. " + down",  dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  bind(mainMod .. " + " .. key,           dsp.focus({ workspace = i}))
  bind(mainMod .. " + ALT + " .. key,     dsp.focus({ workspace = i + 10}))
  bind(mainMod .. " + SHIFT + " .. key,   dsp.window.move({ workspace = i }))
  bind(mainMod .. " + ALT + SHIFT + " .. key,   dsp.window.move({ workspace = i + 10 }))
end


bind(mainMod .. "+ Space", dsp.window.fullscreen_state({
  internal = 2,
  client = 0,
  action = "toggle"
}))

-- Example special workspace (scratchpad)
-- bind(mainMod .. " + S",         dsp.workspace.toggle_special("magic"))
-- bind(mainMod .. " + SHIFT + S", dsp.window.move({ workspace = "special:magic" }))

--
-- bind(mainMod .. " + S", function ()
--
--   hl.animation({ leaf = "fadeOut", enabled = true, speed = 10, bezier = })
--
-- end)
--



hl.bind("SUPER + S", function()

  -- hl.dispatch(hl.dsp.event("test"))
  -- hl.animation({ leaf = "fadeIn", enabled = false})
    -- hl.animation({ leaf = "fadeLayersOut", enabled = false})
    hl.dispatch(hl.dsp.exec_cmd("grimblast --notify copy area"))
    -- hl.animation({ leaf = "fadeIn", enabled = true, speed = 4, bezier = "default" })
    -- hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 4, bezier = "default" })
end)
-- local screenshotarea = hl.animation("fadeOut,0,0,default") ; grimblast --notify copysave area; hyprctl keyword animation "fadeOut,1,4,default"
-- $screenshotarea_copy = hyprctl keyword animation "fadeOut,0,0,default"; grimblast --notify copy area; hyprctl keyword animation "fadeOut,1,4,default"
-- $screenshotarea_copy_edit = hyprctl keyword animation "fadeOut,0,0,default"; grim -g "$(slurp)" - | satty --filename - -c ~/.config/satty/satty_config; hyprctl keyword animation "fadeOut,1,4,default"
-- bind = SUPER SHIFT, S, exec, $screenshotarea
-- bind = SUPER, S, exec, $screenshotarea_copy

-- Scroll through existing workspaces with mainMod + scroll
bind(mainMod .. " + mouse_down", dsp.focus({ workspace = "e+1" }))
bind(mainMod .. " + mouse_up",   dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
bind(mainMod .. " + mouse:272", dsp.window.drag(),   { mouse = true })
bind(mainMod .. " + mouse:273", dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
bind("XF86AudioRaiseVolume", dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
bind("XF86AudioLowerVolume", dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
bind("XF86AudioMute",        dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
bind("XF86AudioMicMute",     dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
bind("XF86MonBrightnessUp",  dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
bind("XF86MonBrightnessDown",dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
bind("XF86AudioNext",  dsp.exec_cmd("playerctl next"),       { locked = true })
bind("XF86AudioPause", dsp.exec_cmd("playerctl play-pause"), { locked = true })
bind("XF86AudioPlay",  dsp.exec_cmd("playerctl play-pause"), { locked = true })
bind("XF86AudioPrev",  dsp.exec_cmd("playerctl previous"),   { locked = true })
