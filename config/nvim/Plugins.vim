call plug#begin('~/.local/share/nvim/plugged')

" => Appearance
Plug 'morhetz/gruvbox' "gruvbox theme
Plug 'vim-airline/vim-airline' "statusbar

" => completion and syntax
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } "autocompletion

Plug 'Shougo/neco-syntax' "completion from syntax files
Plug 'deoplete-plugins/deoplete-jedi' "python completion
Plug 'wokalski/autocomplete-flow' "javascript completion
Plug 'lvht/phpcd.vim' "php completion

Plug 'SirVer/ultisnips' "snippet manager
Plug 'honza/vim-snippets' "snippets repository

Plug 'vim-syntastic/syntastic' "syntax checker

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
Plug 'airblade/vim-gitgutter' "git diff column
Plug 'tpope/vim-fugitive' "git wrapper
Plug 'aymericbeaumet/symlink.vim' "symlink autofolowing

" =>  Other text editing features
Plug 'tpope/vim-commentary' "gcc to comment line, gc in visual to comment selection
Plug 'terryma/vim-multiple-cursors' "<C-n> next, <C-x> skip, <C-p> prev
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
"Plug 'Shougo/vimproc.vim', {'do' : 'make'}

Plug 'neomake/neomake'
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

" suda
let g:suda_smart_edit = 1
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

" => gitgutter
let g:airline#extensions#hunks#non_zero_only = 1
let g:gitgutter_override_sign_column_highlight = 1

"rebind my favorite commands from Git.vim for Fugitive
nmap <leader>gs :Gstatus<cr>
nmap <leader>ga :Gwrite<cr>
nmap <leader>gc :Gcommit<cr>
nmap <leader>gr :Gread<CR>


" => syntastic settings
let g:syntastic_python_checkers = ['flake8', 'pylint']
"let g:syntastic_python_flake8_args='--ignore=E701'
let g:syntastic_python_pylint_args = '--disable=C0103 --extension-pkg-whitelist=pygame'
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
    au!
    au FileType tex let b:syntastic_mode = "passive"
augroup END

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
