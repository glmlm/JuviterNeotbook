local b = vim.b

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.ipynb",
  callback = function()
    if not b.quarto_activated then
      require("quarto").activate()
      vim.cmd "MoltenImportOutput"
      b.quarto_activated = true
    end
  end,
})

local options = {
  lspFeatures = {
    chunks = "all",
  },
  codeRunner = {
    default_method = "molten",
  },
}

return options
