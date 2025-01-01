vim.keymap.set({ "n" }, "<S-A-Up>"   ,"<CMD>LineDuplicate -1<CR>")
vim.keymap.set({ "n" }, "<S-A-Down>" ,"<CMD>LineDuplicate +1<CR>")

vim.keymap.set({ "v" }, "<S-A-Up>"   ,"<CMD>VisualDuplicate -1<CR>")
vim.keymap.set({ "v" }, "<S-A-Down>" ,"<CMD>VisualDuplicate +1<CR>")
