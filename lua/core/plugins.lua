local map = require('core/utils').map

-- Install lazy.nvim if it's missing
local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazy_path) then
  vim.notify('Installing lazy.nvim...')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    'https://github.com/folke/lazy.nvim.git',
    lazy_path,
  })
end
vim.opt.rtp:prepend(lazy_path)

map('n', '<leader>lz', '<cmd>Lazy<CR>', 'Open lazy UI')
map('n', '<leader>li', '<cmd>Lazy install<CR>', 'Lazy install')
map('n', '<leader>lu', '<cmd>Lazy update<CR>', 'Lazy update')
map('n', '<leader>lc', '<cmd>Lazy clean<CR>', 'Lazy clean')
map('n', '<leader>lp', '<cmd>Lazy profile<CR>', 'Lazy profile')
map('n', '<leader>ls', '<cmd>Lazy sync<CR>', 'Lazy sync')
