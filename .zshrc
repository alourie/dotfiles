# vim: filetype=bash
# PROFILING
# zmodload zsh/zprof
#
## DEFS
ZSHRC="${HOME}/.zshrc"

# PROJECTS
export PROJECTS="$HOME/Projects"

# Basic aliases
alias rl="source ${ZSHRC}"
alias edz="vim ${ZSHRC}"
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
alias gcl="git restore .idea *.iml"
alias gst="git stu"

function restore() {
  config restore --staged $@ 
  config restore $@
}

# Make PATH unique; i.e not repeat paths that are already defined.
typeset -U path
typeset -U fpath

## Make sure the config is setup
export DOTS="$HOME/.dots"
if [ ! -d "${DOTS}" ]; then
	# Check prereqs!
	git clone --bare http://gitlab.com/alourie/dotfiles "${DOTS}"

  # Restore function path from config
	config restore Projects/zsh_functions

    # Flag the first install
    FIRST_INSTALL=1
fi

# Custom functions
fpath+=($PROJECTS/zsh_functions)
autoload -Uz c
autoload -Uz edv
autoload -Uz set-tokens
autoload -Uz add-path

# Install the base
if [ "${FIRST_INSTALL}" = 1 ]; then
    autoload -Uz install-base
    install-base

    # "Restore" basic configs
    restore $HOME/.gitconfig $HOME/.config/kitty $HOME/.config/alacritty $HOME/.config/starship $HOME/.config/dunst $HOME/.config/nvim
fi

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
     sbin"fzf"          junegunn/fzf-bin  \

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
# If golang is found on  the system, set it up
if command -v go; then
		export GO111MODULE=on
		export GOROOT=`go env GOROOT`
		export GOPATH="${PROJECTS}/gospace"
		export GOSRC="${GOPATH}/src"

		# Update path
		path+=${GOPATH}/bin
		# Set for convenience
		alias gtest="${GOPATH}/bin/gotest"
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

# Conditionally add common paths in /opt
add-path /opt/IntelliJ/bin /opt/GoLand/bin /opt/PyCharm/bin /opt/terraform /opt/packer

# LUA server (sumneko)
add-path $PROJECTS/lua-language-server/bin/Linux

# Neovim 0.5; NVcode
add-path $HOME/.config/nvim/utils/bin

# This allows putting # to comment out the command
setopt interactivecomments
# For now
unset SSH_ASKPASS

# If keychain is installed and .ssh exists, load the keys
if command -v keychain > /dev/null; then
	keychain -l | grep "no identities" 2>&1 > /dev/null
	if [[ $? = 0 && -d $HOME/.ssh ]]; then
		# Just load all paired keys
		for f in $HOME/.ssh/*; do
			if [[ -f $f\.pub ]]; then
				eval $(keychain -q --agents ssh --eval $f)
			fi
		done
	fi
fi

# VIM mode ....probably needs to be last here
zinit ice lucid depth=1
zinit light jeffreytse/zsh-vi-mode
ZVM_VI_INSERT_ESCAPE_BINDKEY=jj
export ZVM_KEYTIMEOUT=0.2
# The plugin will auto execute this zvm_after_lazy_keybindings function
function zvm_after_lazy_keybindings() {
  zvm_define_widget up-line-or-beginning-search
  zvm_define_widget down-line-or-beginning-search

  zvm_bindkey vicmd 'k' up-line-or-beginning-search
  zvm_bindkey viins "^[k" up-line-or-beginning-search
  zvm_bindkey vicmd 'j' down-line-or-beginning-search
  zvm_bindkey viins "^[j" down-line-or-beginning-search
}

# Awesome prompt (starship); only do this if not installed via the system packaging.
if ! command -v starship > /dev/null ; then
	echo "Install Starship"
	curl -fsSL https://starship.rs/install.sh | bash
fi
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

export EDITOR=vim

# PROFILING
#zprof
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
