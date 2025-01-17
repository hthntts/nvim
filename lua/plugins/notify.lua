return {
  'rcarriga/nvim-notify',
  event = 'VeryLazy',
  config = function()
    require("notify").setup({
      background_colour = '#45475a',
    })
    local notify = require('notify')
    vim.notify = notify
  end
}
