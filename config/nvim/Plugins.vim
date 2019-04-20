call plug#begin('~/.local/share/nvim/plugged')

"Appearance
Plug 'morhetz/gruvbox' "gruvbox theme
Plug 'vim-airline/vim-airline' "statusbar

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } "autocompletion

Plug 'PotatoesMaster/i3-vim-syntax'
call plug#end()

" => airline

let g:airline_powerline_fonts = 0
let g:airline_theme='gruvbox'
let g:airline_section_y = 'BN: %{bufnr("%")}'
let g:airline#extensions#tabline#enabled = 1

" => autocompletion
let g:deoplete#enable_at_startup = 1
