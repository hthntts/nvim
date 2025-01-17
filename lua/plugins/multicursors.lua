return {
  'smoka7/multicursors.nvim',
  event = 'VeryLazy',
  dependencies = 'nvimtools/hydra.nvim',
  cmd = {
    'MCstart',
    'MCvisual',
    'MCclear',
    'MCpattern',
    'MCvisualPattern',
    'MCunderCursor'
  },
  keys = {
    {
      mode = { 'v', 'n' },
      '<M-d>',
      '<cmd>MCvisual<cr>',
      desc = 'Multi Cursors',
    },
  },
  opts = {
    hint_config = {
      float_opts = {
        border = 'rounded',
      },
      position = 'bottom-right',
    },
    generate_hints = {
      normal = true,
      insert = true,
      extend = true,
      config = {
        column_count = 1,
      },
    }
  },
}
