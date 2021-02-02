## Make sure config is setup
export DOTS="$HOME/.dots"
if [ ! -d "${DOTS}" ]; then
	git clone --bare http://gitlab.com/alourie/dotfiles "${DOTS}"
fi

if [ ! -e "${HOME}/.zshrc_personal" ]; then
	echo "Don't forget getting the personal file"
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

zinit wait lucid for \
	OMZP::colorize \
	OMZP::command-not-found \
    OMZP::colored-man-pages \
	OMZP::mvn \

zinit wait lucid for \
    PZT::modules/utility/init.zsh


# Keys/completions/history + compinit
zinit wait'!' lucid atload"zicompinit; zicdreplay" for \
    OMZL::history.zsh \
    OMZL::spectrum.zsh \
    OMZL::completion.zsh \
    OMZL::key-bindings.zsh \
	as"completion" OMZP::docker/_docker

# All of the above using the for-syntax and also z-a-bin-gem-node annex
zinit wait"1" lucid from"gh-r" as"null" for \
     sbin"fzf"          junegunn/fzf-bin \
     sbin"**/fd"        @sharkdp/fd \
     sbin"**/bat"       @sharkdp/bat \
     sbin"exa* -> exa"  ogham/exa

# GIT
zinit wait lucid for \
	light-mode davidde/git


# Themes
setopt promptsubst

#
if (( ${KITTY_WINDOW_ID} )); then
    export TERM="xterm-kitty"
else
    export TERM="screen-256color"
fi


alias edz="vim ~/.zshrc && source ~/.zshrc"
alias rl="source ~/.zshrc"
alias ls="ls --color=auto"

# Awesome prompt (starship)
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

# Personal customisations
source ~/.zshrc_personal
