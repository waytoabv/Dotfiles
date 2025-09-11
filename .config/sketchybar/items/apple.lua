local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local popup_width = 150

-- Padding item required because of bracket
sbar.add("item", { width = 5 })

local apple_logo = sbar.add("item", {
    position = "left",
    icon = {
      font = { size = 22.0 },
      string = icons.apple.apple,
      padding_right = 8,
      padding_left = 8,
      color = colors.blue
  },
  label = { drawing = false },
  padding_left = 1,
  padding_right = 1,
  popup = {
    align = "left",
    height = 30,
    background = {
      color = { alpha = 0.0 },
      border_color = { alpha = 0.0 }
    }
  }
})

local about_mac= sbar.add("item", {
  position = "popup." .. apple_logo.name,
  icon = {
    align = "center",
    string = icons.apple.question_mark,
    width = popup_width / 4,
    color = { alpha = 0.0 },
  },
  label = {
    string = "About This Mac",
    align = "left",
    padding_left = 22,
    padding_right = 12,
    color = { alpha = 0.0 },
  },
  background = {
    border_width = 1,
    border_color = colors.with_alpha(colors.white, 0.0)
  }
})

local sys_settings = sbar.add("item", {
  position = "popup." .. apple_logo.name,
  icon = {
    align = "center",
    string = icons.apple.gear,
    width = popup_width / 4,
    color = { alpha = 0.0 },
  },
  label = {
    string = "System Settings",
    align = "left",
    padding_left = 22,
    padding_right = 12,
    color = { alpha = 0.0 },
  },
  background = {
    border_width = 1,
    border_color = colors.with_alpha(colors.white, 0.0)
  }
})

local btop_monitor= sbar.add("item", {
  position = "popup." .. apple_logo.name,
  icon = {
    align = "center",
    string = icons.apple.graph,
    width = popup_width / 4,
    color = { alpha = 0.0 },
  },
  label = {
    string = "Toggle Terminal",
    align = "left",
    padding_left = 22,
    padding_right = 12,
    color = { alpha = 0.0 },
  },
  background = {
    border_width = 1,
    border_color = colors.with_alpha(colors.white, 0.0)
  }
})

local lock_screen= sbar.add("item", {
  position = "popup." .. apple_logo.name,
  icon = {
    align = "center",
    string = icons.apple.lock,
    width = popup_width / 4,
    color = { alpha = 0.0 },
  },
  label = {
    string = "Lock Screen",
    align = "left",
    padding_left = 22,
    padding_right = 12,
    color = { alpha = 0.0 },
  },
  background = {
    border_width = 1,
    border_color = colors.with_alpha(colors.white, 0.0)
  }
})

local show_trash = sbar.add("item", {
  position = "popup." .. apple_logo.name,
  icon = {
    align = "center",
    string = icons.apple.trash,
    width = popup_width / 4,
    color = { alpha = 0.0 },
  },
  label = {
    string = "Show Trash",
    align = "left",
    padding_left = 22,
    padding_right = 12,
    color = { alpha = 0.0 },
  },
  background = {
    border_width = 1,
    border_color = colors.with_alpha(colors.white, 0.0)
  }
})

local log_out= sbar.add("item", {
  position = "popup." .. apple_logo.name,
  icon = {
    align = "center",
    string = icons.apple.logout,
    width = popup_width / 4,
    color = { alpha = 0.0 },
  },
  label = {
    string = "Log Out",
    align = "left",
    padding_left = 22,
    padding_right = 12,
    color = { alpha = 0.0 },
  },
  background = {
    border_width = 1,
    border_color = colors.with_alpha(colors.white, 0.0)
  }
})

local shutdown= sbar.add("item", {
  position = "popup." .. apple_logo.name,
  icon = {
    align = "center",
    string = icons.apple.power,
    width = popup_width / 4,
    color = { alpha = 0.0 },
  },
  label = {
    string = "Shutdown...",
    align = "left",
    padding_left = 22,
    padding_right = 12,
    color = { alpha = 0.0 },
  },
  background = {
    border_width = 1,
    border_color = colors.with_alpha(colors.white, 0.0)
  }
})

local spaces_indicator = sbar.add("item", {
  position = "left",
  padding_left = -6,
  padding_right = 2,
  icon = {
    font = "Iosevka Nerd Font:Regular:18.0",
    string = "",
    padding_right = 8,
    padding_left = 6,
    color = colors.grey,
  },
  label = {
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Semibold"],
      size = 14,
    },
    width = 0,
    padding_left = 1,
    padding_right = 8,
    string = "Show Menubar",
    color = colors.grey,
  },
  background = {
    color = colors.with_alpha(colors.bg1, 0.0),
    border_color = colors.with_alpha(colors.bg2, 0.0),
  }
})

spaces_indicator:subscribe("swap_menus_and_spaces", function(env)
  local currently_on = spaces_indicator:query().label.value == "Show Menubar"
    spaces_indicator:set({
      label = {
      string = currently_on and "Show Spaces" or "Show Menubar"
    }
  })
end)

spaces_indicator:subscribe("mouse.entered", function()
  sbar.animate("tanh", 30, function()
    spaces_indicator:set({
      background = {
        color = { alpha = 1.0 },
        border_color = { alpha = 1.0 },
      },
      icon = { color = colors.white},
      label = { color = colors.white, width = "dynamic" }
    })
  end)
end)

spaces_indicator:subscribe("mouse.exited", function()
  sbar.animate("tanh", 30, function()
    spaces_indicator:set({
      background = {
        color = { alpha = 0.0 },
        border_color = { alpha = 0.0 },
      },
      icon = { color = colors.grey},
      label = { color = colors.grey, width = 0.0 }
    })
  end)
end)

spaces_indicator:subscribe("mouse.clicked", function()
  sbar.trigger("swap_menus_and_spaces")
end)

-- Table of all popup item names to be used later on
local popup_items = {
  about_mac,
  sys_settings,
  btop_monitor,
  show_trash,
  lock_screen,
  log_out,
  shutdown
}

-- Sets popup icon/label transparency based on whether its hidden or shown
local function set_popup_transparency(item, popup_alpha)
  item:set({
    icon = {
      color = { alpha = popup_alpha }
    },
    label = {
      color = { alpha = popup_alpha }
    }
  })
end

local function turn_off_popup_drawing()
    apple_logo:set({ popup = { drawing = false} })
end

-- hides popup menu
local function hide_apple_menu()
  apple_logo:set({
    popup = { blur_radius = 0 }
  })
  sbar.animate("tanh", 15, function()
    apple_logo:set({
      icon = {
        color = colors.blue
      },
    })
  end)
  sbar.animate("tanh", 15, function()
    apple_logo:set({
      popup = {
        background = {
        color = colors.with_alpha(colors.bar.bg, 0.0),
        border_color = colors.with_alpha(colors.popup.border, 0.0),
        },
      }
    })
    for i, item in ipairs(popup_items) do
      local popup_alpha = 0.0
      set_popup_transparency(item, popup_alpha)
    end
  end)
    sbar.exec("sleep 0.25 && echo 'turning off popup drawing'", turn_off_popup_drawing) 
end

-- Toggle apple menu on click
local function toggle_apple_menu()
  local should_draw_popup = apple_logo:query().popup.drawing == "off"
  if should_draw_popup then
    apple_logo:set({
      popup = {
        drawing = true,
	blur_radius = 20,
        background = {
          color = { alpha = 0.01 },
          border_color = { alpha = 0.01 }
        }
      }
    })
    sbar.animate("tanh", 15, function()
      apple_logo:set({
        popup = {
          background = {
            color = { alpha = 1.0 },
            border_color = { alpha = 1.0 }
          }
        }
      })
      for i, item in ipairs(popup_items) do
        local popup_alpha = 1.0
        set_popup_transparency(item, popup_alpha)
      end
    end)
    sbar.animate("tanh", 15, function()
      apple_logo:set( { icon = { color = colors.green } })
    end)
  else
    hide_apple_menu()
  end
end

-- Finds all of the available scratchpads so that if btop doesn't exist, we can run the script that creates it, but if it does exist we can toggle the scratchpad
function list_yabai_scratchpads()
  sbar.exec("yabai -m query --windows scratchpad", function(scratchpad_output)
    local btop_scratchpad_exists = false
    for _, entry in pairs(scratchpad_output) do
      if entry.scratchpad == "btop_monitor" then
        btop_scratchpad_exists = true
        break
      end
    end
    if btop_scratchpad_exists then
      sbar.exec("yabai -m window --toggle btop_monitor")
    else
      sbar.exec("~/.scripts/skhd/create_btop_scratchpad.sh")
    end
  end)
end

-- Subscribe to toggle apple menu
apple_logo:subscribe("mouse.clicked", toggle_apple_menu)

-- Subscribe to hide menu when mouse exits
apple_logo:subscribe("mouse.exited.global", hide_apple_menu)

-- Apple menu popup commands below
--
-- Open About This Mac
about_mac:subscribe("mouse.clicked", function()
  hide_apple_menu()
  sbar.exec("open -a 'About This Mac'")
end)

-- Open System Settings
sys_settings:subscribe("mouse.clicked", function()
  hide_apple_menu()
  sbar.exec("open -a 'System Settings'")
end)

-- Open btop via a custom iTerm2 profile
btop_monitor:subscribe("mouse.clicked", function()
  hide_apple_menu()
  list_yabai_scratchpads()
end)

-- Show Trash
show_trash:subscribe("mouse.clicked", function()
  hide_apple_menu()
  sbar.exec("open ~/.Trash")
end)

-- Start the screensaver, which by nature also locks the screen.
lock_screen:subscribe("mouse.clicked", function()
  hide_apple_menu()
  sbar.exec("/System/Library/CoreServices/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine")
end)

-- Logout, with a popup confirmation just incase it was clicked by accident
log_out:subscribe("mouse.clicked", function()
  hide_apple_menu()
  sbar.exec("osascript -e 'tell app \"System Events\" to log out'")
end)

-- Shutdown the computer with a confirmation box
shutdown:subscribe("mouse.clicked", function()
  hide_apple_menu()
  sbar.exec("osascript -e 'tell app \"loginwindow\" to «event aevtrsdn»'")
end)

-- List all of the menu items
local menu_items = {
  about_mac,
  sys_settings,
  btop_monitor,
  show_trash,
  lock_screen,
  log_out,
  shutdown
}

-- Function that can be passed the menu-item name and color so that we don't have multiple functions to animate each item
local function animate_item_bg(menu_item_name, bg_color, item_border_color)
  -- Checks whether the name passed isn't one of the others, and makes sure that ones not highlighted are transparent
  for _, not_selected_item in ipairs(menu_items) do
    if not_selected_item ~= menu_item_name then
      sbar.animate("tanh", 15, function()
        not_selected_item:set({
	  background = {
	    color = colors.transparent,
	    border_color = colors.with_alpha(colors.white, 0.0)
          }
        })
      end)
    end
  end
  sbar.animate("tanh", 15, function()
    menu_item_name:set({
      background = {
        color = bg_color,
	border_color =  item_border_color,
      }
    })
  end)
end

--
-- Animation subscriptions for each menu-item
--
about_mac:subscribe("mouse.entered", function()
  local menu_item_name = about_mac
  local bg_color = colors.bg1
  local item_border_color = colors.with_alpha(colors.white, 0.5)
  animate_item_bg(menu_item_name, bg_color, item_border_color)
end)

about_mac:subscribe("mouse.exited", function()
  local menu_item_name = about_mac
  local bg_color = colors.transparent
  local item_border_color = colors.with_alpha(colors.white, 0.0)
  animate_item_bg(menu_item_name, bg_color, item_border_color)
end)

sys_settings:subscribe("mouse.entered", function()
  local menu_item_name = sys_settings
  local bg_color = colors.bg1
  local item_border_color = colors.with_alpha(colors.white, 0.5)
  animate_item_bg(menu_item_name, bg_color, item_border_color)
end)

sys_settings:subscribe("mouse.exited", function()
  local menu_item_name = sys_settings
  local bg_color = colors.transparent
  local item_border_color = colors.with_alpha(colors.white, 0.0)
  animate_item_bg(menu_item_name, bg_color, item_border_color)
end)

btop_monitor:subscribe("mouse.entered", function()
  local menu_item_name = btop_monitor
  local bg_color = colors.bg1
  local item_border_color = colors.with_alpha(colors.white, 0.5)
  animate_item_bg(menu_item_name, bg_color, item_border_color)
end)

btop_monitor:subscribe("mouse.exited", function()
  local menu_item_name = btop_monitor
  local bg_color = colors.transparent
  local item_border_color = colors.with_alpha(colors.white, 0.0)
  animate_item_bg(menu_item_name, bg_color, item_border_color)
end)

show_trash:subscribe("mouse.entered", function()
  local menu_item_name = show_trash
  local bg_color = colors.bg1
  local item_border_color = colors.with_alpha(colors.white, 0.5)
  animate_item_bg(menu_item_name, bg_color, item_border_color)
end)

show_trash:subscribe("mouse.exited", function()
  local menu_item_name = show_trash
  local bg_color = colors.transparent
  local item_border_color = colors.with_alpha(colors.white, 0.0)
  animate_item_bg(menu_item_name, bg_color, item_border_color)
end)

lock_screen:subscribe("mouse.entered", function()
  local menu_item_name = lock_screen
  local bg_color = colors.bg1
  local item_border_color = colors.with_alpha(colors.white, 0.5)
  animate_item_bg(menu_item_name, bg_color, item_border_color)
end)

lock_screen:subscribe("mouse.exited", function()
  local menu_item_name = lock_screen
  local bg_color = colors.transparent
  local item_border_color = colors.with_alpha(colors.white, 0.0)
  animate_item_bg(menu_item_name, bg_color, item_border_color)
end)

log_out:subscribe("mouse.entered", function()
  local menu_item_name = log_out
  local bg_color = colors.bg1
  local item_border_color = colors.with_alpha(colors.white, 0.5)
  animate_item_bg(menu_item_name, bg_color, item_border_color)
end)

log_out:subscribe("mouse.exited", function()
  local menu_item_name = log_out
  local bg_color = colors.transparent
  local item_border_color = colors.with_alpha(colors.white, 0.0)
  animate_item_bg(menu_item_name, bg_color, item_border_color)
end)

shutdown:subscribe("mouse.entered", function()
  local menu_item_name = shutdown
  local bg_color = colors.bg1
  local item_border_color = colors.with_alpha(colors.white, 0.5)
  animate_item_bg(menu_item_name, bg_color, item_border_color)
end)

shutdown:subscribe("mouse.exited", function()
  local menu_item_name = shutdown
  local bg_color = colors.transparent
  local item_border_color = colors.with_alpha(colors.white, 0.0)
  animate_item_bg(menu_item_name, bg_color, item_border_color)
end)
