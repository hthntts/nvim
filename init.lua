vim.loader.enable()
local utils = require('core.utils')
local use = utils.use
utils.is_compatible_version('0.10.2')

require('core.globals')
require('core.options')
require('core.autocmd')
require('core.keymaps')
require('core.plugins')

local plugins = {
  'folke/lazy.nvim',
  use 'onenord',
  use 'eunuch',
  use 'easy-align',
  use 'windows',
  use 'telescope',
  use 'treesitter',
  use 'lsp',
  use 'autocompletion',
  use 'none-ls',
  use 'neogit',
  use 'git-conflict',
  use 'gitsigns',
  use 'gitlinker',
  use 'lazygit',
  use 'lualine',
  use 'bufferline',
  use 'hlslens',
  use 'neo-tree',
  use 'fern',
  use 'oil',
  use 'dashboard',
  use 'indent-blankline',
  use 'comment',
  use 'debug',
  use 'database',
  use 'misc',
  use 'gx',
  use 'move',
  use 'duplicate',
  use 'multicursors',
  use 'navbuddy',
  use 'toggleterm',
  use 'ufo',
  use 'markdown',
  use 'notify',
  use 'statuscol',
  use 'which-key',
  use 'tmux',
  -- use 'avante',
}

require('lazy').setup({
  spec = plugins,
  install = {
    colorscheme = { 'onenord' },
  },
  performance = {
    rtp = {
      disabled_plugins = { 'netrwPlugin', 'tutor' },
    },
  },
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      loaded = ' ',
      not_loaded = ' ',
    },
  },
})

local session_file = ".session.vim"
if utils.file_exists(session_file) then
  vim.cmd('source ' .. session_file)
end

local config_file = '~/.config/nvim/plugins/config.vim'
vim.cmd('source ' .. config_file)
