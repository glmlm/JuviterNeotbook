return {
  {
    "GCBallesteros/jupytext.nvim",
    lazy = false,
    opts = require "juviter.configs.jupytext",
  },
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    lazy = true,
    config = function()
      require "juviter.configs.molten-nvim"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
  },
  {
    "jmbuhr/otter.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    lazy = true,
    opts = {},
  },
  {
    "quarto-dev/quarto-nvim",
    dependencies = { "jmbuhr/otter.nvim", "benlubas/molten-nvim" },
    lazy = true,
    opts = require "juviter.configs.quarto-nvim",
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = "markdown",
    opts = {},
  },
}
