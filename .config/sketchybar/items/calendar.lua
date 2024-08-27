local settings = require("settings")
local colors = require("colors")

-- Padding item required because of bracket
sbar.add("item", { position = "right", width = settings.group_paddings })

local cal = sbar.add("item", {
	icon = {
		color = colors.dirty_white,
		padding_left = 0,
		font = {
			style = settings.font.style_map["Bold"],
			size = 12.0,
		},
		padding_right = 15,
	},
	label = {
		color = colors.dirty_white,
		padding_left = 8,
		padding_right = 8,
		width = 70,
		align = "right",
		font = {
			style = settings.font.style_map["Black"],
			size = 14.0,
		},
	},
	position = "right",
	update_freq = 1,
	padding_left = 0,
	padding_right = 0,
	y_offset = 1,
})

-- german Date
cal:subscribe({ "forced", "routine", "system_woke" }, function(env)
	local weekdayNames = {
		"So.", "Mo.", "Di.", "Mi.", "Do.", "Fr.", "Sa."
	}
	local monthNames = {
		"Jan.", "Feb.", "März", "Apr.", "Mai", "Juni", "Juli", "Aug.", "Sep.", "Okt.", "Nov.", "Dez."
	}

	cal:set({
		icon = weekdayNames[tonumber(os.date("%w")) + 1] ..
			os.date("%d") .. " " .. monthNames[tonumber(os.date("%m"))] .. "｜",
		label = os.date("%H:%M:%S")
	})
end)

cal:subscribe("mouse.clicked", function(env)
	sbar.exec("open -a 'Dato'")
end)

-- english date
-- cal:subscribe({ "forced", "routine", "system_woke" }, function(env)
--   cal:set({ icon = os.date("%a. %d %b."), label = os.date("%H:%M") })
-- end)
