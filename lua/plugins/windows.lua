return {
  'anuvyklack/windows.nvim',
  dependencies = 'anuvyklack/middleclass',
  event = 'WinEnter',
  config = function()
    require('windows').setup({
      animation = { enable = false },
      ignore = {
        buftype = { 'quickfix', 'help' },
        filetype = { '', 'toggleterm', 'neotest-summary', 'blame' },
      },
    })

    local map = require('core.utils').map
    local commands = require('windows.commands')
    map('n', '<leader>wm', commands.maximize, 'Maximized window')
  end
}
