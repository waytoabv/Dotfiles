local settings = require("settings")
local colors = require("colors")

-- Padding item required because of bracket
sbar.add("item", { position = "right", width = settings.group_paddings })

local cal = sbar.add("item", {
  icon = {
    color = colors.dirty_white,
    font = {
      style = settings.font.style_map["Bold"],
      size = 12.0,
    },
    y_offset = -1,
    padding_right = -2,
  },
  label = {
    color = colors.dirty_white,
    width = 96,
    align = "left",
    font = {
      style = settings.font.style_map["Black"],
      size = 14.0,
    },
  },
  position = "right",
  update_freq = 1,
  y_offset = 1,
  padding_left = 4,
  padding_right = 4,
})


cal:subscribe({ "forced", "routine", "system_woke" }, function(env)
  local weekdayNames = {
    "So.", "Mo.", "Di.", "Mi.", "Do.", "Fr.", "Sa."
  }
  local monthNames = {
    "Jan.", "Feb.", "März", "Apr.", "Mai", "Juni", "Juli", "Aug.", "Sep.", "Okt.", "Nov.", "Dez."
  }

  cal:set({
    icon = weekdayNames[tonumber(os.date("%w")) + 1] ..
      os.date("%d") .." ".. monthNames[tonumber(os.date("%m"))],
    label = "｜" .. os.date("%H:%M:%S")
  })
end)
