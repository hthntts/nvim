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
          -- Telescope
          -- TelescopeBorder            = { fg = colors.blue },
          TelescopeMatching          = { fg = colors.flamingo },
          TelescopeSelection         = { fg = colors.text, bg = colors.surface0, bold = true },
          TelescopePromptPrefix      = { bg = colors.surface0 },
          TelescopePromptNormal      = { bg = colors.surface0 },
          TelescopeResultsNormal     = { bg = colors.mantle },
          TelescopePreviewNormal     = { bg = colors.mantle },
          TelescopePromptBorder      = { bg = colors.surface0, fg = colors.surface0 },
          TelescopeResultsBorder     = { bg = colors.mantle, fg = colors.mantle },
          TelescopePreviewBorder     = { bg = colors.mantle, fg = colors.mantle },
          TelescopePromptTitle       = { bg = colors.pink, fg = colors.mantle },
          TelescopeResultsTitle      = { fg = colors.mantle },
          TelescopePreviewTitle      = { bg = colors.green, fg = colors.mantle },

          -- FloatBorder                = { fg = colors.mantle, bg = colors.mantle },

          -- NeoTree
          NeotreeFloatBorder         = { fg = colors.mantle, bg = colors.mantle },
          NeotreeFloatNormal         = { fg = colors.cyan, bg = colors.surface0 },
          NeoTreeFloatTitle          = { fg = colors.yellow, bg = colors.bg },

          -- Neogit
          NeogitDiffContextHighlight = { fg = colors.fg, bg = colors.mantle },

          -- Menu
          Pmenu                      = { bg = colors.mantle },

          -- Navbuddy
          -- NavbuddyBoolean            = { fg = colors.mantle },
          -- NavbuddyEvent              = { fg = colors.mantle },
          -- NavbuddyFile               = { fg = colors.mantle },
          -- NavbuddyKey                = { fg = colors.mantle },
          -- NavbuddyName               = { fg = colors.mantle },
          -- NavbuddyNamespace          = { fg = colors.mantle },
          -- NavbuddyNull               = { fg = colors.mantle },
          -- NavbuddyProperty           = { fg = colors.mantle },
          -- NavbuddyScope              = { fg = colors.rosewater },
          -- NavbuddyStruct             = { fg = colors.mantle },
          NavbuddyArray              = { fg = colors.mauve },
          NavbuddyClass              = { fg = colors.yellow },
          NavbuddyConstant           = { fg = colors.peach },
          NavbuddyConstructor        = { fg = colors.peach },
          NavbuddyEnum               = { fg = colors.yellow },
          NavbuddyEnumMember         = { fg = colors.yellow },
          NavbuddyField              = { fg = colors.sky },
          NavbuddyFloatBorder        = { fg = colors.cyan, bg = colors.mantle },
          NavbuddyFunction           = { fg = colors.blue },
          NavbuddyInterface          = { fg = colors.yellow },
          NavbuddyMethod             = { fg = colors.blue },
          NavbuddyModule             = { fg = colors.mauve },
          NavbuddyNormalFloat        = { fg = colors.cyan, bg = colors.mantle },
          NavbuddyNumber             = { fg = colors.peach },
          NavbuddyObject             = { fg = colors.mauve },
          NavbuddyOperator           = { fg = colors.sky },
          NavbuddyPackage            = { fg = colors.sky },
          NavbuddyString             = { fg = colors.green },
          NavbuddyTypeParameter      = { fg = colors.yellow },
          NavbuddyVariable           = { fg = colors.sapphire },

          -- Eyeliner
          EyelinerPrimary            = { fg = colors.red, underline = true, bold = true },
          EyelinerSecondary          = { fg = colors.sky, underline = true, bold = true },

          -- GitSigns
          GitSignsAddLnInline        = { fg = colors.green, underline = true },
          GitSignsChangeLnInline     = { fg = colors.yellow, underline = true, bold = true },
          GitSignsDeleteLnInline     = { fg = colors.red, underline = true },
        }
      end
    })
    vim.cmd.colorscheme 'catppuccin-frappe'
  end
}
