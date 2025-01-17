return {
  'jinh0/eyeliner.nvim',
  keys = { 't', 'f', 'T', 'F' },
  config = function()
    require 'eyeliner'.setup {
      highlight_on_key = true,
      dim = true,
    }
    -- vim.api.nvim_set_hl(0, 'EyelinerPrimary', { fg = '#a6e3a1', bold = true, underline = true })
    -- vim.api.nvim_set_hl(0, 'EyelinerSecondary', { fg = '#f9e2af', underline = true })
  end
}
