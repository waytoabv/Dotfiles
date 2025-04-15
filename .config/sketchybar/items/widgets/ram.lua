local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

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


ram:subscribe('system_stats', function(env)
	local raw = env.RAM_USAGE
	if not raw then return end

	-- Prozent extrahieren (z. B. "76%" → 76)
	local usedram = tonumber(raw:match('(%d+)'))
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
			padding_left = Padding_left,
		},
		icon = {
			color = Color,
		},
	})
end)





swap:subscribe('system_stats', function(env)
	local raw = env.SWP_USED

	-- Entferne "GB", extrahiere Zahl
	local number = raw:match("([%d%.]+)")
	if not number then return end

	local swapuse = tonumber(number)
	if not swapuse then return end

	local function formatSwapUsage(swapuse)
		if swapuse < 0.01 then
			return "0.00 GB", colors.grey
		elseif swapuse < 1 then
			return string.format("0.%02d GB", math.floor(swapuse * 100)), colors.dirtywhite
		elseif swapuse < 10 then
			return string.format("%.2f GB", swapuse), colors.yellow
		elseif swapuse < 20 then
			return string.format("%.2f GB", swapuse), colors.orange
		else
			return string.format("%.1f GB", swapuse), colors.red
		end
	end

	local swapLabel, swapColor = formatSwapUsage(swapuse)

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

