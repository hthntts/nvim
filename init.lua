vim.loader.enable()
local utils = require("core/utils")
local expected_version = "0.10.2"
utils.is_compatible_version(expected_version)
local config_dir = vim.fn.stdpath("config")

require("core/globals")
require("core/options")
require("core/autocmd")
require("core/mappings")
require("core/plugins")
require("core/colorschemes")
vim.cmd("source " .. vim.fs.joinpath(config_dir, "plugins/config.vim"))
