local lualine = require('lualine')
local icons = require('config/icons')

local colors = {
  bg = '#202328',
  fg = '#bbc2cf',
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec5f67',
}

local mode_color = {
  n = colors.green,
  i = colors.blue,
  v = colors.magenta,
  [''] = colors.magenta,
  V = colors.magenta,
  c = colors.yellow,
  t = colors.red,
  R = colors.orange,
  Rv = colors.orange,
  no = colors.fg,
  s = colors.violet,
  S = colors.violet,
  [''] = colors.violet,
  ic = colors.yellow,
  cv = colors.red,
  ce = colors.red,
  r = colors.cyan,
  rm = colors.cyan,
  ['r?'] = colors.cyan,
  ['!'] = colors.red,
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  buffer_is_file = function()
    return vim.bo.buftype == ''
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}
local progress = { 'progress', color = { fg = colors.fg, gui = 'bold' } }
local filetype = { 'filetype', icon_only = false, color = { fg = colors.blue, gui = 'bold' } }
local filesize = { 'filesize', color = { fg = colors.fg, gui = 'bold' }, cond = conditions.buffer_not_empty }
local fileformat = {
  'fileformat',
  icons_enabled = true,
  symbols = {
    unix = 'LF',
    dos = 'CRLF',
    mac = 'CR',
  },
  color = { fg = colors.white, gui = 'bold' } }

local filename = {
  symbols = {
    readonly = icons.ui.Lock,
  },
  'filename',
  path = 4,
  cond = conditions.buffer_not_empty and conditions.buffer_is_file,
  color = { fg = colors.magenta, gui = 'bold' },
}

local buffers = {
  'buffers',
  filetype_names = {
    TelescopePrompt = icons.ui.Telescope .. 'Telescope',
    dashboard = icons.ui.Dashboard .. 'Dashboard',
    lazy = icons.ui.Sleep .. 'Lazy',
    mason = icons.ui.Package .. 'Mason',
    NvimTree = icons.documents.OpenFolder .. 'Files',
    spectre_panel = icons.ui.Search .. 'Spectre',
  },
  use_mode_colors = true,
}

local branch = {
  'branch',
  icon = icons.git.Branch,
  fmt = function(str)
      return str:sub(1, 32)
  end,
  color = { fg = colors.green, gui = 'bold' },
}

local diff_icons = {
  'diff',
  symbols = { added = icons.git.AddAlt, modified = icons.git.DiffAlt, removed = icons.git.RemoveAlt },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

local diagnostics = {
  'diagnostics',
  sources = { 'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic' },
  symbols = {
    error = icons.diagnostics.Error,
    warn = icons.diagnostics.Warning,
    info = icons.diagnostics.Information,
    hint = icons.diagnostics.Hint,
  },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.blue },
    color_hint = { fg = colors.yellow },
  },
}

local lsp = {
  function()
    local msg = ''
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = icons.ui.Gear,
  color = { fg = colors.fg, gui = 'bold' },
}

local encoding = {
  'o:encoding',
  fmt = string.upper,
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' },
}

local separator = {
  function()
    return icons.ui.Separator
  end,
  color = function()
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { left = 0, right = 0 },
}

local selectioncount = {
  function()
    local mode = vim.fn.mode()
    local start_line, end_line, start_pos, end_pos

    if not (mode:find("[vV\22]") ~= nil) then return "" end
    start_line = vim.fn.line("v")
    end_line = vim.fn.line(".")

    if mode == 'V' then
      start_pos = 1
      end_pos = vim.fn.strlen(vim.fn.getline(end_line)) + 1
    else
      start_pos = vim.fn.col("v")
      end_pos = vim.fn.col(".")
    end

    local chars = 0
    for i = start_line, end_line do
      local line = vim.fn.getline(i)
      local line_len = vim.fn.strlen(line)
      local s_pos = (i == start_line) and start_pos or 1
      local e_pos = (i == end_line) and end_pos or line_len + 1
      chars = chars + vim.fn.strchars(line:sub(s_pos, e_pos - 1))
    end

    local lines = math.abs(end_line - start_line) + 1
    return tostring(lines) .. " lines, " .. tostring(chars) .. " characters"
  end,
  color = { fg = colors.green, gui = 'bold' },
}

local trailing_space = {
  function()
    local space = vim.fn.search([[\s\+$]], 'nwc')
    return space ~= 0 and "tw:"..space or ""
  end,
  color = { fg = colors.red, gui = 'bold' },
}

local virtual_env = {
  function()
    -- only show virtual env for Python
    if vim.bo.filetype ~= "python" then
      return ""
    end
    local conda_env = os.getenv("CONDA_DEFAULT_ENV")
    local venv_path = os.getenv("VIRTUAL_ENV")

    if venv_path == nil then
      if conda_env == nil then
      return ""
      else
      return string.format("conda:%s", conda_env)
      end
    else
      local venv_name = vim.fn.fnamemodify(venv_path, ":t")
      return string.format("venv:%s", venv_name)
    end
  end,
  color = { fg = colors.violet},
}

local function mode(icon)
  icon = icon or icons.ui.NeoVim
  return {
    function()
      return icon
    end,
    color = function()
      return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { left = 1, right = 0 },
  }
end

lualine.setup({
  options = {
    component_separators = '',
    -- section_separators = '',
    theme = 'auto',
    disabled_filetypes = {
      'dashboard',
    },
  },
  extensions = { 'quickfix', 'man', 'mason', 'lazy', 'toggleterm', 'nvim-tree' },
  -- tabline = {
  --   lualine_a = {},
  --   lualine_b = { mode(), buffers },
  --   lualine_c = {},
  --   lualine_x = { diff_icons},
  --   lualine_y = {},
  --   lualine_z = {},
  -- },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { separator, mode(icons.ui.Heart), filesize, filename, 'location', progress, trailing_space, selectioncount },
    lualine_x = { virtual_env, lsp, fileformat, filetype, branch, diagnostics},
    lualine_y = {},
    lualine_z = {},
  },
})
