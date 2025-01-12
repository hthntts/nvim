-- Keymaps for better default experience

-- Set leader key
vim.g.mapleader = " "
-- vim.g.maplocalleader = ' '

local map = vim.keymap.set
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

-- local function reload_nvim()
--   vim.cmd([[
--       update $MYVIMRC
--       source $MYVIMRC
--     ]])
--   vim.notify("Nvim config successfully reloaded!", vim.log.levels.INFO, { title = "nvim-config" })
-- end

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

-- Toggle diagnostics
local diagnostics_active = true

local function toogle_diagnostic()
  diagnostics_active = not diagnostics_active

  if diagnostics_active then
    vim.diagnostic.enable()
  else
    vim.diagnostic.enable(false)
  end
end

-- Use Esc to quit builtin terminal.
map("t", "<Esc><Esc", [[<c-\><c-n>]])

-- Go to beginning of command in command-line mode.
map("c", "<C-A>", "<HOME>")

-- Save key strokes (do not need to press shift to enter command mode).
map({ "x", "n" }, ";", ":")

-- Replace visual selection with text in register, but not contaminate the register.
-- see also https://stackoverflow.com/q/10723700/6064933.
map("x", "p", '"_c<Esc>p')

-- Do not include white space characters when using $ in visual mode.
-- see https://vi.stackexchange.com/q/12607/15292
map("x", "$", "g_")

-- Continuous visual shifting (does not exit Visual mode), `gv` means
-- to reselect previous visual area.
-- see https://superuser.com/q/310417/736190
map("x", "<", "<gv")
map("x", ">", ">gv")

-- Clear search, diff update and redraw.
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Turn the word under cursor to upper case.
map("i", "<c-u>", "<Esc>viwUea", { desc = "Turn word to Upper case" })

-- Turn the current word into title case.
map("i", "<c-t>", "<Esc>b~lea", { desc = "Turn current word into Title case" })

-- Insert semicolon in the end.
map("i", "<A-;>", "<Esc>miA;<Esc>`ii", { desc = "Insert semicolon in the end" })

-- Insert semicolon in the end.
map("i", "<A-.>", "<Esc>miA.<Esc>`ii", { desc = "Insert dot in the end" })

-- Go to the beginning and end of current line in insert mode quickly.
map("i", "<C-A>", "<HOME>")
map("i", "<C-E>", "<END>")

-- Delete the character to the right of the cursor.
map("i", "<C-D>", "<DEL>")

-- Toggle spell checking.
map("i", "<F11>", "<c-o><cmd>set spell!<cr>", { desc = "Toggle spell" })
map("n", "<F11>", "<cmd>set spell!<cr>", { desc = "Toggle spell" })

-- Change text without putting it into the vim register.
-- see https://stackoverflow.com/q/54255/6064933
map("x", "c", '"_c')
map("n", "c", '"_c')
map("n", "C", '"_C')
map("n", "x", '"_x')

-- Go to start or end of line easier.
map({ "n", "x" }, "H", "^")
map({ "n", "x" }, "L", "g_")

-- Move the cursor based on physical lines, not the actual lines.
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "^", "g^")

-- Always use very magic mode for searching.
map("n", "/", [[/\v]])

-- Join lines.
map("n", "J", join_lines, { desc = "Join lines without moving cursor" })

-- Navigation in the location and quickfix list.
map("n", "[l", "<cmd>lprevious<cr>zv", { silent = true, desc = "Previous location item" })
map("n", "]l", "<cmd>lnext<cr>zv", { silent = true, desc = "Next location item" })

map("n", "[L", "<cmd>lfirst<cr>zv", { silent = true, desc = "First location item" })
map("n", "]L", "<cmd>llast<cr>zv", { silent = true, desc = "Last location item" })

map("n", "[q", "<cmd>cprevious<cr>zv", { silent = true, desc = "Previous qf item" })
map("n", "]q", "<cmd>cnext<cr>zv", { silent = true, desc = "Next qf item" })

map("n", "[Q", "<cmd>cfirst<cr>zv", { silent = true, desc = "First qf item" })
map("n", "]Q", "<cmd>clast<cr>zv", { silent = true, desc = "Last qf item" })

-- Text objects for entire buffer
map("n", "<leader>ba", "<cmd>call utils#selectall()<cr>", { desc = "Mark whole buffer" })
map("n", "<M-a>", "<cmd>call utils#selectall()<cr>", { desc = "Mark whole buffer" })

-- Delete a buffer, without closing the window.
-- see https://stackoverflow.com/q/4465095/6064933
map("n", "<leader>bd", "<cmd>bprevious <bar> bdelete #<cr>", { silent = true, desc = "Kill buffer" })
-- map("n", "<leader>bd", "<cmd>bd<cr>", { silent = true, desc = "Kill buffer" })

-- Reselect the text that has just been pasted.
-- see https://stackoverflow.com/a/4317090/6064933.
map("n", "<leader>br", "printf('`[%s`]', getregtype()[0])", { expr = true, desc = "Reselect last pasted area" })
map("n", "<leader>bs", "<cmd>update<cr>", { silent = true, desc = "Save buffer" })

-- Remove trailing whitespace characters
map("n", "<leader>cw", "<cmd>StripTrailingWhitespace<cr>", { desc = "LSP: Delete trailing whitespace" })

-- Delete other buffers.
map("n", "<leader>bO", delete_other_buffers, { desc = "Kill other buffers" })

-- -- Go to a certain buffer.
-- map("n", "<leader>bn", '<cmd>call utils#gotobuffer(v:count, "forward")<cr>', { desc = "Next buffer" })
-- map("n", "<leader>bp", '<cmd>call utils#gotobuffer(v:count, "backward")<cr>', { desc = "Previous buffer" })
-- map("n", "<A-D-Right>", '<cmd>call utils#gotobuffer(v:count, "forward")<cr>', { desc = "Next buffer" })
-- map("n", "<A-D-Left>", '<cmd>call utils#gotobuffer(v:count, "backward")<cr>', { desc = "Previous buffer" })

map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bk", "<cmd>Bdelete!<CR>", { desc = "Kill buffer" })
map("n", "<leader>bN", "<cmd>enew<CR>", { desc = "New empty buffer" })

-- Copy entire buffer.
map("n", "<leader>by", "<cmd>%yank<cr>", { desc = "Yank buffer" })

-- Change current working directory locally and print cwd after that.
-- see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
map("n", "<leader>fc", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", { desc = "Change cd current file" })

-- Shortcut for faster save and quit.
map("n", "<leader>fs", "<cmd>update<cr>", { silent = true, desc = "Save file" })

-- -- Reload config.
-- map("n", "<leader>hdr", reload_nvim, { silent = true, desc = "Reload config" })

-- Paste non-linewise text above or below current line.
-- see https://stackoverflow.com/a/1346777/6064933
map("n", "<leader>ip", "m`o<ESC>p``", { desc = "Clipboard below current line" })
map("n", "<leader>iP", "m`O<ESC>p``", { desc = "CliPboard above current line" })

-- Insert a blank line below or above current line (do not move the cursor).
-- see https://stackoverflow.com/a/16136133/6064933
map("n", "<leader>io", "printf('m`%so<ESC>``', v:count1)", { expr = true, desc = "Blank line below" })
map("n", "<leader>iO", "printf('m`%sO<ESC>``', v:count1)", { expr = true, desc = "Blank line above" })

-- Save and load session
map("n", "<leader>rs", "<cmd>mksession! .session.vim<CR>", { noremap = true, silent = false, desc = "Save Session" })
map("n", "<leader>rl", "<cmd>source .session.vim<CR>", { noremap = true, silent = false, desc = "Load Session" })

-- Toggle cursor column.
map("n", "<leader>to", "<cmd>call utils#ToggleCursorCol()<cr>", { desc = "Toogle cursor column" })

-- Toggle cursor location.
map("n", "<leader>tl", toggle_cursor_location, { desc = "Toggle cursor location" })

-- Toggle line wrapping.
map("n", "<leader>tw", "<cmd>set wrap!<CR>", { desc = "Toggle line wrap" })

-- Quit without saving.
map("n", "<leader>qQ", "<cmd>qa!<cr>", { silent = true, desc = "Quit without saving" })

-- Quit file.
map("n", "<leader>qq", "<cmd>q<cr>", { silent = true, desc = "Quit" })

-- Save file without auto-formatting
map("n", "<leader>fS", "<cmd>noautocmd w <CR>", { silent = true, desc = "Save file without auto-formatting" })

-- Close location list or quickfix list if they are present.
-- see https://superuser.com/q/355325/736190
map("n", [[\x]], "<cmd>windo lclose <bar> cclose <cr>", {
  silent = true,
  desc = "kill qf and location list [x]",
})

-- Break inserted text into smaller undo units when we insert some punctuation chars.
local undo_ch = { ",", ".", "!", "?", ";", ":" }
for _, ch in ipairs(undo_ch) do
  map("i", ch, ch .. "<c-g>u")
end

-- Switch windows.
-- map("n", "<left>", "<c-w>h")
-- map("n", "<Right>", "<C-W>l")
-- map("n", "<Up>", "<C-W>k")
-- map("n", "<Down>", "<C-W>j")

map("n", "<leader>td", toogle_diagnostic, { desc = "Toogle diagnostic" })

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
map("n", "<leader>cqf", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
map("n", "<leader>cqq", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
