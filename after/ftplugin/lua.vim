" Disable inserting comment leader after hitting o or O or <Enter>
set formatoptions-=o
set formatoptions-=r

nnoremap <buffer><silent> <leader>lf :luafile %<CR>
nnoremap <buffer><silent> <leader>ls <cmd>silent !stylua %<CR>
