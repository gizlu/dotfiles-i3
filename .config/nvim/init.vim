" === General setting
set encoding=utf8
set number
set ruler
set nowrap

set wildmenu
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

set hid "A buffer becomes hidden when it is abandoned

set incsearch "search from top
set hlsearch "higlight search
set ignorecase
set smartcase

set mouse=a
set splitbelow
set splitright

set shortmess+=A "disable swapfile warning
set lazyredraw  "Don't redraw while executing macros (good performance config)

"Force using global python interpreter (useful with virtualenv)
let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog='/usr/bin/python3'

let mapleader="," " leader key

filetype plugin indent on
source ~/.config/nvim/Plugins.vim

" --------------------------------------------------------------------------------
" configure editor with tabs and nice stuff...
" --------------------------------------------------------------------------------
set expandtab           " enter spaces when tab is pressed
set textwidth=120       " break lines when line length increases
set tabstop=4           " use 4 spaces to represent tab
set softtabstop=4
set shiftwidth=4        " number of spaces to use for auto indent
set autoindent          " copy indent from current line when starting a new line
"
" === intendation settings ===
" configure expanding of tabs for various file types
" autocmd FileType c,cpp,objc setlocal expandtab shiftwidth=2 softtabstop=2

" make backspaces more powerfull
set backspace=indent,eol,start

" === Apearance

colorscheme gruvbox
set background=dark
" Enable true color
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
syntax on

" === keybindings
" <Esc> to exit terminal mode
tnoremap <Esc> <C-\><C-n>

" Enable split navigations in insert mode
inoremap <C-h> <Esc>:TmuxNavigateLeft<cr>
inoremap <C-j> <Esc>:TmuxNavigateDown<cr>
inoremap <C-k> <Esc>:TmuxNavigateUp<cr>
inoremap <C-l> <Esc>:TmuxNavigateRight<cr>

"Quickly insert paranthesis/brackets/etc
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i 

" => fold toggle

"single folding
nnoremap <space> za
vnoremap <space> zf

"all foldings
nnoremap <expr> <f2> &foldlevel ? 'zM' :'zR'

" copy and paste (ctr+c/x/v)
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa
nmap <C-v> <ESC>"+pa


vmap <S-C-c> "+yi
vmap <S-C-x> "+c
vmap <S-C-v> c<ESC>"+p
imap <S-C-v> <ESC>"+pa
nmap <S-C-v> <ESC>"+pa

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+y$
nnoremap  <leader>yy "+yy

" Cut to clipboard
vnoremap  <leader>d  "+d
nnoremap  <leader>d  "+d
nnoremap  <leader>D  "+d$
nnoremap  <leader>dd  "+dd

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Close all the buffers
map <leader>q :bd<cr>
map <leader>Q :bd!<cr>
map <leader>ba :bufdo bd<cr>

map <M-l> :bnext<cr>
map <M-h> :bprevious<cr>

"quick change directory to current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Fast saving
nmap <leader>w :w!<cr>

" => sudo for handling the permisiond-deined error

" Open a current file with sudo
command! R e suda://%
" Save a current file with sudo
command! W w suda://%

" => Fast editing of vimrc config
map <leader>e :e! ~/.config/nvim/init.vim<cr>

"clear last search
nmap <leader><space> :let@/ =""<cr>

" => Visual mode related
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" === misc

" => Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

set undofile
set undodir=~/.local/share/nvim/temp_dirs/undodir//

set backup
set backupdir=~/.local/share/nvim/temp_dirs/backupdir//

set swapfile
set directory=~/.local/share/nvim/temp_dirs/swapdir//

" => oppening help in vert split
augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

" => fast escaping from insert mode
set timeoutlen=1000 ttimeoutlen=0

" => Set to auto read when a file is changed from the outside
set autoread

" => session storing settings
set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

" open highlited text in vertical split
vnoremap <F3> y<ESC>:vnew<CR>P<c-w>pgv

" => autoreload vimrc after save
autocmd! bufwritepost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim
autocmd! bufwritepost ~/.config/nvim/Plugins.vim source ~/.config/nvim/init.vim
autocmd! bufwritepost ~/.config/nvim/ginit.vim source ~/.config/nvim/init.vim
