keymap = vim.keymap
local uv = vim.uv

local function toggle_cursor_location()
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
end

local function join_lines()
  vim.cmd([[
      normal! mzJ`z
      delmarks z
    ]])
end

local function reload_nvim()
  vim.cmd([[
      update $MYVIMRC
      source $MYVIMRC
    ]])
  vim.notify("Nvim config successfully reloaded!", vim.log.levels.INFO, { title = "nvim-config" })
end

local function delete_other_buffers()
  local buf_ids = vim.api.nvim_list_bufs()
  local cur_buf = vim.api.nvim_win_get_buf(0)

  for _, buf_id in pairs(buf_ids) do
    -- do not Delete unlisted buffers, which may lead to unexpected errors
    if vim.api.nvim_get_option_value("buflisted", { buf = buf_id }) and buf_id ~= cur_buf then
      vim.api.nvim_buf_delete(buf_id, { force = true })
    end
  end
end

-- Use Esc to quit builtin terminal.
keymap.set("t", "<Esc>", [[<c-\><c-n>]])

-- Go to beginning of command in command-line mode.
keymap.set("c", "<C-A>", "<HOME>")

-- Save key strokes (do not need to press shift to enter command mode).
keymap.set({ "x", "n" }, ";", ":")

-- Replace visual selection with text in register, but not contaminate the register.
-- see also https://stackoverflow.com/q/10723700/6064933.
keymap.set("x", "p", '"_c<Esc>p')

-- Text objects for URL.
keymap.set({ "x", "o" }, "iu", "<cmd>call utils#TextObjURL()<cr>", { desc = "URL text object" })

-- Do not include white space characters when using $ in visual mode.
-- see https://vi.stackexchange.com/q/12607/15292
keymap.set("x", "$", "g_")

-- Continuous visual shifting (does not exit Visual mode), `gv` means
-- to reselect previous visual area, see https://superuser.com/q/310417/736190
keymap.set("x", "<", "<gv")
keymap.set("x", ">", ">gv")

-- Clear search, diff update and redraw.
keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Turn the word under cursor to upper case.
keymap.set("i", "<c-u>", "<Esc>viwUea", { desc = "Turn word to Upper case" })

-- Turn the current word into title case.
keymap.set("i", "<c-t>", "<Esc>b~lea", { desc = "Turn current word into Title case" })

-- Insert semicolon in the end.
keymap.set("i", "<A-;>", "<Esc>miA;<Esc>`ii", { desc = "Insert semicolon in the end" })

-- Insert semicolon in the end.
keymap.set("i", "<A-.>", "<Esc>miA.<Esc>`ii", { desc = "Insert dot in the end" })

-- Go to the beginning and end of current line in insert mode quickly.
keymap.set("i", "<C-A>", "<HOME>")
keymap.set("i", "<C-E>", "<END>")

-- Delete the character to the right of the cursor.
keymap.set("i", "<C-D>", "<DEL>")

-- Toggle spell checking.
keymap.set("i", "<F11>", "<c-o><cmd>set spell!<cr>", { desc = "Toggle spell" })
keymap.set("n", "<F11>", "<cmd>set spell!<cr>", { desc = "Toggle spell" })

-- Change text without putting it into the vim register.
-- see https://stackoverflow.com/q/54255/6064933
keymap.set("x", "c", '"_c')
keymap.set("n", "c", '"_c')
keymap.set("n", "C", '"_C')

-- Go to start or end of line easier.
keymap.set({ "n", "x" }, "H", "^")
keymap.set({ "n", "x" }, "L", "g_")

-- Move the cursor based on physical lines, not the actual lines.
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap.set("n", "^", "g^")

-- Always use very magic mode for searching.
keymap.set("n", "/", [[/\v]])

-- Join lines.
keymap.set("n", "J", join_lines, { desc = "Join lines without moving cursor"  })

-- Navigation in the location and quickfix list.
keymap.set("n", "[l", "<cmd>lprevious<cr>zv", { silent = true, desc = "Previous location item" })
keymap.set("n", "]l", "<cmd>lnext<cr>zv", { silent = true, desc = "Next location item" })

keymap.set("n", "[L", "<cmd>lfirst<cr>zv", { silent = true, desc = "First location item" })
keymap.set("n", "]L", "<cmd>llast<cr>zv", { silent = true, desc = "Last location item" })

keymap.set("n", "[q", "<cmd>cprevious<cr>zv", { silent = true, desc = "Previous qf item" })
keymap.set("n", "]q", "<cmd>cnext<cr>zv", { silent = true, desc = "Next qf item" })

keymap.set("n", "[Q", "<cmd>cfirst<cr>zv", { silent = true, desc = "First qf item" })
keymap.set("n", "]Q", "<cmd>clast<cr>zv", { silent = true, desc = "Last qf item" })

-- Text objects for entire buffer
keymap.set("n", "<leader>ba", "<cmd>call utils#MarkWholeBuffer()<cr>", { desc = "Mark whole buffer" })
keymap.set("n", "<M-a>", "<cmd>call utils#MarkWholeBuffer()<cr>", { desc = "Mark whole buffer" })
keymap.set("n", "<c-x>h", "<cmd>call utils#MarkWholeBuffer()<cr>", { desc = "Mark whole buffer" })

-- Delete a buffer, without closing the window.
-- see https://stackoverflow.com/q/4465095/6064933
keymap.set("n", "<leader>bd", "<cmd>bprevious <bar> bdelete #<cr>", {
  silent = true,
  desc = "Kill buffer",
})
-- keymap.set("n", "<leader>bd", "<cmd>bd<cr>", { silent = true, desc = "Kill buffer" })

-- Reselect the text that has just been pasted.
-- see https://stackoverflow.com/a/4317090/6064933.
keymap.set("n", "<leader>br", "printf('`[%s`]', getregtype()[0])", { expr = true, desc = "Reselect last pasted area" })

-- Remove trailing whitespace characters
keymap.set("n", "<leader>bR", "<cmd>StripTrailingWhitespace<cr>", { desc = "Remove trailing space" })

-- Delete other buffers.
keymap.set("n", "<leader>bO", delete_other_buffers, { desc = "Delete other buffers"  })

-- Go to a certain buffer.
keymap.set("n", "<leader>bn", '<cmd>call utils#GoToBuffer(v:count, "forward")<cr>', { desc = "Next buffer" })
keymap.set("n", "<leader>bp", '<cmd>call utils#GoToBuffer(v:count, "backward")<cr>', { desc = "Previous buffer" })
keymap.set("n", "<A-D-Right>", '<cmd>call utils#GoToBuffer(v:count, "forward")<cr>', { desc = "Next buffer" })
keymap.set("n", "<A-D-Left>", '<cmd>call utils#GoToBuffer(v:count, "backward")<cr>', { desc = "Previous buffer" })

-- Copy entire buffer.
keymap.set("n", "<leader>by", "<cmd>%yank<cr>", { desc = "Yank buffer" })

-- Change current working directory locally and print cwd after that.
-- see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
keymap.set("n", "<leader>fc", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", { desc = "Change cd" })

-- Shortcut for faster save and quit.
keymap.set("n", "<leader>fs", "<cmd>update<cr>", { silent = true, desc = "Save file" })
keymap.set("n", "<c-x><c-s>", "<cmd>update<cr>", { silent = true, desc = "Save file" })

-- Reload config.
keymap.set("n", "<leader>hdr", reload_nvim, { silent = true, desc = "Reload config"  })

-- Paste non-linewise text above or below current line.
-- see https://stackoverflow.com/a/1346777/6064933
keymap.set("n", "<leader>ip", "m`o<ESC>p``", { desc = "Clipboard below current line" })
keymap.set("n", "<leader>iP", "m`O<ESC>p``", { desc = "Clipboard above current line" })

-- Insert a blank line below or above current line (do not move the cursor).
-- see https://stackoverflow.com/a/16136133/6064933
keymap.set("n", "<leader>io", "printf('m`%so<ESC>``', v:count1)", { expr = true, desc = "Blank line below" })
keymap.set("n", "<leader>iO", "printf('m`%sO<ESC>``', v:count1)", { expr = true, desc = "Blank line above" })

-- Toggle cursor column
keymap.set("n", "<leader>tc", "<cmd>call utils#ToggleCursorCol()<cr>", { desc = "Cursor column" })

-- Toggle cursor location.
keymap.set("n", "<leader>tl", toggle_cursor_location, { desc = "Toggle cursor location" })

-- Check the syntax group of current cursor position.
keymap.set("n", "<leader>ts", "<cmd>call utils#SynGroup()<cr>", { desc = "Syntax group" })

-- Quit without saving.
keymap.set("n", "<leader>qQ", "<cmd>qa!<cr>", { silent = true, desc = "Quit without saving" })

-- Quit.
keymap.set("n", "<leader>qq", "<cmd>q<cr>", { silent = true, desc = "Quit" })

-- Close location list or quickfix list if they are present.
-- see https://superuser.com/q/355325/736190
keymap.set("n", [[\x]], "<cmd>windo lclose <bar> cclose <cr>", {
  silent = true,
  desc = "Close qf and location list",
})

-- Break inserted text into smaller undo units when we insert some punctuation chars.
local undo_ch = { ",", ".", "!", "?", ";", ":" }
for _, ch in ipairs(undo_ch) do
  keymap.set("i", ch, ch .. "<c-g>u")
end

-- Switch windows.
-- keymap.set("n", "<left>", "<c-w>h")
-- keymap.set("n", "<Right>", "<C-W>l")
-- keymap.set("n", "<Up>", "<C-W>k")
-- keymap.set("n", "<Down>", "<C-W>j")
