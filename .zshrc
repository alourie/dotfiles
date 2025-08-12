# vim: filetype=bash
# PROFILING
# zmodload zsh/zprof
#
## DEFS
# TERM=xterm
ZSHRC="${HOME}/.zshrc"
ZINIT_HOME="${HOME}/.zinit"

# PROJECTS
export PROJECTS="$HOME/Projects"

# EDITOR
# export NVIM_APPNAME=nvim-new
# export nvim=$HOME/.local/bin/nvim
# export NVIM_APPNAME=nvim
export EDITOR=$HOME/Projects/zsh_functions/mvim


# Basic aliases
alias ls="ls --color"
alias rl="source ${ZSHRC}"
alias ee="$EDITOR ${ZSHRC}"
alias gp="cd $PROJECTS"
alias t=todo.sh
alias vim=$EDITOR
alias ssh="ssh -A "
alias picsort="$PROJECTS/merge_pics/merge_go/picsort"
alias showbig="du -sh * | grep -e '\dG'"
alias showst="lsblk | ack -v \"loop|ram|rom\""
alias cls="clear"
alias nn="notify-send \"all done\" -t 3000"
alias nne="notify-send -u critical -a \"shell\" \"error!\" -t 3000"
alias config='git --git-dir=$HOME/.dots/ --work-tree=$HOME'
alias gcl="git restore .idea"
alias gst="git stu"
alias gf="gix fetch"
alias gr="git rebase"
alias vact="source venv/bin/activate"
alias pp="termpdf.py"
alias qp='qpdf --empty --pages'
alias k=kubectl
alias run='podman run --rm'

#fix obvious typo's
alias cd..='cd ..'
alias pdw="pwd"
alias udpate='sudo pacman -Syyu'
alias upate='sudo pacman -Syyu'
alias updte='sudo pacman -Syyu'
alias updqte='sudo pacman -Syyu'
alias upqll="paru -Syu --noconfirm"
alias upal="paru -Syu --noconfirm"

#arcolinux logout unlock
alias rmlogoutlock="sudo rm /tmp/arcologout.lock"

#free
alias free="free -mt"

# Aliases for software managment
# pacman or pm
alias pacman='sudo pacman --color auto'
alias update='sudo pacman -Syyu'

# yay as aur helper - updates everything
alias pksyua="paru -Syu --noconfirm"
alias upall="paru -Syu --noconfirm"

#ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"

#grub update
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

#add new fonts
alias update-fc='sudo fc-cache -fv'

#copy/paste all content of /etc/skel over to home folder - backup of config created - beware
alias skel='cp -Rf ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H.%M.%S) && cp -rf /etc/skel/* ~'
#backup contents of /etc/skel to hidden backup folder in home/user
alias bupskel='cp -Rf /etc/skel ~/.skel-backup-$(date +%Y.%m.%d-%H.%M.%S)'

#switch between lightdm and sddm
alias tolightdm="sudo pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings --noconfirm --needed ; sudo systemctl enable lightdm.service -f ; echo 'Lightm is active - reboot now'"
alias tosddm="sudo pacman -S sddm --noconfirm --needed ; sudo systemctl enable sddm.service -f ; echo 'Sddm is active - reboot now'"

#quickly kill conkies
alias kc='killall conky'

#hardware info --short
alias hw="hwinfo --short"

#skip integrity check
alias yayskip='yay -S --mflags --skipinteg'
alias trizenskip='trizen -S --skipinteg'

#check vulnerabilities microcode
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'

#get fastest mirrors in your neighborhood
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 30 --number 10 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 30 --number 10 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 30 --number 10 --sort age --save /etc/pacman.d/mirrorlist"
#our experimental - best option for the moment
alias mirrorx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 5 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"
alias mirrorxx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 20 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"

#Cleanup orphaned packages
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

#search content with ripgrep
alias rg="rg --sort path"

# xdg-open
alias xo=xdg-open

# fetch date
alias ddd="echo -n $(date +'%B %d, %Y') | wl-copy"

# Zepben Address
alias zzz="echo -n Suite 2, Level 2, 11 London Circuit, Canberra, Australian Capital Territory 2601 | pbcopy"


function restore() {
  git restore --staged $@ 
  git restore $@
}

function restore_config() {
  config restore --staged $@ 
  config restore $@
}

function ex() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Make PATH/FPATH unique; i.e not repeat paths that are already defined.
typeset -U path
typeset -U fpath

## Make sure the config is setup
export DOTS="$HOME/.dots"
if [ ! -d "${DOTS}" ]; then

  # Check prereqs!
  if ! command -v git > /dev/null; then
      sudo pacman -Sy git
  fi

  git clone --bare http://github.com/alourie/dotfiles "${DOTS}"

  # Restore config
  config reset --hard HEAD 
fi

# Custom functions
fpath+=($PROJECTS/zsh_functions)
autoload -Uz c
autoload -Uz edv
autoload -Uz set-tokens
autoload -Uz add-path
autoload -Uz ginit
autoload -Uz lock
autoload -Uz my-slack
autoload -Uz doccc
autoload -Uz gg 
autoload -Uz clearusb 
autoload -Uz get-git-path
autoload -Uz update-tmux-pane

# Install the base
if [ "${FIRST_INSTALL}" = 1 ]; then
    autoload -Uz install-base
    install-base

    # "Restore" basic configs
    restore_config .gitconfig .config/starship 
fi

if [[ ! -f $ZINIT_HOME/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$ZINIT_HOME" && command chmod g-rwX "$ZINIT_HOME"
    command git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
### End of Zinit's installer chunk

source "$ZINIT_HOME/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/z-a-rust \
    zdharma-continuum/z-a-as-monitor \
    zdharma-continuum/z-a-patch-dl \
    zdharma-continuum/z-a-bin-gem-node

zi for \
	zdharma-continuum/history-search-multi-word \
    light-mode agkozak/zsh-z \
    light-mode OMZL::history.zsh \

zinit wait'!' lucid for \
	light-mode PZT::modules/utility/init.zsh \

zinit wait'!' lucid for \
	light-mode OMZP::colorize \
    light-mode OMZP::colored-man-pages \
	light-mode OMZP::command-not-found \
	light-mode OMZP::mvn \

zinit wait'!' lucid atload"zicompinit; zicdreplay" for \
    light-mode OMZL::completion.zsh \

zinit lucid for \
    light-mode OMZL::key-bindings.zsh \

# KITTY TERM
if (( ${KITTY_WINDOW_ID} )); then
    export TERM="xterm-kitty"
elif [ ! -z ${BYOBU_BACKEND} ]; then
    export TERM="tmux-256color"
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
if command -v java > /dev/null; then
    JAVA=$(which java)
	export JAVA_HOME=$(dirname $(dirname $(readlink -f $JAVA)))
    export IDEA_JDK=/usr/lib/jvm/jre-jetbrains/

fi

# Golang
# If golang is found on  the system, set it up
add-path /usr/local/go/bin
if command -v go > /dev/null; then
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
export GOOGLE_TOOLS=$HOME/GoogleAndroidTools
if [ -d ${GOOGLE_TOOLS} ]; then
	path+=(${GOOGLE_TOOLS}/ndk-bundle ${GOOGLE_TOOLS}/platform-tools)
fi

# Pascal
# export FPCDIR='/usr/lib/fpc/src'      # FPC source directory (This is the only required option for the server to work).
export PP='/usr/lib/fpc/3.2.2/ppcx64' # Path to the Free Pascal compiler executable.
# export LAZARUSDIR='/usr/lib/lazarus'  # Path to the Lazarus sources.
export FPCTARGET=''                   # Target operating system for cross compiling.
export FPCTARGETCPU='x86_64'          # Target CPU for cross compiling.

# Rust/Cargo
#source $HOME/.cargo/env
add-path $HOME/.cargo/bin

# Haskel
add-path $HOME/.cabal/bin

# Conditionally add common paths in /opt
# add-path /opt/IntelliJ/bin /opt/GoLand/bin /opt/PyCharm/bin /opt/terraform /opt/packer
echo "/opt paths are out, be mindful"

# Conda (mini)
add-path $HOME/.miniconda/bin

# LUA server (sumneko)
# add-path $PROJECTS/lua-language-server/bin/Linux

# LUA Formatter
add-path $HOME/.luarocks/bin

# This allows putting # to comment out the command
setopt interactivecomments
# For now
unset SSH_ASKPASS

# If keychain is installed , load the keys
if command -v keychain > /dev/null; then
	keychain -l | grep "no identities" 2>&1 > /dev/null
	if [[ $? = 0 && -d $HOME/.ssh ]]; then
		# Just load all paired keys
		for f in $HOME/.ssh/*; do
			if [[ -f $f\.pub ]]; then
				eval $(keychain -q --ssh-allow-gpg --eval $f)
			fi
		done
	fi
else
    echo " ***  Keychain is not installed, so keys are probably not loaded *** "
fi

# Awesome prompt (starship); only do this if not installed via the system packaging.
if ! command -v starship > /dev/null ; then
	echo "Install Starship"
	curl -fsSL https://starship.rs/install.sh | sudo sh
fi
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/.miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/.miniconda/etc/profile.d/conda.sh" ]; then
        . "$HOME/.miniconda/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/.miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# direnv
eval "$(direnv hook zsh)"

# mise
eval "$(mise hook-env -s zsh)"

# PROFILING
#zprof

# FZF stuff
source <(fzf --zsh)

bindkey \^U backward-kill-line
bindkey -s ^s "tmux choose-tree -Zs\n"

# Autorename tmux windows
add-zsh-hook chpwd update-tmux-pane
