-- automatically export output chunks to a jupyter notebook on write
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.ipynb",
  callback = function()
    if require("molten.status").kernels() ~= "" then
      vim.cmd("MoltenExportOutput!")
    end
  end,
})
