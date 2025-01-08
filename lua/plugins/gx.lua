return {
  "chrishrb/gx.nvim",
  keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" }, desc = "Browse" } },
  cmd = { "Browse" },
  init = function()
    vim.g.netrw_nogx = 1 -- disable netrw gx
  end,
  enabled = function()
    if vim.g.is_win or vim.g.is_mac then
      return true
    else
      return false
    end
  end,
  dependencies = { "nvim-lua/plenary.nvim" },
  config = true,      -- default settings
  submodules = false, -- not needed, submodules are required only for tests
  event = "VeryLazy",

}
