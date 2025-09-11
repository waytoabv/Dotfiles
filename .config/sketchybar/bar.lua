local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
  topmost = "window",
  height = 36,
  color = colors.bar.bg,
  padding_right = -2,
  padding_left = -2,
  corner_radius = 16,
  margin = 10,
  y_offset = 4,
  font_smoothing = "on",
  border_width = 0,
  shadow = "on",
  sticky = "on"
})
