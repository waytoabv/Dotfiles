local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local LIST_ALL = "aerospace list-workspaces --all"
local LIST_CURRENT = "aerospace list-workspaces --focused"
local spaces = {}


local function addWorkspaceItem(workspaceName)
    local space = "workspace_" .. workspaceName
    spaces[space] = sbar.add("item", space, {
        label = {
            string = workspaceName,
            padding_right = 10,
            color = colors.grey,
            highlight_color = colors.blue,
        },
        padding_right = 2,
        padding_left = 2,
        background = {
          color = colors.bg1,
          border_width = 1,
          height = 24,
          border_color = colors.black,
        },
        click_script = "aerospace workspace " .. workspaceName,
    })

    
    -- Aerospace-Event
    spaces[space]:subscribe("aerospace_workspace_change", function(env)
        -- is the current the focussed workspace?
        sbar.exec(LIST_CURRENT, function(focusedWorkspaceOutput)
            local focusedWorkspaceName = focusedWorkspaceOutput:match("[^\r\n]+")
            -- Iterate trough all workspace items
            for sid, space in pairs(spaces) do
                -- does spaces[space] exists
                if space ~= nil then
                    local isSelected = sid == "workspace_" .. focusedWorkspaceName
                    -- add highlights
                    space:set({
                        label = { highlight = isSelected },
                        background = { border_color = isSelected and colors.blue or colors.bg2, height = isSelected and 26 or 24 }
                    })
                else
                    print("Error: Item '" .. sid .. "' not found.")
                end
            end
        end)
    end)
end

-- Function to add Workspaces
sbar.exec(LIST_ALL, function(workspacesOutput)
    for workspaceName in workspacesOutput:gmatch("[^\r\n]+") do
        addWorkspaceItem(workspaceName)
    end
    
    -- First Iteration
    sbar.exec(LIST_CURRENT, function(focusedWorkspaceOutput)
        local focusedWorkspaceName = focusedWorkspaceOutput:match("[^\r\n]+")
        for sid, space in pairs(spaces) do
            local isSelected = sid == "workspace_" .. focusedWorkspaceName
            space:set({
                label = { highlight = isSelected },
                background = { border_color = isSelected and colors.blue or colors.bg2, height = isSelected and 26 or 24 }
            })
        end
    end)
end)

local space_window_observer = sbar.add("item", {
  drawing = false,
  updates = true,
})

local spaces_indicator = sbar.add("item", {
  padding_left = -3,
  padding_right = 0,
  icon = {
    padding_left = 8,
    padding_right = 9,
    color = colors.grey,
    string = icons.switch.on,
  },
  label = {
    width = 0,
    padding_left = 0,
    padding_right = 8,
    string = "Spaces",
    color = colors.bg1,
  },
  background = {
    color = colors.with_alpha(colors.grey, 0.0),
    border_color = colors.with_alpha(colors.bg1, 0.0),
  }
})


spaces_indicator:subscribe("swap_menus_and_spaces", function(env)
  local currently_on = spaces_indicator:query().icon.value == icons.switch.on
  spaces_indicator:set({
    icon = currently_on and icons.switch.off or icons.switch.on
  })
end)

spaces_indicator:subscribe("mouse.entered", function(env)
  sbar.animate("tanh", 30, function()
    spaces_indicator:set({
      background = {
        color = { alpha = 1.0 },
        border_color = { alpha = 0.5 },
      },
      icon = { color = colors.bg1 },
      label = { width = "dynamic" }
    })
  end)
end)

spaces_indicator:subscribe("mouse.exited", function(env)
  sbar.animate("tanh", 30, function()
    spaces_indicator:set({
      background = {
        color = { alpha = 0.0 },
        border_color = { alpha = 0.0 },
      },
      icon = { color = colors.grey },
      label = { width = 0, }
    })
  end)
end)

spaces_indicator:subscribe("mouse.clicked", function(env)
  sbar.trigger("swap_menus_and_spaces")
end)
