local options = {
  lspFeatures = {
    chunks = "all",
  },
  codeRunner = {
    default_method = "molten",
  },
}

require("juviter.autocmds.quarto-nvim")

return options
