return {
  'lambdalisue/vim-fern',
  lazy = true,
  keys = {
    { '<leader>oF', '<cmd>Fern . -drawer -reveal=% -toggle -width=40<cr>', desc = 'Fern' },
    { '<M-g>',      '<cmd>Fern . -drawer -reveal=% -toggle -width=40<cr>', desc = 'Fern' },
  },
  config = function()
    vim.api.nvim_create_augroup('vimrc', {})
    vim.api.nvim_create_autocmd('WinEnter', {
      callback = function()
        if (vim.bo.filetype ~= 'fern') then
          vim.cmd('FernDo close -stay')
        end
      end,
    })
  end,
}
