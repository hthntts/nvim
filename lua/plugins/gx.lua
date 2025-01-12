return {
  "chrishrb/gx.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "Browse" },
  keys = {
    { "gx", "<cmd>Browse<cr>", mode = { "n", "x" }, desc = "Browse" },
  },
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
  config = true,      -- default settings
  submodules = false, -- not needed, submodules are required only for tests
}
