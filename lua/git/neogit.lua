local icons = require('core/icons')

return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>gg",  "<cmd>Neogit<cr>",       desc = "Status" },
    { "<leader>gcc", "<cmd>NeogitCommit<cr>", desc = "Commit" },
    { "<leader>gF",  "<cmd>Neogit fetch<cr>", desc = "Fetch" },
  },
  opts = {
    signs = {
      hunk = { "", "" },
      item = { icons.ui.ChevronRight, icons.ui.ArrowClosed },
      section = { icons.ui.ChevronRight, icons.ui.ArrowClosed },
    },
  }
}
