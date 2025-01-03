local utils = require("core/utils")

local plugin_dir = vim.fn.stdpath("data") .. "/lazy"
local lazypath = plugin_dir .. "/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local firenvim_not_active = function()
  return not vim.g.started_by_firenvim
end

local plugin_specs = {
  -- tmux navigator (Alt+h/j/k/l)
  {
    "numToStr/Navigator.nvim",
    config = function()
      require("config.navigator")
    end,
    event = "VeryLazy",
  },

  -- tmux config syntax highlighting and setting check
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

  -- show match number and index for searching
  {
    "kevinhwang91/nvim-hlslens",
    branch = "main",
    keys = { "*", "#", "n", "N" },
    config = function()
      require("config.hlslens")
    end,
    event = "VeryLazy",
  },

  -- super fast buffer jump (f)
  {
    "smoka7/hop.nvim",
    config = function()
      require("config.hop")
    end,
    event = "VeryLazy",
  },

  -- move lines and blocks
  {
    'fedepujol/move.nvim',
    config = function()
      require("config.move")
    end,
    event = "VeryLazy",
  },

  -- duplicate lines and blocks
  {
    'hinell/duplicate.nvim',
    config = function()
      require("config.duplicate")
    end,
    event = "VeryLazy",
  },

  -- python-related text object
  { "jeetsukumaran/vim-pythonsense", ft = { "python" } },

  -- reorder delimited items (g< - g> - gs[h/l swap items, j/k choose item])
  { "machakann/vim-swap", event = "VeryLazy" },

  -- show and trim trailing whitespaces
  { "jdhao/whitespace.nvim", event = "VeryLazy" },

  -- session management plugin (vim -S to restore from file)
  { "tpope/vim-obsession", cmd = "Obsession", event = "VeryLazy" },

  -- unicode glyphs
  { "chrisbra/unicode.vim", event = "VeryLazy" },

  -- plugin to manipulate character pairs quickly (sa, sd, sr)
  { "machakann/vim-sandwich", event = "VeryLazy" },

  -- add indent object for vim (useful for languages like Python)
  { "michaeljsmith/vim-indent-object", event = "VeryLazy" },

  -- modern matchit implementation
  { "andymass/vim-matchup", event = "BufRead" },
  { "tpope/vim-scriptease", cmd = { "Scriptnames", "Messages", "Verbose" } },

  -- asynchronous command execution
  { "skywind3000/asyncrun.vim", lazy = true, cmd = { "AsyncRun" } },
  { "cespare/vim-toml", ft = { "toml" }, branch = "main" },

  -- automatic insertion and deletion of a pair of characters
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- comment plugin
  { "tpope/vim-commentary", event = "VeryLazy" },

  -- autosave files on certain events
  { "907th/vim-auto-save",
    config = function()
      vim.g.auto_save = 1
    end,
    event = "InsertEnter",
  },

  -- show undo history visually
  { "simnalamburt/vim-mundo",
    config = function()
      vim.g.mundo_verbose_graph = 0
      vim.g.mundo_width = 60
    end,
    cmd = { "MundoToggle", "MundoShow" },
  },

  -- manage your yank history
  {
    "gbprod/yanky.nvim",
    config = function()
      require("config.yanky")
    end,
    event = "VeryLazy",
  },

  -- handy unix command inside vim (rename, move etc.)
  { "tpope/vim-eunuch", cmd = { "Rename", "Delete" } },

  -- repeat vim motions
  { "tpope/vim-repeat", event = "VeryLazy" },

  -- jk to escape
  { "nvim-zh/better-escape.vim",
    config = function()
      vim.g.better_escape_interval = 200
    end,
    event = { "InsertEnter" }
  },

  -- auto format tools
  { "sbdchd/neoformat",
    config = function()
      vim.g.better_escape_interval = 200
    end,
    cmd = { "Neoformat" }
  },

  -- vim tabular plugin for manipulate tabular, required by markdown plugins
  { "godlygeek/tabular", cmd = { "Tabularize" } },

  -- another markdown plugin
  { "preservim/vim-markdown",
    config = function()
      require("config.markdown")
    end,
    ft = { "markdown" }
  },

  -- faster footnote generation
  { "vim-pandoc/vim-markdownfootnotes", ft = { "markdown" } },

  -- markdown previewing (only for mac and windows)
  {
    "iamcco/markdown-preview.nvim",
    enabled = function()
      if vim.g.is_win or vim.g.is_mac then
        vim.g.mkdp_auto_close = 0
        return true
      end
      return false
    end,
    build = "cd app && npm install",
    ft = { "markdown" },
  },

  -- highlight URLs inside vim
  { "itchyny/vim-highlighturl", event = "VeryLazy" },

  -- grammar checker
  { "rhysd/vim-grammarous", ft = { "markdown" } },

  -- show file tags in vim window
  {
    "liuchengxu/vista.vim",
    enabled = function()
      if utils.executable("ctags") then
        return true
      else
        return false
      end
    end,
    cmd = "Vista",
  },

  -- dimmer buffer
  {
    "TaDaa/vimade",
    event = "VeryLazy",
    config = function()
      require("config.vimade")
    end,
  },

  -- For Windows and Mac, we can open an URL in the browser. For Linux, it may
  -- not be possible since we maybe in a server which disables GUI.
  {
    "chrishrb/gx.nvim",
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" }, desc = "Browse" } },
    cmd = { "Browse" },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    enabled = function()
      if vim.g.is_win or vim.g.is_mac then
        return true
      else
        return false
      end
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true, -- default settings
    submodules = false, -- not needed, submodules are required only for tests
  },

  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      'nvimtools/hydra.nvim',
    },
    opts = {},
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    keys = {
        {
          mode = { 'v', 'n' }, '<Leader>m', '<cmd>MCvisual<cr>',
          desc = 'Multi Cursors',
        },
    },
    event = "VeryLazy",
  },

  -- ufo
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "VeryLazy",
    opts = {},
    init = function()
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = function()
      require("config.ufo")
    end,
  },

  {
    "sourproton/tunnell.nvim",
    opts = {
      cell_header = "# %%",
      tmux_target = "{right-of}",
    },
    keys = {
      { "<leader>or", ":TunnellCell<CR>",   mode = { "n" }, silent = true, desc = "REPL cell" },
      { "<leader>or", ":TunnellRange<CR>",  mode = { "v" }, silent = true, desc = "REPL range" },
      { "<leader>oR", ":TunnellConfig<CR>", mode = { "n" }, silent = true, desc = "REPL config" },
    },
    cmd = {
      "TunnellCell",
      "TunnellRange",
      "TunnellConfig",
    },
    event = "VeryLazy",
  },

  -- git command inside vim

  -- fugitive
  -- {
  --   "tpope/vim-fugitive",
  --   event = "User InGitRepo",
  --   config = function()
  --     require("config.fugitive")
  --   end,
  -- },

  -- neogit
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",
      "echasnovski/mini.pick",
    },
    config = function()
      require("config.neogit")
    end,
    event = "VeryLazy",
  },

  -- better git log display
  { "rbong/vim-flog", cmd = { "Flog" } },
  { "akinsho/git-conflict.nvim", version = "*", config = true },
  {
    "ruifm/gitlinker.nvim",
    event = "User InGitRepo",
    config = function()
      require("config.git-linker")
    end,
  },

  -- show git change (change, delete, add) signs in vim sign column
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("config.gitsigns")
    end,
  },

  {
    "smjonas/live-command.nvim",
    -- live-command supports semantic versioning via Git tags
    -- tag = "2.*",
    cmd = "Preview",
    config = function()
      require("config.live-command")
    end,
    event = "VeryLazy",
  },

  -- diff view
  {
    "sindrets/diffview.nvim",
  },

  -- better quickfix window
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("config.bqf")
    end,
  },

  -- fancy start screen
  {
    "nvimdev/dashboard-nvim",
    cond = firenvim_not_active,
    config = function()
      require("config.dashboard")
    end,
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    cond = firenvim_not_active,
    config = function()
      require("config.lualine")
    end,
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    event = { "BufEnter" },
    cond = firenvim_not_active,
    config = function()
      require("config.bufferline")
    end,
  },

  -- cmd center
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("config.noice")
    end,
  },

  -- better ui for some nvim actions
  { "stevearc/dressing.nvim" },

  {
    "luukvbaal/statuscol.nvim",
    opts = {},
    config = function()
      require("config.statuscol")
    end,
  },

  {
    "Bekaboo/dropbar.nvim",
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    config = function()
      require("config.indent-blankline")
    end,
  },

  {
    -- show hint for code actions, the user can also implement code actions themselves,
    -- see discussion here: https://github.com/neovim/neovim/issues/14869
    "kosayoda/nvim-lightbulb",
    config = function()
      require("nvim-lightbulb").setup { autocmd = { enabled = true } }
    end,
  },

  -- A list of colorscheme plugin
  { "navarasu/onedark.nvim", lazy = true },
  { "sainnhe/edge", lazy = true },
  { "sainnhe/sonokai", lazy = true },
  { "sainnhe/gruvbox-material", lazy = true },
  { "sainnhe/everforest", lazy = true },
  { "EdenEast/nightfox.nvim", lazy = true },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  { "olimorris/onedarkpro.nvim", lazy = true },
  {
    "rockyzhang24/arctic.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    name = "arctic",
    branch = "v2",
  },
  { "nvim-tree/nvim-web-devicons", event = "VeryLazy" },

  -- notification plugin
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      require("config.notify")
    end,
  },

  -- leaderf
  {
    "Yggdroot/LeaderF",
    cmd = "Leaderf",
    build = function()
      local leaderf_path = plugin_dir .. "/LeaderF"
      vim.opt.runtimepath:append(leaderf_path)
      vim.cmd("runtime! plugin/leaderf.vim")

      if not vim.g.is_win then
        vim.cmd("LeaderfInstallCExtension")
      end
    end,
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-telescope/telescope-symbols.nvim",
    },
    config = function()
      require("config.telescope")
    end,
  },

  -- fzf-lua
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup {}
    end,
  },

  -- file explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("config.nvim-tree")
    end,
    event = "VeryLazy",
  },

  {
    'lambdalisue/vim-fern',
    config = function()
      require("config.fern")
    end,
    event = "VeryLazy",
  },

  -- auto-completion engine
  {
    "iguanacucumber/magazine.nvim",
    name = "nvim-cmp",
    -- event = 'InsertEnter',
    event = "VeryLazy",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "onsails/lspkind-nvim",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-omni",
      "quangnguyen30192/cmp-nvim-ultisnips",
    },
    config = function()
      require("config.nvim-cmp")
    end,
  },

  -- lsp config
  {
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("config.nvim-lsp")
    end,
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = function()
      if vim.g.is_mac then
        return true
      end
      return false
    end,
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
      require("config.nvim-treesitter")
    end,
  },

  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    tag = "legacy",
    config = function()
      require("config.fidget")
    end,
  },


  -- markdown.nvim
  {
    "MeanderingProgrammer/markdown.nvim",
    main = "render-markdown",
    opts = { latex = { enabled = false } },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },

  -- Snippet engine and snippet template
  {
    "SirVer/ultisnips",
    dependencies = {
    "honza/vim-snippets",
    },
    event = "InsertEnter"
  },

  -- showing keybindings
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("config.which-key")
    end,
  },

}

require("lazy").setup {
  spec = plugin_specs,
  lockfile = vim.fn.stdpath('config') .. 'lua/core/plugins.json',
  ui = {
    border = "rounded",
    title = "Plugin Manager",
    title_pos = "center",
  },
  rocks = {
    enabled = false,
    hererocks = false,
  },
}

