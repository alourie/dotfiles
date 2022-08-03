# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

if [ ! -d $ZSH ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi



# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fzf z)

source $ZSH/oh-my-zsh.sh

# DEFS
TERM=xterm
ZSHRC="${HOME}/.zshrc"

# PROJECTS
export PROJECTS="$HOME/Projects"

# Basic aliases
alias rl="source ${ZSHRC}"
alias ee="lvim ${ZSHRC}"
alias gp="cd $PROJECTS"
alias t=todo.sh
alias vim='lvim'
alias ssh="ssh -A "
alias picsort="$PROJECTS/merge_pics/merge_go/picsort"
alias showbig="du -sh * | grep -e '\dG'"
alias showst="lsblk | ack -v \"loop|ram|rom\""
alias cls="clear"
alias nn="notify-send \"all done\" -t 3000"
alias config='git --git-dir=$HOME/.dots/ --work-tree=$HOME'
alias gcl="git restore .idea"
alias gst="git stu"
alias vact="source venv/bin/activate"

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

alias pp="ping 1.1.1.1"

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
  git clone --bare http://gitlab.com/alourie/dotfiles "${DOTS}"

  # Restore function path from config
  restore_config Projects/zsh_functions

  # Flag the first install
  FIRST_INSTALL=1
fi

# Custom functions
fpath+=($PROJECTS/zsh_functions)
autoload -Uz c
autoload -Uz edv
autoload -Uz set-tokens
autoload -Uz add-path
autoload -Uz ginit

# Install the base
if [ "${FIRST_INSTALL}" = 1 ]; then
    echo "First install, setting up the basic stuff"
    autoload -Uz install-base
    install-base

    # "Restore" basic configs
    restore_config .gitconfig .config/starship 
fi

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
if command -v java > /dev/null; then
    JAVA=$(which java)
	export JAVA_HOME=$(dirname $(dirname $(readlink -f $JAVA)))
fi

# Golang
# If golang is found on  the system, set it up
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

# If keychain is installed and .ssh exists, load the keys
eval `ssh-agent -s` > /dev/null 
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

# Awesome prompt (starship); only do this if not installed via the system packaging.
if ! command -v starship > /dev/null ; then
	echo "Install Starship"
	curl -fsSL https://starship.rs/install.sh | bash
fi
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/alourie/.miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/alourie/.miniconda/etc/profile.d/conda.sh" ]; then
        . "/home/alourie/.miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/home/alourie/.miniconda/bin:$PATH"
    fi
fi
unset __conda_setup

export EDITOR=lvim
