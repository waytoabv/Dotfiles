local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Execute the event provider binary which provides the event "network_update"
-- for the network interface "en0", which is fired every 2.0 seconds.
sbar.exec("killall network_load >/dev/null; $CONFIG_DIR/helpers/event_providers/network_load/bin/network_load en0 network_update 2.0")

local popup_width = 250

local wifi_up = sbar.add("item", "widgets.wifi1", {
  position = "right",
  width = 0,
  padding_left = -2,
  icon = {
    padding_right = 0,
    width = 0,
    font = {
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    string = icons.wifi.upload,
  },
  label = {
    width = 0,
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    color = colors.red,
    string = "??? Bps",
  },
  y_offset = 4,
})

local wifi_down = sbar.add("item", "widgets.wifi2", {
  position = "right",
  padding_left = -2,
  icon = {
    width = 0,
    padding_right = 0,
    font = {
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    string = icons.wifi.download,
  },
  label = {
    width = 0,
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    color = colors.blue,
    string = "??? Bps",
  },
  y_offset = -4,
})

local wifi = sbar.add("item", "widgets.wifi.padding", {
  position = "right",
  label = { drawing = false },
  padding_left = 3,
})

-- Background around the item
local wifi_bracket = sbar.add("bracket", "widgets.wifi.bracket", {
  wifi.name,
  wifi_up.name,
  wifi_down.name,
  },
  {
  background = { color = colors.bg1 },
  popup = {
    align = "center",
    height = 30,
    background = {
      color = { alpha = 0.0 },
      border_color = { alpha = 0.0 }
    }
  }
})

local ssid = sbar.add("item", {
  position = "popup." .. wifi_bracket.name,
  icon = {
    font = {
      style = settings.font.style_map["Bold"]
    },
    string = icons.wifi.router,
    color = { alpha = 0.0 },
  },
  width = popup_width,
  align = "center",
  label = {
    font = {
      size = 15,
      style = settings.font.style_map["Bold"]
    },
    max_chars = 18,
    string = "????????????",
    color = { alpha = 0.0 },
  },
  background = {
    height = 2,
    y_offset = -15
  }
})

local hostname = sbar.add("item", {
  position = "popup." .. wifi_bracket.name,
  icon = {
    align = "left",
    string = "Hostname:",
    width = popup_width / 2,
    color = { alpha = 0.0 },
  },
  label = {
    max_chars = 25,
    string = "????????????",
    width = popup_width / 2,
    align = "right",
    color = { alpha = 0.0 },
  }
})

local pub_ip = sbar.add("item", {
  position = "popup." .. wifi_bracket.name,
  icon = {
    align = "left",
    string = "Public IP:",
    width = popup_width / 2,
    color = { alpha = 0.0 },
  },
  label = {
    string = "???.???.???.???",
    width = popup_width / 2,
    align = "right",
    color = { alpha = 0.0 },
  }
})


local local_ip = sbar.add("item", {
  position = "popup." .. wifi_bracket.name,
  icon = {
    align = "left",
    string = "Local IP:",
    width = popup_width / 2,
    color = { alpha = 0.0 },
  },
  label = {
    string = "???.???.???.???",
    width = popup_width / 2,
    align = "right",
    color = { alpha = 0.0 },
  }
})

local mask = sbar.add("item", {
  position = "popup." .. wifi_bracket.name,
  icon = {
    align = "left",
    string = "Subnet mask:",
    width = popup_width / 2,
    color = { alpha = 0.0 },
  },
  label = {
    string = "???.???.???.???",
    width = popup_width / 2,
    align = "right",
    color = { alpha = 0.0 },
  }
})

local router = sbar.add("item", {
  position = "popup." .. wifi_bracket.name,
  icon = {
    align = "left",
    string = "Router:",
    width = popup_width / 2,
    color = { alpha = 0.0 },
  },
  label = {
    string = "???.???.???.???",
    width = popup_width / 2,
    align = "right",
    color = { alpha = 0.0 },
  },
})

sbar.add("item", { position = "right", width = settings.group_paddings })

-- Table of all popup item names to be used later on
local wifi_popup_items = {
  ssid,
  hostname,
  pub_ip,
  local_ip,
  mask,
  router
}

wifi_up:subscribe("network_update", function(env)
  local up_color = (env.upload == "000 Bps") and colors.grey or colors.pink
  local down_color = (env.download == "000 Bps") and colors.grey or colors.blue
  wifi_up:set({
    icon = { color = up_color },
    label = {
      string = env.upload,
      color = up_color
    }
  })
  wifi_down:set({
    icon = { color = down_color },
    label = {
      string = env.download,
      color = down_color
    }
  })
end)

-- Variable to track if network speed should be permanently shown
local showSpeed = false

-- Function to toggle the state of showSpeed variable
local function toggleSpeed()
  showSpeed = not showSpeed
  if showSpeed then
    -- Show network speed with animation
    sbar.animate("elastic", 10, function()
      wifi_up:set({
        label = { width = "dynamic" },
        icon = { width = "dynamic" }
      })
      wifi_down:set({
        label = { width = "dynamic" },
        icon = { width = "dynamic" }
      })
    end)
  end
end

-- Function to show network speed if not permanently shown
local function showSpeedIfNotPermanent()
  if not showSpeed then
    sbar.animate("elastic", 10, function()
      wifi_up:set({
        label = { width = "dynamic" },
        icon = { width = "dynamic" }
      })
      wifi_down:set({
        label = { width = "dynamic" },
        icon = { width = "dynamic" }
      })
    end)
  end
end

-- Function to hide network speed if not permanently shown
local function hideSpeedIfNotPermanent()
  if not showSpeed then
    sbar.animate("elastic", 10, function()
      wifi_up:set({
        label = { width = 0 },
        icon = { width = 0 }
      })
      wifi_down:set({
        label = { width = 0 },
        icon = { width = 0 }
      })
    end)
  end
end

-- Reveal up+down speed when moused over
wifi_bracket:subscribe("mouse.entered", function(env)
  showSpeedIfNotPermanent()
end)

-- Hide up+down speed after mouse exits
wifi_bracket:subscribe("mouse.exited", function(env)
  hideSpeedIfNotPermanent()
end)


wifi:subscribe({ "wifi_change", "system_woke", "forced" }, function(env)
  wifi:set({
    icon = {
      string = icons.wifi.disconnected,
      color = colors.pink,
    }
  })
  sbar.exec([[ipconfig getifaddr en0]], function(result_ip)
    local ipconnected = not (result_ip == "")

    if ipconnected then
      Wifi_icon = icons.wifi.connected
      Wifi_color = colors.dirty_white
    end

    wifi:set({
      icon = {
        string = Wifi_icon,
        color = Wifi_color,
      }
    })

    -- VPN icon
    sbar.exec([[sleep 2; scutil --nwi | grep -m1 'utun' | awk '{ print $1 }']], function(vpn)
       local vpnconnected = not (vpn == "")

      if vpnconnected then
        Wifi_icon = icons.wifi.vpn
        Wifi_color = colors.green
      end

      wifi:set({
        icon = {
          string = Wifi_icon,
          color = Wifi_color,
        }
      })
    end)
  end)
end)

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
    wifi_bracket:set({ popup = { drawing = false} })
end

-- hides popup menu
local function hide_details()
  wifi_bracket:set({
    popup = { blur_radius = 0 }
  })
  sbar.animate("tanh", 15, function()
    ssid:set({
      background = {
        color = { alpha = 0.0 }
      },
    })
    wifi_bracket:set({
      popup = {
        background = {
        color = colors.with_alpha(colors.bar.bg, 0.0),
        border_color = colors.with_alpha(colors.popup.border, 0.0),
        },
      }
    })
    for i, item in ipairs(wifi_popup_items) do
      local popup_alpha = 0.0
      set_popup_transparency(item, popup_alpha)
    end
  end)
    sbar.exec("sleep 0.25 && echo 'turning off popup drawing'", turn_off_popup_drawing) 
end

-- start popup animation after enabling drawing, setting the blur radius, and setting alpha to a miniscule amount so that the blur is shown just before animation. Makes it look sleek af.
local function show_popup_animation()
  sbar.animate("tanh", 15, function()
    wifi_bracket:set({
      popup = {
        background = {
          color = { alpha = 1.0 },
          border_color = { alpha = 1.0 }
        }
      }
    })
    for i, item in ipairs(wifi_popup_items) do
      local popup_alpha = 1.0
      set_popup_transparency(item, popup_alpha)
    end
  end)
end

local function toggle_details()
  local should_draw = wifi_bracket:query().popup.drawing == "off"
  if should_draw then
    -- setting drawing
    wifi_bracket:set({
      popup = {
        drawing = true,
	blur_radius = 20,
        background = {
          color = { alpha = 0.01 },
          border_color = { alpha = 0.01 }
        }
      }
    })
    -- Setting network label values
    sbar.exec("networksetup -getcomputername", function(result)
      hostname:set({ label = result })
    end)
    sbar.exec("curl -s icanhazip.com", function(result)
      pub_ip:set({ label = result })
    end)
    sbar.exec("ipconfig getifaddr en0", function(result)
      local_ip:set({ label = result })
    end)
    sbar.exec("ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}'", function(result)
      ssid:set({ label = result })
    end)
    sbar.exec("networksetup -getinfo Wi-Fi | awk -F 'Subnet mask: ' '/^Subnet mask: / {print $2}'", function(result)
      mask:set({ label = result })
    end)
    sbar.exec("networksetup -getinfo Wi-Fi | awk -F 'Router: ' '/^Router: / {print $2}'", function(result)
      router:set({ label = result })
    end)
    -- setting animations
    show_popup_animation()
  else
    hide_details()
  end
end

-- Subscribing to mouse-click events to determine whether to show details or toggle the details pane
wifi_up:subscribe("mouse.clicked", function(env)
  if env.MODIFIER == "alt" then
    toggle_details()
  else
    toggleSpeed()
  end
end)

wifi_down:subscribe("mouse.clicked", function(env)
  if env.MODIFIER == "alt" then
    toggle_details()
  else
    toggleSpeed()
  end
end)

wifi:subscribe("mouse.clicked", function(env)
  if env.MODIFIER == "alt" then
    toggle_details()
  else
    toggleSpeed()
  end
end)

-- Subscribe to hide details when mouse exits
wifi:subscribe("mouse.exited.global", hide_details)

local function copy_label_to_clipboard(env)
  local label = sbar.query(env.NAME).label.value
  sbar.exec("echo \"" .. label .. "\" | pbcopy")
  sbar.set(env.NAME, { label = { string = icons.clipboard, align="center" } })
  sbar.delay(1, function()
    sbar.set(env.NAME, { label = { string = label, align = "right" } })
  end)
end

ssid:subscribe("mouse.clicked", copy_label_to_clipboard)
hostname:subscribe("mouse.clicked", copy_label_to_clipboard)
pub_ip:subscribe("mouse.clicked", copy_label_to_clipboard)
local_ip:subscribe("mouse.clicked", copy_label_to_clipboard)
mask:subscribe("mouse.clicked", copy_label_to_clipboard)
router:subscribe("mouse.clicked", copy_label_to_clipboard)
