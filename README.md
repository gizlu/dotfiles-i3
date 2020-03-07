# dotfiles-i3

My archlinux configuration files

## Instalation

###Install zsh, zsh config framework, zsh theme:
'''bash
sudo pacman -S zsh
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
git clone https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
'''


## Dependencies
Currently the following arch packages are used:
- [i3-gaps](https://github.com/Airblader/i3) as window manager
- polybar for the status bar
- [termite](https://github.com/thestinger/termite) as the terminal emulator
- [neovim](https://github.com/neovim/neovim) as editor
- [neovim-qt](https://github.com/equalsraf/neovim-qt) as gui editor
- [firefox](https://www.mozilla.org/pl/firefox/) as internet browser
- [thunar](https://wiki.archlinux.org/index.php/Thunar) as file browser
- [rcm](https://github.com/thoughtbot/rcm) managing dotfiles
- [rofi](https://github.com/davatorium/rofi) program launcher
- [feh](https://github.com/derf/feh) to set the background
- [compton](https://github.com/chjj/compton) A compositor for X11
- ccls c/cpp language server protocol
