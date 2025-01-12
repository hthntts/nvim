return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  opts = {
    -- Animation style
    stages = "fade_in_slide_out",
    -- Default timeout for notifications
    timeout = 1500,
    background_colour = "#2E3440",
  },
  config = function()
    vim.notify = require("notify")
  end,
}
