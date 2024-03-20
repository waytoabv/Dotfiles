return {
  black = 0xff181819,
  white = 0xffe2e2e3,
  red = 0xffed8796,
  green = 0xffa6da95,
  blue = 0xff8aadf4,
  yellow = 0xffeed49f,
  orange = 0xfff5a97f,
  magenta = 0xffc6a0f6,
  purple = 0xffc29df1,
  grey = 0xff7f8490,
  dirtywhite = 0xc8cad3f5,
  lightblack=0x8a262323,
  transparent = 0x00000000,

  bar = {
    bg = 0x00000000,
    border = 0xff2c2e34,
  },
  popup = {
    bg = 0xc02c2e34,
    border = 0xff7f8490
  },
  bg1 = 0x88211f21,
  bg2 = 0x88211f21,

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}
