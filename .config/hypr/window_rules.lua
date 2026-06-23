local rule = hl.window_rule

-- rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })


local suppressMaximizeRule = rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

rule({
  -- Fix some dragging issues with XWayland
  name  = "fix-xwayland-drags",
  match = {
    class       = "^$",
    title       = "^$",
    xwayland    = true,
    float       = true,
    fullscreen  = false,
    pin         = false,
  },

  no_focus = true,
})

rule({
  name = "bitwarden popup",
  match = {
    class       = "brave-.*",
    title       = "_crx_.*",
  },

  float = true,
  center = true,
  size = {"monitor_w * 0.3", "monitor_h * 0.7"},
})

rule({
  name = "portal filemanger popup",
  match = { class = "^(org.freedesktop.impl.portal.desktop.kde)$" },

  float = true,
  center = true,
  size = {
    "monitor_w * 0.75",
    "monitor_h * 0.75"
  },
})




-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})



rule({
  name = "rotation_widget_krita",
  match = { title = "(Rotation Widget — Krita)|(Pie Widget — Krita)" },

  float = true,
  -- decorate = false,
  no_blur = true,
  move = { "(cursor_x - (window_w * 0.5))", "(cursor_y - (window_h * 0.5))" }
})

--
-- rule({
--   name = "pie_widget_krita",
--   match = { title = "Pie Widget — Krita" },
--
--   float = true,
--   decorate = false,
--   no_blur = true,
--   move = { "(cursor_x - (window_w * 0.5))", "(cursor_y - (window_h * 0.5))" }
-- })
