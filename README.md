# Juviter Neotbook

![demo](https://github.com/user-attachments/assets/1eca75f0-fb54-4cc6-b7de-c369f6195e52)

<p align="center">
    <i>OOTB Jupyter Notebook experience in Neovim</i>
</p>

## 👋 Preface

This plugin simply suggests best practices for the integration of each plugin. In short, it corresponds to an [Extension Pack](https://code.visualstudio.com/blogs/2017/03/07/extension-pack-roundup) in VSCode.

The parts of this plugin that are set independently (global variables, user/auto commands, etc.) are subject to maintenance. If you require any information regarding the functions of each plugin, I kindly request that you reach out to the respective maintainer.

### Goals

- Improve Jupyter Notebook development experience on Neovim (at least for me)
- Explore better ways to integrate each plugins

### Non-Goals

- Implement functionality as an independent plugin
    - In the event that the feature is considered to be a truly expected one, it might be worthwhile to consider creating a separate repository. In that case, the setup of it could be mentioned on this plugin.

## ⚡️ Requirements

- **Neovim** >= 0.10.0
- **Python** >= 3.10.0
    - **pynvim**
    - **ipykernel**
    - **nbformat**
    - **jupytext**
- (Optional) LSP setup for Python (such as [basedpyright](https://github.com/DetachHead/basedpyright))
- (Optional) Image provider ([see below](#optional-setup-an-image-provider))

## 📦 Setup

### Setup Python

<details><summary>Install pynvim, ipykernel, and nbformat</summary>

```bash
$ pip install pynvim ipykernel nbformat
```

</details>

<details><summary>Install jupytext</summary>

```bash
$ pip install jupytext
```

You can also install it via [mason.nvim](https://github.com/williamboman/mason.nvim).

</details>

<details open><summary>Set a global variable</summary>

Add this line to your config file of Neovim:

```lua
vim.g.python3_host_prog = "/path/to/python"
```

</details>

### (Optional) Setup an image provider

> [!NOTE]
> This feature requires a terminal that supports the [Kitty Graphics Protocol](https://sw.kovidgoyal.net/kitty/graphics-protocol/). If you skip this section, the default image viewer will be used instead.

<details><summary>Linux</summary>

```bash
$ sudo apt install liblua5.1-0-dev
$ sudo apt install libmagickwand-dev
```

</details>

<details><summary>macOS</summary>

```bash
$ brew install luajit
$ brew install imagemagick
```

</details>

<details><summary>Windows</summary>

Currently, native Windows cannot handle inline images. As an alternative, you can use [Wezterm](https://wezterm.org/index.html) to display images in the terminal.

```bash
> scoop install wezterm
```

It may be possible in the future when [image.nvim can handle sixel](https://github.com/3rd/image.nvim/issues/59).

</details>

### Install the plugin with [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "glmlm/JuviterNeotbook",
  import = "juviter.plugins",
  keys = {
    {
      "<leader>rc",
      function()
        require("quarto.runner").run_cell()
      end,
      desc = "Juviter Run Cell",
    },
    {
      "<leader>ra",
      function()
        require("quarto.runner").run_above()
      end,
      desc = "Juviter Run cell and above",
    },
    {
      "<leader>rA",
      function()
        require("quarto.runner").run_all()
      end,
      desc = "Juviter Run all cells",
    },
    { "<leader>rd", ":noautocmd MoltenDelete<CR>", silent = true, desc = "Juviter Delete cell" },
    { "<leader>ri", ":noautocmd MoltenInterrupt<CR>", silent = true, desc = "Juviter Send a keyboard interrupt" },
    { "<leader>ro", ":noautocmd MoltenEnterOutput<CR>", silent = true, desc = "Juviter Open output window" },
    { "<leader>nj", "<cmd>NewNotebook<CR>", silent = true, desc = "Juviter Create a new notebook" },
  },
}
```

### First-time only operation

1. Open Neovim
1. `:lua require "molten.health"`
1. `:UpdateRemotePlugins`
1. Restart Neovim

## ❓ FAQ

<details open><summary><b>I got an error during setup.</b></summary>

There are two main reasons why this happens:

#### Case #1: Python is not set up (or the path is incorrect/missing)

[See above](#setup-python)

#### Case #2: [rplugin.vim](https://github.com/neovim/neovim/blob/master/runtime/plugin/rplugin.vim) is disabled

Certain Neovim distributions may disable loading of default plugins. [molten-nvim](https://github.com/benlubas/molten-nvim) requires `runtime/plugin/rplugin.vim`, so if it is missing, the following error is raised when the `:UpdateRemotePlugins` command is entered.

```
E492: Not an editor command: UpdateRemotePlugins
```

As for NvChad, you can enable it by deleting [this line](https://github.com/NvChad/starter/blob/c3d1fb646a04aaa97b2929b90269f8a7bf8e8dc4/lua/configs/lazy.lua#L37).

</details>

<details><summary><b>An error occurs when saving outputs.</b></summary>

`:MoltenExportOutput` depends on [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter). To enable it, enter the following command:
```
:TSInstall python
```

</details>

<details><summary><b>Past outputs are not displayed.</b></summary>

If a valid kernel is not running, the outputs will not be imported. To select the kernel, enter the `MoltenImportOutput` command or just reopen the buffer.

</details>

<details><summary><b>Images are not displayed.</b></summary>

If the [image provider](#optional-setup-an-image-provider) is not set up, images from previous runs will not be loaded.

Also, even if you have set up [image.nvim](https://github.com/3rd/image.nvim), The image disappears when the buffer is switched. If you want to display it again, enter the `:noautocmd MoltenEnterOutput` command on the code block or just reopen the buffer.

</details>

## Acknowledgements

The [documentation of molten-nvim](https://github.com/benlubas/molten-nvim/blob/main/docs/Notebook-Setup.md) proved to be a valuable resource in the creation of this plugin. I would like to take this opportunity to express my gratitude.
