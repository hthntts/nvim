return {
  "folke/which-key.nvim",
  event = 'BufReadPre',
  config = function()
    require('which-key').setup {
      -- classic, modern, helix
      preset = "modern",
      delay = 0,
      icons = {
        mappings = false,
      },
    }

    local wk = require('which-key')
    wk.add({
      { "<leader>b",  group = "Buffers" },
      { "<leader>c",  group = "Code" },
      { "<leader>co", group = "Object" },
      { "<leader>cq", group = "Quickfix" },
      { "<leader>d",  group = "Debug" },
      { "<leader>f",  group = "File" },
      { "<leader>g",  group = "Git" },
      { "<leader>gc", group = "Create" },
      { "<leader>go", group = "Open" },
      { "<leader>h",  group = "Help" },
      { "<leader>i",  group = "Insert" },
      { "<leader>l",  group = "Lazy" },
      { "<leader>m",  group = "Markdown" },
      { "<leader>o",  group = "Open" },
      { "<leader>p",  group = "Project" },
      { "<leader>q",  group = "Quit" },
      { "<leader>r",  group = "Reload" },
      { "<leader>s",  group = "Search" },
      { "<leader>t",  group = "Toggle" },
      { "<leader>w",  proxy = "<c-w>",   group = "Windows" },
    })
  end,
}
