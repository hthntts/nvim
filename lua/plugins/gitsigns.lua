return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  config = function()
    local gs = require('gitsigns')

    gs.setup({
      signs = {
        add = { text = ' ▎' },
        change = { text = ' ▎' },
        delete = { text = ' ' },
        topdelete = { text = ' ' },
        changedelete = { text = '~' },
        untracked = { text = '▎ ' },
      },

      signs_staged = {
        add = { text = ' ▎' },
        change = { text = ' ▎' },
        delete = { text = ' ' },
        topdelete = { text = ' ' },
        changedelete = { text = '~' },
        untracked = { text = '▎ ' },
      },

      signs_staged_enable = true,
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = true,  -- Toggle with `:Gitsigns toggle_word_diff`

      watch_gitdir = {
        follow_files = true,
      },

      attach_to_untracked = false,

      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- Options: 'eol', 'overlay', 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },

      current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,  -- Use default formatter
      max_file_length = 40000, -- Disable if file exceeds this line length

      preview_config = {
        -- Options for `nvim_open_win`
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
      },

      on_attach = function(bufnr)
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', '<leader>g]', function()
          if vim.wo.diff then
            return '<leader>g]'
          end
          vim.schedule(function()
            gs.nav_hunk('next')
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to next hunk' })

        map('n', '<leader>g[', function()
          if vim.wo.diff then
            return '<leader>g['
          end
          vim.schedule(function()
            gs.nav_hunk('prev')
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to previous hunk' })

        -- Actions
        map('n', '<leader>gB', gs.blame, { expr = true, desc = 'Git blame' })
        map('n', '<leader>gd', function() gs.diffthis('~') end, { expr = true, desc = 'Git file (diff)' })
        map('n', '<leader>tD', gs.toggle_deleted, { expr = true, desc = 'Toggle (git) line delete' })
        map('n', '<leader>tb', gs.toggle_current_line_blame, { expr = true, desc = 'Toggle (git) line blame' })
        -- map('n', '<leader>gf', gs.preview_hunk)
        -- map('n', '<leader>gf', gs.reset_buffer)
        -- map('n', '<leader>gf', gs.reset_hunk)
        -- map('n', '<leader>gf', gs.stage_buffer)
        -- map('n', '<leader>gf', gs.stage_hunk)
        -- map('n', '<leader>gf', gs.undo_stage_hunk)
        -- map('n', '<leader>gf', function() gs.blame_line({ full = true }) end)
        -- map('v', '<leader>gf', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
        -- map('v', '<leader>gf', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
      end,
    })

    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = '*',
      callback = function()
        vim.cmd([[
      hi GitSignsChangeInline gui=reverse
      hi GitSignsAddInline gui=reverse
      hi GitSignsDeleteInline gui=reverse
    ]])
      end,
    })
  end,
}
