return {
  "shaunsingh/nord.nvim",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    -- Example config in lua
    vim.g.nord_contrast = true                   -- Make sidebars and popup menus like nvim-tree and telescope have a different background
    vim.g.nord_borders = false                   -- Enable the border between verticaly split windows visable
    vim.g.nord_disable_background = true         -- Disable the setting of background color so that NeoVim can use your terminal background
    vim.g.set_cursorline_transparent = false     -- Set the cursorline transparent/visible
    vim.g.nord_italic = false                    -- enables/disables italics
    vim.g.nord_enable_sidebar_background = false -- Re-enables the background of the sidebar if you disabled the background of everything
    vim.g.nord_uniform_diff_background = true    -- enables/disables colorful backgrounds when used in diff mode
    vim.g.nord_bold = false                      -- enables/disables bold

    -- Load the colorscheme
    require("nord").set()

    -- Function to set menu borders to transparent
    local set_menu_border_transparency = function()
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE', fg = 'NONE' })
      vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE', fg = 'NONE' })
    end

    -- Execute the function once after loading the colorscheme
    -- set_menu_border_transparency()

    local bg_transparent = true

    -- Toggle background transparency
    local toggle_transparency = function()
      bg_transparent = not bg_transparent
      vim.g.nord_disable_background = bg_transparent
      vim.cmd([[colorscheme nord]])
      -- set_menu_border_transparency()
    end

    local colors = require("nord.colors")

    vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = colors.nord1_gui, fg = colors.nord6_gui })
    vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = colors.nord1_gui, fg = colors.nord1_gui })

    vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { bg = colors.nord15_gui, fg = colors.nord0_gui })
    vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = colors.nord3_gui_bright })
    vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = colors.nord3_gui_bright, fg = colors.nord3_gui_bright })

    vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { bg = colors.nord14_gui, fg = colors.nord0_gui })
    vim.api.nvim_set_hl(0, 'TelescopePreviewNormal', { bg = colors.nord1_gui })
    vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { bg = colors.none, fg = colors.none })

    vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { bg = colors.nord13_gui, fg = colors.nord0_gui })
    vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', { bg = colors.nord1_gui })
    vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { bg = colors.none, fg = colors.none })

    vim.api.nvim_set_hl(0, 'RenderMarkdownH1Bg', { bg = colors.none, fg = colors.nord14_gui })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH2Bg', { bg = colors.none, fg = colors.nord13_gui })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH3Bg', { bg = colors.none, fg = colors.nord15_gui })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH4Bg', { bg = colors.none, fg = colors.nord9_gui })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH5Bg', { bg = colors.none, fg = colors.nord10_gui })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH6Bg', { bg = colors.none, fg = colors.nord7_gui })

    vim.keymap.set("n", "<leader>tt", toggle_transparency, { desc = "Toggle [t]ransparent" })
  end,
}
