local icons = require('core/icons')

return {
  "nvimdev/dashboard-nvim",
  event = "VeryLazy",
  cmd = "Dashboard",
  keys = {
    { "<leader>hd", "<cmd>Dashboard<cr>", desc = "Dashboard" },
  },
  opts = {
    theme = 'hyper',
    disable_move = false,
    shortcut_type = 'letter',
    change_to_vcs_root = true,
    hide = {
      statusline = true,
      tabline = false,
      winbar = false,
    },
    config = {
      week_header = {
        enable = true,
        append = { '', icons.ui.Circle .. ' Tux: Learn, Make, Explore! ' .. icons.ui.Circle },
      },
      packages = { enable = true },
      project = { enable = true, limit = 12, action = 'Telescope find_files cwd=' },
      mru = { limit = 12 },
      shortcut = {
        {
          desc = icons.ui.Package .. 'Lazy',
          group = '@property',
          action = 'Lazy',
          key = 'l',
        },
        {
          desc = icons.documents.OpenFolder .. 'Files',
          group = 'Label',
          action = 'Telescope find_files',
          key = 'f',
        },
        {
          desc = icons.ui.Search .. 'Search',
          group = 'Label',
          action = 'Telescope live_grep',
          key = 'g',
        },
        {
          desc = icons.ui.Power,
          group = 'Action',
          action = 'quit',
          key = 'q',
        },
      },
      footer = { '', icons.ui.Heart .. ' Nothing to say ' .. icons.ui.Heart },
    },
  },

  config = function()
    if vim.o.filetype == 'lazy' then
      vim.cmd.close()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'DashboardLoaded',
        callback = function()
          require('lazy').show()
        end,
      })
    end
  end,
}
