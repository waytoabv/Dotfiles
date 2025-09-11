local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local spaces = {}

-- item to show the current yabai window status, as well as swap the spaces display from dots to apps. Icon for yabai, label for spaces
spaces.yabai_indicator = sbar.add("item", "yabai_indicator", {
  position = "center",
  padding_right = 6.7,
  icon = {
    string = icons.yabai.grid,
    color = colors.orange,
    font = { size = 11.0 },
    padding_left = 16,
    padding_right = 0,
  },
  label = {
    width = 0,
    padding_left = 8,
    padding_right = 16,
    string = icons.space_layout.dots,
    color = colors.with_alpha(colors.red, 0.0),
  },
  background = {
    corner_radius=16,
    padding_left = -2,
    color = colors.with_alpha(colors.bg1, 0.0),
    border_width = 0.0,
  }
})

for i = 1, 10, 1 do
  local space = sbar.add("space", "space." .. i, {
    space = i,
    position = "center",
    icon = {
      font = { family = settings.font.numbers },
      string = icons.space_icon.not_active,
      padding_left = 6,
      padding_right = 6,
      color = colors.white,
      highlight_color = colors.red,
      drawing = false,
    },
    label = {
      padding_right = 9,
      padding_left = 10,
      color = colors.grey,
      highlight_color = colors.bar.bg,
      font = "sketchybar-app-font:Regular:14.0",
    },
    padding_right = 1,
    padding_left = 1,
    background = {
      color = colors.transparent,
      height = 25,
      corner_radius=16,
      border_width = 0,
    },
    popup = {
      drawing = false,
      background = {
        color = colors.transparent,
	border_width = 0,
      }
    }
  })

  spaces[i] = space

  -- Padding space
  sbar.add("space", "space.padding." .. i, {
    position = "center",
    space = i,
    script = "",
    width = settings.group_paddings,
  })

  -- popup full window preview for the various spaces
  local space_popup = sbar.add("item", {
    position = "popup." .. space.name,
    padding_left= 5,
    padding_right= 0,
    background = {
      border_color = colors.with_alpha(colors.transparent, 0.0),
      drawing = true,
      image = {
        corner_radius = 9,
        scale = 0.0,
	border_width = 1,
	border_color = colors.blue,
      }
    }
  })

  local function animate_space_icon(color, string)
    space:set({
      icon = { color = colors.with_alpha(color, 0.0), string = string },
    })
    sbar.animate("tanh", 10, function()
      space:set({
        icon = { color = color },
      })
    end)
  end

  space:subscribe("space_change", function(env)
    local dots_showing = spaces.yabai_indicator:query().label.value == icons.space_layout.apps
    -- determine whether the app icons or dots are showing^^^
    local selected = env.SELECTED == "true"
    local border_color = selected and colors.blue or colors.transparent
    local space_label = space:query().label.value
    local no_windows = space_label == "—"
    if selected then
      animate_space_icon(colors.red, icons.space_icon.active)
    else
      local space_color = ""
      local space_icon= ""
      if no_windows then
        space_color = colors.white
	space_icon = icons.space_icon.not_active
      else
        space_color = colors.red
	space_icon = icons.space_icon.not_active_has_apps
      end
      space:set({
        icon = {
	  color = space_color,
          string = space_icon
        },
      })
    end
    -- animation for changing the colors of the dots if in dot mode, or changing the color of the background if in app mode
    if dots_showing then
      sbar.animate("tanh", 10, function()
        space:set({
          background = {
            color = colors.transparent,
            border_width = 0,
            border_color = colors.transparent,
          }
        })
      end)
    else
      sbar.animate("tanh", 10, function()
        space:set({
          label = { highlight = selected },
          background = {
	    color = selected and colors.purple or colors.transparent,
	    border_width = 1,
	    border_color = selected and colors.bg1 or colors.transparent,
          }
        })
      end)
    end
  end)

-- switch to space with left click, destroy space with right click, or show preview while holding down option
  space:subscribe("mouse.clicked", function(env)
  if env.MODIFIER == "alt" then
      space_popup:set({ background = { image = "space." .. env.SID } })
      space:set({ popup = { drawing = true } })
      sbar.animate("tanh", 30, function()
        space_popup:set({
          background = {
	    image = { scale = 0.15 },
          }
        })
      end)
    else
      local op = (env.BUTTON == "right") and "--destroy" or "--focus"
      sbar.exec("yabai -m space " .. op .. " " .. env.SID)
    end
  end)

-- Turn off preview drawings after minimization
  local function turn_off_preview_drawing()
    space:set({ popup = { drawing = false } })
  end

-- Show faint outline of spaces when app icons are showing
  space:subscribe("mouse.entered", function()
    local dots_showing = spaces.yabai_indicator:query().label.value == icons.space_layout.apps
    if not dots_showing then
      local space_is_selected = space:query().icon.value == "􀀁"
      if not space_is_selected then
        sbar.animate("tanh", 20, function()
          space:set({
            background = {
	    color = colors.bg2,
	    border_color = colors.with_alpha(colors.white, 0.5),
	    },
          })
        end)
      end
    end
  end)

  space:subscribe("mouse.exited", function()
    -- hide space preview on mouse exit if showing
    local preview_is_on = space:query().popup.drawing == "on"
    if preview_is_on then
      sbar.animate("tanh", 20, function()
        space_popup:set({
          background = {
            image = { scale = 0.0 },
          }
        })
      end)
      sbar.exec("sleep 0.5 && echo 'turning off drawing'", turn_off_preview_drawing)
    end
    -- Fade space background back to transparent on mouse exit, again only when app icons are showing
    local dots_showing = spaces.yabai_indicator:query().label.value == icons.space_layout.apps
    if not dots_showing then
      local space_is_selected = space:query().icon.value == "􀀁"
      if not space_is_selected then
        sbar.animate("tanh", 30, function()
          space:set({
            background = {
	    color = colors.transparent,
	    border_color = colors.transparent,
	    },
          })
        end)
      end
    end
  end)
-- end spaces for-loop
end

-- item to keep track of app icons
local space_window_observer = sbar.add("item", {
  drawing = false,
  updates = true,
})

-- Right bracket dot that can be used to create new spaces
spaces.space_creator = sbar.add("item","space_creator", {
  position = "center",
  icon = {
    string = icons.space_icon.active,
    color = colors.orange,
    font = { size = 11.0 },
    padding_left = 0,
    padding_right = 16,
  },
  label = {
    width = 0,
    padding_left = 0,
    padding_right = 16,
    string = icons.space_layout.creator,
    color = colors.with_alpha(colors.green, 0.0),
  },
  background = {
    corner_radius=16,
    padding_right = -2,
    color = colors.with_alpha(colors.bg1, 0.0),
    border_width = 0.0,
  }
})

-- bracket to span the width of all the spaces/side buttons
local space_selector_bracket = sbar.add("bracket", "space_selector_bracket",
  {
    spaces.yabai_indicator.name,
    spaces.space_creator.name
  },{
  background = {
    color = colors.bg1, border_color = colors.bg2,
    corner_radius=16,
  },
})

-- setting the app icons
space_window_observer:subscribe("space_windows_change", function(env)
  local icon_line = ""
  local space_color = ""
  local space_icon = ""
  local no_app = true
  local space_number = env.INFO.space
  local yabai_selected_command = "yabai -m query --spaces has-focus --space " .. space_number
  -- Yabai query to determine whether the space is focused or not
  sbar.exec(yabai_selected_command, function(yabai_output)
    local space_is_selected = yabai_output["has-focus"]
    for app, count in pairs(env.INFO.apps) do
      no_app = false
      local lookup = app_icons[app]
      local icon = ((lookup == nil) and app_icons["Default"] or lookup)
      icon_line = icon_line .. "" .. icon
    end
    if (no_app) then
      --Set the space icon color to white if apps have changed and the space no longer has any windows, but only if that space is not currently focused
      icon_line = "󰇘"
      space_color = space_is_selected and colors.red or colors.white 
      space_icon = space_is_selected and icons.space_icon.active or icons.space_icon.not_active 
    else
      space_color = colors.red
      space_icon = space_is_selected and icons.space_icon.active or icons.space_icon.not_active_has_apps
    end
    sbar.animate("tanh", 10, function()
      spaces[env.INFO.space]:set({
        icon = {
          color = space_color,
	  string = space_icon,
        },
        label = icon_line
      })
    end)
  end)
end)

-- return command allowing us to reference the items and functions in this spaces.lua file from a separate file
return spaces
