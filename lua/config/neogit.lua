local neogit = require("neogit")
local icons = require('config/icons')

neogit.setup {
  signs = {
    hunk = { "", "" },
    item = { icons.ui.ChevronRight, icons.ui.ArrowClosed },
    section = { icons.ui.ChevronRight, icons.ui.ArrowClosed },
  },
}

keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Status" })
keymap.set("n", "<leader>gcc", "<cmd>NeogitCommit<cr>", { desc = "Commit" })
keymap.set("n", "<leader>gF", "<cmd>Neogit fetch<cr>", { desc = "Fetch" })
