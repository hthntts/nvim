vim.loader.enable()
local utils = require("core/utils")
local expected_version = "0.10.2"
utils.is_compatible_version(expected_version)

require("core.globals")
require("core.options")
require("core.autocmd")
require("core.keymaps")

-- Install package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local nvim_theme = "onenord"

local themes = {
  nord = "themes.nord",
  onedark = "themes.onedark",
  onenord = "themes.onenord",
}

-- Setup plugins
require("lazy").setup({
  require(themes[nvim_theme]),
  require("plugins.telescope"),
  require("plugins.treesitter"),
  require("plugins.lsp"),
  require("plugins.autocompletion"),
  require("plugins.none-ls"),
  require("git.neogit"),
  require("git.gitsigns"),
  require("git.gitlinker"),
  require("git.lazygit"),
  require("plugins.lualine"),
  require("plugins.bufferline"),
  require("plugins.hlslens"),
  require("plugins.neo-tree"),
  require("plugins.fern"),
  require("plugins.dashboard"),
  require("plugins.indent-blankline"),
  require("plugins.comment"),
  require("plugins.debug"),
  require("plugins.database"),
  require("plugins.misc"),
  require("plugins.gx"),
  require("plugins.move"),
  require("plugins.duplicate"),
  require("plugins.ufo"),
  require("plugins.markdown"),
  require("plugins.notify"),
  require("plugins.statuscol"),
  require("plugins.which-key"),
  require("plugins.tmux-navigator"),
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})

-- Function to check if a file exists
local function file_exists(file)
  local f = io.open(file, "r")
  if f then
    f:close()
    return true
  else
    return false
  end
end

-- Path to the session file
local session_file = ".session.vim"

-- Check if the session file exists in the current directory
if file_exists(session_file) then
  -- Source the session file
  vim.cmd("source " .. session_file)
end
-- The line beneath this is called `modeline`. See `:help modeline`

vim.cmd("source ~/.config/nvim/plugins/config.vim")
-- vim: ts=2 sts=2 sw=2 et
