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
Plug 'wellle/tmux-complete.vim' "completion from tmux pane
Plug 'Shougo/neoinclude.vim' "Include completion framework

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'SirVer/ultisnips' "snippet manager
Plug 'honza/vim-snippets' "snippets repository

Plug 'jiangmiao/auto-pairs' "automatic bracket completion
Plug 'dense-analysis/ale'
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
Plug 'Yggdroot/indentLine'

call plug#end()

" => airline

let g:airline_powerline_fonts = 0
let g:airline_theme='gruvbox'
let g:airline_section_y = 'BN: %{bufnr("%")}'
let g:airline#extensions#tabline#enabled = 1

" => autocompletion
let g:deoplete#enable_at_startup = 1
let deoplete#tag#cache_limit_size = 5000000
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" => snippets
"default ultisnips bindings

let g:UltiSnipsExpandTrigger= '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" => nerdtree
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

" => ALE

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '▲'

nmap <silent> <A-k> <Plug>(ale_previous_wrap)
nmap <silent> <A-j> <Plug>(ale_next_wrap)

let g:ale_python_pylint_options = '--disable=C0114,C0116'
let g:ale_linters = {'c': [], 'cpp': []} " TO TIDY

" => asyncrun
" Quick run via <F5>
nnoremap <F5> :call <SID>compile_and_run()<CR>
" Make via <F6>
nnoremap <F6> :AsyncRun -cwd=<root> make<CR>

function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
       exec "AsyncRun! g++ -std=c++17 % -o %<; time ./%<"
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

let g:neoformat_enabled_python = ['yapf']
" => jedi-vim
" disable autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled = 0

" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"


let g:alternateSearchPath = 'sfr:../Source,sfr:../src,sfr:../Include,sfr:../inc'

let g:LanguageClient_serverCommands = {
    \ 'c': ['ccls', '--log-file=/tmp/cc.log'],
    \ 'cpp': ['ccls', '--log-file=/tmp/cc.log'],
    \ 'cuda': ['ccls', '--log-file=/tmp/cc.log'],
    \ 'objc': ['ccls', '--log-file=/tmp/cc.log'],
    \ }

function SetLSPShortcuts()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>r :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType cpp,c call SetLSPShortcuts()
augroup END

let g:LanguageClient_useVirtualText = "No"
