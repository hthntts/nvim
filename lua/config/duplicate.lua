local map = vim.keymap.set

map({ "n" }, "<S-A-Up>"   ,"<CMD>LineDuplicate -1<CR>")
map({ "n" }, "<S-A-Down>" ,"<CMD>LineDuplicate +1<CR>")
map({ "v" }, "<S-A-Up>"   ,"<CMD>VisualDuplicate -1<CR>")
map({ "v" }, "<S-A-Down>" ,"<CMD>VisualDuplicate +1<CR>")
