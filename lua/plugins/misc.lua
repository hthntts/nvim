-- Standalone plugins with less than 10 lines of config go here

return {
  -- Collection of various small independent plugins/modules
  {
    'echasnovski/mini.nvim',
    event = "VeryLazy",
    config = function()
      -- Better Around/Inside textobjects
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      require('mini.cursorword').setup { delay = 100 }
    end,
  },

  -- Automatic insertion and deletion of a pair of characters
  {
    "windwp/nvim-autopairs",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },

  -- Peek lines just when you intend
  {
    'nacro90/numb.nvim',
    event = 'VeryLazy',
    opts = {
      show_numbers = true,
      show_cursorline = true,
      hide_relativenumbers = true,
      number_only = false,
      centered_peeking = true,
    },
  },

  -- Establish good command workflow and quit bad habit
  {
    "m4xshen/hardtime.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    opts = {}
  },

  -- Better ui for some nvim actions
  { "stevearc/dressing.nvim",   event = 'BufReadPre', },

  -- Highlight URLs inside vim
  { "itchyny/vim-highlighturl", event = "BufReadPre" },

  -- Adventurous wildmenu
  { "gelguy/wilder.nvim",       event = 'VeryLazy', },

  -- Show and trim trailing whitespaces
  { "jdhao/whitespace.nvim",    lazy = true, },

  -- Breadcrumbs plugin
  {
    "utilyre/barbecue.nvim",
    event = "BufReadPre",
    cmd = "Barbecue",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      exclude_filetypes = { "netrw", "toggleterm" },
    },
  },

  -- Show file tags in vim window
  {
    "liuchengxu/vista.vim",
    cmd = "Vista",
    keys = {
      { "<leader>ts", "<cmd>Vista!!<cr>", desc = "Toogle symbol" },
    },
    -- enabled = function()
    --   if utils.executable("ctags") then
    --     return true
    --   else
    --     return false
    --   end
    -- end,
    config = function()
      vim.g.vista_echo_cursor = 0
      vim.g.vista_stay_on_open = 0
    end,
  },

  -- High-performance color highlighter
  {
    "norcalli/nvim-colorizer.lua",
    event = 'VeryLazy',

    cmd = {
      "ColorizerToggle",
    },
    keys = {
      { "<leader>tc", "<cmd>ColorizerToggle<cr>", desc = "Toogle colors" },
    },
    opts = {},
  },

  -- Dimmer inactive buffer
  {
    "TaDaa/vimade",
    event = 'VeryLazy',
    opts = {
      recipe = { 'default', { animate = true } },
      ncmode = 'buffers',
      fadelevel = 0.7,
      tint = {},
    }
  },

  -- Diffs for all modified files
  {
    "sindrets/diffview.nvim",
    event = 'VeryLazy',
    cmd = {
      "DiffviewFileHistory",
      "DiffviewOpen",
    },
  },

  -- Unicode glyphs
  {
    "chrisbra/unicode.vim",
    cmd = { "UnicodeName" },
    keys = {
      { "<leader>un", "<cmd>UnicodeName<cr>", desc = "Unicode name" },
    }
  },

  -- Show undo history visually
  {
    "simnalamburt/vim-mundo",
    cmd = {
      "MundoToggle",
      "MundoShow"
    },
    keys = {
      { "<leader>tm", "<cmd>MundoToggle<cr>", desc = "Toggle mundo" },
    },
    config = function()
      vim.g.mundo_verbose_graph = 0
      vim.g.mundo_width = 60
    end,
  },

  -- Asynchronous command execution
  {
    -- :AsyncRun python -u "%"
    "skywind3000/asyncrun.vim",
    cmd = { "AsyncRun" },
    config = function()
      vim.g.asyncrun_open = 12
    end,
  },

  -- Remote (sshfs)
  {
    "nosduco/remote-sshfs.nvim",
    event = 'VeryLazy',
    dependencies = "nvim-telescope/telescope.nvim",
    opts = {
    },
  },
}
