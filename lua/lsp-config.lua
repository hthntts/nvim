-- local function lspSymbol(name, icon)
--   vim.fn.sign_define("LspDiagnosticsSign" .. name, { text = icon, numhl = "LspDiagnosticsDefault" .. name })
-- end
-- lspSymbol("Error", " ")
-- lspSymbol("Information", " ")
-- lspSymbol("Hint", " ")
-- lspSymbol("Warning", " ")

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    -- virtual_text = {
    --   prefix = " ❯❯❯ ",
    --   spacing = 0,
    -- },
    signs = true,
    underline = true,
  }
)

----------------------------------------------------------------------
--                         npm i -g pyright                         --
--              pip3 install 'python-lsp-server[all]'               --
--                        :LspInstall python                        --
--                        :TSInstall python                         --
----------------------------------------------------------------------
require('lspconfig').pyright.setup {}
-- require('lspconfig').pylsp.setup {}
----------------------------------------------------------------------
--                  npm i -g bash-language-server                   --
--                         :LspInstall bashls                       --
--                         :TSInstall bash                          --
----------------------------------------------------------------------
require('lspconfig').bashls.setup {}
----------------------------------------------------------------------
--             yarn global add ansible-language-server              --
--          pip3 install "ansible-lint[yamllint]" ansible           --
--                         :LspInstall yamlls                       --
--                         :TSInstall yaml                          --
----------------------------------------------------------------------
require('lspconfig').ansiblels.setup{}
