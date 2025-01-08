return {
  "folke/which-key.nvim",
  event = "VimEnter",
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
      { "<leader>c",  group = "[c]ode" },
      { "<leader>co", group = "[o]bject" },
      { "<leader>cq", group = "[q]uickfix" },
      { "<leader>d",  group = "[d]ebug" },
      { "<leader>f",  group = "[f]ile" },
      { "<leader>g",  group = "[g]it" },
      { "<leader>gc", group = "[c]reate" },
      { "<leader>go", group = "[o]pen" },
      { "<leader>p",  group = "[p]roject" },
      { "<leader>h",  group = "[h]elp" },
      { "<leader>hd", group = "Nvim [d]" },
      { "<leader>i",  group = "[i]nsert" },
      { "<leader>o",  group = "[o]pen" },
      { "<leader>q",  group = "[q]uit" },
      { "<leader>r",  group = "[r]eload" },
      { "<leader>s",  group = "[s]earch" },
      { "<leader>u",  group = "[u]" },
      { "<leader>t",  group = "[t]oggle" },
      { "<leader>z",  group = "[z]Folds" },
      { "<leader>w",  proxy = "<c-w>",     group = "[w]indows" },
      {
        "<leader>b",
        group = "[b]uffers",
        expand = function()
          return require("which-key.extras").expand.buf()
        end
      },
      {
        mode = { "n", "v" },
        { "<leader>,", "<cmd>Telescope buffers<cr>", desc = "Switch buffer" },
      },
      { "<leader>gB", "<cmd>Gitsigns blame<cr>",        desc = "[B]lame",                mode = "n" },
      { "<leader>ht", "<cmd>Telescope colorscheme<cr>", desc = "[t]hemes" },
      { "<leader>hk", "<cmd>Telescope keymaps<cr>",     desc = "[k]eymaps" },
      { "<leader>ie", "<cmd>Telescope symbols<cr>",     desc = "[e]moji" },
      { "<leader>om", "<cmd>MarkdownPreview<cr>",       desc = "[m]arkdown Preview" },
      { "<leader>os", "<cmd>MarkdownPreviewStop<cr>",   desc = "Markdown Preview [s]top" },
      { "<leader>tm", "<cmd>MundoToggle<cr>",           desc = "Toggle [m]undo" },
      { "<leader>tc", "<cmd>ColorizerToggle<cr>",       desc = "Toogle [c]olors" },
      { "<leader>ts", "<cmd>Vista!!<cr>",               desc = "Toogle [s]ymbol" },
      { "<leader>un", "<cmd>UnicodeName<cr>",           desc = "Unicode [n]ame" },
    })
  end,
}
