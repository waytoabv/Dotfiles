local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

sbar.exec("killall cpu_load >/dev/null; $CONFIG_DIR/helpers/event_providers/ram_load/bin/ram_load ram_update 1.0")
sbar.exec("killall swap_load >/dev/null; $CONFIG_DIR/helpers/event_providers/swap_load/bin/swap_load swap_update 5.0")

-- RAM Plugin
local ram = sbar.add("item", "widgets.ram1", {
	position = "right",
	padding_left = -5,
	width = 0,
	icon = {
		padding_right = 0,
		padding_left = 0,
		font = {
			style = settings.font.style_map["Bold"],
			size = 9.0,
		},
		string = icons.ramicons.ram,
	},
	label = {
		font = {
			family = "SF Mono",
			style = settings.font.style_map["Bold"],
			size = 9.0,
		},
		padding_left = 14,
		padding_right = 8,
		color = colors.grey,
		string = "??? %",
	},
	y_offset = 4,
	update_freq = 180,
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
		color = colors.grey,
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


ram:subscribe("ram_update", function(env)
	local raw = env.pressure
	if not raw then return end

	-- - "%" and later add " %"
	local usedram = tonumber(raw)
	if not usedram then return end

	local Color = colors.grey
	local label = tostring(usedram) .. " %"

	if usedram >= 90 then
	elseif usedram >= 80 then
		Color = colors.orange
	elseif usedram >= 70 then
		Color = colors.yellow
	end

	ram:set({
		label = {
			string = label,
			color = Color,
		},
		icon = {
			color = Color,
		},
	})
end)





swap:subscribe('swap_update', function(env)
	local used_gb = tonumber(env.used_gb)
	if not used_gb then
		print("Error: Could not get used_gb from environment")
		return
	end

	local function formatSwapUsage(value)
		if value < 0.01 then
			return "0.00 GB", colors.grey
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

