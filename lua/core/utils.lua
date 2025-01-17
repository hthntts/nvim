local M = {}

function M.map(modes, lhs, rhs, opts)
  if type(opts) == 'string' then
    opts = { desc = opts }
  end
  local options = vim.tbl_extend('keep', opts or {}, { silent = true })
  vim.keymap.set(modes, lhs, rhs, options)
end

--- Import plugin config from external module in `lua/plugins/`
function M.use(module)
  local ok, m = pcall(require, string.format('plugins.%s', module))
  if ok then
    return m
  else
    vim.notify(string.format('Failed to import Lazy config module %s: %s', module, m))
    return {}
  end
end

function M.executable(name)
  if vim.fn.executable(name) > 0 then
    return true
  end

  return false
end

function M.plugin_is_loaded(plugin)
  -- Checking with `require` and `pcall` will cause Lazy to load the plugin
  local plugins = require('lazy.core.config').plugins
  return not not plugins[plugin] and plugins[plugin]._.loaded
end

--- check file exist
function M.file_exists(file)
  local f = io.open(file, "r")
  if f then
    f:close()
    return true
  else
    return false
  end
end

--- check whether a feature exists in Nvim
--- @param feat string the feature name, like `nvim-0.7` or `unix`.
--- @return boolean
M.has = function(feat)
  if vim.fn.has(feat) == 1 then
    return true
  end

  return false
end

--- Create a dir if it does not exist
function M.may_create_dir(dir)
  local res = vim.fn.isdirectory(dir)

  if res == 0 then
    vim.fn.mkdir(dir, "p")
  end
end

--- @param low integer the lower value for this range
--- @param high integer the upper value for this range
--- @return integer
function M.rand_int(low, high)
  -- Use lua to generate random int, see also: https://stackoverflow.com/a/20157671/6064933
  math.randomseed(os.time())

  return math.random(low, high)
end

--- Select a random element from a sequence/list.
--- @param seq any[] the sequence to choose an element
function M.rand_element(seq)
  local idx = M.rand_int(1, #seq)

  return seq[idx]
end

function M.noice_is_loaded()
  local success, _ = pcall(require, 'noice.config')
  return success and require('noice.config')._running
end

--- check if the current nvim version is compatible with the allowed version
--- @param expected_version string
--- @return boolean
function M.is_compatible_version(expected_version)
  -- check if we have the latest stable version of nvim
  local expect_ver = vim.version.parse(expected_version)
  local actual_ver = vim.version()

  if expect_ver == nil then
    local msg = string.format("Unsupported version string: %s", expected_version)
    vim.api.nvim_err_writeln(msg)
    return false
  end

  local result = vim.version.cmp(expect_ver, actual_ver)
  if result ~= 0 then
    local _ver = string.format("%s.%s.%s", actual_ver.major, actual_ver.minor, actual_ver.patch)
    local msg = string.format(
      "Expect nvim version %s, but your current nvim version is %s. Use at your own risk!",
      expected_version,
      _ver
    )
    vim.api.nvim_err_writeln(msg)
  end

  return true
end

return M
