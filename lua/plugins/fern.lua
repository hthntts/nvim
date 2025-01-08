return {
  'lambdalisue/vim-fern',
  lazy = true,
  config = function()
    vim.api.nvim_create_augroup("vimrc", {})
    vim.api.nvim_create_autocmd("WinEnter", {
      callback = function()
        if (vim.bo.filetype ~= "fern") then
          vim.cmd("FernDo close -stay")
        end
      end,
    })
    vim.keymap.set("n", "<leader>oF", "<cmd>Fern . -drawer -reveal=% -toggle -width=40<cr>", { desc = "[F]ern" })
    vim.keymap.set("n", "<M-g>", "<cmd>Fern . -drawer -reveal=% -toggle -width=40<cr>", { desc = "[F]ern" })
  end,
  event = "VeryLazy",
}
