-- Easily comment visual regions/lines
return {
  "numToStr/Comment.nvim",
  opts = {},
  config = function()
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<M-/>", require("Comment.api").toggle.linewise.current, opts)
    vim.keymap.set(
      "v",
      "<M-/>",
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
      opts
    )
  end,
  event = "VeryLazy",
}
