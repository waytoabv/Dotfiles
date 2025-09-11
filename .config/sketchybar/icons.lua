local settings = require("settings")

local icons = {
  sf_symbols = {
    plus = "􀅼",
    loading = "􀖇",
    cpu = "􀫥",
    clipboard = "􀉄",
    messages = "􀌤",
    
    apple = {
    apple = "󰅏", --􀣺
    question_mark = "􀁝",
    gear = "􀍟",
    graph = "􁣃",
    trash = "􀈒",
    lock = "􀼓",
    logout = "􀉭",
    power = "􀷃",
    },
    space_icon = {
      active = "􀀁",
      not_active = "􁅃",
      not_active_has_apps = "􁹧",
    },
    space_layout = {
      dots = "􀧸",
      apps = "􀑏",
      creator = "􀏑",
    },
    yabai = {
      float = "􀢌",
      fullscreen_zoom = "􀏜",
      grid = "􀧍",
      parent_zoom = "􀥃",
      stack = "􀏭",
      sticky = "􀒖",
    },
    volume = {
      _100="􀊩",
      _66="􀊧",
      _33="􀊥",
      _10="􀊡",
      _0="􀊣",
      standby = "􀻂", --􀻂
    },
    battery = {
      _100 = "􀛨",
      _75 = "􀺸",
      _50 = "􀺶",
      _25 = "􀛩",
      _0 = "􀛪",
      charging = "􀢋"
    },
    wifi = {
      upload = "􀄨",
      download = "􀄩",
      connected = "􀙇",
      disconnected = "􀙈",
      router = "􁓤",
      vpn = "󰌾",
    },
    media = {
      back = "􀊊",
      forward = "􀊌",
      play_pause = "􀊈",
    },
    ramicons = {
        swap = "󰁄",
        ram = "󰍛",
    },
    switch = {
        on = "􁏮",
        off = "􁏯",
    },
  },

  -- Alternative NerdFont icons
  nerdfont = {
    plus = "",
    loading = "",
    apple = "",
    gear = "",
    cpu = "",
    clipboard = "Missing Icon",
    more_vertical = "",

    switch = {
      on = "󱨥",
      off = "󱨦",
    },
    volume = {
      _100="",
      _66="",
      _33="",
      _10="",
      _0="",
    },
    battery = {
      _100 = "",
      _75 = "",
      _50 = "",
      _25 = "",
      _0 = "",
      charging = ""
    },
    wifi = {
      upload = "",
      download = "",
      connected = "󰖩",
      disconnected = "󰖪",
      router = "Missing Icon"
    },
    media = {
      back = "",
      forward = "",
      play_pause = "",
    },
  },
}

if not (settings.icons == "NerdFont") then
  return icons.sf_symbols
else
  return icons.nerdfont
end
