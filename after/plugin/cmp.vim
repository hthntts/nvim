if empty(vim_coc)
  lua require('treesitter')
  lua require('luasnip-config')
  lua require('luasnip-tux')
  lua require('nvim-lualine')
  lua require('nvim-tabline')
  lua require('lsp-cmp')
  lua require('lsp-config')
  lua require('lsp-kind')
  lua require('indent-blankline')
"| [CMP] ---------------------------------------------------------------------
"| K       => Show documentation.
  nnoremap <silent> K :lua vim.lsp.buf.hover()<cr>
"| SPC-cn  => Symbol renaming.
  nnoremap <silent> <leader>cn :lua vim.lsp.buf.rename()<cr>
"| SPC-cd  => Code definition.
  nnoremap <silent> <leader>cd :lua vim.lsp.buf.definition()<cr>
"| SPC-cy  => Code type definition.
  nnoremap <silent> <leader>ct :lua vim.lsp.buf.type_definition()<cr>
"| SPC-ci  => Code implementation.
  nnoremap <silent> <leader>ci :lua vim.lsp.buf.implementation()<cr>
"| SPC-cr  => Code references.
  nnoremap <silent> <leader>cD :lua vim.lsp.buf.references()<cr>
"| [g / ]g => Use `[g` and `]g` to navigate diagnostics
  nnoremap <silent> [g :lua vim.diagnostic.goto_prev()<cr>
  nnoremap <silent> ]g :lua vim.diagnostic.goto_next()<cr>
endif
