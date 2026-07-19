-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--

-- autostart.lua

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprland-session.target")
    -- ... your existing autostart commands
end)

hl.on("hyprland.shutdown", function()
    os.execute("systemctl --user stop hyprland-session.target && sleep 0.1")
end)

hl.on("hyprland.start", function ()
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP DBUS_SESSION_BUS_ADDRESS")
  hl.exec_cmd("dunst & elephant & aw-qt")
  hl.exec_cmd("/usr/lib/pam_kwallet_init")
  hl.exec_cmd("otd-daemon")
  hl.exec_cmd("input-remapper-control --command stop-all && input-remapper-control --command autoload")
  -- hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
  hl.exec_cmd("awww-daemon & waybar & sunsetr")
  hl.exec_cmd("/usr/bin/kdeconnectd")
  hl.exec_cmd("kdeconnect-indicator")
  hl.exec_cmd("fcitx5 -d")
end)

