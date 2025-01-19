-- Collection of various small independent plugins/modules
return {
  {
    'echasnovski/mini.nvim',
    event = 'VeryLazy',
    config = function()
      -- Better Around/Inside textobjects
      --  - va)  - [V]isually select [A]round [)]paren
      --  - vana - [V]isually select [A]round [N]ext [A]round
      --  - vala - [V]isually select [A]round [L]ast [A]round
      --  - ci'  - [C]hange [I]nside [']quote
      --  - cina - [C]hange [I]nside [N]ext [A]round
      --  - cila - [C]hange [I]nside [L]ast [A]round
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - yilq - [Y]ank [I]nside [L]ast [Q]uote

      -- Enhanced: [ { ( "aa" 'bb' 'cc' ) } ]
      --  - vaq aq aq ab ab

      -- New ones: f(aa, g(bb, cc))
      --  - via aa if af

      -- Default: 1aa_bb_cc1 dd
      --  - da_ di1 da_

      -- (
      --   (aa) (bb) (cc)
      -- ) (dd)
      -- va) a) a) a)
      -- van) in) al) il)
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - saiwf - [S]urround [A]dd [I]nner [W]ord [F]unction
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sdq   - [S]urround [D]elete [Q]uotes
      -- - sdf   - [S]urround [D]elete [F]unction
      -- - sr)'  - [S]urround [R]eplace [)] [']
      -- - srn)' - [S]urround [R]eplace [N]ext [)] [']
      -- - srl)' - [S]urround [R]eplace [L]ast [)] [']
      -- - srff' - [S]urround [R]eplace [F]unction to new [F]unction
      -- - srn{{ - [S]urround Add inner space
      require('mini.surround').setup()

      -- - griw  - [R]eplaces [I]nner [W]ord with register
      -- - grr   - [R]eplaces current line with register
      -- - gmiw  - multiple/duplicate [I]nner [W]ord
      -- - gmm   - duplicate line
      -- - gxiw  - e[X]change two regions [I]nner [W]ord
      -- - gxina - e[X]change two regions [I]nner [N]ext
      -- - gxina - e[X]change two regions [I]nner [L]ast
      -- - gxx   - e[X]change two line
      -- - g=ina - evaluate region [I]nner [N]ext
      -- - g==
      -- - gsin) - [S]ort [I]ner [N]ext [)]Paren
      -- - gsil) - [S]ort [I]ner [L]ast [)]Paren
      -- - gsip
      require('mini.operators').setup()

      require('mini.jump2d').setup({ mappings = { start_jumping = '<F1>' } })

      require('mini.files').setup()

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
