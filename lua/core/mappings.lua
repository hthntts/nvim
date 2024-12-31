keymap = vim.keymap
local uv = vim.uv

-- Save key strokes (now we do not need to press shift to enter command mode).
keymap.set({ "n", "x" }, ";", ":")

-- Turn the word under cursor to upper case
keymap.set("i", "<c-u>", "<Esc>viwUea")

-- Turn the current word into title case
keymap.set("i", "<c-t>", "<Esc>b~lea")

-- Paste non-linewise text above or below current line, see https://stackoverflow.com/a/1346777/6064933
keymap.set("n", "<leader>lp", "m`o<ESC>p``", { desc = "Paste below current line" })
keymap.set("n", "<leader>lP", "m`O<ESC>p``", { desc = "Paste above current line" })
--
-- Clear search, diff update and redraw
keymap.set({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and clear hlsearch' })

-- Shortcut for faster save and quit
keymap.set("n", "<leader>fs", "<cmd>update<cr>", { silent = true, desc = "Save file" })
keymap.set("n", "<c-x><c-s>", "<cmd>update<cr>", { silent = true, desc = "Save file" })

-- Saves the file if modified and quit
keymap.set("n", "<leader>qq", "<cmd>q<cr>", { silent = true, desc = "Quit Nvim" })

-- Quit all opened buffers
keymap.set("n", "<leader>qQ", "<cmd>qa!<cr>", { silent = true, desc = "Quit Nvim without saving" })

-- Navigation in the location and quickfix list
keymap.set("n", "[l", "<cmd>lprevious<cr>zv", { silent = true, desc = "Previous location item" })
keymap.set("n", "]l", "<cmd>lnext<cr>zv", { silent = true, desc = "Next location item" })

keymap.set("n", "[L", "<cmd>lfirst<cr>zv", { silent = true, desc = "First location item" })
keymap.set("n", "]L", "<cmd>llast<cr>zv", { silent = true, desc = "Last location item" })

keymap.set("n", "[q", "<cmd>cprevious<cr>zv", { silent = true, desc = "Previous qf item" })
keymap.set("n", "]q", "<cmd>cnext<cr>zv", { silent = true, desc = "Next qf item" })

keymap.set("n", "[Q", "<cmd>cfirst<cr>zv", { silent = true, desc = "First qf item" })
keymap.set("n", "]Q", "<cmd>clast<cr>zv", { silent = true, desc = "Last qf item" })

-- Close location list or quickfix list if they are present, see https://superuser.com/q/355325/736190
keymap.set("n", [[\x]], "<cmd>windo lclose <bar> cclose <cr>", {
  silent = true,
  desc = "Close qf and location list",
})

-- Delete a buffer, without closing the window, see https://stackoverflow.com/q/4465095/6064933
-- keymap.set("n", [[\d]], "<cmd>bprevious <bar> bdelete #<cr>", {
keymap.set("n", "<leader>bd", "<cmd>bd<cr>", {
  silent = true,
  desc = "Kill buffer",
})

-- keymap.set("n", "<leader>bO", function()
--   local buf_ids = vim.api.nvim_list_bufs()
--   local cur_buf = vim.api.nvim_win_get_buf(0)
--
--   for _, buf_id in pairs(buf_ids) do
--     -- do not Delete unlisted buffers, which may lead to unexpected errors
--     if vim.api.nvim_get_option_value("buflisted", { buf = buf_id }) and buf_id ~= cur_buf then
--       vim.api.nvim_buf_delete(buf_id, { force = true })
--     end
--   end
-- end, {
--   desc = "delete other buffers",
-- })

-- Insert a blank line below or above current line (do not move the cursor),
-- see https://stackoverflow.com/a/16136133/6064933
keymap.set("n", "<leader>lo", "printf('m`%so<ESC>``', v:count1)", {
  expr = true,
  desc = "Insert blank line below",
})

keymap.set("n", "<leader>lO", "printf('m`%sO<ESC>``', v:count1)", {
  expr = true,
  desc = "Insert blank line above",
})

-- Move the cursor based on physical lines, not the actual lines.
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap.set("n", "^", "g^")

-- Do not include white space characters when using $ in visual mode,
-- see https://vi.stackexchange.com/q/12607/15292
keymap.set("x", "$", "g_")

-- Go to start or end of line easier
keymap.set({ "n", "x" }, "H", "^")
keymap.set({ "n", "x" }, "L", "g_")

-- Continuous visual shifting (does not exit Visual mode), `gv` means
-- to reselect previous visual area, see https://superuser.com/q/310417/736190
keymap.set("x", "<", "<gv")
keymap.set("x", ">", ">gv")

-- Edit and reload nvim config file quickly
keymap.set("n", "<leader>hdo", "<cmd>tabnew $MYVIMRC <bar> tcd %:h<cr>", {
  silent = true,
  desc = "Open init.lua",
})

keymap.set("n", "<leader>hdr", function()
  vim.cmd([[
      update $MYVIMRC
      source $MYVIMRC
    ]])
  vim.notify("Nvim config successfully reloaded!", vim.log.levels.INFO, { title = "nvim-config" })
end, {
  silent = true,
  desc = "Reload init.lua",
})

-- Reselect the text that has just been pasted, see also https://stackoverflow.com/a/4317090/6064933.
keymap.set("n", "<leader>br", "printf('`[%s`]', getregtype()[0])", {
  expr = true,
  desc = "Reselect last pasted area",
})

-- Always use very magic mode for searching
keymap.set("n", "/", [[/\v]])

-- Change current working directory locally and print cwd after that,
-- see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
keymap.set("n", "<leader>fc", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", { desc = "Change cd" })

-- Use Esc to quit builtin terminal
keymap.set("t", "<Esc>", [[<c-\><c-n>]])

-- Toggle spell checking
keymap.set("n", "<F11>", "<cmd>set spell!<cr>", { desc = "toggle spell" })
keymap.set("i", "<F11>", "<c-o><cmd>set spell!<cr>", { desc = "toggle spell" })

-- Change text without putting it into the vim register,
-- see https://stackoverflow.com/q/54255/6064933
keymap.set("n", "c", '"_c')
keymap.set("n", "C", '"_C')
keymap.set("x", "c", '"_c')

-- Remove trailing whitespace characters
keymap.set("n", "<leader>bR", "<cmd>StripTrailingWhitespace<cr>", { desc = "Remove trailing space" })

-- check the syntax group of current cursor position
keymap.set("n", "<leader>ts", "<cmd>call utils#SynGroup()<cr>", { desc = "Syntax group" })

-- Copy entire buffer.
keymap.set("n", "<leader>by", "<cmd>%yank<cr>", { desc = "Yank buffer" })

-- Toggle cursor column
keymap.set("n", "<leader>tc", "<cmd>call utils#ToggleCursorCol()<cr>", { desc = "Cursor column" })

-- Replace visual selection with text in register, but not contaminate the register,
-- see also https://stackoverflow.com/q/10723700/6064933.
keymap.set("x", "p", '"_c<Esc>p')

-- Go to a certain buffer
keymap.set("n", "<leader>bn", '<cmd>call utils#GoToBuffer(v:count, "forward")<cr>', {
  desc = "Next buffer",
})
keymap.set("n", "<leader>bp", '<cmd>call utils#GoToBuffer(v:count, "backward")<cr>', {
  desc = "Previous buffer",
})
-- Editer Next and Previous (VSCode)
keymap.set("n", "<A-D-Right>", '<cmd>call utils#GoToBuffer(v:count, "forward")<cr>', {
  desc = "Next buffer",
})
keymap.set("n", "<A-D-Left>", '<cmd>call utils#GoToBuffer(v:count, "backward")<cr>', {
  desc = "Previous buffer",
})

-- Switch windows
-- keymap.set("n", "<left>", "<c-w>h")
-- keymap.set("n", "<Right>", "<C-W>l")
-- keymap.set("n", "<Up>", "<C-W>k")
-- keymap.set("n", "<Down>", "<C-W>j")

-- Text objects for URL
keymap.set({ "x", "o" }, "iu", "<cmd>call utils#TextObjURL()<cr>", { desc = "URL text object" })

-- Text objects for entire buffer (VScode)
keymap.set("n", "<c-x>h", "<cmd>call utils#MarkWholeBuffer()<cr>", { desc = "Mark whole buffer" })
keymap.set("n", "<leader>ba", "<cmd>call utils#MarkWholeBuffer()<cr>", { desc = "Mark whole buffer" })

-- Do not move my cursor when joining lines.
keymap.set("n", "J", function()
  vim.cmd([[
      normal! mzJ`z
      delmarks z
    ]])
end, {
  desc = "Join lines without moving cursor",
})

keymap.set("n", "gJ", function()
  -- we must use `normal!`, otherwise it will trigger recursive mapping
  vim.cmd([[
      normal! mzgJ`z
      delmarks z
    ]])
end, {
  desc = "Join lines without moving cursor",
})

-- Break inserted text into smaller undo units when we insert some punctuation chars.
local undo_ch = { ",", ".", "!", "?", ";", ":" }
for _, ch in ipairs(undo_ch) do
  keymap.set("i", ch, ch .. "<c-g>u")
end

-- insert semicolon in the end
keymap.set("i", "<A-;>", "<Esc>miA;<Esc>`ii")

-- Go to the beginning and end of current line in insert mode quickly
keymap.set("i", "<C-A>", "<HOME>")
keymap.set("i", "<C-E>", "<END>")

-- Go to beginning of command in command-line mode
keymap.set("c", "<C-A>", "<HOME>")

-- Delete the character to the right of the cursor
keymap.set("i", "<C-D>", "<DEL>")

keymap.set("n", "<leader>tl", function()
  local cnt = 0
  local blink_times = 9
  local timer = uv.new_timer()
  if timer == nil then
    return
  end

  timer:start(
    0,
    100,
    vim.schedule_wrap(function()
      vim.cmd([[
      set cursorcolumn!
      set cursorline!
    ]])

      if cnt == blink_times then
        timer:close()
      end

      cnt = cnt + 1
    end)
  )
end, { desc = "Cursor localtion" })

if vim.fn.exists('$TMUX') == 1 then
    keymap.set({"n", "i", "x"}, "<A-h>", "<cmd>NavigatorLeft<cr>", { silent = true, desc = "Navigator Left" })
    keymap.set({"n", "i", "x"}, "<A-j>", "<cmd>NavigatorDown<cr>", { silent = true, desc = "Navigator Down" })
    keymap.set({"n", "i", "x"}, "<A-k>", "<cmd>NavigatorUp<cr>", { silent = true, desc = "Navigator Up" })
    keymap.set({"n", "i", "x"}, "<A-l>", "<cmd>NavigatorRight<cr>", { silent = true, desc = "Navigator Right" })
end
