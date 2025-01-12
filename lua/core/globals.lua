local cmd = vim.cmd
local api = vim.api
local fn = vim.fn
local utils = require("core/utils")
local username = os.getenv("USER")
local python3_path = "/Users/" .. username .. "/.pyenv/shims/python3"

-- Custom variables
vim.g.is_win = (utils.has("win32") or utils.has("win64")) and true or false
vim.g.is_linux = (utils.has("unix") and (not utils.has("macunix"))) and true or false
vim.g.is_mac = utils.has("macunix") and true or false
vim.g.logging_level = "info"

-- Builtin variables
vim.g.loaded_perl_provider = 0      -- Disable perl provider
vim.g.loaded_ruby_provider = 0      -- Disable ruby provider
-- vim.g.loaded_node_provider = 0 -- Disable node provider
vim.g.did_install_default_menus = 1 -- do not load menu

-- Python3
if fn.executable(python3_path) == 1 then
  if vim.g.is_win then
    vim.g.python3_host_prog = fn.substitute(fn.exepath("python3"), ".exe$", "", "g")
  else
    vim.g.python3_host_prog = python3_path
  end
else
  api.nvim_err_writeln("You must install Python3 and set its PATH correctly!")
  return
end

-- Enable highlighting for lua HERE doc inside vim script
vim.g.vimsyn_embed = "l"

-- Use English as main language
cmd([[language en_US.UTF-8]])

-- Whether to load netrw by default, see https://github.com/bling/dotvim/issues/4
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_liststyle = 3
if vim.g.is_win then
  vim.g.netrw_http_cmd = "curl --ssl-no-revoke -Lo"
end

-- Do not load tohtml.vim
vim.g.loaded_2html_plugin = 1

-- Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all these plugins are
-- related to checking files inside compressed files)
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1

-- Do not load the tutor plugin
vim.g.loaded_tutor_mode_plugin = 1

-- Disable sql omni completion, it is broken.
vim.g.loaded_sql_completion = 1
