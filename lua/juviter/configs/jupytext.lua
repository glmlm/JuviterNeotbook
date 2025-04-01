local default_notebook = [[
  {
    "cells": [
      {
        "cell_type": "markdown",
        "metadata": {},
        "source": [
          ""
        ]
      }
    ],
    "metadata": {
      "kernelspec": {
        "display_name": "Python 3",
        "language": "python",
        "name": "python3"
      },
      "language_info": {
        "codemirror_mode": {
          "name": "ipython"
        },
        "file_extension": ".py",
        "mimetype": "text/x-python",
        "name": "python",
        "nbconvert_exporter": "python",
        "pygments_lexer": "ipython3"
       }
    },
    "nbformat": 4,
    "nbformat_minor": 5
  }
]]

local function new_notebook(filename_input)
  local ext = ".ipynb"
  local path = string.sub(filename_input, -6) == ext and filename_input or filename_input .. ext
  local file = io.open(path, "w")
  if file then
    file:write(default_notebook)
    file:close()
    vim.cmd("edit " .. path)
  else
    vim.notify("Could not open a new .ipynb file for writing", vim.log.levels.ERROR)
  end
end

-- Provide a command to create a blank new Python notebook
vim.api.nvim_create_user_command("NewNotebook", function()
  vim.ui.input({ prompt = "Create a new Jupyter Notebook: " }, function(filename)
    if filename and filename ~= "" then
      new_notebook(filename)
    end
  end)
end, {})

local options = {
  style = "markdown",
  output_extension = "md",
  force_ft = "markdown",
}

return options
