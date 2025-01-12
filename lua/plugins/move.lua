return {
  "fedepujol/move.nvim",
  cmd = {
    "MoveLine",
    "MoveBlock"
  },
  keys = {
    { "<A-up>",   ":MoveLine(-1)<CR>",  mode = "n" },
    { "<A-down>", ":MoveLine(1)<CR>",   mode = "n" },

    { "<A-up>",   ":MoveBlock(-1)<CR>", mode = "v" },
    { "<A-down>", ":MoveBlock(1)<CR>",  mode = "v" },
  },

  opts = {
    line = {
      enable = true, -- Enables line movement
      indent = true, -- Toggles indentation
    },
    block = {
      enable = true, -- Enables block movement
      indent = true, -- Toggles indentation
    },
    word = {
      enable = false, -- Enables word movement
    },
    char = {
      enable = false, -- Enables char movement
    },
  }
}
