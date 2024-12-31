require("which-key").setup {
  preset = "classic",
  icons = {
    mappings = false,
  },
}

local wk = require("which-key")
wk.add({
  { "<leader>b", group = "Buffers", expand = function()
      return require("which-key.extras").expand.buf()
    end
  },
  { "<leader>bb", "<cmd>Leaderf buffer<cr>", desc = "Switch buffer", mode = "n" },
  {
    mode = { "n", "v" },
    { "<leader>,", "<cmd>Leaderf buffer<cr>", desc = "Switch buffer" },
    { "<leader>/", "<cmd>Leaderf rg --no-messages --nameOnly<cr>", desc = "Search project" },
    { "<leader><leader>", "<cmd>Leaderf file<cr>", desc = "Find file in project", mode = "n" },
  },
  { "<leader>c", group = "Code" },
  { "<leader>ce", group = "Debug" },
  { "<leader>cw", group = "Workspace" },
  { "<leader>f", group = "File" },
  { "<leader>ff", "<cmd>Leaderf file<cr>", desc = "Find File", mode = "n" },
  { "<leader>fn", "<cmd>enew<cr>", desc = "New File" , mode = "n"},
  { "<leader>fr", "<cmd>Leaderf mru --absolute-path<cr>", desc = "Recent files", mode = "n" },
  { "<leader>g", group = "Git" },
  { "<leader>gc", group = "Create" },
  { "<leader>go", group = "Open" },
  { "<leader>h", group = "Help" },
  { "<leader>ht", "<cmd>:Telescope colorscheme<cr>", desc = "Themes" },
  { "<leader>hd", group = "Nvim" },
  { "<leader>hh", "<cmd>Leaderf help<cr>", desc = "Help" },
  { "<leader>l", group = "Line" },
  { "<leader>o", group = "Open" },
  { "<leader>oe", "<cmd>NvimTreeToggle<cr>", desc = "Nvim Tree" },
  { "<leader>om", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview" },
  { "<leader>os", "<cmd>MarkdownPreviewStop<cr>", desc = "Markdown Preview Stop" },
  { "<leader>q", group = "Quit/Session" },
  { "<leader>qQ", "<cmd>qa!<cr>", desc = "Quit Nvim without saving" },
  { "<leader>r", group = "Tunnel" },
  { "<leader>s", group = "Search" },
  { "<leader>ss", "<cmd>Leaderf line<cr>", desc = "Search buffer" },
  { "<leader>st", "<cmd>Leaderf bufTag<cr>", desc = "Search Tag", mode = "n" },
  { "<leader>t", group = "Toggle" },
  { "<leader>tm", "<cmd>MundoToggle<cr>", desc = "Mundo" },
  { "<leader>ts", "<cmd>Vista!!<cr>", desc = "Symbol" },
  { "<leader>u", group = "Unicode" },
  { "<leader>w", proxy = "<c-w>", group = "Windows" },
  { "<leader>z", group = "Folds" },
})
