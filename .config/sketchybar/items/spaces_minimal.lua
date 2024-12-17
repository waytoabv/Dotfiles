local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local spaces = {}

-- Create the container bracket for all spaces to wrap them in a background
local container_bracket = sbar.add("bracket", {}, {
	background = {
		color = colors.bg2,
		border_color = colors.bg1,
		border_width = 2,
	},
})


container_bracket.items = {}

for i = 1, 10, 1 do
	local space = sbar.add("space", "space." .. i, {
		space = i,
		icon = {
			drawing = false,
		},
		label = {
			drawing = false,
		},
		padding_right = 4,
		padding_left = 4,
		background = {
			color = colors.spaces.inactive,
			border_width = 0,
			height = 12,
			corner_radius = 12,
		},
		popup = { background = { border_width = 0, border_color = colors.black } },
	})

	spaces[i] = space


	table.insert(container_bracket.items, space.name)


	sbar.add("space", "space.padding." .. i, {
		space = i,
		width = settings.group_paddings,
	})

	local space_popup = sbar.add("item", {
		position = "popup." .. space.name,
		padding_left = 5,
		padding_right = 0,
		background = {
			drawing = true,
			image = {
				corner_radius = 9,
				scale = 0.2,
			},
		},
	})

	space:subscribe("space_change", function(env)
		local selected = env.SELECTED == "true"
		sbar.animate("tanh", 30, function(progress)
			progress = progress or 0

			local width = selected and 24 or 12
			local radius = selected and 12 or 12

			space:set({
				background = {
					color = selected and colors.spaces.active or colors.spaces.inactive,
					width = 12 + (24 - 12) * progress, -- Animating width
					corner_radius = radius,
				},
				width = width,
			})
		end)
	end)




	space:subscribe("mouse.clicked", function(env)
		if env.BUTTON == "other" then
			space_popup:set({ background = { image = "space." .. env.SID } })
			space:set({ popup = { drawing = "toggle" } })
		else
			local op = (env.BUTTON == "right") and "--destroy" or "--focus"
			sbar.exec("yabai -m space " .. op .. " " .. env.SID)
		end
	end)

	space:subscribe("mouse.entered", function(env)
		space_popup:set({ background = { image = "space." .. env.SID } })
		space:set({ popup = { drawing = "toggle" } })
	end)

	space:subscribe("mouse.exited", function(_)
		space:set({ popup = { drawing = false } })
	end)
end

sbar.add("item", { position = "left", width = settings.group_paddings })
