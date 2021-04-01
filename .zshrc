# PROFILING
# zmodload zsh/zprof

# OPTIONS:
# Uncomment; these work on being set/notset; *NOT* on true/false
USE_GO=bla

## DEFS
ZSHRC="${HOME}/.zshrc"

# PROJECTS
export PROJECTS="$HOME/Projects"

## Make sure the config is setup
export DOTS="$HOME/.dots"
if [ ! -d "${DOTS}" ]; then
	# Check prereqs!
	git clone --bare http://gitlab.com/alourie/dotfiles "${DOTS}"
fi


# Make PATH unique; i.e not repeat paths that are already defined.
typeset -U path

# Deps list, it's for arch; will need some update for debians/fedoras
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

zinit wait'!' lucid for \
	light-mode PZT::modules/utility/init.zsh \

zinit wait'!' lucid for \
	light-mode OMZP::colorize \
	light-mode OMZP::command-not-found \
    light-mode OMZP::colored-man-pages \
	light-mode OMZP::mvn \

zinit wait'!' lucid atload"zicompinit; zicdreplay" for \
    light-mode OMZL::completion.zsh \

zinit lucid for \
    light-mode OMZL::key-bindings.zsh \


# Docker, currently unused
# zinit wait lucid atload"zicompinit; zicdreplay" for \
#  	as"completion" OMZP::docker/_docker

zinit wait'!' lucid from"gh-r" as"null" for \
     sbin"fzf"          junegunn/fzf-bin \
     sbin"**/fd"        @sharkdp/fd \
     sbin"**/bat"       @sharkdp/bat \
     sbin"**/hyperfine" @sharkdp/hyperfine \

# GIT
zinit wait lucid for \
	light-mode davidde/git


# KITTY TERM
if (( ${KITTY_WINDOW_ID} )); then
    export TERM="xterm-kitty"
else
    export TERM="screen-256color"
fi

# PATH LOCAL stuff
path=($PROJECTS/scripts $HOME/.local/bin $path)

alias rl="source ${ZSHRC}"
alias edz="vim ${ZSHRC} && rl"
alias gp="cd $PROJECTS"
alias t=$PROJECTS/todo.txt-cli/todo.sh
alias vim='nvim'
alias ssh="ssh -A "
alias picsort="$PROJECTS/merge_pics/merge_go/picsort"
alias showbig="du -sh * | grep -e '\dG'"
alias showst="lsblk | ack -v \"loop|ram|rom\""
alias cls="clear"
alias nn="notify-send \"all done\" -t 3000"
alias config='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'

# Custom functions
fpath+=($PROJECTS/zsh_functions)
autoload -Uz c
autoload -Uz edv
autoload -Uz set-tokens
autoload -Uz set-go
autoload -Uz add-path

# PDFWork functions (ex-aliases)
# autoload -Uz pdfwork

# Locales!
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Perl
# if (( ${USE_PERL} )); then
# 	export PERL_MB_OPT="--install_base \"/Users/alexlourie/perl5\""; export PERL_MB_OPT;
# 	export PERL_MM_OPT="INSTALL_BASE=/Users/alexlourie/perl5"; export PERL_MM_OPT;
# 	export PERL5LIB="/Users/alexlourie/perl5/lib/perl5"
# fi


# JAVA_HOME
JAVA=$(which java)
if [[ $? == 0 ]]; then
	export JAVA_HOME=$(dirname $(dirname $(readlink -f $JAVA)))
fi

# Golang
if (( ${USE_GO} )); then
	set-go
fi

# Google tools
export GOOGLE_TOOLS=/home/alourie/GoogleAndroidTools
if [ -d ${GOOGLE_TOOLS} ]; then
	path+=(${GOOGLE_TOOLS}/ndk-bundle ${GOOGLE_TOOLS}/platform-tools)
fi

# Rust/Cargo
#source $HOME/.cargo/env
add-path $HOME/.cargo/bin

# Haskel
add-path $HOME/.cabal/bin

# Common paths in /opt
for p in /opt/IntelliJ/bin /opt/GoLand/bin /opt/PyCharm/bin /opt/terraform /opt/packer; do
	add-path $p
done

# This allows putting # to comment out the command
setopt interactivecomments
# For now
unset SSH_ASKPASS


keychain -l | grep "no identities" 2> /dev/null
if [[ $? = 0 && -d $HOME/.ssh ]]; then
	# Just load all paired keys
	for f in $HOME/.ssh/*; do
        if [[ -f $f\.pub ]]; then
            eval $(keychain -q --agents ssh --eval $f)
        fi
    done
fi

# VIM mode ....probably needs to be last here
zinit ice lucid depth=1
zinit light jeffreytse/zsh-vi-mode
export ZVM_KEYTIMEOUT=0.2
# The plugin will auto execute this zvm_after_lazy_keybindings function
function zvm_after_lazy_keybindings() {
  # Here we define the custom widget
  zvm_define_widget up-line-or-beginning-search
  zvm_define_widget down-line-or-beginning-search

  # In normal mode, press Ctrl-E to invoke this widget
  zvm_bindkey vicmd 'k' up-line-or-beginning-search
  zvm_bindkey viins "\ek" up-line-or-beginning-search
  zvm_bindkey vicmd 'j' down-line-or-beginning-search
  zvm_bindkey viins "\ej" down-line-or-beginning-search
}

# Awesome prompt (starship)
type starship > /dev/null
if [ ! $? -eq 0 ]; then
	echo "Install Starship"
	curl -fsSL https://starship.rs/install.sh | bash
fi
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

# PROFILING
#zprof
