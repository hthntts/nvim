local map = require('core.utils').map

return {
  'nvim-pack/nvim-spectre',
  config = function()
    require('spectre').setup()
    map('n', '<leader>srs', '<cmd>lua require("spectre").toggle()<CR>', "Toggle Spectre")
    map('n', '<leader>srw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', "Search current word")
    map('v', '<leader>srw', '<esc><cmd>lua require("spectre").open_visual()<CR>', "Search current word")
    map('n', '<leader>srf', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
      "Search on current file"
    )
  end
}
