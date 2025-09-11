local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local spaces = require("items.spaces")

-- Events that get pushed by yabai
sbar.add("event", "window_focus")
sbar.add("event", "title_change")

-- a variable that stores whether the title or app name should be shown
local show_titles = true

-- a variable that stores the app name
local app_name = ""

-- a variable that stores the window title
local window_title = ""

-- a variable that stores the current title, so it can be checked against
local current_title = ""

-- The main item that shows the window title
local front_app = sbar.add("item", "front_app", {
  padding_left = -1,
  position = "left",
  display = "active",
  icon = {
    background = {
      drawing = true,
      image = {
        border_width = 1,
        border_color = colors.bg1,
      }
    },
  },
  label = {
    font = {
      style = settings.font.style_map["Black"],
      size = 12.0,
    },
  },
  updates = true,
})

local function toggle_show_titles()
  show_titles = not show_titles
end

local function end_title_animation()
  sbar.animate("tanh", 15, function()
    front_app:set({
      label = {
        string = window_title,
        width = "dynamic",
        color = { alpha = 1.0 }
      }
    })
  end)
  current_title = window_title
end

local function start_title_animation()
  -- checking to see whether the title actually changed. This prevents starting excessive animations if the title isn't actually changing to anything new
  if window_title ~= current_title then
    sbar.animate("tanh", 15, function()
      front_app:set({
        label = {
          width = 0,
          color = { alpha = 0.0 }
        }
      })
    end)
    -- Short delay so that full animation can occur
    sbar.exec("sleep 0.25 && echo 'finishing slide'", end_title_animation) 
  end
end

local function set_window_title()
  -- Offloading the "yabai -m query --windows id,title --window" script to an external shell script so that we can determine whether the space has no windows
  sbar.exec("~/.scripts/query_window_title.sh", function(result)
    if result ~= "empty" and type(result) == "table" and result.title then
      window_title = result.title
      if #window_title > 50 then
        window_title = window_title:sub(1, 50) .. "..."
      end
    else
      -- Set title to Finder, as empty spaces will not return a window title
      window_title = "Finder"
      sbar.animate("tanh", 10, function()
        spaces.space_creator:set({ icon = { string = icons.space_icon.active } })
      end)
    end
    start_title_animation()
  end)
end

-- Animate app icon back to 1.0
local function end_icon_animation()
  sbar.animate("tanh", 15, function()
    front_app:set({
      icon = {
        background = {
          image = { scale = 0.90 },
	}
      }
    })
  end)
end

-- Make app icon slightly bigger before returning back to regular size
local function start_icon_animation()
  sbar.animate("tanh", 15, function()
    front_app:set({
      icon = {
        background = {
          image = { scale = 1.2 },
	}
      }
    })
  end)
  -- Short delay so that full animation can occur
  sbar.exec("sleep 0.25 && echo 'finishing bounce'", end_icon_animation) 
end

-- subscripitons (don't forget to smash that like button, subcribe, and ring that notification bell)
front_app:subscribe("front_app_switched", function(env)
  front_app:set({
    icon = { background = { image = "app." .. env.INFO } }
  })
  app_name = env.INFO
  start_icon_animation()
  if show_titles then
    set_window_title()
  else
    window_title = app_name
    start_title_animation()
  end
end)

front_app:subscribe("space_change", function()
  start_icon_animation()
  if show_titles then
    set_window_title()
  end
end)

front_app:subscribe("window_focus", function()
  start_icon_animation()
  if show_titles then
    set_window_title()
  end
end)

front_app:subscribe("title_change", function()
  if show_titles then
    set_window_title()
  end
end)

front_app:subscribe("mouse.clicked", function()
  toggle_show_titles()
  start_icon_animation()
  if show_titles then
    set_window_title()
  else
    window_title = app_name
    start_title_animation()
  end
end)
