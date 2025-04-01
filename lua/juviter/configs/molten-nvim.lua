local g = vim.g
local env = vim.env

local image, _ = pcall(require, "image")
local wezterm, _ = pcall(require, "wezterm")

local is_os_win = vim.uv.os_uname().sysname == "Windows_NT"
local runtime = is_os_win and env.APPDATA .. "/jupyter/runtime" or env.HOME .. "/.local/share/jupyter/runtime"

g.loaded_python3_provider = nil
g.molten_auto_image_popup = not (image or wezterm)
g.molten_auto_open_output = false
g.molten_enter_output_behavior = "open_and_enter"
g.molten_image_provider = (is_os_win and wezterm) and "wezterm" or (not is_os_win and image) and "image.nvim" or "none"
g.molten_output_win_max_height = 20
g.molten_split_size = 20
g.molten_virt_text_output = true
g.molten_wrap_output = true

if vim.fn.isdirectory(runtime) == 0 then
  vim.fn.mkdir(runtime, "p")
end

-- automatically export output chunks to a jupyter notebook on write
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.ipynb",
  callback = function()
    if require("molten.status").kernels() ~= "" then
      vim.cmd "MoltenExportOutput!"
    end
  end,
})
