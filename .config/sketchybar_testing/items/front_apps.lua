local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

sbar.add("event", "window_focus")
sbar.add("event", "title_change")

local apps = sbar.add("bracket", "apps", {}, {
	position = "center",
	icon = {
		padding_right = 15,
		padding_left = 8,
		color = colors.dirty_white,
		font = "sketchybar-app-font:Regular:16.0",
		y_offset = -1,
	},
	label = {
		font = {
			style = settings.font.style_map["Black"],
			size = 12.0,
		},
	},
	background = {
		color = colors.bg2,
		border_color = colors.bg1,
		border_width = 2,
	},
})

local function update_windows(windows)
	-- Create a list of unique apps
	local seen_apps = {}
	local unique_windows = {}
	
	for _, window in ipairs(windows) do
		local app_name = window['app']
		
		-- Only add each app once (first instance, typically the focused one)
		if not seen_apps[app_name] then
			seen_apps[app_name] = true
			table.insert(unique_windows, window)
		end
	end
	
	-- Remove existing items
	sbar.remove("/apps.\\.*/")
	
	for _, window in ipairs(unique_windows) do
		local app_name = window['app']
		
		-- Fetch the icon for the app
		local icon = app_icons[app_name] or app_icons["default"]
		
		sbar.add("item", "apps." .. window['id'], {
			label = {
				string = app_name,
				highlight = window['has-focus'],
				color = colors.purple,
				highlight_color = colors.pink,
			},
			icon = {
				string = icon,
				font = "sketchybar-app-font:Regular:16.0",
				color = colors.dirty_white,
			},
			padding_right = 2,
			click_script = "yabai -m window --focus " .. window['id'],
		})
	end
end

local function get_apps()
	sbar.exec("yabai -m query --windows id,title,app,has-focus --space", function(output)
		update_windows(output)
	end)
end

apps:subscribe("space_change", get_apps)
apps:subscribe("front_app_changed", get_apps)
apps:subscribe("title_change", get_apps)
apps:subscribe("window_focus", get_apps)