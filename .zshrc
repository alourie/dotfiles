# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="mortalscumbag"
ZSH_THEME="oh-my-solarized"
#ZSH_THEME="russel"
unsetopt NOMATCH

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Set environment
SSH_ENV="$HOME/.ssh/environment"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# plugins=(git docker mvn notify z colorize command-not-found helm kubectl mvn pip)
plugins=(git docker notify z colorize command-not-found pip)
ZSH_COLORIZE_STYLE="solarized-dark"

# Cursor shape first, or other things will be fucked
source ~/Projects/zsh_functions/cursor_shape

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/sbin:/usr/sbin:/sbin/:/opt/terraform:/home/alourie/local/bin/:/home/alourie/Projects/scripts:/opt/terraform/:/opt/packer/:/home/alourie/.local/bin:/usr/local/go/bin:/home/alourie/Projects/gospace/bin:/home/alourie/GoogleAndroidTools/ndk-bundle:/home/alourie/GoogleAndroidTools/platform-tools:/opt/GoLand/bin:/home/alourie/bin:/var/lib/snapd/snap/bin

# Dircolors
#eval $(dircolors ~/.dir_colors)
if (( ${KITTY_WINDOW_ID} )); then
    export TERM="xterm-kitty"
else
    export TERM="screen-256color"
fi
# User specific aliases and functions
alias gp="cd ~/Projects/"
alias gosrc="cd $GOSRC"
alias app="cd ~/Projects/app"
# alias edv='nvim ~/.config/nvim/init.vim'
alias edz='nvim ~/.zshrc && rl'
# alias edc='nvim ~/.ssh/config'
# alias edcp='nvim ~/.ssh/prod-config'
# alias edct='nvim ~/.ssh/test-config'
# alias edkh='nvim ~/.ssh/known_hosts'
# alias edf='nvim ~/Projects/zsh_functions'
# alias edi3='nvim ~/.config/i3/config'
# alias edik='nvim ~/.config/kitty/kitty.conf'
# alias eda='nvim ~/.config/alacritty/alacritty.yml'
# alias edd='nvim ~/.config/dunst/dunstrc'
alias t=~/Projects/todo.txt-cli/todo.sh
alias vim='nvim-nightly'
alias rl='source ~/.zshrc'
alias run=xdg-open
alias ci='HOST=jenkins ssh citadeltunnel-d2 -L 8080:localhost:8080'
alias kibana='HOST=kibana ssh -nTL 5601:localhost:5601 nodes-tunnel-a1'
#alias p95="postgres -D \"/Users/alexlourie/Library/Application Support/Postgres/data9.5\""
alias ssh="ssh -A "
alias lpsql="psql -h localhost -p 54321 instaclustr instaclustr"
alias picsort="~/Projects/merge_pics/merge_go/picsort"
alias tshow="terraform state show"
alias tmv="terraform state mv"
alias showbig="du -sh * | grep -e '\dG'"
alias cls="clear"
alias pbcopy="xclip -sel clip"
alias xo=xdg-open
alias nn="notify-send \"all done\" -t 3000"
alias kube=kubectl
alias config='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'


# Go nodes
# source ~/Projects/zsh_functions/local_go

# Local aliases
# source ~/Projects/zsh_functions/local

# Editing nvim settings
source ~/Projects/zsh_functions/edv

# Edit configs
source ~/Projects/zsh_functions/edco

# DBload
# source ~/Projects/zsh_functions/dbload

# Z
source ~/Projects/z/z.sh

# Locales!
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#export PERL_MB_OPT="--install_base \"/Users/alexlourie/perl5\""; export PERL_MB_OPT;
#export PERL_MM_OPT="INSTALL_BASE=/Users/alexlourie/perl5"; export PERL_MM_OPT;
#export PERL5LIB="/Users/alexlourie/perl5/lib/perl5"

# PDFWork
# functions (ex-aliases)
source ~/Projects/zsh_functions/pdfwork

# JAVA_HOME
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))

# Source SSH settings, if applicable
#if [ -f "${SSH_ENV}" ]; then
#    . "${SSH_ENV}" > /dev/null
#    #ps ${SSH_AGENT_PID} doesn't work under cywgin
#    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
#        start_agent;
#    }
#else
#    start_agent;
#fi
eval $(keychain -q --agents ssh --eval alourie-ssh)
eval $(keychain -q --agents ssh --eval alourie.code)
eval $(keychain -q --agents ssh --eval flockin_gitlab)
eval $(keychain -q --agents ssh --eval github-flockin)

# Local bin
export PATH="${PATH}:/home/alourie/.local/bin"


# Golang
export GO111MODULE=on
export GOROOT=""
export GOROOT=`go env GOROOT`
export GOPATH=$HOME/Projects/gospace
export GOSRC="${GOPATH}/src"
export PATH=${PATH}:${GOPATH}/bin
alias gtest="$GOPATH/bin/gotest"

# For now
unset SSH_ASKPASS

# AWS CLI completions
# source /opt/boxen/homebrew/share/zsh/site-functions/_aws

# Ruby
# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
#
# Rust/Cargo
#source $HOME/.cargo/env
#
# Google tools
export GOOGLE_TOOLS=/home/alourie/GoogleAndroidTools
export PATH=${PATH}:${GOOGLE_TOOLS}/ndk-bundle:${GOOGLE_TOOLS}/platform-tools

# IntelliJ
export PATH=${PATH}:/opt/GoLand/bin:/opt/PyCharm/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Cargo
export PATH=${PATH}:$HOME/.cargo/bin
