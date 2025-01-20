-- Standalone plugins with less than 10 lines of config go here

return {
  -- Automatic insertion and deletion of a pair of characters
  {
    'windwp/nvim-autopairs',
    event = { 'BufReadPre', 'BufNewFile' },
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

  -- Better ui for some nvim actions
  { 'stevearc/dressing.nvim',   event = 'BufReadPre', },

  -- Highlight URLs inside vim
  { 'itchyny/vim-highlighturl', event = 'BufReadPre' },

  -- -- Adventurous wildmenu
  -- { 'gelguy/wilder.nvim',       event = 'VeryLazy', },

  -- Show and trim trailing whitespaces
  { 'jdhao/whitespace.nvim' },

  -- Breadcrumbs plugin
  {
    'utilyre/barbecue.nvim',
    event = 'BufReadPre',
    cmd = 'Barbecue',
    name = 'barbecue',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons', -- optional dependency
    },
    opts = {
      exclude_filetypes = { 'netrw', 'toggleterm', 'neo-tree', 'fern', 'oil' },
    },
  },

  -- High-performance color highlighter
  {
    'norcalli/nvim-colorizer.lua',
    event = 'VeryLazy',

    cmd = {
      'ColorizerToggle',
    },
    keys = {
      { '<leader>tc', '<cmd>ColorizerToggle<cr>', desc = 'Toogle colors' },
    },
    opts = {},
  },

  -- Dimmer inactive buffer
  {
    'TaDaa/vimade',
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
    'sindrets/diffview.nvim',
    event = 'VeryLazy',
    cmd = {
      'DiffviewFileHistory',
      'DiffviewOpen',
    },
  },

  -- Unicode glyphs
  {
    'chrisbra/unicode.vim',
    cmd = { 'UnicodeName' },
    keys = {
      { '<leader>su', '<cmd>UnicodeName<cr>',            desc = 'Unicode characters' },
      { '<leader>un', '<PLug>(UnicodeSwapCompleteName)', mode = { 'n', 'x' },        desc = 'Toggle Unicode Complete Name' },
    }
  },

  -- Show undo history visually
  {
    'simnalamburt/vim-mundo',
    cmd = {
      'MundoToggle',
      'MundoShow'
    },
    keys = {
      { '<leader>tm', '<cmd>MundoToggle<cr>', desc = 'Toggle mundo' },
    },
    config = function()
      vim.g.mundo_verbose_graph = 0
      vim.g.mundo_width = 60
    end,
  },

  -- Asynchronous command execution
  {
    -- :AsyncRun python -u '%'
    'skywind3000/asyncrun.vim',
    cmd = { 'AsyncRun' },
    config = function()
      vim.g.asyncrun_open = 12
    end,
  },

  -- Remote (sshfs)
  {
    'nosduco/remote-sshfs.nvim',
    event = 'VeryLazy',
    dependencies = 'nvim-telescope/telescope.nvim',
    config = function()
      require('telescope').load_extension('remote-sshfs')
    end
  },

  -- -- Establish good command workflow and quit bad habit
  -- {
  --   'm4xshen/hardtime.nvim',
  --   dependencies = 'MunifTanjim/nui.nvim',
  --   opts = {}
  -- },

}
