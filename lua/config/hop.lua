local map = vim.keymap.set

local hop = require("hop")
hop.setup {
  case_insensitive = true,
  char2_fallback_key = "<CR>",
  quit_key = "<Esc>",
  match_mappings = { "zh_sc" },
}

map({ "n", "v", "o" }, "f", "", {
  silent = true,
  noremap = true,
  callback = function()
    hop.hint_char2()
  end,
  desc = "Hop 2 char",
})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd([[
      hi HopNextKey cterm=bold ctermfg=176 gui=bold guibg=#ff00ff guifg=#ffffff
      hi HopNextKey1 cterm=bold ctermfg=176 gui=bold guibg=#ff00ff guifg=#ffffff
      hi HopNextKey2 cterm=bold ctermfg=176 gui=bold guibg=#ff00ff guifg=#ffffff
    ]])
  end,
})
