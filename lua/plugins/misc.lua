-- Standalone plugins with less than 10 lines of config go here
local utils = require("core/utils")

return {
  {
    "gelguy/wilder.nvim",
    event = 'VeryLazy'
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    event = "VeryLazy",
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
    cmd = "Barbecue",
    event = { "BufReadPre" },
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
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },

  -- Better ui for some nvim actions
  { "stevearc/dressing.nvim",   event = 'BufReadPre', },

  -- Highlight URLs inside vim
  { "itchyny/vim-highlighturl", event = "BufReadPre" },

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

  -- Unicode glyphs
  {
    "chrisbra/unicode.vim",
    cmd = { "UnicodeName" },
    keys = {
      { "<leader>un", "<cmd>UnicodeName<cr>", desc = "Unicode name" },
    }
  },

  -- Show and trim trailing whitespaces
  {
    "jdhao/whitespace.nvim",
    lazy = true,
  },

  -- Syntax for TOML
  {
    "cespare/vim-toml",
    branch = "main",
    ft = { "toml" },
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

  -- Tunnell text from neovim to a tmux
  {
    "sourproton/tunnell.nvim",
    cmd = {
      "TunnellCell",
      "TunnellRange",
      "TunnellConfig",
    },
    keys = {
      { "<leader>oR", ":TunnellCell<CR>",   mode = { "n" }, silent = true, desc = "REPL cell" },
      { "<leader>or", ":TunnellRange<CR>",  mode = { "v" }, silent = true, desc = "REPL range" },
      { "<leader>oC", ":TunnellConfig<CR>", mode = { "n" }, silent = true, desc = "REPL config" },
    },
    opts = {
      cell_header = "# %%",
      tmux_target = "{right-of}",
    },
    event = "BufReadPre",
  },

  -- A multi cursor plugin
  {
    "smoka7/multicursors.nvim",
    cmd = {
      'MCstart',
      'MCvisual',
      'MCclear',
      'MCpattern',
      'MCvisualPattern',
      'MCunderCursor'
    },
    dependencies = {
      'nvimtools/hydra.nvim',
    },
    keys = {
      {
        mode = { 'v', 'n' },
        '<M-d>',
        '<cmd>MCvisual<cr>',
        desc = 'Multi Cursors',
      },
    },
    opts = {
      hint_config = {
        float_opts = {
          border = 'rounded',
        },
        position = 'bottom-right',
      },
      generate_hints = {
        normal = true,
        insert = true,
        extend = true,
        config = {
          column_count = 1,
        },
      }
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
    cmd = {
      "ColorizerToggle",
    },
    keys = {
      { "<leader>tc", "<cmd>ColorizerToggle<cr>", desc = "Toogle colors" },
    },
    opts = {},
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
    event = 'BufReadPre',
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  -- Diffs for all modified files
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewFileHistory",
      "DiffviewOpen",
    },
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
    lazy = true,
    event = { "BufReadPre" },
    version = "*",
    config = true,
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
}
