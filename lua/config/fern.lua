vim.api.nvim_create_augroup("vimrc", {})
vim.api.nvim_create_autocmd("WinEnter", {
  callback = function()
    if(vim.bo.filetype ~= "fern") then
      vim.cmd("FernDo close -stay")
    end
  end,
})
