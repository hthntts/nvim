local map = vim.keymap.set
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
map('n', '<A-down>', ':MoveLine(1)<CR>', opts)
map('n', '<A-up>', ':MoveLine(-1)<CR>', opts)

-- Visual-mode commands
map('v', '<A-down>', ':MoveBlock(1)<CR>', opts)
map('v', '<A-up>', ':MoveBlock(-1)<CR>', opts)
