return {
  'jinh0/eyeliner.nvim',
  -- keys = { 't', 'f', 'T', 'F' },
  config = function()
    require 'eyeliner'.setup {
      highlight_on_key = true,
      dim = true,
      default_keymaps = false,
    }
    vim.api.nvim_set_hl(0, 'EyelinerPrimary', { bold = true, underline = true })
    vim.api.nvim_set_hl(0, 'EyelinerSecondary', { underline = true })
  end
}
