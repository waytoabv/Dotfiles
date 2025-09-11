local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

sbar.exec("killall swap_load >/dev/null; $CONFIG_DIR/helpers/event_providers/swap_load/bin/swap_load swap_update 5.0")

-- RAM Plugin
local ram = sbar.add("item", "widgets.ram1", {
  	position = "right",
  	padding_left = -5,
  	width = 0,
  	icon = {
	  	padding_right = 0,
		padding_left  = 0,
		font = { 
			style = settings.font.style_map["Bold"], 
			size = 9.0 },
		string = icons.ramicons.ram,
  	  	},
  	label = {
	  	font = { 
			family = "SF Mono", 
		    style = settings.font.style_map["Bold"], 
			size = 9.0 },
		padding_left  = 14,
		padding_right = 8,
		color = colors.dirtywhite,
		string = "??? %",
  	  	},
  	y_offset = 4,
  	script = "$HOME/.scripts/mem_pressure.sh",  
  	update_freq    = 0,
})


-- SWAP Plugin
local swap = sbar.add("item", "widgets.swap1", {
	position = "right",
	padding_left = -5,
	icon = {
		padding_right = 0,
		padding_left = 0,
		font = {
			style = settings.font.style_map["Bold"],
			size = 9.0,
		},
		string = icons.ramicons.swap,
	},
	label = {
		font = {
			family = "SF Mono",
			style = settings.font.style_map["Bold"],
			size = 9.0,
		},
		color = colors.dirtywhite,
		string = "??.? Mb",
	},
	y_offset = -4,
	update_freq = 180,
})

local swapram = sbar.add("item", "widgets.ram.padding", {
	position = "right",
	label = { drawing = false, },
})

local ram_bracket = sbar.add("bracket", "widgets.ram.bracket", {
	swapram.name,
	ram.name,
	swap.name
	}, {
	background = {
		color = colors.bg2,
		border_color = colors.bg1,
		border_width = 2,
	}
})


sbar.add("item", { position = "right", width = settings.group_paddings })


swap:subscribe('swap_update', function(env)
	local used_gb = tonumber(env.used_gb)
	if not used_gb then
		print("Error: Could not get used_gb from environment")
		return
	end

	local function formatSwapUsage(value)
		if value < 0.01 then
			return "0.00 GB", colors.dirtywhite
		elseif value < 1 then
			return string.format("0.%02d GB", math.floor(value * 100)), colors.dirtywhite
		elseif value < 10 then
			return string.format("%.2f GB", value), colors.yellow
		elseif value < 20 then
			return string.format("%.2f GB", value), colors.orange
		else
			return string.format("%.1f GB", value), colors.red
		end
	end

	local swapLabel, swapColor = formatSwapUsage(used_gb)

	swap:set({
		label = {
			string = swapLabel,
			color = swapColor,
		},
		icon = {
			color = swapColor,
		},
	})
end)