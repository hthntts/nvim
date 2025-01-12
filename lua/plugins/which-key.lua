return {
  "folke/which-key.nvim",
  event = 'BufReadPre',
  config = function()
    require("which-key").setup {
      -- classic, modern, helix
      preset = "classic",
      delay = 0,
      icons = {
        mappings = false,
      },
    }

    local wk = require("which-key")
    wk.add({
      { "<leader>c",  group = "Code" },
      { "<leader>co", group = "Object" },
      { "<leader>cq", group = "Quickfix" },
      { "<leader>d",  group = "Debug" },
      { "<leader>f",  group = "File" },
      { "<leader>g",  group = "Git" },
      { "<leader>gc", group = "Create" },
      { "<leader>go", group = "Open" },
      { "<leader>p",  group = "Project" },
      { "<leader>h",  group = "Help" },
      { "<leader>i",  group = "Insert" },
      { "<leader>o",  group = "Open" },
      { "<leader>q",  group = "Quit" },
      { "<leader>r",  group = "Reload" },
      { "<leader>s",  group = "Search" },
      { "<leader>u",  group = "U" },
      { "<leader>t",  group = "Toggle" },
      { "<leader>z",  group = "Folds" },
      { "<leader>w",  proxy = "<c-w>",   group = "Windows" },
      {
        "<leader>b",
        group = "Buffers",
        expand = function()
          return require("which-key.extras").expand.buf()
        end
      },
      { "<leader>om", "<cmd>MarkdownPreview<cr>",     desc = "Markdown preview" },
      { "<leader>os", "<cmd>MarkdownPreviewStop<cr>", desc = "Stop Markdown preview" },
    })
  end,
}
