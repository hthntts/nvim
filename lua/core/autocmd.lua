local utils = require('core.utils')
local fn = vim.fn
local api = vim.api
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup

autocmd({ 'BufRead' }, {
  desc = 'Display a message when the current file is not in utf-8 format',
  group = augroup('non_utf8_file', { clear = true }),
  pattern = '*',
  callback = function()
    if vim.bo.fileencoding ~= 'utf-8' then
      vim.notify('File not in UTF-8 format!', vim.log.levels.WARN, { title = 'nvim-config' })
    end
  end,
})

-- Highlight yanked region
local yank_group = api.nvim_create_augroup("highlight_yank", { clear = true })
autocmd({ 'TextYankPost' }, {
  pattern = '*',
  group = yank_group,
  callback = function()
    vim.highlight.on_yank({ higroup = 'YankColor', timeout = 300 })
  end,
})
autocmd({ 'CursorMoved' }, {
  pattern = '*',
  group = yank_group,
  callback = function()
    vim.g.current_cursor_pos = fn.getcurpos()
  end,
})
autocmd('TextYankPost', {
  pattern = '*',
  group = yank_group,
  callback = function()
    if vim.v.event.operator == 'y' then
      fn.setpos('.', vim.g.current_cursor_pos)
    end
  end,
})

autocmd({ 'BufWritePre' }, {
  desc = 'Auto-create dir when saving a file',
  pattern = '*',
  group = augroup('auto_create_dir', { clear = true }),
  callback = function(ctx)
    local dir = fn.fnamemodify(ctx.file, ':p:h')
    utils.may_create_dir(dir)
  end,
})

-- Automatically reload the file if it is changed outside of Nvim, see https://unix.stackexchange.com/a/383044/221410.
-- It seems that `checktime` does not work in command line. We need to check if we are in command
-- line before executing this command, see also https://vi.stackexchange.com/a/20397/15292 .
augroup('auto_read', { clear = true })
autocmd({ 'FileChangedShellPost' }, {
  pattern = '*',
  group = 'auto_read',
  callback = function()
    vim.notify('File changed on disk. Buffer reloaded!', vim.log.levels.WARN, { title = 'nvim-config' })
  end,
})
autocmd({ 'FocusGained', 'CursorHold' }, {
  pattern = '*',
  group = 'auto_read',
  callback = function()
    if fn.getcmdwintype() == '' then
      vim.cmd('checktime')
    end
  end,
})

autocmd('VimResized', {
  desc = 'Autoresize windows on resizing operation',
  group = augroup('win_autoresize', { clear = true }),
  command = 'wincmd =',
})

local function open_nvim_tree(data)
  -- check if buffer is a directory
  local directory = fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- create a new, empty buffer
  vim.cmd.enew()

  -- wipe the directory buffer
  vim.cmd.bw(data.buf)

  require('nvim-tree.api').tree.open()
end
autocmd({ 'VimEnter' }, { callback = open_nvim_tree })

-- Do not use smart case in command line mode, extracted from https://vi.stackexchange.com/a/16511/15292.
augroup('dynamic_smartcase', { clear = true })
autocmd('CmdLineEnter', {
  group = 'dynamic_smartcase',
  pattern = ':',
  callback = function()
    vim.o.smartcase = false
  end,
})
autocmd('CmdLineLeave', {
  group = 'dynamic_smartcase',
  pattern = ':',
  callback = function()
    vim.o.smartcase = true
  end,
})

-- Return to last cursor position when opening a file
-- see: https://github.com/ethanholz/nvim-lastplace/blob/main/lua/nvim-lastplace/init.lua
local ignore_buftype = { 'quickfix', 'nofile', 'help' }
local ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' }

local function run()
  if vim.tbl_contains(ignore_buftype, vim.bo.buftype) then
    return
  end

  if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
    -- reset cursor to first line
    vim.cmd [[normal! gg]]
    return
  end

  -- If a line has already been specified on the command line, we are done
  --   nvim file +num
  if fn.line('.') > 1 then
    return
  end

  local last_line = fn.line([['"]])
  local buff_last_line = fn.line('$')

  -- If the last line is set and the less than the last line in the buffer
  if last_line > 0 and last_line <= buff_last_line then
    local win_last_line = fn.line('w$')
    local win_first_line = fn.line('w0')
    -- Check if the last line of the buffer is the same as the win
    if win_last_line == buff_last_line then
      -- Set line to last line edited
      vim.cmd [[normal! g`"]]
      -- Try to center
    elseif buff_last_line - last_line > ((win_last_line - win_first_line) / 2) - 1 then
      vim.cmd [[normal! g`"zz]]
    else
      vim.cmd [[normal! G'"<c-e>]]
    end
  end
end

autocmd({ 'BufWinEnter', 'FileType' }, {
  group    = augroup('nvim_lastplace', {}),
  callback = run
})

local number_toggle_group = augroup('numbertoggle', { clear = true })
autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
  desc = 'Togger line number',
  group = number_toggle_group,
  pattern = '*',
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = true
    end
  end,
})

autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
  desc = 'Togger line number',
  group = number_toggle_group,
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = false
    end
  end,
})

autocmd('ColorScheme', {
  desc = 'Define or overrride some highlight groups',
  group = augroup('custom_highlight', { clear = true }),
  pattern = '*',
  callback = function()
    -- For yank highlight
    api.nvim_set_hl(0, 'YankColor', { fg = '#34495E', bg = '#f9e2af', ctermfg = 59, ctermbg = 41 })

    -- For cursor colors
    api.nvim_set_hl(0, 'TermCursor', { fg = 'black', bg = '#74c7ec', bold = true })
    api.nvim_set_hl(0, 'Cursor', { fg = 'black', bg = '#74c7ec', bold = true })

    -- For floating windows border highlight
    -- api.nvim_set_hl(0, 'FloatBorder', { fg = 'LightGreen' })

    -- highlight for matching parentheses
    api.nvim_set_hl(0, 'MatchParen', { bold = true, underline = true })
  end,
})

autocmd('BufEnter', {
  desc = 'Quit Nvim if we have only one window, and its filetype match our pattern',
  pattern = '*',
  group = augroup('auto_close_win', { clear = true }),
  callback = function()
    local quit_filetypes = { 'qf', 'fern', 'neo-tree' }
    local should_quit = true
    local tabwins = api.nvim_tabpage_list_wins(0)

    for _, win in pairs(tabwins) do
      local buf = api.nvim_win_get_buf(win)
      local bf = fn.getbufvar(buf, '&filetype')

      if fn.index(quit_filetypes, bf) == -1 then
        should_quit = false
      end
    end

    if should_quit then
      vim.cmd('qall')
    end
  end,
})

autocmd({ 'InsertLeave', 'WinEnter' }, {
  desc = 'Show cursorline only on active windows',
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = false
    end
  end,
})

autocmd({ 'InsertEnter', 'WinLeave' }, {
  desc = 'Hide cursorline when inactive windows',
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
})

autocmd({ 'VimEnter', 'DirChanged' }, {
  desc = 'Check if we are inside Git repo',
  group = augroup('git_repo_check', { clear = true }),
  pattern = '*',
  command = 'call utils#InsideGitRepo()',
})

autocmd('BufReadPre', {
  desc = 'Check if we are inside Git repo',
  group = augroup('large_file', { clear = true }),
  pattern = '*',
  callback = function(ev)
    local file_size_limit = 524288 -- 0.5MB
    local f = ev.file
    if fn.getfsize(f) > file_size_limit or fn.getfsize(f) == -2 then
      vim.o.eventignore = 'all'
      vim.wo.relativenumber = false
      vim.bo.swapfile = false
      vim.bo.bufhidden = 'unload'
      vim.bo.undolevels = -1
    end
  end,
})

autocmd('CmdlineEnter', {
  desc = 'Do not hide the status line when typing a command',
  group = augroup('gmr_cmdheight_1_on_cmdlineenter', { clear = true }),
  command = ':set cmdheight=1',
})

autocmd('CmdlineLeave', {
  desc = 'Hide cmdline when not typing a command',
  group = augroup('gmr_cmdheight_0_on_cmdlineleave', { clear = true }),
  command = ':set cmdheight=0',
})

autocmd('BufWritePost', {
  desc = 'Get rid of message after writing a file',
  group = augroup('gmr_hide_message_after_write', { clear = true }),
  pattern = { '*' },
  command = 'redrawstatus',
})

autocmd({ 'InsertEnter', 'CmdlineEnter' }, {
  desc = 'Remove hl search when enter Insert',
  callback = vim.schedule_wrap(function()
    vim.cmd.nohlsearch()
  end),
})

autocmd({ 'WinResized' }, {
  desc = 'Updates scrolloff on startup and when window is resized',
  group = augroup('smart_scrolloff', { clear = true }),
  callback = function()
    local scrolloffPercentage = 0.2
    vim.opt.scrolloff = math.floor(vim.o.lines * scrolloffPercentage)
  end,
})

autocmd('FileType', {
  desc = 'Add an autocmd to disable relative numbers for the special filetype',
  group = augroup('spectial_filetype', { clear = true }),
  pattern = { 'spectre_panel', 'qf', 'vim' },
  callback = function()
    vim.wo.relativenumber = false
    vim.wo.number = false
  end,
})

autocmd("FileType", {
  desc = 'Close on "q"',
  pattern = {
    'checkhealth',
    'gitsigns-blame',
    'help',
    'lazy',
    'man',
    'qf',
    'vim',
  },
  command = [[
          nnoremap <buffer><silent> q :close<CR>
          nnoremap <buffer><silent> <ESC> :close<CR>
          set nobuflisted
      ]],
})

autocmd('FileType', {
  desc = 'Automatically Split help Buffers to the right',
  pattern = 'help',
  command = 'wincmd L',
})

autocmd({ "FileType" }, {
  group = augroup('wrap_spell', { clear = true }),
  pattern = { "text", "gitcommit", "markdown", "conf" },
  callback = function()
    vim.opt_local.spell = true
  end,
})
