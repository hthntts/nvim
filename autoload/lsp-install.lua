local function setup_servers()
  require('lspinstall').setup()
  local servers = require('lspinstall').installed_servers()
  for _, server in pairs(servers) do
    require('lspconfig')[server].setup{}
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require('lspinstall').post_install_hook = function ()
  setup_servers()    -- Reload installed servers
  vim.cmd("bufdo e") -- This triggers the FileType autocmd that starts the server
end
