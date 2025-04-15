local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local messages = sbar.add("item", "widgets.messages", {
	position = "right",
	icon = {
		font = {
			style = settings.font.style_map["Regular"],
			size = 13.0,
		},
		string = icons.messages,
		padding_left = 8,
	},
	label = {
		font = {
			family = settings.font.numbers
		},
		padding_right = 8,
	},
	background = {
		color = colors.bg2,
		border_color = colors.bg1,
		border_width = 2,
	},
	update_freq = 1,
})

--script needed for better functionality
messages:subscribe("routine", "forced", function(env)
  sbar.exec("$HOME/.scripts/query_messages.sh")
end)

messages:subscribe("mouse.clicked", function(env)
	sbar.exec("open -a 'Messages'")
end)
