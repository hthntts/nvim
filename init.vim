" ----------------------------------------------------------------------------
"   ____ _       _           _
"  / ___| | ___ | |__   __ _| |___
" | |  _| |/ _ \| '_ \ / _` | / __|
" | |_| | | (_) | |_) | (_| | \__ \
"  \____|_|\___/|_.__/ \__,_|_|___/
" ----------------------------------------------------------------------------

" CUSTOM VARIABLES -----------------------------------------------------------
if v:progname == 'vi'
  set noloadplugins
endif

let vim_coc = "tux"
" let vim_coc = ""

let g:is_win = (has('win32') || has('win64')) ? v:true : v:false
let g:is_linux = (has('unix') && !has('macunix')) ? v:true : v:false
let g:is_mac = has('macunix') ? v:true : v:false

" BUILTIN VARIABLES ----------------------------------------------------------
let g:loaded_python_provider = 0
" let g:loaded_ruby_provider = 1
" let g:loaded_node_provider = 1
let g:loaded_perl_provider = 0
let g:did_install_default_menus = 1

if executable('python3')
  if g:is_win
    let g:python3_host_prog=substitute(exepath('python3'), '.exe$', '', 'g')
  elseif g:is_mac
    let g:python3_host_prog = $HOME . '/.venv/python/bin/python'
    let g:ruby_host_prog = '/usr/local/lib/ruby/gems/3.1.0/bin/neovim-ruby-host'
  elseif g:is_linux
    let g:python3_host_prog = $HOME . '/.venv/python/bin/python'
    let g:ruby_host_prog = '/var/lib/gems/3.0.0/gems/neovim-0.9.0/exe/neovim-ruby-host'
  else

  endif
else
  echoerr 'Python 3 not found! You must install and set its PATH correctly!'
endif

" LEADER MAP -----------------------------------------------------------------
let mapleader = "\<Space>"
let maplocalleader="\\"

" ----------------------------------------------------------------------------
"   ___        _   _
"  / _ \ _ __ | |_(_) ___  _ __  ___
" | | | | '_ \| __| |/ _ \| '_ \/ __|
" | |_| | |_) | |_| | (_) | | | \__ \
"  \___/| .__/ \__|_|\___/|_| |_|___/
"       |_|
" ----------------------------------------------------------------------------

" BUILTIN OPTIONS AND SETTINGS -----------------------------------------------
set nocompatible
set autoindent autoread autowrite
set backspace=eol,start,indent
set belloff=all
set cmdheight=1
set completeopt=menuone,noselect
set confirm
set expandtab
set fileformats=unix,dos,mac
set foldlevelstart=99
set formatoptions+=j
set formatoptions+=n
set hidden
set history=500
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set linebreak
set list
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=tab:▷┅
set listchars+=trail:•
set listchars=nbsp:⦸
set magic
set matchpairs+=<:>,「:」,『:』,【:】,“:”,‘:’,《:》
set maxmempattern=1000
set mouse=a
set mousemodel=popup
set cursorcolumn
set cursorline
set nojoinspaces
set nomodeline
set noshiftround
set showcmd
set noshowmode
set number
set re=1
set redrawtime=10000
set relativenumber
set ruler
set scrolloff=3
set sessionoptions+=buffers
set sessionoptions+=curdir
set sessionoptions+=folds
set sessionoptions+=help
set sessionoptions+=options
set sessionoptions+=resize
set sessionoptions+=tabpages
set sessionoptions+=terminal
set sessionoptions+=winpos
set sessionoptions+=winsize
set sessionoptions=blank
set shell=sh
set shiftwidth=2
set shortmess+=A " Ignore annoying swapfile messages
set shortmess+=I " No splash screen
set shortmess+=O " File-read message overwrites previous
set shortmess+=T " Truncate non-file messages in middle
set shortmess+=W " Don't echo "[w]"/"[written]" when writing
set shortmess+=a " Use abbreviations in messages eg. `[RO]` instead of `[readonly]`
set shortmess+=c " Completion messages
set shortmess+=o " Overwrite file-written messages
set shortmess+=t " Truncate file messages at start
set showbreak=↪
set showmatch
set sidescroll=0
set sidescrolloff=3
set smartcase
set smarttab
set softtabstop=2
set splitbelow splitright
set suffixes-=.h
set switchbuf=usetab
set synmaxcol=180
set tabstop=2
set termguicolors
set timeoutlen=1000
set title
set titlestring=
set titlestring=%{tux#functions#getTitlestr()}
set updatetime=300
set viewoptions=cursor,folds
set virtualedit=block
set visualbell
set nowrap
set whichwrap=b,h,l,s,<,>,[,],~
set wildcharm=26
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.xdv
set wildignore+=*.jpg,*.png,*.jpeg,*.bmp,*.gif,*.tiff,*.svg,*.ico
set wildignore+=*.o,*.obj,*.dylib,*.bin,*.dll,*.exe
set wildignore+=*.pyc,*.pkl
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignorecase
set wildmenu
set wildmode=longest:full,full
set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor20

" No one is really happy until you have this shortcuts -----------------------
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" Only Nvim ------------------------------------------------------------------
if has("nvim")
  set fillchars+=eob:\
  set fillchars+=fold:·
  set fillchars+=vert:┃
  set fillchars=diff:∙
  set inccommand=nosplit
  set pumblend=5
  set winblend=5
  set pumheight=20
  set wildoptions+=pum
endif

" Backup ---------------------------------------------------------------------
if has('nvim')
  set backupdir=$HOME/.cache/nvim/backup
else
  set backupdir=$HOME/.cache/vim/backup
endif

if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif

let &backupskip=&wildignore
set backup
set backupcopy=yes

" Swapfile -------------------------------------------------------------------
set swapfile

if has('nvim')
  set directory=$HOME/.cache/nvim/swap
else
  set directory=$HOME/.cache/vim/swap
endif

if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif

" Undo -----------------------------------------------------------------------
set undofile
set undolevels=1000

if has('nvim')
  set undodir=$HOME/.cache/nvim/undodir
else
  set undodir=$HOME/.cache/vim/undodir
endif

if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif

" Clipboard ------------------------------------------------------------------
if has("nvim")
  if !empty(provider#clipboard#Executable())
    set clipboard+=unnamedplus
  endif
endif

" ----------------------------------------------------------------------------
"     _         _                                                      _
"    / \  _   _| |_ ___   ___ ___  _ __ ___  _ __ ___   __ _ _ __   __| |___
"   / _ \| | | | __/ _ \ / __/ _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` / __|
"  / ___ \ |_| | || (_) | (_| (_) | | | | | | | | | | | (_| | | | | (_| \__ \
" /_/   \_\__,_|\__\___/ \___\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|___/
" ----------------------------------------------------------------------------

" AUTOCOMMANDS ---------------------------------------------------------------
augroup resume_edit_position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' | execute "normal! g`\"zvzz" | endif
augroup END

augroup custom_highlight
  autocmd!
  autocmd ColorScheme * call s:custom_highlight()
augroup END

function! s:custom_highlight() abort
  highlight YankColor ctermfg=59 ctermbg=41 guifg=#00010A guibg=#EBDBB2
  " highlight Cursor guifg=reverse guibg=reverse cterm=bold gui=bold 
  highlight Cursor2 guifg=red guibg=red
  highlight FloatBorder guifg=LightGreen guibg=NONE
  highlight MatchParen cterm=underline gui=underline
endfunction

if !has('nvim')
  au CursorHold * checktime | call feedkeys("lh")
endif

if has('nvim')
  augroup non_utf8_file_warn
    autocmd!
    autocmd BufRead * if &fileencoding != 'utf-8' | call v:lua.vim.notify('File not in UTF-8 format!', 'warn', {'title': 'nvim-config', 'timeout': 2500}) | endif
  augroup END

  augroup auto_read
    autocmd!
    autocmd FileChangedShellPost * call v:lua.vim.notify("File changed on disk. Buffer reloaded!", 'warn', {'title': 'nvim-config', 'timeout': 2500})
    autocmd FocusGained,CursorHold * if getcmdwintype() == '' | checktime | endif
  augroup END

  augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="YankColor", timeout=300, on_visual=false}
  augroup END

  " In the quickfix window, <cr> is used to jump to the error under the cursor, so undefine the mapping there.
  autocmd BufReadPost quickfix nnoremap <buffer> <cr> <cr>:cclose <cr>
endif

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

" ----------------------------------------------------------------------------
"  ____  _             _
" |  _ \| |_   _  __ _(_)_ __  ___
" | |_) | | | | |/ _` | | '_ \/ __|
" |  __/| | |_| | (_| | | | | \__ \
" |_|   |_|\__,_|\__, |_|_| |_|___/
"                |___/
" ----------------------------------------------------------------------------

" VIM-PLUG -------------------------------------------------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin(expand('~/.vim/plugged'))
  " Tree view ----------------------------------------------------------------
  Plug 'lambdalisue/fern.vim'
  " Undo manager -------------------------------------------------------------
  Plug 'mbbill/undotree'
  " Maximizes and restore
  Plug 'szw/vim-maximizer'
  " Switch between single-line and multiline forms of code (gJ & gS) ---------
  Plug 'AndrewRadev/splitjoin.vim'
  " Modern matchit implementation -(%, #) ------------------------------------
  Plug 'andymass/vim-matchup'
  " Multiple cursors (Ctrl + n | q skip current) -----------------------------
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}
  " Simple alignment (junegunn/vim-easy-align) -------------------------------
  Plug 'tommcdo/vim-lion'
  " Simple terminal (Alt + =) ------------------------------------------------
  Plug 'skywind3000/vim-terminal-help'
  " Better escape -(jk to ESC) -----------------------------------------------
  Plug 'jdhao/better-escape.vim'
  " Mouse
  Plug 'psliwka/vim-smoothie'
  " Surround -(cs' | ds' | ysiw' )--------------------------------------------
  Plug 'tpope/vim-surround'
  " Commentary -(gc or gcc)---------------------------------------------------
  Plug 'tpope/vim-commentary'
  " Navigator integration tmux -----------------------------------------------
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'blueyed/vim-diminactive'
  Plug 'edkolev/tmuxline.vim'
  " Run Python code in IPython -----------------------------------------------
  Plug 'jpalardy/vim-slime', { 'for': 'python' }
  Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
  " Minimap ------------------------------------------------------------------
  Plug 'wfxr/minimap.vim'
  " Markdown preview ---------------------------------------------------------
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
  " Peek lines just when you intend ------------------------------------------
  Plug 'nacro90/numb.nvim'
  " Indent -------------------------------------------------------------------
  Plug 'lukas-reineke/indent-blankline.nvim'
  " Colorizer ----------------------------------------------------------------
  Plug 'norcalli/nvim-colorizer.lua'
  " Fast movement ------------------------------------------------------------
  Plug 'phaazon/hop.nvim'
  " Notify -------------------------------------------------------------------
  Plug 'rcarriga/nvim-notify'
  " Fzf Lua ------------------------------------------------------------------
  Plug 'ibhagwan/fzf-lua'
  Plug 'vijaymarupudi/nvim-fzf'
  Plug 'kyazdani42/nvim-web-devicons'
  " Session manager ----------------------------------------------------------
  Plug 'rmagatti/auto-session'
  " Snippets -----------------------------------------------------------------
  Plug 'rafamadriz/friendly-snippets'

  if empty(vim_coc)
    " Colorscheme ------------------------------------------------------------
    Plug 'navarasu/onedark.nvim'
    " Auto close parentheses and repeat by dot dot dot -------------------------
    Plug 'cohama/lexima.vim'
    " Statusline and Tabline -------------------------------------------------
    Plug 'kdheepak/tabline.nvim'
    Plug 'nvim-lualine/lualine.nvim'
    " Rainbow parentheses ----------------------------------------------------
    Plug 'p00f/nvim-ts-rainbow'
    " Lsp --------------------------------------------------------------------
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'onsails/lspkind-nvim'
    " Autocomplete -----------------------------------------------------------
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-calc'
    Plug 'hrsh7th/cmp-emoji'
    Plug 'hrsh7th/cmp-latex-symbols'
    " Snippets ---------------------------------------------------------------
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    " Treesitter -------------------------------------------------------------
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-treesitter/nvim-treesitter'
  else
    " Colorscheme ------------------------------------------------------------
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'joshdick/onedark.vim'
    " Completion COC ------------ --------------------------------------------
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'honza/vim-snippets'
  endif

call plug#end()

" ----------------------------------------------------------------------------
"  _   _ ___
" | | | |_ _|
" | | | || |
" | |_| || |
"  \___/|___|
" ----------------------------------------------------------------------------

" UI -------------------------------------------------------------------------
if empty(vim_coc)
  " Colorscheme
  colorscheme onedark
else
  " Airline
  let g:airline_powerline_fonts = 0
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#formatter = 'unique_tail'
  let g:airline#extensions#tabline#tab_nr_type = 1
  let g:airline#extensions#coc#enabled = 1
  let g:airline_theme='onedark'
  " Colorscheme
  set background=dark
  colorscheme onedark
  " let g:onedark_termcolors=256
  " let g:onedark_terminal_italic=1
endif

" ----------------------------------------------------------------------------
"  __  __                   _
" |  \/  | __ _ _ __  _ __ (_)_ __   __ _ ___
" | |\/| |/ _` | '_ \| '_ \| | '_ \ / _` / __|
" | |  | | (_| | |_) | |_) | | | | | (_| \__ \
" |_|  |_|\__,_| .__/| .__/|_|_| |_|\__, |___/
"              |_|   |_|            |___/
" ----------------------------------------------------------------------------

" BASIC ----------------------------------------------------------------------
"| [BASIC] -------------------------------------------------------------------
"| C-c/C-x => Emulate windows copy, cut behavior (Visual).
vnoremap <LeftRelease> "+y<LeftRelease>
vnoremap <C-c> "+y<cr>
vnoremap <C-x> "+d<cr>
"| Enter   => New line without insert.
nnoremap <Enter> o<ESC>
"| J       => Don't move cursor when joining lines.
nnoremap J mzJ`z
"| Y       => Copy from cursor to end of line.
nnoremap Y y$
"| H/L     => Move to beginning/end of line.
nnoremap H ^
nnoremap L $
"| </>     => Continuous visual shifting (Visual).
xnoremap < <gv
xnoremap > >gv
"| Q       => Apply macro with Q.
nnoremap Q @q
vnoremap Q :norm @q<cr>
"| C-h     => Find and replace (Visual).
xnoremap <C-h> :s/
"| C-u     => Turn the word under cursor to upper case (Insert).
inoremap <C-u> <Esc>viwUea
"| C-t     => Turn the current word into title case (Insert).
inoremap <C-t> <Esc>b~lea

" OTHER ----------------------------------------------------------------------
"| [OTHER] -------------------------------------------------------------------
"| SPC-hr  => Reload init.vim quickly
nnoremap <silent> <leader>hr:<C-U>silent update $MYVIMRC <bar> source $MYVIMRC <cr>

" SAVE AND QUIT --------------------------------------------------------------
"| SPC-fs  => Save.
nnoremap <silent> <leader>fs :w<cr>
"| SPC-qq  => Quit.
nnoremap <silent> <leader>qq :q<cr>
"| SPC-qQ  => Quit all.
nnoremap <silent> <leader>qQ :qa!<cr>
"| SPC-xx  => Back to ZSH.
nnoremap <silent> <leader>xx :xit<cr>
"| CMD-/ => Comment Toggle.
noremap <silent> <M-/> :Commentary<cr>

" BUFFER ---------------------------------------------------------------------
"| [Buffer] ------------------------------------------------------------------
"| SPC-bl  => Switch to last active buffer.
nnoremap <silent> <leader>bl <C-^>
"| SPC-bn  => Switch to next buffer.
nnoremap <silent> <leader>bn :bnext<cr>
"| SPC-bp  => Switch to previous buffer.
nnoremap <silent> <leader>bp :bprevious<cr>
"| SPC-bd  => Close current buffer.
nnoremap <silent> <leader>bd :bd<cr>
"| SPC-bK  => Close all buffers.
nnoremap <silent> <leader>bK :%bdelete<cr>
"| SPC-bO  => Close all buffers except current.
nnoremap <silent> <leader>bO :call tux#functions#closeOtherBuffer()<cr>
"| SPC-bN  => New buffer on new tab.
nnoremap <silent> <leader>bN :tabe<cr>
"| SPC-tn  => Toggle number.
nnoremap <silent> <leader>tn :call tux#functions#toggleNumber()<cr>

" ALT ------------------------------------------------------------------------
"| [ALT] ---------------------------------------------------------------------
"| Alt-a   => Move current line up.
nnoremap <silent> <A-a> <Cmd>call tux#functions#switchLine(line('.'), 'up')<cr>
nnoremap <silent> <A-s> <Cmd>call tux#functions#switchLine(line('.'), 'down')<cr>
"| Alt-s   => Move current line down.
xnoremap <silent> <A-a> :<C-U>call tux#functions#moveSelection('up')<cr>
xnoremap <silent> <A-s> :<C-U>call tux#functions#moveSelection('down')<cr>
"| Alt-t   => Remove trailing whitespace characters.
nnoremap <silent> <A-t> :<C-U>call tux#functions#stripTrailingWhitespaces()<cr>
"| Alt-c   => Fill line with '-'.
nnoremap <silent> <A-c> :call tux#functions#fillLine('-')<cr>

if has('nvim')
"| ESC     => Disable hl with 2 ESC.
  noremap <silent> <ESC> <ESC>:noh<cr><ESC>
"| SPC-hrr => Reload init.vim quickly with notification.
  nnoremap <silent> <leader>hrr :<C-U>silent update $MYVIMRC <bar> source $MYVIMRC <bar> call v:lua.vim.notify("Nvim config successfully reloaded!", 'info', {'title': 'nvim-config', 'timeout': 2500})<cr>

" FZFLUA ---------------------------------------------------------------------
"| [FZFLUA] ------------------------------------------------------------------
"| SPC-fB  => fzf builtin.
  nnoremap <silent> <leader>fB :FzfLua builtin<cr>
"| SPC-fb  => fzf buffers.
  nnoremap <silent> <leader>fb :FzfLua buffers<cr>
"| SPC-fh  => fzf command history.
  nnoremap <silent> <leader>fh :FzfLua command_history<cr>
"| SPC-ff  => fzf files.
  nnoremap <silent> <leader>ff :FzfLua files<cr>
"| SPC-fg  => fzf live grep.
  nnoremap <silent> <leader>fg :FzfLua live_grep<cr>
"| SPC-fc  => fzf grep current buffer.
  nnoremap <silent> <leader>fc :FzfLua grep_curbuf<cr>
"| SPC-fw  => fzf grep current word.
  nnoremap <silent> <leader>fw :FzfLua grep_cword<cr>
"| SPC-fr  => fzf recent open files.
  nnoremap <silent> <leader>fr :FzfLua oldfiles<cr>
"| SPC-ft  => fzf colors schemes.
  nnoremap <silent> <leader>ft :FzfLua colorschemes<cr>
"| SPC-fk  => fzf key maps.
  nnoremap <silent> <leader>fk :FzfLua keymaps<cr>

"| [GIT] ----------------------------------------------------------------------
"| SPC-gs  => fzf git status.
  nnoremap <silent> <leader>gs :FzfLua git_status<cr>

" IPYTHON --------------------------------------------------------------------
"| [IPYTHON] -----------------------------------------------------------------
"| , s     => Open ipython.
  nnoremap ,s :SlimeSend1 ipython<cr>
"| , r     => Run file.
  nnoremap ,r :IPythonCellRun<cr>
"| , R     => Run file with Time.
  nnoremap ,R :IPythonCellRunTime<cr>
"| , c     => Cell Execute.
  nnoremap ,c :IPythonCellExecuteCell<cr>
"| , C     => Cell Execute Jump.
  nnoremap ,C :IPythonCellExecuteCellJump<cr>
"| , l     => Clear screen.
  nnoremap ,l :IPythonCellClear<cr>
"| [ c     => Previous cell.
  nnoremap [c :IPythonCellPrevCell<cr>
"| ] c     => Next cell.
  nnoremap ]c :IPythonCellNextCell<cr>
"| , p     => Previous command.
  nnoremap ,p :IPythonCellPrevCommand<cr>
"| , q     => Restart ipython.
  nnoremap ,q :IPythonCellRestart<cr>
"| , Q     => Exit ipython.
  nnoremap ,Q :SlimeSend1 exit<cr>
"| , ,     => Send command.
  nnoremap ,, :SlimeSend1 
"| , h     => Line send.
  nmap ,h <Plug>SlimeLineSend
"| , h     => Region send.
  xmap ,h <Plug>SlimeRegionSend

  nmap <F5> :IPythonCellInsertAbove<cr>
  imap <F5> <C-o>:IPythonCellInsertAbove<cr>
  nmap <F6> :IPythonCellInsertBelow<cr>
  imap <F6> <C-o>:IPythonCellInsertBelow<cr>
endif

"| [FN FUNC] -----------------------------------------------------------------
"| F1      => Motion search.
nnoremap <silent> <F1> :HopPattern<cr>
"| F2      => Color toggle.
nnoremap <silent> <F2> :ColorizerToggle<cr>
"| F3      => Maximizer toggle.
nnoremap <silent> <F3> :MaximizerToggle<cr>
"| F4      => AirlineTheme random.
nnoremap <silent> <F4> :AirlineTheme random<cr>
"| F8      => Minimap.
nnoremap <silent> <F8> :MinimapToggle<cr>
"| F12     => Undotree.
nnoremap <silent> <F12> :UndotreeToggle<cr>

" grep '"|' ~/.config/nvim/after/plugin/coc.vim ~/.config/nvim/after/plugin/fern.vim ~/.config/nvim/after/plugin/cmp.vim| awk -F ":" '{$1=""}1'
" grep '"|' ~/.config/nvim/init.vim
