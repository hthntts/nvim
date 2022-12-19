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

" Custom settings and mappings.
let g:fern#disable_default_mappings = 1
let g:fern#disable_drawer_smart_quit = 0
let g:fern#disable_drawer_auto_restore_focus = 0
let g:fern#scheme#file#show_absolute_path_on_root_label = 0
let g:fern#renderer#default#leading = "│"
let g:fern#renderer#default#root_symbol = "┬ "
let g:fern#renderer#default#leaf_symbol = "├─ "
let g:fern#renderer#default#collapsed_symbol = "├─ "
let g:fern#renderer#default#expanded_symbol = "├┬ "

let g:fern#default_exclude = '^\%(\.git\|__pycache__\)$'

"| [FERN] --------------------------------------------------------------------
"| E       => Open Fern.
noremap <silent> <S-E> :Fern . -drawer -reveal=% -toggle<CR>
" noremap <silent> <S-E> :Fern . -drawer -stay -reveal=% -toggle<CR>

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
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
"| ?       => Help.
  nmap <buffer> ? <Plug>(fern-action-help)
"| a       => Action choise.
  nmap <buffer> a <Plug>(fern-action-choice)
"| -       => Action leave.
  nmap <buffer> - <Plug>(fern-action-leave)
"| l       => Open expand collapse.
  nmap <buffer> l <Plug>(fern-my-open-expand-collapse)
"| h       => Open collapse.
  nmap <buffer> h <Plug>(fern-action-collapse)
"| m       => Move.
  nmap <buffer> m <Plug>(fern-action-move)
"| c       => Copy.
  nmap <buffer> c <Plug>(fern-action-copy)
"| rm      => Remove.
  nmap <buffer> rm <Plug>(fern-action-remove)
"| rn      => Rename (Split).
  nmap <buffer> rn <Plug>(fern-action-rename:split)
"| nf      => New file.
  nmap <buffer> nf <Plug>(fern-action-new-file)
"| np      => New folder.
  nmap <buffer> np <Plug>(fern-action-new-path)
"| x       => Mark toggle.
  nmap <buffer> x <Plug>(fern-action-mark:toggle)
"| H       => Hidden toggle.
  nmap <buffer> H <Plug>(fern-action-hidden:toggle)
"| R       => Reload.
  nmap <buffer> R <Plug>(fern-action-reload)
"| y       => Yank.
  nmap <buffer> y <Plug>(fern-action-yank)
"| C-v     => Open (like tmux -).
  nmap <buffer> <C-v> <Plug>(fern-action-open:split)
"| C-x     => Open (like tmux |).
  nmap <buffer> <C-x> <Plug>(fern-action-open:vsplit)
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END
