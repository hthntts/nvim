local opts = { noremap = true, silent = true }

require('move').setup({
  line = {
    enable = true, -- Enables line movement
    indent = true  -- Toggles indentation
  },
  block = {
    enable = true, -- Enables block movement
    indent = true  -- Toggles indentation
  },
  word = {
    enable = false, -- Enables word movement
  },
  char = {
    enable = false -- Enables char movement
  }
})

-- Normal-mode commands
vim.keymap.set('n', '<A-down>', ':MoveLine(1)<CR>', opts)
vim.keymap.set('n', '<A-up>', ':MoveLine(-1)<CR>', opts)

-- Visual-mode commands
vim.keymap.set('v', '<A-down>', ':MoveBlock(1)<CR>', opts)
vim.keymap.set('v', '<A-up>', ':MoveBlock(-1)<CR>', opts)
