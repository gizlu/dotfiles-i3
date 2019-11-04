call plug#begin('~/.local/share/nvim/plugged')

" => Appearance
Plug 'morhetz/gruvbox' "gruvbox theme
Plug 'vim-airline/vim-airline' "statusbar
Plug 'vim-airline/vim-airline-themes'

" => completion and syntax
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'deoplete-plugins/deoplete-jedi' "python completion
Plug 'davidhalter/jedi-vim' "python goto and refactoring
Plug 'Shougo/neco-syntax' "completion from syntax files
Plug 'Shougo/neoinclude.vim' "Include completion framework
Plug 'Shougo/deoplete-clangx' "c/cpp completion

Plug 'SirVer/ultisnips' "snippet manager
Plug 'honza/vim-snippets' "snippets repository

Plug 'jiangmiao/auto-pairs' "automatic bracket completion
Plug 'neomake/neomake'
Plug 'skywind3000/asyncrun.vim'

" => syntax plugins
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'pangloss/vim-javascript'
Plug 'StanAngeloff/php.vim'

" => Project navigation
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'ctrlpvim/ctrlp.vim' "fuzzy find
Plug 'vim-scripts/bufexplorer.zip'
Plug 'mhinz/vim-startify' "fancy start screenT

" => git support
Plug 'mhinz/vim-signify' "git diff column
Plug 'tpope/vim-fugitive' "git wrapper
Plug 'aymericbeaumet/symlink.vim' "symlink autofolowing

" =>  Other text editing features
Plug 'tpope/vim-commentary' "gcc to comment line, gc in visual to comment selection
Plug 'terryma/vim-multiple-cursors' "<C-n> next, <C-x> skip, <C-p> prev
Plug 'sbdchd/neoformat' " multi language autoformater
Plug 'lambdalisue/suda.vim' " read or write files with sudo command
Plug 'vim-scripts/a.vim' " Switching between source and header file

" => Other imporvemnts
Plug 'Vimjas/vim-python-pep8-indent' " A nicer Python indentation style for vim. 
Plug 'tweekmonster/django-plus.vim' "improvements to the handling of Django related files in Vim
Plug 'sukima/xmledit/' " help edit XML/HTML documents
Plug 'christoomey/vim-tmux-navigator' " have same bindings with tmux
Plug 'edkolev/tmuxline.vim'

call plug#end()

" => airline

let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'
let g:airline_section_y = 'BN: %{bufnr("%")}'
let g:airline#extensions#tabline#enabled = 1

" => autocompletion
let g:deoplete#enable_at_startup = 1
let deoplete#tag#cache_limit_size = 5000000
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" => snippets
"default ultisnips bindings

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

" => nerdtree
" Open/close NERDTree Tabs with ,t
nmap <silent> <leader>n :NERDTreeTabsToggle<CR>

" => bufExplorer plugin

let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>

"rebind my favorite commands from Git.vim for Fugitive
nmap <leader>gs :Gstatus<cr>
nmap <leader>ga :Gwrite<cr>
nmap <leader>gc :Gcommit<cr>
nmap <leader>gr :Gread<CR>

" => neomake
function! MyOnBattery()
  if has('macunix')
    return match(system('pmset -g batt'), "Now drawing from 'Battery Power'") != -1
  elsif has('unix')
    return readfile('/sys/class/power_supply/AC/online') == ['0']
  endif
  return 0
endfunction

if MyOnBattery()
  call neomake#configure#automake('w')
else
  call neomake#configure#automake('nw', 1000)
endif

" set symbols
let g:neomake_error_sign = {'text': '✘'}
let g:neomake_warning_sign = {'text': '▲'}
" disable inline warning

" config for python syntax checking
let g:neomake_virtualtext_current_error=0

let g:neomake_python_pylint_maker = {
  \ 'args': [
  \ '-d', 'C0103',
  \ '-f', 'text',
  \ '--max-line-length=100',
  \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg}"',
  \ '-r', 'n'
  \ ],
  \ 'errorformat':
  \ '%A%f:%l:%c:%t: %m,' .
  \ '%A%f:%l: %m,' .
  \ '%A%f:(%l): %m,' .
  \ '%-Z%p^%.%#,' .
  \ '%-G%.%#',
  \ }
let g:neomake_python_enabled_makers = ['pylint']

" => asyncrun
" Quick run via <F5>
nnoremap <F5> :call <SID>compile_and_run()<CR>

function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
       exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
       exec "AsyncRun! javac %; time java %<"
    elseif &filetype == 'sh'
       exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
       exec "AsyncRun! time python %"
    endif
endfunction

let g:asyncrun_open = 15

" => neoformat
nnoremap <F8> :Neoformat<CR>

" Settings when formatter not found
let g:neoformat_basic_format_align = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1

" => jedi-vim
" disable autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled = 0

" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"
