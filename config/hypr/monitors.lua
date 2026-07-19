local monitor_1 = "DP-1"
local monitor_2 = "DP-2"
local monitor_3 = "HDMI-A-1"
local scaling_factor = .67
local position_x = math.ceil(1366/scaling_factor) + 10

hl.notification.create({
  text = position_x,
  duration = 10000,
})


hl.monitor({
    output   = monitor_1,
    -- mode =  "1920x1080@144",
    mode =  "2560x1440@144",
    position = "0x0",
    scale    = "auto",
})

hl.monitor({
    output   = monitor_2,
    mode =  "1920x1080@60",
    position = "2560x550",
    scale    = "auto",
})

hl.monitor({
    output   = monitor_3,
    mode =  "1366x768@59.79",
    -- cm = "adobe",
    -- bitdepth = 8,
    position = "-" .. position_x .."x150",
    -- position = "-1366x150",
    scale    = tostring(scaling_factor),
    -- scale    = auto,
})


-- 	availableModes:
-- 1366x768@59.79Hz
-- 1280x1024@60.02Hz
-- 1280x960@60.00Hz
-- 1280x720@60.00Hz
-- 1024x768@60.00Hz
-- 800x600@60.32Hz
-- 640x480@59.94Hz
-- 720x400@70.08Hz


