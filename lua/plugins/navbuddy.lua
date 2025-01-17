local map = require('core.utils').map

return {
  'SmiteshP/nvim-navbuddy',
  event = 'VeryLazy',
  dependencies = {
    'SmiteshP/nvim-navic',
    'MunifTanjim/nui.nvim'
  },
  opts = {
    window = {
      border = 'rounded',
      size = { height = '40%', width = '100%' },
      position = { row = '96%', col = '50%' },
    },
    node_markers = {
      enabled = true,
      icons = {
        leaf          = '  ',
        leaf_selected = ' → ',
        branch        = '  ',
      },
    },
    icons = {
      File = ' ',
      Module = ' ',
      Namespace = ' ',
      Package = ' ',
      Class = ' ',
      Method = ' ',
      Property = ' ',
      Field = ' ',
      Constructor = ' ',
      Enum = ' ',
      Interface = ' ',
      Function = ' ',
      Variable = ' ',
      Constant = ' ',
      String = ' ',
      Number = ' ',
      Boolean = ' ',
      Array = ' ',
      Object = ' ',
      Key = ' ',
      Null = ' ',
      EnumMember = ' ',
      Struct = ' ',
      Event = ' ',
      Operator = ' ',
      TypeParameter = ' ',
    },
    lsp = { auto_attach = true },
  },
  map('n', '<leader>sn', '<cmd>Navbuddy<cr>', 'Navbuddy'),
}
