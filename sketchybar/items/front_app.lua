local colors = require("colors")
local settings = require("settings")

local front_app = sbar.add("item", "front_app", {
  position = "center",
  display = "active",
  icon = { drawing = false },
  label = {
    font = {
      style = settings.font.style_map["Black"],
      size = 13.0,
    },
    color = colors.red,
    padding_left=5,
    padding_right=5,
  },
  background = {
    color = colors.bg1,
  },
  updates = true,
})

front_app:subscribe("front_app_switched", function(env)
  front_app:set({ label = { string = env.INFO } })
end)

front_app:subscribe("mouse.clicked", function(env)
  sbar.exec("open -a 'Mission Control'")
end)
