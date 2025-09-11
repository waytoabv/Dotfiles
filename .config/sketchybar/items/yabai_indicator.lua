local colors = require("colors")
local icons = require("icons")
local spaces = require("items.spaces")

--yabai event so we can monitor the stack/bsp/float/sticky status
sbar.add("event", "window_state_change")
-- Event that can be triggered to change the spaces dots/icons layout. This is an event because events can be triggered outside of sketchybar, IE like the BTT button
sbar.add("event", "toggle_spaces_display")

-- Monitoring item that will allow us to change whether the spaces bar shows minimal dots, or app icons
local swap_space_display_type = sbar.add("item", {
  drawing = false,
  updates = true,
})

-- Shows space creator icon on mouseover
spaces.space_creator:subscribe("mouse.entered", function()
  sbar.animate("tanh", 30, function()
    spaces.space_creator:set({
      icon = { padding_left = 16 },
      background = {
        color = { alpha = 1.0 },
      },
      label = {
        width = "dynamic",
	color = { alpha = 1.0 }
      }
    })
  end)
end)

-- Hides space creator icon after mouse exit
spaces.space_creator:subscribe("mouse.exited", function()
  sbar.animate("tanh", 30, function()
    spaces.space_creator:set({
      icon = { padding_left = 0 },
      background = {
        color = { alpha = 0.0 },
      },
      label = {
        width = 0.0,
	color = { alpha = 0.0 }
      }
    })
  end)
end)

-- Makes new space
spaces.space_creator:subscribe("mouse.clicked", function()
  sbar.exec("yabai -m space --create")
end)

-- Swaps dots/app icons display
swap_space_display_type:subscribe("toggle_spaces_display",function()
  local dots_showing = spaces.yabai_indicator:query().label.value == icons.space_layout.apps
  if dots_showing then
    spaces.yabai_indicator:set({
      label = { string = icons.space_layout.dots}
    })
    sbar.trigger("space_change")
    sbar.set("/space\\..*/", {label = { drawing = true }})
    sbar.animate("tanh", 50, function()
      sbar.set("/space\\..*/", {
	icon = {
          width = 0,
	  color = { alpha = 0.0 },
	},
      })
    end)

    sbar.animate("tanh", 15, function()
      sbar.set("/space\\..*/", {
        label = {
          width = "dynamic",
          padding_left = 10
        },
      })
      spaces.yabai_indicator:set({ label = { color = colors.red } })
    end)
    sbar.exec("sleep 1.0 && echo 'turning off icons'", function(result)
      sbar.set("/space\\..*/", { icon = { drawing = false }})
    end)
  else
    spaces.yabai_indicator:set({
      label = { string = icons.space_layout.apps }
    })
    sbar.set("/space\\..*/",{
      icon = {
        drawing = true,
        width = "dynamic",
      },
    })
    sbar.animate("tanh", 20, function()
      sbar.set("/space\\..*/", {
	icon = {
	  color = { alpha = 1.0 },
	},
      })
    end)
    sbar.animate("tanh", 30, function()
      sbar.set("/space\\..*/", {
	background = {
          color = { alpha = 0.0 },
	  border_width = 0,
	},
	label = {
	  width = 0,
          padding_left = 0,
	},
      })
      spaces.yabai_indicator:set({ label = { color = colors.blue } })
    end)
    sbar.exec("sleep 0.5 && echo 'turning off labels'", function(result)
      sbar.set("/space\\..*/", { label = { drawing = false }})
    end)
  end
end)

-- Expands the yabai indicator to reveal the spaces swap button when moused-over
spaces.yabai_indicator:subscribe("mouse.entered", function()
  sbar.animate("tanh", 30, function()
    spaces.yabai_indicator:set({
      icon = { padding_right = 8 },
      background = {
        color = { alpha = 1.0 },
      },
      label = {
        width = "dynamic",
	color = { alpha = 1.0 }
      }
    })
  end)
end)

-- hides the spaces swap button after mouse-exit
spaces.yabai_indicator:subscribe("mouse.exited", function()
  sbar.animate("tanh", 30, function()
    spaces.yabai_indicator:set({
      icon = { padding_right = 0 },
      background = {
        color = { alpha = 0.0 },
      },
      label = {
        width = 0.0,
	color = { alpha = 0.0 }
      }
    })
  end)
end)

-- Triggers the spaces display swap
spaces.yabai_indicator:subscribe("mouse.clicked", function()
  sbar.trigger("toggle_spaces_display")
end)

-- Define stack index outside of the function below so the value is stored and can be references elsewhere
local stack_index

-- checks the yabai json table to determine what type of window is currently focused
local function determine_yabai_indicator_icon_and_color(window_type_result)
  stack_index = window_type_result["stack-index"]
  if window_type_result["is-sticky"] then
    return icons.yabai.sticky, colors.yellow
  elseif window_type_result["is-floating"] then
    return icons.yabai.float, colors.blue
  elseif window_type_result["has-fullscreen-zoom"] then
    return icons.yabai.fullscreen_zoom, colors.green
  elseif window_type_result["has-parent-zoom"] then
    return icons.yabai.parent_zoom, colors.red
  elseif window_type_result["stack-index"] > 0 then
    sbar.exec("yabai -m query --windows stack-index --window stack.last", function(total_stack_index_result)
      local total_stack_index = total_stack_index_result["stack-index"]
      local stack_index_string = "[" .. stack_index .. "/" .. total_stack_index .. "]"
      spaces.space_creator:set({ icon = { string = stack_index_string }})
    end)
    return icons.yabai.stack, colors.magenta
  else
    return icons.yabai.grid, colors.orange
  end
end

-- Query yabai to get the window info, and set the stack indicator icon string/color based on the results
local function yabai_window_type()
  sbar.exec("yabai -m query --windows stack-index,is-sticky,is-floating,has-fullscreen-zoom,has-parent-zoom --window", function(window_type_result)
    local window_icon, window_icon_color = determine_yabai_indicator_icon_and_color(window_type_result)
    local current_icon = spaces.yabai_indicator:query().icon.value
    local current_space_creator_icon = spaces.space_creator:query().icon.value
    local space_creator_dot_showing = current_space_creator_icon == icons.space_icon.active
    if window_icon ~= current_icon then
      spaces.yabai_indicator:set({ icon = { string = window_icon }})
      sbar.animate("tanh", 10, function()
        spaces.yabai_indicator:set({ icon = { color = window_icon_color }})
        spaces.space_creator:set({ icon = { color = window_icon_color } })
      end)
    end
    if stack_index < 1 and not space_creator_dot_showing then
      spaces.space_creator:set({ icon = { string = icons.space_icon.active }})
    end
  end)
end

-- Yabai subscriptions to determine when to change  the indicator/what to
spaces.yabai_indicator:subscribe("window_focus", yabai_window_type)
spaces.yabai_indicator:subscribe("window_state_change", yabai_window_type)

-- Sets the stack icon for the first time on startup, otherwise it will remain the default-set icon until something happens
local indicator_first_set = false
if not indicator_first_set then
 indicator_first_set = true
 yabai_window_type()
end
