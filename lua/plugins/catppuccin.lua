return {
  'catppuccin/nvim',
  priority = 1000,
  opts = {
  },
  config = function()
    require('catppuccin').setup({
      flavour = 'auto', -- latte, frappe, macchiato, mocha
      indent_blankline = {
        enabled = true,
        scope_color = '', -- catppuccin color (eg. `lavender`) Default: text
        colored_indent_levels = false,
      },
      integfloating_border = 'off',
      integration = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        notify = true,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
        noice = true,
        which_key = true,

      },

      custom_highlights = function(colors)
        return {
          -- TelescopeBorder            = { fg = colors.blue },
          -- TelescopeMatching          = { fg = colors.flamingo },
          -- TelescopeSelection         = { fg = colors.text, bg = colors.surface0, bold = true },
          -- TelescopePromptPrefix      = { bg = colors.surface0 },
          -- TelescopePromptNormal      = { bg = colors.surface0 },
          -- TelescopeResultsNormal     = { bg = colors.mantle },
          -- TelescopePreviewNormal     = { bg = colors.mantle },
          -- TelescopePromptBorder      = { bg = colors.surface0, fg = colors.surface0 },
          -- TelescopeResultsBorder     = { bg = colors.mantle, fg = colors.mantle },
          -- TelescopePreviewBorder     = { bg = colors.mantle, fg = colors.mantle },
          -- TelescopePromptTitle       = { bg = colors.pink, fg = colors.mantle },
          -- TelescopeResultsTitle      = { fg = colors.mantle },
          -- TelescopePreviewTitle      = { bg = colors.green, fg = colors.mantle },

          -- FloatBorder                = { fg = colors.mantle, bg = colors.mantle },
          -- NeotreeFloatBorder         = { fg = colors.mantle, bg = colors.mantle },
          -- NeotreeFloatNormal         = { fg = colors.cyan, bg = colors.surface0 },
          -- NeoTreeFloatTitle          = { fg = colors.yellow, bg = colors.bg },

          NeogitDiffContextHighlight = { fg = colors.fg, bg = colors.mantle },

          Pmenu                      = { bg = colors.mantle },

          -- NavbuddyName               = { fg = colors.mantle },
          -- NavbuddyScope              = { fg = colors.rosewater },
          NavbuddyFloatBorder        = { fg = colors.cyan, bg = colors.mantle },
          NavbuddyNormalFloat        = { fg = colors.cyan, bg = colors.mantle },
          -- NavbuddyFile               = { fg = colors.mantle },
          NavbuddyModule             = { fg = colors.mauve },
          -- NavbuddyNamespace          = { fg = colors.mantle },
          NavbuddyPackage            = { fg = colors.sky },
          NavbuddyClass              = { fg = colors.yellow },
          NavbuddyMethod             = { fg = colors.blue },
          -- NavbuddyProperty           = { fg = colors.mantle },
          NavbuddyField              = { fg = colors.sky },
          NavbuddyConstructor        = { fg = colors.peach },
          NavbuddyEnum               = { fg = colors.yellow },
          NavbuddyInterface          = { fg = colors.yellow },
          NavbuddyFunction           = { fg = colors.blue },
          NavbuddyVariable           = { fg = colors.sapphire },
          NavbuddyConstant           = { fg = colors.peach },
          NavbuddyString             = { fg = colors.green },
          NavbuddyNumber             = { fg = colors.peach },
          -- NavbuddyBoolean            = { fg = colors.mantle },
          NavbuddyArray              = { fg = colors.mauve },
          NavbuddyObject             = { fg = colors.mauve },
          -- NavbuddyKey                = { fg = colors.mantle },
          -- NavbuddyNull               = { fg = colors.mantle },
          NavbuddyEnumMember         = { fg = colors.yellow },
          -- NavbuddyStruct             = { fg = colors.mantle },
          -- NavbuddyEvent              = { fg = colors.mantle },
          NavbuddyOperator           = { fg = colors.sky },
          NavbuddyTypeParameter      = { fg = colors.yellow },

          EyelinerPrimary            = { fg = colors.red, underline = true, bold = true },
          EyelinerSecondary          = { fg = colors.sky, underline = true, bold = true },
        }
      end
    })
    vim.cmd.colorscheme 'catppuccin-frappe'
  end
}
