local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

sbar.add("event", "window_focus")
sbar.add("event", "title_change")

-- Cache to store the previous window state
local window_cache = {}

local apps = sbar.add("bracket", "apps", {}, {
	position = "left",
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

-- Function to truncate strings to a max length and add dots if needed
local function truncate_string(str, max_length)
	if #str > max_length then
		return str:sub(1, max_length) .. "…"
	else
		return str
	end
end


-- Function to create a window hash for comparison
local function create_window_hash(window)
	return {
		id = window.id,
		app = window.app,
		title = window.title,
		has_focus = window["has-focus"]
	}
end

-- Function to determine if windows arrays have changed
local function windows_changed(new_windows, old_windows)
	if #new_windows ~= #old_windows then
		return true
	end

	-- Create a map of window IDs for faster lookups
	local old_window_map = {}
	for _, window in ipairs(old_windows) do
		old_window_map[window.id] = create_window_hash(window)
	end

	-- Check if any window has changed
	for _, window in ipairs(new_windows) do
		local old_window = old_window_map[window.id]
		if not old_window or
		   old_window.app ~= window.app or
		   old_window.title ~= window.title or
		   old_window.has_focus ~= window["has-focus"] then
			return true
		end
	end

	return false
end

local function update_windows(windows)
	-- Filter windows to exclude "Zen PIP", "Fivenotes" and "kitty" without titles
	local filtered_windows = {}
	for _, window in ipairs(windows) do
		if not ((window['app'] == "FiveNotes"
		or window['app'] == "kitty"
		or window['app'] == "Zen")
		and (window['title'] == nil
		or window['title'] == ""
		or window['title'] == "Picture-in-Picture"))
		then
			table.insert(filtered_windows, window)
		end
	end

	-- Check if the filtered windows have actually changed
	if not windows_changed(filtered_windows, window_cache) then
		return
	end

	-- Update the cache with the new window state
	window_cache = filtered_windows

	-- Remove existing items
	sbar.remove("/apps.\\.*/")

	local max_length
	local count = #filtered_windows
	if count > 4 then
		max_length = nil -- Show only the app name
	elseif count > 3 then
		max_length = 15
	elseif count > 2 then
		max_length = 20
	elseif count > 1 then
		max_length = 30
	else
		max_length = 60
	end

	for _, window in ipairs(filtered_windows) do
		local window_label
		if max_length then
			window_label = truncate_string(window['app'] .. ": " .. window['title'], max_length)
		else
			window_label = window['app']
		end

		-- Fetch the icon for the app
		local icon_lookup = app_icons[window['app']]
		local icon = icon_lookup or app_icons["default"]

		sbar.add("item", "apps." .. window['id'], {
			label = {
				string = window_label,
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