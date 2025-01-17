return {
  "rmehri01/onenord.nvim",
  -- lazy = false, -- make sure we load this during startup if it is your main colorscheme
  -- priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    local colors = require('onenord.colors').load()
    require('onenord').setup({
      theme = nil,     -- "dark" or "light". Alternatively, remove the option and set vim.o.background instead
      borders = false, -- Split window borders
      fade_nc = false, -- Fade non-current windows, making them more distinguishable
      -- Style that is applied to various groups: see `highlight-args` for options
      styles = {
        comments = "italic",
        strings = "none",
        keywords = "none",
        functions = "none",
        variables = "none",
        diagnostics = "underline",
      },
      disable = {
        background = false,       -- Disable setting the background color
        float_background = false, -- Disable setting the background color for floating windows
        cursorline = false,       -- Disable the cursorline
        eob_lines = false,        -- Hide the end-of-buffer lines
      },
      -- Inverse highlight for different groups
      inverse = {
        match_paren = false,
      },
      custom_highlights = {
        MatchParen = { fg = colors.none, bg = colors.none, style = 'bold,underline' },

        -- GitSignsAddLnInline = { fg = colors.none, bg = colors.none, style = 'underline' },
        -- GitSignsChangeLnInline = { fg = colors.none, bg = colors.none, style = 'underline' },
        -- GitSignsDeleteLnInline = { fg = colors.purple, bg = colors.none, style = 'bold,underline' },

        -- TelescopeNormal = { bg = colors.none, fg = colors.none },
        -- TelescopeBorder = { bg = colors.none, fg = colors.none },

        -- TelescopePromptTitle = { bg = colors.purple, fg = colors.bg },
        -- TelescopePromptNormal = { bg = colors.highlight },
        -- TelescopePromptBorder = { bg = colors.highlight, fg = colors.highlight },

        -- TelescopePreviewTitle = { bg = colors.green, fg = colors.bg },
        -- TelescopePreviewNormal = { bg = colors.none },
        -- TelescopePreviewBorder = { bg = colors.bg, fg = colors.bg },

        -- TelescopeResultsTitle = { bg = colors.yellow, fg = colors.bg },
        -- TelescopeResultsNormal = { bg = colors.none },
        -- TelescopeResultsBorder = { bg = colors.bg, fg = colors.bg },

        RenderMarkdownH1Bg = { bg = colors.bg, fg = colors.green },
        RenderMarkdownH2Bg = { bg = colors.bg, fg = colors.yellow },
        RenderMarkdownH3Bg = { bg = colors.bg, fg = colors.purple },
        RenderMarkdownH4Bg = { bg = colors.bg, fg = colors.magenta },
        RenderMarkdownH5Bg = { bg = colors.bg, fg = colors.blue },
        RenderMarkdownH6Bg = { bg = colors.bg, fg = colors.cyan },

      },
      custom_colors = {}, -- Overwrite default colors
    })
    vim.cmd([[colorscheme onenord]])
  end,
}
