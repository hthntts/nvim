-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
  "lewis6991/gitsigns.nvim",
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
        map("n", "<leader>gp", gs.preview_hunk, { expr = true, desc = "[p]review hunk" })
        map("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, { expr = true, desc = "[b]lame line" })
        -- map('n', '<leader>gshD', function() gs.diffthis('~') end)
        -- map('n', '<leader>gshR', gs.reset_buffer)
        -- map('n', '<leader>gshS', gs.stage_buffer)
        -- map('n', '<leader>gshb', function() gs.blame_line { full = true } end)
        -- map('n', '<leader>gshd', gs.diffthis)
        -- map('n', '<leader>gshp', gs.preview_hunk)
        -- map('n', '<leader>gshr', gs.reset_hunk)
        -- map('n', '<leader>gshs', gs.stage_hunk)
        -- map('n', '<leader>gshu', gs.undo_stage_hunk)
        -- map('n', '<leader>gstb', gs.toggle_current_line_blame)
        -- map('n', '<leader>gstd', gs.toggle_deleted)
        -- map('v', '<leader>gshr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
        -- map('v', '<leader>gshs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
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
