local opts = {
  options = {
    icons_enabled = false,
    theme = 'auto',
    -- section_separators = { left = '', right = ''},
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    -- component_separators = { left = '', right = ''},
    disabled_filetypes = {'startify'},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      'branch',
      {
        'diff',
        colored = true,      -- displays diff status in color if set to true
        diff_color = {
          added = nil,       -- changes diff's added color
          modified = nil,    -- changes diff's modified color
          removed = nil,     -- changes diff's removed color
        },
        source = nil,        -- A function that works as a data source for diff.
        symbols = {added = ' ', modified = ' ', removed = ' '}, -- changes diff symbols
      }
    },
    lualine_c = {
      {
        -- 'filename',
        file_status = true,               -- displays file status (readonly status, modified status)
        path = 0,                         -- 0 = just filename, 1 = relative path, 2 = absolute path
        shorting_target = 40,             -- Shortens path to leave 40 space in the window
        symbols = {
          modified = ' [modified] ',      -- Text to show when the file is modified.
          readonly = ' [readonly] ',      -- Text to show when the file is non-modifiable or readonly.
          unnamed = ' [No Name] ',        -- Text to show for unnamed buffers.
        }
      }
    },
    lualine_x = {
      { 'diagnostic', sources = {'nvim_diagnostic'}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
      'filesize',
      {
        'fileformat',
        symbols = {
          unix = '',
          dos = '',
          mac = '',
        }
      },
      'encoding',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { require'tabline'.tabline_buffers },
    lualine_x = { require'tabline'.tabline_tabs },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = {'quickfix', 'nvim-tree', 'fugitive', 'fern'}
}

require('lualine').setup(opts)
