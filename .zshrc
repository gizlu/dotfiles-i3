# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

export LC_ALL=en_US.UTF-8 # set terminal language to english

#
# History
#

#set history size
export HISTSIZE=10000
#save history after logout
export SAVEHIST=10000
#history file
export HISTFILE=~/.zhistory
#append into history file
setopt INC_APPEND_HISTORY
#save only one command if 2 common are same and consistent
setopt HIST_IGNORE_DUPS
#add timestamp for each entry
# setopt EXTENDED_HISTORY   

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
# bindkey -v

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

### Aliases ###
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' 
alias rm_metadata="exiftool -all= -overwrite_original"

alias h="history 1"

# youtube-dl aliases
alias audio-dl="youtube-dl -f bestaudio --extract-audio"
alias opus-dl="youtube-dl --extract-audio --audio-quality 0 --audio-format opus"
alias mkv-dl="youtube-dl -f bestvideo+bestaudio/mkv"

# git aliases
alias ggraph="git log --graph --decorate --all --oneline"

# disk-related aliases
alias show_disk_processes="sudo lsof | grep"
alias veracrypt-dismount="killall mpd; veracrypt -d -f"

# Taskwarrior aliases
alias in="task add +in"  # inbox
alias rnd='task add +rnd +next +@computer +@online'  # research

alias cmake-compile_commands=-DCMAKE_EXPORT_COMPILE_COMMANDS=ON .

#vim
alias suvi='sudo -E nvim'

tickle () {
    deadline=$1
    shift
    in +tickle wait:$deadline $@
}
alias tick=tickle
alias think='tickle +1d'


### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# zsh theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
zplugin ice depth=1; zplugin light romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zinit ice wait'1' lucid; zinit light laggardkernel/zsh-thefuck
zinit ice wait'1' lucid; zinit light rupa/z
zinit ice wait'1' lucid; zinit light hcgraf/zsh-sudo
# zinit ice wait'1' lucid; zinit light jsahlen/tmux-vim-integration.plugin.zsh todo: find alternative

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions
