local icons = require('core.icons')

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  config = function()
    local lualine = require('lualine')
    local colors = {
      bg       = '#202328',
      fg       = '#bbc2cf',
      yellow   = '#ECBE7B',
      cyan     = '#008080',
      darkblue = '#081633',
      green    = '#98be65',
      orange   = '#FF8800',
      violet   = '#a9a1e1',
      magenta  = '#c678dd',
      blue     = '#51afef',
      red      = '#ec5f67',
      bar      = '#383F4E'
    }

    local mode_color = {
      n = colors.green,
      i = colors.blue,
      v = colors.magenta,
      [''] = colors.magenta,
      V = colors.magenta,
      c = colors.yellow,
      no = colors.fg,
      s = colors.violet,
      S = colors.violet,
      [''] = colors.violet,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
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

    -- Config
    local config = {
      options = {
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        theme = {
          -- We are going to use lualine_c an lualine_x as left and
          -- right section. Both are highlighted by c theme .  So we
          -- are just setting default looks o statusline
          normal = { c = { fg = colors.fg, bg = colors.bar } },
          inactive = { c = { fg = colors.fg, bg = colors.bar } },
        },
        disabled_filetypes = {
          'dashboard',
          'neo-tree',
          'fern',
          'help',
          'lazy',
          'lazygit'
          'navbuddy',
          'markdown',
          'mason',
          'noice',
          'toggleterm',
        },
        extensions = { 'quickfix' }
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x at right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_left {
      function()
        return icons.ui.Separator
      end,
      color = function()
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { left = 0, right = 0 },
    }

    -- mode
    ins_left {
      function()
        return icons.ui.Doom
      end,
      color = function()
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { right = 1 },
    }

    -- filesize
    ins_left {
      'filesize',
      cond = conditions.buffer_not_empty,
    }

    -- filename
    ins_left {
      symbols = {
        readonly = icons.ui.Lock,
        unnamed = 'Empty',
      },
      'filename',
      path = 4,
      cond = conditions.buffer_not_empty and conditions.buffer_is_file,
      color = { fg = colors.magenta, gui = 'bold' },
    }

    -- -- diff
    -- ins_left {
    --   'diff',
    --   -- Is it me or the symbol for modified us really weird
    --   symbols = { added = icons.git.Add, modified = icons.git.Modified, removed = icons.git.Deleted },
    --   diff_color = {
    --     added = { fg = colors.green },
    --     modified = { fg = colors.blue },
    --     removed = { fg = colors.red },
    --   },
    --   cond = conditions.hide_in_width,
    -- }

    -- location
    ins_left { 'location' }

    -- progress
    ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

    -- trailing_space
    ins_left {
      function()
        local space = vim.fn.search([[\s\+$]], 'nwc')
        return space ~= 0 and 'tw:' .. space or ''
      end,
      color = { fg = colors.red, gui = 'bold' },
    }

    -- selectioncount
    ins_left {
      function()
        local mode = vim.fn.mode()
        local start_line, end_line, start_pos, end_pos

        if not (mode:find('[vV\22]') ~= nil) then
          return ''
        end
        start_line = vim.fn.line('v')
        end_line = vim.fn.line('.')

        if mode == 'V' then
          start_pos = 1
          end_pos = vim.fn.strlen(vim.fn.getline(end_line)) + 1
        else
          start_pos = vim.fn.col('v')
          end_pos = vim.fn.col('.')
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
        return tostring(lines) .. ' lines, ' .. tostring(chars) .. ' characters'
      end,
      color = { fg = colors.green, gui = 'bold' },
    }

    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    ins_left {
      function()
        return '%='
      end,
    }

    -- ins_left {
    --   'o:encoding',
    --   fmt = string.upper,
    --   cond = conditions.hide_in_width,
    --   color = { fg = colors.blue, gui = 'bold' },
    -- }

    -- lsp
    ins_left {
      function()
        local msg = ''
        local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
        local clients = vim.lsp.get_clients()
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

    -- Add components to right sections
    -- virtual_env
    ins_right {
      function()
        if vim.bo.filetype ~= 'python' then
          return ''
        end
        local conda_env = os.getenv('CONDA_DEFAULT_ENV')
        local venv_path = os.getenv('VIRTUAL_ENV')

        if venv_path == nil then
          if conda_env == nil then
            return ''
          else
            return string.format('conda:%s', conda_env)
          end
        else
          local venv_name = vim.fn.fnamemodify(venv_path, ':t')
          return string.format('venv:%s', venv_name)
        end
      end,
      color = { fg = colors.violet },
    }

    -- fileformat
    ins_right {
      'fileformat',
      symbols = {
        unix = 'LF',
        dos = 'CRLF',
        mac = 'CR',
      },
      color = { fg = colors.cyan, gui = 'bold' },
    }

    -- filetype
    ins_right {
      'filetype',
      icon_only = false,
      color = { fg = colors.blue, gui = 'bold' }
    }

    -- branch
    ins_right {
      'branch',
      icon = icons.git.Branch,
      color = { fg = colors.green, gui = 'bold' },
    }

    -- diagnostics
    ins_right {
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
      }
    }

    -- Now don't forget to initialize lualine
    lualine.setup(config)
  end,
}
