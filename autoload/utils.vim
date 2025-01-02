function! utils#Cabbrev(key, value) abort
  execute printf('cabbrev <expr> %s (getcmdtype() == ":" && getcmdpos() <= %d) ? %s : %s',
        \ a:key, 1+len(a:key), <SID>Single_quote(a:value), <SID>Single_quote(a:key))
endfunction

function! s:Single_quote(str) abort
  return "'" . substitute(copy(a:str), "'", "''", 'g') . "'"
endfunction

" Check if we are inside a Git repo.
function! utils#InsideGitRepo() abort
  let res = system('git rev-parse --is-inside-work-tree')
  if match(res, 'true') == -1
    return v:false
  else
    " Manually trigger a special user autocmd InGitRepo (used lazyloading.
    doautocmd User InGitRepo
    return v:true
  endif
endfunction

" Check the syntax group in the current cursor position, see
" https://stackoverflow.com/q/9464844/6064933 and
" https://jordanelver.co.uk/blog/2015/05/27/working-with-vim-colorschemes/
function! utils#SynGroup() abort
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

" Toggle cursor column
function! utils#ToggleCursorCol() abort
  if &cursorcolumn
    set nocursorcolumn
    echo 'cursorcolumn: OFF'
  else
    set cursorcolumn
    echo 'cursorcolumn: ON'
  endif
endfunction

function! utils#GoToBuffer(count, direction) abort
  if a:count == 0
    if a:direction ==# 'forward'
      bnext
    elseif a:direction ==# 'backward'
      bprevious
    else
      echoerr 'Bad argument ' a:direction
    endif
    return
  endif
  " Check the validity of buffer number.
  if index(s:GetBufNums(), a:count) == -1
    " Using `lua vim.notify('invalid bufnr: ' .. a:count)` won't work, because
    " we are essentially mixing Lua and vim script. We need to make sure that
    " args inside vim.notify() are valid vim values. The conversion from vim
    " value to lua value will be done by Nvim. See also https://github.com/neovim/neovim/pull/11338.
    call v:lua.vim.notify('Invalid bufnr: ' . a:count, 4, {'title': 'nvim-config'})
    return
  endif

  " Do not use {count} for gB (it is less useful)
  if a:direction ==# 'forward'
    silent execute('buffer' . a:count)
  endif
endfunction

function! utils#TextObjURL() abort
  if match(&runtimepath, 'vim-highlighturl') != -1
    " Note that we use https://github.com/itchyny/vim-highlighturl to get the URL pattern.
    let url_pattern = highlighturl#default_pattern()
  else
    let url_pattern = expand('<cfile>')
    " Since expand('<cfile>') also works for normal words, we need to check if
    " this is really URL using heuristics, e.g., URL length.
    if len(url_pattern) <= 10
      return
    endif
  endif

  " We need to find all possible URL on this line and their start, end index.
  " Then find where current cursor is, and decide if cursor is on one of the
  " URLs.
  let line_text = getline('.')
  let url_infos = []

  let [_url, _idx_start, _idx_end] = matchstrpos(line_text, url_pattern)
  while _url !=# ''
    let url_infos += [[_url, _idx_start+1, _idx_end]]
    let [_url, _idx_start, _idx_end] = matchstrpos(line_text, url_pattern, _idx_end)
  endwhile

  " echo url_infos
  " If no URL is found, do nothing.
  if len(url_infos) == 0
    return
  endif

  let [start_col, end_col] = [-1, -1]
  " If URL is found, find if cursor is on it.
  let [buf_num, cur_row, cur_col] = getcurpos()[0:2]
  for url_info in url_infos
    " echo url_info
    let [_url, _idx_start, _idx_end] = url_info
    if cur_col >= _idx_start && cur_col <= _idx_end
      let start_col = _idx_start
      let end_col = _idx_end
      break
    endif
  endfor

  " Cursor is not on a URL, do nothing.
  if start_col == -1
    return
  endif

  " Now set the '< and '> mark
  call setpos("'<", [buf_num, cur_row, start_col, 0])
  call setpos("'>", [buf_num, cur_row, end_col, 0])
  normal! gv
endfunction

function! utils#MarkWholeBuffer() abort
  let buf_num = bufnr()
  call setpos("'<", [buf_num, 1, 1, 0])
  call setpos("'>", [buf_num, line('$'), 1, 0])
  execute 'normal! `<V`>'
endfunction

" http://stackoverflow.com/a/39348498/2103996
function! utils#clearregisters() abort
  let l:regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
  for l:reg in l:regs
    call setreg(l:reg, [])
  endfor
endfunction
