call plug#begin('~/.local/share/nvim/plugged')

" => Appearance
Plug 'morhetz/gruvbox' "gruvbox theme
Plug 'vim-airline/vim-airline' "statusbar
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline-themes'

" => completion and syntax
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } "autocompletion

Plug 'Shougo/neco-syntax' "completion from syntax files
Plug 'deoplete-plugins/deoplete-jedi' "python completion
Plug 'wokalski/autocomplete-flow' "javascript completion
Plug 'lvht/phpcd.vim' "php completion

Plug 'SirVer/ultisnips' "snippet manager
Plug 'honza/vim-snippets' "snippets repository

Plug 'neomake/neomake'
Plug 'skywind3000/asyncrun.vim'

" => syntax plugins
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'pangloss/vim-javascript'
Plug 'StanAngeloff/php.vim'
Plug 'elzr/vim-json'

" => Project navigation
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar'

Plug 'mileszs/ack.vim'


Plug 'ctrlpvim/ctrlp.vim' "fuzzy find

Plug 'vim-scripts/bufexplorer.zip'

Plug 'mhinz/vim-startify' "fancy start screenT

" => git support
Plug 'mhinz/vim-signify' "git diff column
Plug 'tpope/vim-fugitive' "git wrapper
Plug 'aymericbeaumet/symlink.vim' "symlink autofolowing

" =>  Other text editing features
Plug 'tpope/vim-commentary' "gcc to comment line, gc in visual to comment selection
"Plug 'terryma/vim-multiple-cursors' "<C-n> next, <C-x> skip, <C-p> prev
Plug 'hlissner/vim-multiedit' 
Plug 'tpope/vim-surround' "easily change, delete parenthes, brackets, quotes, XML tags, and more
Plug 'alvan/vim-closetag' "auto closing HTML tags
"Plug 'Valloric/MatchTagAlways' "show matching HTML tags
Plug 'brooth/far.vim' "search and replace
Plug 'lambdalisue/suda.vim' " read or write files with sudo command

" => Other imporvemnts
Plug 'klen/python-mode'
Plug 'Vimjas/vim-python-pep8-indent' " A nicer Python indentation style for vim. 
Plug 'tweekmonster/django-plus.vim' "improvements to the handling of Django related files in Vim
Plug 'tell-k/vim-autopep8' " autopep8
Plug 'sbdchd/neoformat' " multi language autoformater
Plug 'sukima/xmledit/' " help edit XML/HTML documents
Plug 'christoomey/vim-tmux-navigator' " have same bindings with tmux
Plug 'edkolev/tmuxline.vim'

"Plug 'idanarye/vim-vebugger' " multi-language debugger
" 

" => buffer plugins
Plug 'Shougo/denite.nvim' 
Plug 'blindFS/vim-taskwarrior' " vim interface to taskwarrior

call plug#end()

" => airline

let g:airline_powerline_fonts = 0
let g:airline_theme='gruvbox'
let g:airline_section_y = 'BN: %{bufnr("%")}'
let g:airline#extensions#tabline#enabled = 1

" => autocompletion
let g:deoplete#enable_at_startup = 1
let deoplete#tag#cache_limit_size = 5000000


" => snippets
"default ultisnips bindings

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

" => nerdtree
" Open/close NERDTree Tabs with ,t
nmap <silent> <leader>n :NERDTreeTabsToggle<CR>

" => ack.vim
" open ack for fast search
map <leader>g :Ack

" => easytags and tagbar

" Where to look for tags files
set tags=./tags;,~/.vimtags
" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

" Open/close tagbar with ,b
nmap <silent> <leader>b :TagbarToggle<CR>

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

" config for python syntax checking
let g:neomake_python_pylint_maker = {
  \ 'args': [
  \ '-d', 'C0103, C0111',
  \ '-f', 'text',
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
let g:neomake_python_pylint_args = neomake#makers#ft#python#pylint().args + ['--max-line-length=100']
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

" => python-mode
let g:pymode_python = 'python3'
let g:pymode_indent = 0
let g:pymode_folding = 1
let g:pymode_virtualenv = 1
let g:pymode_lint = 0
let g:pymode_rope = 1
"disable annoying pymode features
let g:pymode_doc = 0
let g:pymode_rope_complete_on_dot = 0

" => python debugger
let g:vebugger_leader='<Leader>d'

" => autopep8
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>
" => neoformat
autocmd Filetype * if &ft!="python"|noremap <buffer> <F8> :Neoformat<CR>|endif

" => json
let g:vim_json_syntax_conceal = 0 " disable json concealing
