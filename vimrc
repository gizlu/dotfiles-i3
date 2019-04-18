" === General setting
set encoding=utf8
set number
set ruler

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

" === Apearance
" Awesome colorshemes:
" gruvbox
" deep-space

set background=dark
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
colorscheme gruvbox
syntax on


if has("gui_running")
	colorscheme gruvbox
	set guifont=Droid\ Sans\ Mono\ 11

	"highlight Cursor guibg=#20bbfc  "set cursor color
	set guicursor+=a:blinkon0 "disable cursor blinking

	set guioptions-=m  "remove menu bar
	set guioptions-=T  "remove toolbar
	set guioptions-=r  "remove right-hand scroll bar
	set guioptions-=L  "remove left-hand scroll bar
endif

" === Plugins
call plug#begin()

"Appearance
Plug 'vim-airline/vim-airline' "statusbar
Plug 'vim-airline/vim-airline-themes' "statusbar themes
Plug 'morhetz/gruvbox' "gruvbox theme

"python tricks
Plug 'Vimjas/vim-python-pep8-indent' "pep8 intendation
Plug 'ntpeters/vim-better-whitespace' "whitespace autoremover
Plug 'ap/vim-css-color' "colorname highlighting

"syntax plugins
Plug 'PotatoesMaster/i3-vim-syntax' "i3 syntax

"python-mode
Plug 'python-mode/python-mode', { 'branch': 'develop' }

" Consoles as buffers
Plug 'rosenfeld/conque-term'
" Pending tasks list
Plug 'fisadev/FixedTaskList.vim'

"exploring files
Plug 'vim-scripts/bufexplorer.zip' "buffer managing | <leader>o
Plug 'scrooloose/nerdtree' "Tab file explorer
Plug 'Xuyuanp/nerdtree-git-plugin' "git extension for nerdtree

"flow utilities
Plug 'amix/open_file_under_cursor.vim' "Open file under cursor when pressing gf
Plug 'tpope/vim-commentary' "gcc to comment one line, gc in visual mode to comment selected
Plug 'terryma/vim-multiple-cursors' " <C-n> next, <C-x> skip, <C-p> prev
Plug 'jwilm/i3-vim-focus' "same nav bindings with i3
Plug 'rbgrouleff/bclose.vim' "close one buffer

call plug#end()

" => airline
let g:airline_powerline_fonts = 0
let g:airline_theme='gruvbox'

let g:airline_section_y = 'BN: %{bufnr("%")}'
let g:airline#extensions#tabline#enabled = 1

" => better whitespace
let g:strip_whitespace_on_save = 1

" => bufExplorer plugin
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" => Nerd Tree
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>

" === keybindings

" leader key
let mapleader=","

" Easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

map gwl :call Focus('right', 'l')<CR>
map gwh :call Focus('left', 'h')<CRq
map gwk :call Focus('up', 'k')<CR>
map gwj :call Focus('down', 'j')<CR>

" copy and paste (ctr+c/x/v)
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa
nmap <C-v> <ESC>"+pa

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
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" create new tabs
nnoremap <leader>t :tabnew<Enter>

" Fast saving
nmap <leader>w :w!<cr>

" => sudo for handling the permisiond-deined error
command W w !sudo tee % > /dev/null

" => Fast editing and reloading of vimrc configs
map <leader>e :e! ~/.vimrc<cr>
autocmd! bufwritepost ~/.vimrc source ~/.vimrc

"clear last search
nmap <leader><space> :let@/ =""<cr>

" === misc
" => Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" => persistent undo (not cleared after close)
try
    set undodir=~/.vim/temp_dirs/undodir
    set undofile
catch
endtry

" => oppening help in vert split
augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END
"
" => nvim-like cursor switching
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" optional reset cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

" => fast escaping from insert mode
set timeoutlen=1000 ttimeoutlen=0

" => Set to auto read when a file is changed from the outside
set autoread

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
