return {
  'chrishrb/gx.nvim',
  event = 'VeryLazy',
  dependencies = 'nvim-lua/plenary.nvim',
  cmd = 'Browse',
  keys = {
    { '<leader>ob', '<cmd>Browse<cr>', mode = { 'n', 'x' }, desc = 'Open link (search current word)' },
  },
  opts = {
    handlers = { search = true },
    -- handler_options = { search_engine = 'duckduckgo' },
  },
  init = function()
    vim.g.netrw_nogx = 1 -- disable netrw gx
  end,
  enabled = function()
    if vim.g.is_win or vim.g.is_mac then
      return true
    else
      return false
    end
  end,
  config = true,      -- default settings
  submodules = false, -- not needed, submodules are required only for tests
}
