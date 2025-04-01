if vim.uv.os_uname().sysname == "Windows_NT" then
  if vim.env.WEZTERM_EXECUTABLE ~= nil then
    return {
      "willothy/wezterm.nvim",
      lazy = true,
      opts = {},
    }
  end
else
  local glob = vim.fn.glob
  local include = { g = "/usr/include", l = "/usr/local/include", h = "/opt/homebrew/include" }
  local lua = "/lua*/lua.h"
  local magick = "/ImageMagick-*/wand/MagickWand.h"
  local has_lua = glob(include["g"] .. lua) ~= "" or glob(include["l"] .. lua) ~= "" or glob(include["h"] .. lua) ~= ""
  local has_magick = glob(include["g"] .. magick) ~= ""
    or glob(include["l"] .. magick) ~= ""
    or glob(include["h"] .. magick) ~= ""
  if has_lua and has_magick then
    return {
      "3rd/image.nvim",
      lazy = true,
      opts = require "juviter.configs.image",
    }
  end
end
return {}
