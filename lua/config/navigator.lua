require("Navigator").setup {
  auto_save = 'current',
  disable_on_zoom = false,
  mux = 'auto',
}

if vim.fn.exists('$TMUX') == 1 then
  keymap.set({"n", "i", "x"}, "<A-h>", "<cmd>NavigatorLeft<cr>", { silent = true, desc = "Navigator Left" })
  keymap.set({"n", "i", "x"}, "<A-j>", "<cmd>NavigatorDown<cr>", { silent = true, desc = "Navigator Down" })
  keymap.set({"n", "i", "x"}, "<A-k>", "<cmd>NavigatorUp<cr>", { silent = true, desc = "Navigator Up" })
  keymap.set({"n", "i", "x"}, "<A-l>", "<cmd>NavigatorRight<cr>", { silent = true, desc = "Navigator Right" })
end
