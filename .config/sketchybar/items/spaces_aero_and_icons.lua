local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local item_order = ""

sbar.exec("aerospace list-workspaces --all", function(spaces)
  for space_name in spaces:gmatch("[^\r\n]+") do
    local space = sbar.add("item", "space." .. space_name, {
      icon = {
        font = { family = settings.font.numbers },
        string = string.sub(space_name, 3),
        padding_left = 7,
        padding_right = 3,
        color = colors.white,
        highlight_color = colors.red,
      },
      label = {
        padding_right = 12,
        color = colors.grey,
        highlight_color = colors.white,
        font = "sketchybar-app-font:Regular:16.0",
        y_offset = -1,
      },
      padding_right = 1,
      padding_left = 1,
      background = {
        color = colors.bg1,
        border_width = 1,
        height = 26,
        border_color = colors.black,
      }
    })

    local space_bracket = sbar.add("bracket", { space.name }, {
      background = {
        color = colors.transparent,
        border_color = colors.bg2,
        height = 28,
        border_width = 2
      }
    })

    -- Padding space
    local space_padding = sbar.add("item", "space.padding." .. space_name, {
      script = "",
      width = settings.group_paddings,
    })

    space:subscribe("aerospace_workspace_change", function(env)
      local selected = env.FOCUSED_WORKSPACE == space_name
      local color = selected and colors.grey or colors.bg2
      space:set({
        icon = { highlight = selected, },
        label = { highlight = selected },
        background = { border_color = selected and colors.black or colors.bg2 }
      })
      space_bracket:set({
        background = { border_color = selected and colors.grey or colors.bg2 }
      })
    end)

    space:subscribe("mouse.clicked", function()
      sbar.exec("aerospace workspace " .. space_name)
    end)



    space:subscribe("space_windows_change", function()
      sbar.exec("aerospace list-windows --format %{app-name} --workspace " .. space_name, function(windows)
        print(windows)
        local no_app = true
        local icon_line = ""
        for app in windows:gmatch("[^\r\n]+") do
          no_app = false
          local lookup = app_icons[app]
          local icon = ((lookup == nil) and app_icons["default"] or lookup)
          icon_line = icon_line .. " " .. icon
        end

        if (no_app) then
          icon_line = " —"
        end
        sbar.animate("tanh", 10, function()
          space:set({ label = icon_line })
        end)
      end)
    end)

    item_order = item_order .. " " .. space.name .. " " .. space_padding.name
  end
  sbar.exec("sketchybar --reorder apple " .. item_order .. " front_app")
end)
