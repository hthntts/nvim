local utils = require('core/utils')
local map = utils.map

return {
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

  -- Navigation between tmux panes and vim
  {
    "christoomey/vim-tmux-navigator",
    event = 'VeryLazy',
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<M-h>",  "<cmd>TmuxNavigateLeft<cr>" },
      { "<M-j>",  "<cmd>TmuxNavigateDown<cr>" },
      { "<M-k>",  "<cmd>TmuxNavigateUp<cr>" },
      { "<M-l>",  "<cmd>TmuxNavigateRight<cr>" },
      { "<M-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
    },
  },

  -- sending lines, capturing content, creating terminals
  {
    -- echo $TMUX_PANE
    "juselara1/tmutils.nvim",
    event = 'VeryLazy',
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      require("tmutils").setup({})
      map("n", "<leader>oC", ":TmutilsConfig<CR>", "Tmutils config")
      map("n", "<leader>oc", ":TmutilsCapture newbuffer<CR>", "Tmutils capture")
      map("n", "<leader>os", ":.TmutilsSend<CR>", "Tmutils send")
      map("v", "<leader>os", ":TmutilsSend<CR>", "Tmutils send")
    end,
  },

  -- -- Tunnell text from neovim to a tmux
  -- {
  --   "sourproton/tunnell.nvim",
  --   event = "BufReadPre",
  --   cmd = {
  --     "TunnellCell",
  --     "TunnellRange",
  --     "TunnellConfig",
  --   },
  --   keys = {
  --     { "<leader>os", ":TunnellCell<CR>",   mode = { "n" }, silent = true, desc = "REPL cell" },
  --     { "<leader>os", ":TunnellRange<CR>",  mode = { "v" }, silent = true, desc = "REPL range" },
  --     { "<leader>oC", ":TunnellConfig<CR>", mode = { "n" }, silent = true, desc = "REPL config" },
  --   },
  --   opts = {
  --     cell_header = "# %%",
  --     tmux_target = "{right-of}",
  --   },
  -- },

  -- Tmuxinator with telescope
  {
    -- Config layout: tmux list-windows | sed -n 's/.*layout \(.*\)] @.*/\1/p'
    "danielpieper/telescope-tmuxinator.nvim",
    event = 'VeryLazy',
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require('telescope').load_extension('tmuxinator')
      map("n", "<leader>pt",
        "<cmd>lua require('telescope').extensions.tmuxinator.projects(require('telescope.themes').get_dropdown({}))<cr>",
        "Tmuxinator Project")
      -- vim.keymap.set("n", "<leader>pt",
      --   "<cmd>lua require('telescope').extensions.tmuxinator.projects(require('telescope.themes').get_dropdown({}))<cr>",
      --   { desc = "Tmuxinator Project" })
    end,
  },

}
