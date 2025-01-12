-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
  "lewis6991/gitsigns.nvim",
  event = 'BufReadPre',
  config = function()
    local gs = require("gitsigns")
    gs.setup({
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "│" },
      },
      word_diff = true,
      on_attach = function(bufnr)
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.nav_hunk('next')
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Next hunk" })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.nav_hunk('prev')
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Previous hunk" })

        -- Actions
        map("n", "<leader>gB", gs.blame, { expr = true, desc = "Blame" })
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, { expr = true, desc = "Blame line" })
        map("n", "<leader>gp", gs.preview_hunk, { expr = true, desc = "Preview hunk" })
        map('n', '<leader>gd', function() gs.diffthis('~') end, { expr = true, desc = "Different current file" })
        map('n', '<leader>tb', gs.toggle_current_line_blame, { expr = true, desc = "Toggle (git) line blame" })
        map('n', '<leader>td', gs.toggle_deleted, { expr = true, desc = "Toggle (git) line delete" })
        -- map('n', '<leader>gf', gs.diffthis)
        -- map('n', '<leader>gf', gs.reset_buffer)
        -- map('n', '<leader>gf', gs.reset_hunk)
        -- map('n', '<leader>gf', gs.stage_buffer)
        -- map('n', '<leader>gf', gs.stage_hunk)
        -- map('n', '<leader>gf', gs.undo_stage_hunk)
        -- map('v', '<leader>gf', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
        -- map('v', '<leader>gf', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
      end,
    })

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
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
