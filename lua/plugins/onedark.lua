-- return {
--   "navarasu/onedark.nvim",
--   -- lazy = false, -- make sure we load this during startup if it is your main colorscheme
--   commit = "dd640f6",
--   -- priority = 1000, -- make sure to load this before all the other start plugins
--   config = function()
--     local config = {
--       -- Main options --
--       style = "dark",               -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
--       transparent = false,          -- Show/hide background
--       term_colors = true,           -- Change terminal color as per the selected theme style
--       ending_tildes = false,        -- Show the end-of-buffer tildes. By default they are hidden
--       cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

--       -- toggle theme style ---
--       -- toggle_style_key = "<leader>th",                                                     -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
--       -- toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

--       -- Change code style ---
--       -- Options are italic, bold, underline, none
--       -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
--       code_style = {
--         comments = "italic",
--         keywords = "none",
--         functions = "none",
--         strings = "none",
--         variables = "none",
--       },

--       -- Lualine options --
--       lualine = {
--         transparent = false, -- lualine center bar transparency
--       },

--       -- Custom Highlights --
--       colors = {
--         -- purple = '#56b6c2',
--       },               -- Override default colors
--       highlights = {}, -- Override highlight groups

--       -- Plugins Config --
--       diagnostics = {
--         darker = true,     -- darker colors for diagnostic
--         undercurl = true,  -- use undercurl instead of underline for diagnostics
--         background = true, -- use background color for virtual text
--       },
--     }

--     local onedark = require("onedark")
--     onedark.setup(config)
--     onedark.load()

--     -- Make the background of diagnostics messages transparent
--     local set_diagnostics_bg_transparency = function()
--       vim.cmd([[highlight DiagnosticVirtualTextError guibg=none]])
--       vim.cmd([[highlight DiagnosticVirtualTextWarn guibg=none]])
--       vim.cmd([[highlight DiagnosticVirtualTextInfo guibg=none]])
--       vim.cmd([[highlight DiagnosticVirtualTextHint guibg=none]])
--     end
--     set_diagnostics_bg_transparency()

--     -- Toggle background transparency
--     local toggle_transparency = function()
--       config.transparent = not config.transparent
--       onedark.setup(config)
--       onedark.load()
--       set_diagnostics_bg_transparency()
--     end

--     local colors = require("onedark.colors")

--     vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = colors.none, fg = colors.none })
--     vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = colors.none, fg = colors.none })

--     vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { bg = colors.purple, fg = colors.bg })
--     vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = colors.bg2 })
--     vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = colors.bg2, fg = colors.bg2 })

--     vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { bg = colors.green, fg = colors.bg1 })
--     vim.api.nvim_set_hl(0, 'TelescopePreviewNormal', { bg = colors.bg1 })
--     vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { bg = colors.bg1, fg = colors.bg1 })

--     vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { bg = colors.yellow, fg = colors.bg1 })
--     vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', { bg = colors.bg1 })
--     vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { bg = colors.bg1, fg = colors.bg1 })

--     vim.api.nvim_set_hl(0, 'RenderMarkdownH1Bg', { bg = colors.none, fg = colors.green })
--     vim.api.nvim_set_hl(0, 'RenderMarkdownH2Bg', { bg = colors.none, fg = colors.yellow })
--     vim.api.nvim_set_hl(0, 'RenderMarkdownH3Bg', { bg = colors.none, fg = colors.purple })
--     vim.api.nvim_set_hl(0, 'RenderMarkdownH4Bg', { bg = colors.none, fg = colors.orange })
--     vim.api.nvim_set_hl(0, 'RenderMarkdownH5Bg', { bg = colors.none, fg = colors.blue })
--     vim.api.nvim_set_hl(0, 'RenderMarkdownH6Bg', { bg = colors.none, fg = colors.cyan })

--     vim.keymap.set("n", "<leader>tt", toggle_transparency, { noremap = true, silent = true })
--   end,
-- }

-- -- OneDark colors
-- --   black = "#181a1f",
-- --   bg0 = "#282c34",
-- --   bg1 = "#31353f",
-- --   bg2 = "#393f4a",
-- --   bg3 = "#3b3f4c",
-- --   bg_d = "#21252b",
-- --   bg_blue = "#73b8f1",
-- --   bg_yellow = "#ebd09c",
-- --   fg = "#abb2bf",
-- --   purple = "#c678dd",
-- --   green = "#98c379",
-- --   orange = "#d19a66",
-- --   blue = "#61afef",
-- --   yellow = "#e5c07b",
-- --   cyan = "#56b6c2",
-- --   red = "#e86671",
-- --   grey = "#5c6370",
-- --   light_grey = "#848b98",
-- --   dark_cyan = "#2b6f77",
-- --   dark_red = "#993939",
-- --   dark_yellow = "#93691d",
-- --   dark_purple = "#8a3fa0",
-- --   diff_add = "#31392b",
-- --   diff_delete = "#382b2c",
-- --   diff_change = "#1c3448",
-- --   diff_text = "#2c5372",

-------------
-- Onedark --
-------------
---@diagnostic disable: missing-fields
return {
  'mawkler/onedark.nvim',
  priority = 999,
  config = function()
    local colors = require('onedark.colors').setup()
    local style = require('onedark.types').od.HighlightStyle

    local barbar_bg = '#1d2026'
    local barbar_bg_visible = '#23262d'
    local barbar_fg_gray = '#3b4048'
    local cursorline_bg = '#2f343d'
    local treesitter_context_bg = '#252933'

    require('onedark').setup({
      hide_end_of_buffer = false,
      dev = true,
      hot_reload = false,
      colors = {
        bg_search = colors.bg_visual,
        hint = colors.dev_icons.gray,
        -- bg_float = colors.bg_highlight,
        git = {
          add = colors.green0,
          change = colors.orange1,
          delete = colors.red1
        }
      },
      overrides = function(c)
        return {
          -- General
          Substitute                               = { link = 'Search' },
          Title                                    = { fg = c.red0, style = style.Bold },
          Folded                                   = { fg = c.fg_dark, bg = c.bg1 },
          FloatBorder                              = { fg = c.blue0, bg = c.bg_float },
          Search                                   = { bg = c.bg_search },
          SpecialKey                               = { fg = c.blue0 },
          SpecialKeyWin                            = { link = 'Comment' },
          IncSearch                                = { bg = c.blue0 },
          CurSearch                                = { link = 'Search' },
          WinSeparator                             = { fg = barbar_bg, style = style.Bold },
          MatchParen                               = { fg = nil, bg = c.bg_search, style = style.Bold },
          CursorLine                               = { bg = cursorline_bg },
          CursorColumn                             = { link = 'CursorLine' },
          CursorLineNr                             = { fg = c.green0, bg = cursorline_bg, style = style.Bold },
          MsgArea                                  = { link = 'Normal' },
          SpellBad                                 = { style = style.Undercurl, sp = c.red1 },
          Todo                                     = { link = '@text.warning' },

          -- Modes
          NormalMode                               = { fg = c.green0, bg = cursorline_bg, style = style.Bold },
          InsertMode                               = { fg = c.blue0, bg = cursorline_bg, style = style.Bold },
          VisualMode                               = { fg = c.purple0, style = style.Bold },
          CommandMode                              = { fg = c.red0, bg = cursorline_bg, style = style.Bold },
          SelectMode                               = { fg = c.cyan0, bg = cursorline_bg, style = style.Bold },
          ReplaceMode                              = { fg = c.red2, bg = cursorline_bg, style = style.Bold },
          TerminalMode                             = { fg = c.green0, bg = cursorline_bg, style = style.Bold },
          TerminalNormalMode                       = { link = 'NormalMode' },

          -- Custom highlights
          InlineHint                               = { fg = c.bg_visual },
          LspCodeLens                              = { link = 'InlineHint' },
          LspCodeLensSeparator                     = { link = 'LspCodeLens' },

          -- Quickfix
          qfLineNr                                 = { fg = c.fg_gutter },

          -- Treesitter
          ['@tag.delimiter']                       = { link = 'TSPunctBracket' },
          ['@text.note']                           = { fg = c.info, style = style.Bold },
          ['@text.warning']                        = { fg = c.warning, style = style.Bold },
          ['@text.danger']                         = { fg = c.error, style = style.Bold },
          ['@lsp.type.comment']                    = {}, -- Use Treesitter's highlight instead, which supports TODO, NOTE, etc.

          -- Markdown (Treesitter)
          ['@text.literal']                        = { fg = c.green0 },
          ['@text.emphasis']                       = { fg = c.purple0, style = style.Italic },
          ['@text.strong']                         = { fg = c.orange0, style = style.Bold },
          ['@punctuation.special']                 = { fg = c.red0 },
          ['@text.todo.checked.markdown']          = { fg = c.blue1 },
          ['@text.todo.unchecked.markdown']        = { link = '@text.todo.checked.markdown' },
          ['@markup.italic']                       = { fg = c.purple0, style = style.Italic },
          ['@markup.strong']                       = { fg = c.orange0, style = style.Bold },

          -- Markdown/html
          mkdLink                                  = { fg = c.blue0, style = style.Underline },
          mkdHeading                               = { link = 'Title' },
          markdownTag                              = { fg = c.purple0, style = style.Bold },
          markdownUrl                              = { link = 'mkdLink' },
          markdownWikiLink                         = { fg = c.blue0, sylte = style.Bold },
          ['@punctuation.bracket.markdown_inline'] = { link = 'markdownWikiLink' },
          ['@markup.quote.markdown']               = { fg = c.fg_dark },
          htmlBold                                 = { fg = c.orange0, style = style.Bold },
          htmlItalic                               = { fg = c.purple0, style = style.Italic },

          -- TypeScript
          typescriptParens                         = { link = 'TSPunctBracket' },

          -- Git commit
          gitcommitOverflow                        = { link = 'Error' },
          gitcommitSummary                         = { link = 'htmlBold' },

          -- QuickScope
          QuickScopePrimary                        = { fg = c.red0, style = style.Bold },
          QuickScopeSecondary                      = { fg = c.orange1, style = style.Bold },

          -- Eyeliner
          EyelinerPrimary                          = { fg = c.red0, style = style.Bold },
          EyelinerSecondary                        = { fg = c.orange1, style = style.Bold },
          EyelinerDimmed                           = { fg = c.fg_dark },

          -- NvimTree
          NvimTreeFolderIcon                       = { fg = '#8094b4' },
          NvimTreeFolderName                       = { fg = c.blue0 },
          NvimTreeOpenedFolderName                 = { fg = c.blue0, style = style.Bold },
          NvimTreeOpenedFile                       = { style = style.Bold },
          NvimTreeGitDirty                         = { fg = c.orange1 },
          NvimTreeGitNew                           = { fg = c.green0 },
          NvimTreeGitIgnored                       = { fg = c.fg_dark },
          NvimTreeRootFolder                       = { fg = c.fg0, style = style.Bold },

          -- Telescope
          TelescopeMatching                        = { fg = c.blue0, style = style.Bold },
          TelescopePromptPrefix                    = { fg = c.fg0, style = style.Bold },
          TelescopePathSeparator                   = { fg = c.fg_dark },

          -- LSP
          LspReferenceText                         = { link = 'Search' },
          LspReferenceRead                         = { link = 'Search' },
          LspReferenceWrite                        = { link = 'Search' },

          -- Diagnostics
          DiagnosticUnderlineError                 = { style = style.Underline, sp = c.error },
          DiagnosticUnderlineWarn                  = { style = style.Underline, sp = c.warning },
          DiagnosticUnderlineHint                  = { style = style.Underline, sp = c.hint },
          DiagnosticUnderlineInfo                  = { style = style.Underline, sp = c.info },

          -- nvim-cmp
          PmenuSel                                 = { fg = c.bg1, bg = c.blue0 },
          CmpItemAbbrMatch                         = { fg = c.blue0, style = style.Bold },
          CmpItemAbbrMatchFuzzy                    = { link = 'CmpItemAbbrMatch' },
          CmpItemKindFile                          = { link = 'NvimTreeFolderIcon' },
          CmpItemKindFolder                        = { link = 'CmpItemKindFile' },

          -- Gitsigns
          GitSignsDeleteLn                         = { link = 'GitSignsDeleteVirtLn' },
          GitSignsAdd                              = { fg = colors.green0 },

          -- Fidget
          FidgetTitle                              = { fg = c.blue0, style = style.Bold },

          -- Barbar
          BufferCurrentTarget                      = { fg = c.blue0, bg = c.bg0, style = style.Bold },
          BufferVisible                            = { fg = c.fg0, bg = barbar_bg_visible },
          BufferVisibleSign                        = { fg = barbar_fg_gray, bg = barbar_bg_visible },
          BufferVisibleMod                         = { fg = c.warning, bg = barbar_bg_visible },
          BufferVisibleIndex                       = { fg = barbar_fg_gray, bg = barbar_bg_visible },
          BufferVisibleTarget                      = { fg = c.blue0, bg = barbar_bg_visible, style = style.Bold },
          BufferTabpageFill                        = { fg = barbar_fg_gray, bg = barbar_bg },
          BufferTabpages                           = { fg = c.blue0, bg = barbar_bg, style = style.Bold },
          BufferTabPagesSep                        = { link = 'BufferTabpages' },
          BufferInactive                           = { fg = '#707070', bg = barbar_bg },
          BufferInactiveSign                       = { fg = barbar_fg_gray, bg = barbar_bg },
          BufferInactiveMod                        = { fg = c.warning, bg = barbar_bg },
          BufferInactiveTarget                     = { fg = c.blue0, bg = barbar_bg, style = style.Bold },
          BufferInactiveIndex                      = { fg = barbar_fg_gray, bg = barbar_bg },
          BufferModifiedIndex                      = { fg = barbar_fg_gray, bg = barbar_bg },

          -- Grammarous
          GrammarousError                          = { style = style.Undercurl, sp = c.error },

          -- Scrollbar
          Scrollbar                                = { fg = c.bg_visual, bg = nil },

          -- Leap
          LeapMatch                                = { fg = c.orange0, style = string.format('%s,%s', style.Bold, style.Underline) },
          LeapLabel                                = { fg = c.green0, style = style.Bold },
          LeapBackdrop                             = { fg = c.fg_dark },

          -- Alpha
          AlphaHeader                              = { fg = c.green0, style = style.Bold },

          -- Treesitter context
          TreesitterContext                        = { bg = treesitter_context_bg },
          TreesitterContextLineNumber              = { fg = c.fg_gutter, bg = treesitter_context_bg },

          -- Mini indentscope
          MiniIndentScopeSymbol                    = { fg = '#39536c', style = style.Bold },

          -- Nvim-Tree
          NvimTreeIndentMarker                     = { link = 'IblIndent' },

          -- Crates
          CratesNvimVersion                        = { fg = c.fg_dark },
          CratesNvimLoading                        = { link = 'CratesNvimVersion' },

          -- Fidget
          FidgetNormal                             = { fg = c.fg_dark },

          -- Neotest
          NeotestFile                              = { fg = c.blue0 },
          NeotestDir                               = { link = 'NvimTreeFolderIcon' },
          NeotestAdapterName                       = { link = 'Title' },
          NeotestFailed                            = { fg = c.red0 },
          NeotestPassed                            = { fg = c.green0 },
          NeotestRunning                           = { fg = c.orange0 },
          NeotestWatching                          = { fg = c.orange1 },
          NeotestSkipped                           = { fg = c.fg_dark },
          NeotestUnknown                           = { link = 'NeotestSkipped' },
          NeotestMarked                            = { fg = c.purple0 },
          NeotestFocused                           = { style = style.Bold },
          ['@text.uri']                            = { link = '@markup.link.url' }, -- temporary fix for rest.nvim

          -- Gitsigns
          GitSignsAddInline                        = { link = 'DiffText' },

          -- Headlines
          Headline                                 = { fg = c.red0, bg = c.bg_visual },

          -- Helpview
          HelpviewTagLink                          = { fg = c.blue0 },
          HelpviewMentionLink                      = { fg = c.blue0, style = style.Italic },
        }
      end
    })
  end
}
