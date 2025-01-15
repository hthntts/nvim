return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  opts = {
    stages = "fade_in_slide_out",
    timeout = 1500,
    background_colour = "#2E3440",
  },
  config = function()
    local notify = require('notify')
    vim.notify = notify
  end,
}
