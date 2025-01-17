return {
  'freddiehaddad/feline.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/lsp-status.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local colorscheme = require('core.colorscheme')
    local default_theme = colorscheme.get_default_feline_highlights()

    require('core.statusline').setup({ theme = default_theme })
    require('feline').add_theme('onedark', default_theme)

    -- require('feline').setup()
    -- require('feline').winbar.setup()       -- to use winbar
    -- require('feline').statuscolumn.setup() -- to use statuscolumn
    vim.opt.laststatus = 3 -- Global statusline
  end
}
