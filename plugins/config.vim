""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lambdalisue/vim-fern                                                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable netrw.
let g:loaded_netrw  = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

augroup my-fern-hijack
  autocmd!
  autocmd BufEnter * ++nested call s:hijack_directory()
augroup END

function! s:hijack_directory() abort
  let path = expand('%:p')
  if !isdirectory(path)
    return
  endif
  bwipeout %
  execute printf('Fern %s', fnameescape(path))
endfunction

" " Custom settings and mappings.
let g:fern#disable_default_mappings = 1
let g:fern#disable_drawer_smart_quit = 0
let g:fern#disable_drawer_auto_restore_focus = 0
let g:fern#scheme#file#show_absolute_path_on_root_label = 0
let g:fern#renderer#default#leading = "│ "
let g:fern#renderer#default#root_symbol = "◓ "
let g:fern#renderer#default#leaf_symbol = "├ "
let g:fern#renderer#default#collapsed_symbol = " "
let g:fern#renderer#default#expanded_symbol = " "

let g:fern#default_exclude = '^\%(\.git\|__pycache__\)$'

function! FernInit() abort
  set nonumber
  set norelativenumber
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> l <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> h <Plug>(fern-action-collapse)
  nmap <buffer> ? <Plug>(fern-action-help)
  nmap <buffer> <C-v> <Plug>(fern-action-open:vsplit)
  nmap <buffer> <C-x> <Plug>(fern-action-open:split)
  nmap <buffer> - <Plug>(fern-action-leave)
  nmap <buffer> E <Plug>(fern-action-expand-tree:in)
  nmap <buffer> F <Plug>(fern-action-reload)
  nmap <buffer> H <Plug>(fern-action-hidden:toggle)
  nmap <buffer> R <Plug>(fern-action-remove)
  nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> r <Plug>(fern-action-rename:split)
  nmap <buffer> c <Plug>(fern-action-copy)
  nmap <buffer> x <Plug>(fern-action-move)

  nmap <buffer> y <Plug>(fern-action-yank:label)
  nmap <buffer> Y <Plug>(fern-action-yank)
  nmap <buffer> m <Plug>(fern-action-mark:toggle)
  nmap <buffer> M <Plug>(fern-action-mark:clear)
  nmap <buffer> a <Plug>(fern-action-choice)
  nmap <buffer> zr <Plug>(fern-action-zoom:reset)
  nmap <buffer> zf <Plug>(fern-action-zoom:full)
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " gelguy/wilder.nvim                                                               "
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" call timer_start(250, { -> s:wilder_init() })

" function! s:wilder_init() abort
"   try
"     call wilder#setup({
"           \ 'modes': [':', '/', '?'],
"           \ 'next_key': '<Tab>',
"           \ 'previous_key': '<S-Tab>',
"           \ 'accept_key': '<C-y>',
"           \ 'reject_key': '<C-e>'
"           \ })

"     let l:hl = wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}])

"     call wilder#set_option('renderer', wilder#popupmenu_renderer({
"           \ 'highlighter': wilder#basic_highlighter(),
"           \ 'max_height': 15,
"           \ 'highlights': {
"           \   'accent': l:hl,
"           \ },
"           \ 'left': [' ', wilder#popupmenu_devicons(),],
"           \ 'right': [' ', wilder#popupmenu_scrollbar(),],
"           \ 'apply_incsearch_fix': 0,
"           \ }))
"   catch /^Vim\%((\a\+)\)\=:E117/
"     echohl Error |echomsg "Wilder.nvim missing"| echohl None
"   endtry
" endfunction
