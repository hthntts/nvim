return {
  'fedepujol/move.nvim',
  event = 'VeryLazy',
  cmd = {
    'MoveLine',
    'MoveBlock'
  },
  keys = {
    { '<A-up>',   ':MoveLine(-1)<CR>',  mode = 'n', noremap = true, silent = true },
    { '<A-down>', ':MoveLine(1)<CR>',   mode = 'n', noremap = true, silent = true },

    { '<A-up>',   ':MoveBlock(-1)<CR>', mode = 'v', noremap = true, silent = true },
    { '<A-down>', ':MoveBlock(1)<CR>',  mode = 'v', noremap = true, silent = true },
  },

  opts = {
    line = {
      enable = true, -- Enables line movement
      indent = true, -- Toggles indentation
    },
    block = {
      enable = true, -- Enables block movement
      indent = true, -- Toggles indentation
    },
    word = {
      enable = false, -- Enables word movement
    },
    char = {
      enable = false, -- Enables char movement
    },
  }
}
