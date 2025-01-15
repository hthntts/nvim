local icons = require('core.icons')

return {
  "NeogitOrg/neogit",
  cmd = 'Neogit',
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>gg",  "<cmd>Neogit<cr>",       desc = "Git status" },
    { "<leader>gcc", "<cmd>NeogitCommit<cr>", desc = "Git commit" },
    { "<leader>gF",  "<cmd>Neogit fetch<cr>", desc = "Git fetch" },
  },
  opts = {
    signs = {
      hunk = { "", "" },
      item = { icons.ui.ChevronRight, icons.ui.ArrowClosed },
      section = { icons.ui.ChevronRight, icons.ui.ArrowClosed },
    },
    popup = {
      kind = 'vsplit',
    },
    commit_editor = {
      staged_diff_split_kind = 'vsplit',
    },
    ignored_settings = { 'NeogitCommitPopup--all' },
    integrations = {
      telescope = true,
      diffview = true,
    },
    disable_builtin_notifications = true,
    disable_commit_confirmation = true,
  },
}
