require("which-key").setup {
  preset = "classic",
  icons = {
    mappings = false,
  },
}

local wk = require("which-key")
wk.add({
  { "<leader>f", group = "File" },
  { "<leader>ff", "<cmd>Leaderf file --popup<cr>", desc = "Find File", mode = "n" },
  { "<leader>fr", "<cmd>Leaderf mru --popup --absolute-path<cr>", desc = "Recent files", mode = "n" },
  { "<leader>fn", "<cmd>enew<cr>", desc = "New File" , mode = "n"},
  { "<leader>f1", hidden = true },
  { "<leader>w", proxy = "<c-w>", group = "Windows" },
  { "<leader>b", group = "Buffers", expand = function()
      return require("which-key.extras").expand.buf()
    end
  },
  { "<leader>bb", "<cmd>Leaderf buffer --popup<cr>", desc = "Switch buffer", mode = "n" },
  {
    mode = { "n", "v" },
    { "<leader>,", "<cmd>Leaderf buffer --popup<cr>", desc = "Switch buffer" },
    { "<leader>/", "<cmd>Leaderf rg --no-messages --popup --nameOnly<cr>", desc = "Search project" },
    { "<leader><leader>", "<cmd>Leaderf file --popup<cr>", desc = "Find file in project", mode = "n" },
  },
  { "<leader>q", group = "Quit/Session" },
  { "<leader>qQ", "<cmd>qa!<cr>", desc = "Quit Nvim without saving" },
  { "<leader>t", group = "Toggle" },
  { "<leader>tm", "<cmd>MundoToggle<cr>", desc = "Mundo" },
  { "<leader>ts", "<cmd>Vista!!<cr>", desc = "Symbol" },
  { "<leader>s", group = "Search" },
  { "<leader>ss", "<cmd>Leaderf line<cr>", desc = "Search buffer" },
  { "<leader>st", "<cmd>Leaderf bufTag --popup<cr>", desc = "Search Tag", mode = "n" },
  { "<leader>h", group = "Help" },
  { "<leader>hh", "<cmd>Leaderf help --popup<cr>", desc = "Help" },
  { "<leader>o", group = "Open" },
  { "<leader>oe", "<cmd>NvimTreeToggle<cr>", desc = "Nvim Tree" },
  { "<leader>om", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview" },
  { "<leader>os", "<cmd>MarkdownPreviewStop<cr>", desc = "Markdown Preview Stop" },
  { "<leader>u", group = "Unicode" },
  { "<leader>g", group = "Git" },
  { "<leader>z", group = "Folds" },
  { "<leader>r", group = "Tunnel" },
})