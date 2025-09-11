local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	topmost = "window",
	height = 26,
	color = colors.bar.bg,
	padding_right = 0,
	padding_left = 0,
	margin = 0,
	corner_radius = 0,
	y_offset = 0,
	border_color = colors.transparent,
	border_width = 0,
	blur_radius = 10,
})

-- sbar.bar({
-- 	topmost = "window",
-- 	height = 36,
-- 	color = colors.bar.bg,
-- 	padding_right = 2,
-- 	padding_left = 2,
-- 	margin = 6,
-- 	corner_radius = 12,
-- 	y_offset = 2,
-- 	border_color = colors.transparent,
-- 	border_width = 2,
-- 	blur_radius = 10,
-- })
