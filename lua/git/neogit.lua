return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",
      "echasnovski/mini.pick",
    },
    config = function()
      local neogit = require("neogit")
      local icons = require('core/icons')

      neogit.setup {
        signs = {
          hunk = { "", "" },
          item = { icons.ui.ChevronRight, icons.ui.ArrowClosed },
          section = { icons.ui.ChevronRight, icons.ui.ArrowClosed },
        },
      }

      vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Status [g]" })
      vim.keymap.set("n", "<leader>gcc", "<cmd>NeogitCommit<cr>", { desc = "[c]ommit" })
      vim.keymap.set("n", "<leader>gF", "<cmd>Neogit fetch<cr>", { desc = "[F]etch" })
    end,
    event = "VeryLazy",
  },
}
