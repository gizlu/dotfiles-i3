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

Plug 'Shougo/neosnippet.vim' "snippet manager
Plug 'Shougo/neosnippet-snippets' "snippets repository

Plug 'vim-syntastic/syntastic' "syntax checker

" => syntax plugins
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'pangloss/vim-javascript'
Plug 'StanAngeloff/php.vim'

" => Project navigation
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar'

Plug 'ctrlpvim/ctrlp.vim' "fuzzy find

Plug 'vim-scripts/bufexplorer.zip'

Plug 'mhinz/vim-startify' "fancy start screen

" => git support
Plug 'airblade/vim-gitgutter' "git diff column
Plug 'tpope/vim-fugitive' "git wrapper
Plug 'aymericbeaumet/symlink.vim' "symlink autofolowing 

" =>  Other text editing features
Plug 'tpope/vim-commentary' "gcc to comment line, gc in visual to comment selection
Plug 'terryma/vim-multiple-cursors' "<C-n> next, <C-x> skip, <C-p> prev

" => python
Plug 'klen/python-mode'

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

imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
	\ "\<Plug>(neosnippet_expand_or_jump)"
	\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
	\ "\<Plug>(neosnippet_expand_or_jump)"
	\: "\<TAB>"

" => nerdtree
" Open/close NERDTree Tabs with ,t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>

" => easytags and tagbar

" Where to look for tags files
set tags=./tags;,~/.vimtags
" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

" Open/close tagbar with \b
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
nmap <leader>gc :Gcommit<cr>
nmap <leader>ga :Gwrite<cr>

" => syntastic settings 
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args='--ignore=E701'
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

" => python-mode
let g:pymode_python = 'python3'
let g:pymode_indent = 1
let g:pymode_folding = 1
let g:pymode_virtualenv = 1
let g:pymode_lint = 0
let g:pymode_rope = 0
