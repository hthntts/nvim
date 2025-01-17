return {
  'hinell/duplicate.nvim',
  cmd = {
    'LineDuplicate',
    'VisualDuplicate'
  },
  keys = {
    { '<S-A-up>',   '<cmd>LineDuplicate -1<CR>',   mode = 'n' },
    { '<S-A-down>', '<cmd>LineDuplicate +1<CR>',   mode = 'n' },

    { '<S-A-up>',   '<cmd>VisualDuplicate -1<cr>', mode = 'v' },
    { '<S-A-down>', '<cmd>VisualDuplicate +1<cr>', mode = 'v' },
  },
}
