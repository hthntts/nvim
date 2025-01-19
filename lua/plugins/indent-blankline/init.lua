return {
  'lukas-reineke/indent-blankline.nvim',
  event = 'BufReadPre',
  config = function()
    local api = vim.api

    require('ibl').setup({
      whitespace = { highlight = { 'Whitespace', 'NonText' } },
      indent = {
        char = '▏',
      },
      scope = {
        show_start = false,
        show_end = false,
      },
      exclude = {
        filetypes = require('plugins.indent-blankline.config').disabled_filetypes,
        buftypes = { 'fzf', 'help', 'terminal', 'nofile' },
      },
    })

    -- Don't show lines on the first indent level
    local hooks, builtin = require('ibl.hooks'), require('ibl.hooks').builtin
    hooks.register(hooks.type.WHITESPACE, builtin.hide_first_space_indent_level)
    hooks.register(hooks.type.WHITESPACE, builtin.hide_first_tab_indent_level)

    local gid = api.nvim_create_augroup('indent_blankline', { clear = true })
    api.nvim_create_autocmd('InsertEnter', {
      pattern = '*',
      group = gid,
      command = 'IBLDisable',
    })

    api.nvim_create_autocmd('InsertLeave', {
      pattern = '*',
      group = gid,
      callback = function()
        if not vim.tbl_contains(require('plugins.indent-blankline.config').disabled_filetypes, vim.bo.filetype) then
          vim.cmd([[IBLEnable]])
        end
      end,
    })
  end,
}
