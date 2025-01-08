-- Standalone plugins with less than 10 lines of config go here
local utils = require("core/utils")

return {
  { "gelguy/wilder.nvim" },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },

  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },

  -- Automatic insertion and deletion of a pair of characters
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- Better ui for some nvim actions
  { "stevearc/dressing.nvim" },

  -- Highlight URLs inside vim
  { "itchyny/vim-highlighturl", event = "VeryLazy" },

  -- Dimmer inactive buffer
  {
    "TaDaa/vimade",
    config = function()
      require('vimade').setup({
        recipe = { 'default', { animate = true } },
        ncmode = 'buffers',
        fadelevel = 0.7,
        tint = {},
      })
    end,
    event = "VeryLazy",
  },

  -- Unicode glyphs
  {
    "chrisbra/unicode.vim",
    cmd = { "UnicodeName" },
    event = "VeryLazy"
  },

  -- Show and trim trailing whitespaces
  {
    "jdhao/whitespace.nvim",
    event = "VeryLazy",
  },

  -- Syntax for TOML
  {
    "cespare/vim-toml",
    ft = { "toml" },
    branch = "main",
    event = "VeryLazy",
  },

  -- Syntax for tmux
  {
    "tmux-plugins/vim-tmux",
    enabled = function()
      if utils.executable("tmux") then
        return true
      end
      return false
    end,
    ft = { "tmux" },
    event = "VeryLazy",
  },

  -- Asynchronous command execution
  {
    -- :AsyncRun python -u "%"
    "skywind3000/asyncrun.vim",
    config = function()
      vim.g.asyncrun_open = 12
    end,
    cmd = { "AsyncRun" },
    event = "VeryLazy",
  },

  -- Tunnell text from neovim to a tmux
  {
    -- :TunnellCell
    -- :TunnellRange
    -- :TunnellConfig
    "sourproton/tunnell.nvim",
    opts = {
      cell_header = "# %%",
      tmux_target = "{right-of}",
    },
    keys = {
      { "<leader>oR", ":TunnellCell<CR>",   mode = { "n" }, silent = true, desc = "[R]EPL cell" },
      { "<leader>or", ":TunnellRange<CR>",  mode = { "v" }, silent = true, desc = "[r]EPL range" },
      { "<leader>oC", ":TunnellConfig<CR>", mode = { "n" }, silent = true, desc = "REPL [C]onfig" },
    },
    cmd = {
      "TunnellCell",
      "TunnellRange",
      "TunnellConfig",
    },
    event = "VeryLazy",
  },

  -- A multi cursor plugin
  {
    -- :MCstart
    -- :MCvisual
    -- :MCclear
    -- :MCpattern
    -- :MCvisualPattern
    -- :MCunderCursor
    "smoka7/multicursors.nvim",
    dependencies = {
      'nvimtools/hydra.nvim',
    },
    opts = {},
    cmd = {
      'MCstart',
      'MCvisual',
      'MCclear',
      'MCpattern',
      'MCvisualPattern',
      'MCunderCursor'
    },
    keys = {
      {
        mode = { 'v', 'n' },
        '<M-d>',
        '<cmd>MCvisual<cr>',
        desc = 'Multi Cursors',
      },
    },
    event = "VeryLazy",
  },

  -- Show file tags in vim window
  {
    -- :Vista
    "liuchengxu/vista.vim",
    enabled = function()
      if utils.executable("ctags") then
        return true
      else
        return false
      end
    end,
    config = function()
      vim.g.vista_echo_cursor = 0
      vim.g.vista_stay_on_open = 0
    end,
    cmd = "Vista",
    event = "VeryLazy",
  },

  -- High-performance color highlighter
  {
    -- :ColorizerToggle
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
    event = "VeryLazy",
  },

  -- Highlight todo, notes, etc in comments
  {
    -- :TodoLocList
    -- :TodoQuickFix
    -- :TodoTelescope
    -- :TodoTelescope cwd=~/projects/foobar
    -- :TodoTelescope keywords=TODO,FIX
    -- :Trouble todo
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  -- Diffs for all modified files
  {
    -- :DiffviewFileHistory
    -- :DiffviewOpen
    "sindrets/diffview.nvim",
    event = "VeryLazy",
  },

  -- Git conflict
  {
    -- GitConflictChooseOurs — Select the current changes.
    -- GitConflictChooseTheirs — Select the incoming changes.
    -- GitConflictChooseBoth — Select both changes.
    -- GitConflictChooseNone — Select none of the changes.
    -- GitConflictNextConflict — Move to the next conflict.
    -- GitConflictPrevConflict — Move to the previous conflict.
    -- GitConflictListQf — Get all conflict to quickfix
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
    event = "VeryLazy",
  },
  -- Show undo history visually
  {
    -- :MundoToggle
    -- :MundoShow
    "simnalamburt/vim-mundo",
    config = function()
      vim.g.mundo_verbose_graph = 0
      vim.g.mundo_width = 60
    end,
    cmd = { "MundoToggle", "MundoShow" },
    event = "VeryLazy",
  },
}
