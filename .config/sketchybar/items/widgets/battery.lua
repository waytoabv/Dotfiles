local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

sbar.add("item", "widgets.battery.padding", {
  position = "right",
  width = settings.group_paddings
})

local battery = sbar.add("item", "widgets.battery", {
  position = "right",
  icon = {
    font = {
      style = settings.font.style_map["Regular"],
      size = 19.0,
    },
    padding_right = 5,
  },
  label = {
    font = { family = settings.font.numbers },
    width = 0,
    padding_left = 2,
    padding_right = 4},
  update_freq = 60,
  popup = {
    align = "center",
    background = {
      color = { alpha = 0.0 },
      border_color = { alpha = 0.0 }
    }
  }
})

local remaining_time = sbar.add("item", {
  position = "popup." .. battery.name,
  icon = {
    string = "Time remaining:",
    width = 100,
    align = "left",
    color = { alpha = 0.0 },
  },
  label = {
    string = "??:??h",
    width = 100,
    align = "right",
    color = { alpha = 0.0 },
  },
})

battery:subscribe({"routine", "power_source_change", "system_woke"}, function()
  sbar.exec("pmset -g batt", function(batt_info)
    local icon = "!"
    local label = "?"

    local found, _, charge = batt_info:find("(%d+)%%")
    if found then
      charge = tonumber(charge)
      label = charge .. "%"
    end

    local color = colors.green
    local charging, _, _ = batt_info:find("AC Power")

    if charging then
      icon = icons.battery.charging
    else
      if found and charge > 80 then
        icon = icons.battery._100
      elseif found and charge > 60 then
        icon = icons.battery._75
      elseif found and charge > 40 then
        icon = icons.battery._50
      elseif found and charge > 20 then
        icon = icons.battery._25
        color = colors.orange
      else
        icon = icons.battery._0
        color = colors.red
      end
    end

    local lead = ""
    if found and charge < 10 then
      lead = "0"
    end

    battery:set({
      icon = {
        string = icon,
        color = color
      },
      label = { string = lead .. label },
    })
  end)
end)

-- Variable to track if battery percentage should be permanently shown
local showBattery = false

-- Function to toggle the state of showBattery variable
local function toggleBattery()
  showBattery = not showBattery
  if showBattery then
    -- Show battery percentage with animation
    sbar.animate("tanh", 30, function()
      battery:set({
        label = { width = "dynamic" }
      })
    end)
  end
end

-- Function to show battery percentage if not permanently shown
local function showBatteryIfNotPermanent()
  if not showBattery then
    sbar.animate("tanh", 30, function()
      battery:set({
        label = { width = "dynamic" }
      })
    end)
  end
end

-- Function to hide battery percentage if not permanently shown
local function hideBatteryIfNotPermanent()
  if not showBattery then
    sbar.animate("tanh", 30, function()
      battery:set({
        label = { width = 0 }
      })
    end)
  end
end

local function turn_off_popup_drawing()
    battery:set({ popup = { drawing = false} })
end

-- Sets popup icon/label transparency based on whether its hidden or shown
local function set_popup_transparency(popup_alpha)
  remaining_time:set({
    icon = {
      color = { alpha = popup_alpha }
    },
    label = {
      color = { alpha = popup_alpha }
    }
  })
end

-- Toggle details pane for remaining battery charge
local function toggle_battery_popup()
  local should_draw_popup = battery:query().popup.drawing == "off"
  if should_draw_popup then
    battery:set({
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
      battery:set({
        popup = {
          background = {
            color = { alpha = 1.0 },
            border_color = { alpha = 1.0 }
          }
        }
      })
      local popup_alpha = 1.0
      set_popup_transparency(popup_alpha)
    end)
    sbar.exec("pmset -g batt", function(batt_info)
      local found, _, remaining = batt_info:find(" (%d+:%d+) remaining")
      local label = found and remaining .. "h" or "No estimate"
      remaining_time:set( { label = label })
    end)
  else
    hide_battery_popup()
  end
end

-- Hide battery details pane
local function hide_battery_popup()
  battery:set({
    popup = { blur_radius = 0 }
  })
  sbar.animate("tanh", 15, function()
    battery:set({
      popup = {
        background = {
        color = colors.with_alpha(colors.bar.bg, 0.0),
        border_color = colors.with_alpha(colors.popup.border, 0.0),
        },
      }
    })
      local popup_alpha = 0.0
      set_popup_transparency(popup_alpha)
  end)
    sbar.exec("sleep 0.25 && echo 'turning off popup drawing'", turn_off_popup_drawing) 
end

-- Subscribe to mouse click event to toggle percentage visibility or details pane
battery:subscribe("mouse.clicked", function(env)
  if env.MODIFIER == "alt" then
    toggle_battery_popup()
  else
    toggleBattery()
  end
end)

-- Subscribe to mouse enter event to show battery if not permanently shown
battery:subscribe("mouse.entered", function(env)
  showBatteryIfNotPermanent()
end)

-- Subscribe to mouse exit event to hide battery if not permanently shown
battery:subscribe("mouse.exited", function(env)
  hideBatteryIfNotPermanent()
end)

-- Subscribe to hide battery details pane when mouse exits
battery:subscribe("mouse.exited.global", hide_battery_popup)

sbar.add("bracket", "widgets.battery.bracket", { battery.name }, {
  background = { color = colors.bg1 }
})


