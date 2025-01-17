return {
  'stevearc/oil.nvim',
  event = 'VeryLazy',
  dependencies = 'echasnovski/mini.icons',
  cmd = 'Oil',
  keys = {
    { '<leader>oo', '<cmd>Oil<cr>', desc = 'Oil' },
  },
  opts = {
    delete_to_trash = true,
    keymaps = {
      ['?'] = { 'actions.show_help', mode = 'n' },
      ['q'] = { 'actions.close', mode = 'n' },
    },
  },
}
