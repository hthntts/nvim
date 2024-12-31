local api = vim.api
local keymap = vim.keymap
local dashboard = require("dashboard")

local conf = {}
conf.header = {
  "                                                       ",
  "                                                       ",
  "                                                       ",
  "                                                       ",
  " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
  " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
  " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
  " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
  " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
  " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
  "                                                       ",
  "                                                       ",
  "                                                       ",
  "                                                       ",
}

conf.center = {
  {
    icon = "󰈞  ",
    desc = "Find File                               ",
    action = "Leaderf file --popup",
    key = "SPC f f",
  },
  {
    icon = "󰈢  ",
    desc = "Recently Opened Files                   ",
    action = "Leaderf mru --popup",
    key = "SPC f r",
  },
  {
    icon = "󰈬  ",
    desc = "Project Grep                            ",
    action = "Leaderf rg --popup --no-messages --nameOnly",
    key = "SPC /",
  },
  {
    icon = "  ",
    desc = "New File                                ",
    action = "enew",
    key = "e",
  },
  {
    icon = "󰗼  ",
    desc = "Quit Nvim                               ",
    action = "qa",
    key = "q",
  },
}

dashboard.setup {
  theme = "doom",
  shortcut_type = "number",
  config = conf,
}

api.nvim_create_autocmd("FileType", {
  pattern = "dashboard",
  group = api.nvim_create_augroup("dashboard_enter", { clear = true }),
  callback = function()
    keymap.set("n", "q", ":qa<CR>", { buffer = true, silent = true })
    keymap.set("n", "e", ":enew<CR>", { buffer = true, silent = true })
  end,
})
