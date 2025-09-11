local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local volume_widget = sbar.add("item", "widgets.volume", {
  position = "right",
  icon = {
    string = icons.volume._0,
    width = 35,
    align = "center",
    font = {
      style = settings.font.style_map["Regular"],
      size = 14.0,
    },
    padding_left = 0,
    padding_right = 0,
  },
  label = {
    string = "",
    width = 0,
    font = { family = settings.font.numbers },
    padding_left = 0,
    padding_right = 8,
  },
  background = { color = colors.bg1 },
})

local show_volume_percent = false

volume_widget:subscribe("volume_change", function(env)
  local volume = tonumber(env.INFO)
  local icon = icons.volume._0
  local icon_width = 35

  sbar.exec("SwitchAudioSource -t output -c", function(result)
    local Current_output_device = result:sub(1, -2)

    if Current_output_device == "AirPods Max " then
      icon = "􀺹"
    elseif Current_output_device == "AirPods2" or Current_output_device == "AirPods von Anna" then
      icon = "􀟥"
    elseif Current_output_device == "Arctis Nova Pro Wireless" then
      icon = "􀑈"
    elseif Current_output_device == "AirPods4" then
      icon = "􁄡"
    elseif Current_output_device == "Ear (2)" then
      icon = "􀪷"
    elseif Current_output_device == "iD4" then
      icon = "􀝎"
    else
      if volume > 70 then
        icon = icons.volume._100
        icon_width = 35
      elseif volume > 40 then
        icon = icons.volume._66
        icon_width = 33
      elseif volume > 20 then
        icon = icons.volume._33
        icon_width = 31
      elseif volume > 0 then
        icon = icons.volume._10
        icon_width = 30
      else
        icon = icons.volume._0
        icon_width = 30
      end
    end

    local lead = (volume < 10) and "0" or ""

    volume_widget:set({
      icon = {
        string = icon,
        width = icon_width,
      },
      label = {
        string = lead .. volume .. "%"
      }
    })
  end)
end)

local function toggle_volume_display()
  show_volume_percent = not show_volume_percent
  local width = show_volume_percent and "dynamic" or 0
  sbar.animate("elastic", 10, function()
    volume_widget:set({
      label = { width = width }
    })
  end)
end

local function show_volume_percent_if_not_permanent()
  if not show_volume_percent then
    sbar.animate("elastic", 10, function()
      volume_widget:set({
        label = { width = "dynamic" }
      })
    end)
  end
end

local function hide_volume_percent_if_not_permanent()
  if not show_volume_percent then
    sbar.animate("elastic", 10, function()
      volume_widget:set({
        label = { width = 0 }
      })
    end)
  end
end

volume_widget:subscribe("mouse.clicked", toggle_volume_display)
volume_widget:subscribe("mouse.entered", show_volume_percent_if_not_permanent)
volume_widget:subscribe("mouse.exited", hide_volume_percent_if_not_permanent)
