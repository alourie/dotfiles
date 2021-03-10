# PROFILING
# zmodload zsh/zprof

## DEFS
ZSHRC="${HOME}/.zshrc"
ZSHRC_PERSONAL="${HOME}/.zshrc_personal"

## Make sure config is setup
export DOTS="$HOME/.dots"
if [ ! -d "${DOTS}" ]; then
	git clone --bare http://gitlab.com/alourie/dotfiles "${DOTS}"
fi

if [ ! -e "${ZSHRC_PERSONAL}" ]; then
	wget https://gitlab.com/alourie/dotfiles/-/raw/master/.zshrc_personal "${ZSHRC_PERSONAL}"
fi

alias rl="source ${ZSHRC}"
alias rlc="source ${ZSHRC_PERSONAL}"
alias edz="vim ${ZSHRC} && rl"
alias edzp="vim ${ZSHRC_PERSONAL} && rlc"

# Test alt+k as arrow up in the terminal
bindkey "\ek" up-line-or-beginning-search
bindkey "\ej" down-line-or-beginning-search
bindkey "\eh" backward-word
bindkey "\el" forward-word # this one is also redefined on key-bindings loading

# Awesome prompt (starship)
type starship > /dev/null
if [ ! $? -eq 0 ]; then
	echo "Install Starship"
	curl -fsSL https://starship.rs/install.sh | bash
fi
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"


# Make PATH unique; i.e not repeat paths that are already defined.
typeset -U path

# Applications list, it's for arch; will need some update for debians/fedoras
# APPS="dunst polybar redshift feh network-manager-applet pasystray kitty neovim"
# for app in "${(@s/ /)APPS}"; do
# 	type $app 2&>1 > /dev/null
# 	if [ ! $? -eq 0 ]; then
# 		# Not installed, just do all
# 		echo "Installing minimal programs set"
# 		sudo pacman -S --needed ${(@s/ /)APPS}
# 	fi
# done

# Check fonts; currently I'm using JetBrains Mono, so expect it to be installed
# pacman -Q nerd-fonts-jetbrains-mono 2&>1 > /dev/null
# if [ ! $? -eq 0 ]; then
#    yay -y nerd-fonts-jetbrains-mono
# fi

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

# Autosuggestions & fast-syntax-highlighting
zinit for \
	zdharma/history-search-multi-word \
    light-mode  agkozak/zsh-z \
    light-mode  marzocchi/zsh-notify \
    light-mode OMZL::history.zsh \

zinit wait lucid atload'bindkey "\el" forward-word' for \
    light-mode OMZL::key-bindings.zsh \

zinit wait lucid atload"zicompinit; zicdreplay" for \
    light-mode OMZL::completion.zsh \
	light-mode OMZP::colorize \
	light-mode OMZP::command-not-found \
    light-mode OMZP::colored-man-pages \
	light-mode OMZP::mvn \
    light-mode PZT::modules/utility/init.zsh

# Docker, currently unused
# zinit wait lucid atload"zicompinit; zicdreplay" for \
#  	as"completion" OMZP::docker/_docker

# All of the above using the for-syntax and also z-a-bin-gem-node annex
zinit wait lucid from"gh-r" as"null" for \
     sbin"fzf"          junegunn/fzf-bin \
     sbin"**/fd"        @sharkdp/fd \
     sbin"**/bat"       @sharkdp/bat \
     sbin"exa* -> exa"  ogham/exa

# GIT
zinit wait lucid for \
	light-mode davidde/git

# KITTY TERM
if (( ${KITTY_WINDOW_ID} )); then
    export TERM="xterm-kitty"
else
    export TERM="screen-256color"
fi

# Personal customisations
source ${ZSHRC_PERSONAL}

# VIM mode
# zinit ice depth=1
# zinit light jeffreytse/zsh-vi-mode
# ZVM_KEYTIMEOUT=1


# PROFILING
#zprof
