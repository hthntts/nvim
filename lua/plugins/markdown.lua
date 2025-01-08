return {
  {
    "preservim/vim-markdown",
    config = function()
      -- Disable header folding
      vim.g.vim_markdown_folding_disabled = 1

      -- Whether to use conceal feature in markdown
      vim.g.vim_markdown_conceal = 1

      -- Disable math tex conceal and syntax highlight
      vim.g.tex_conceal = ''
      vim.g.vim_markdown_math = 0

      -- Support front matter of various format
      vim.g.vim_markdown_frontmatter = 1
      vim.g.vim_markdown_toml_frontmatter = 1
      vim.g.vim_markdown_json_frontmatter = 1

      -- Let the TOC window autofit so that it doesn't take too much space
      vim.g.vim_markdown_toc_autofit = 1
    end,
    ft = { "markdown" }
  },

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

  {
    "MeanderingProgrammer/markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    main = "render-markdown",
    opts = {
      heading = {
        icons = { '󰎥 ', '󰎨 ', '󰎫 ', '󰎲 ', '󰎯 ', '󰎴 ' },
        signs = { '󰫎 ' },
      },
      indent = {
        enabled = true,
      },
      latex = { enabled = false }
    },
    ft = { "markdown" }
  },
}
