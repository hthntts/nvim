local options = {
  ai = true,
  autoindent = true,
  autowrite = true,
  backspace = "indent,eol,start",
  backup = false,                        -- creates a backup file
  breakindent = true,                    -- enable line breaks when the text is wrapped
  clipboard = "unnamedplus",             -- allows neovim to access the system clipboard
  cmdheight = 1,                         -- more space in the neovim command line for displaying messages
  completeopt = "menu,menuone,noselect", -- mostly just for cmp
  conceallevel = 0,                      -- so that `` is visible in markdown files
  confirm = true,                        -- confirm to save changes before exiting modified buffer
  cursorline = true,                     -- highlight the current line
  expandtab = true,                      -- convert tabs to spaces
  fileencoding = "utf-8",                -- the encoding written to a file
  formatoptions = "jlnqt",               -- set formatoptions, check help fo-table
  hlsearch = true,                       -- highlight all matches on previous search pattern
  ignorecase = true,                     -- ignore case in search patterns
  inccommand = "split",                  -- preview incremental substitute
  laststatus = 3,                        -- status line
  list = true,                           -- enable list
  mouse = "a",                           -- allow the mouse to be used in neovim
  number = true,                         -- set numbered lines
  numberwidth = 4,                       -- set number column width to 2 {default 4}
  -- pumblend = 10,                         -- popup blen
  pumheight = 20,                        -- popup menu height
  relativenumber = true,                 -- set relative numbered lines
  scrolloff = 10,                        -- is one of my fav
  shiftround = true,                     -- round indent
  shiftwidth = 4,                        -- the number of spaces inserted for each indentation
  showcmd = false,                       -- disable display the current command
  showmode = true,                       -- we need to see things like -- INSERT -- anymore
  showtabline = 0,                       -- always show tabs
  si = true,                             -- indentation level for the current line or selected lines
  sidescrolloff = 8,                     -- minimum number of screen columns
  signcolumn = "yes",                    -- always show the sign column, otherwise it would shift the text each time
  smartcase = true,                      -- smart case
  smartindent = true,                    -- make indenting smarter again
  smarttab = true,                       -- enable space for tab
  splitbelow = true,                     -- force all horizontal splits to go below current window
  splitright = true,                     -- force all vertical splits to go to the right of current window
  swapfile = false,                      -- creates a swapfile
  tabstop = 2,                           -- insert 2 spaces for a tab
  termguicolors = true,                  -- set term gui colors (most terminals support this)
  undofile = true,                       -- enable persistent undo
  undolevels = 10000,                    -- maximum number of undo levels
  updatetime = 50,                       -- faster completion (4000ms default)
  wildmenu = true,                       -- enable wildmenu
  wildmode = "longest:full,full",        -- command-line completion mode
  winminwidth = 5,                       -- minimum window width
  wrap = false,                          -- display lines as one long line
  writebackup = false,                   -- do not edit backups
  -- timeoutlen = 300,                      -- time to wait for a mapped sequence to complete (in milliseconds)
  grepformat = "%f:%l:%c:%m",
  grepprg = "rg --vimgrep",
  listchars = { trail = "", tab = "", nbsp = "_", extends = ">", precedes = "<" },
  sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal",
}

vim.opt.path:append({ "**" })
vim.opt.shortmess:append({ W = true, I = true, c = true })
vim.opt.splitkeep = "screen"

-- Enable spell check
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

for k, v in pairs(options) do
  vim.opt[k] = v
end
