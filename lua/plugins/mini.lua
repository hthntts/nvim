-- Collection of various small independent plugins/modules
return {
  {
    'echasnovski/mini.nvim',
    event = 'VeryLazy',
    config = function()
      -- Better Around/Inside textobjects
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      require('mini.cursorword').setup { delay = 100 }

      require('mini.indentscope').setup({
        symbol = '▏',
        mappings = {
          object_scope = 'iI',
          object_scope_with_border = 'aI',
          goto_top = '[I',
          goto_bottom = ']I',
        },
        options = {
          border = 'both',
        },
      })
      local augroup = vim.api.nvim_create_augroup('MiniIndentScope', {})
      vim.api.nvim_create_autocmd('FileType', {
        pattern = require('plugins.indent-blankline.config').disabled_filetypes,
        group = augroup,
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
