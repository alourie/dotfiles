# vim: filetype=zsh
#
# PROFILING: uncomment the next line and the `zprof` line at the bottom
# zmodload zsh/zprof

# ---------------------------------------------------------------------------
# Basics
# ---------------------------------------------------------------------------
ZSHRC="${HOME}/.zshrc"
export PROJECTS="$HOME/Projects"
export LANG=en_US.UTF-8     # LC_ALL intentionally not set; put locale in ~/.config/locale.conf

# Editor
export NVIM_APPNAME=nvim-fixed
export EDITOR=nvim
if [ -f "$PROJECTS/zsh_functions/mvim" ]; then
    export EDITOR="$PROJECTS/zsh_functions/mvim"   # must be executable + have a shebang
fi
export VISUAL="$EDITOR"

# Coloured man pages (replaces OMZP::colored-man-pages)
export MANPAGER="less -R --use-color -Dd+r -Du+b"

setopt interactivecomments   # allow "# comment" on the command line
unsetopt flow_control        # free up Ctrl-S / Ctrl-Q - these will freeze (Ctrl-S) and unfreeze (Ctrl-Q) the terminal output, so not using them.

# Make PATH/FPATH unique
# These are just like variables
typeset -U path
typeset -U fpath

# ---------------------------------------------------------------------------
# History (replaces OMZL::history.zsh)
# ---------------------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history hist_ignore_dups hist_ignore_space hist_verify share_history hist_expire_dups_first

# ---------------------------------------------------------------------------
# Aliases
# ---------------------------------------------------------------------------
alias ls="ls --color"
alias ll="ls -lh"
alias rl="source ~/.zshrc"
alias ee="$EDITOR ${ZSHRC}"
alias gp="cd $PROJECTS"
alias t=todo.sh
alias vim=$EDITOR
alias picsort="$PROJECTS/merge_pics/merge_go/picsort"
alias showbig='du -sh -- * .[!.]* 2>/dev/null | sort -rh | head -20'
alias showst='lsblk -e7,11'
alias cls="clear"
alias nn='paplay /usr/share/sounds/freedesktop/stereo/complete.oga && notify-send "all done" -t 3000'
alias nne='notify-send -u critical -a "shell" "error!" -t 3000'
alias config='git --git-dir=$HOME/.dots/ --work-tree=$HOME'
alias yget="yt-dlp --cookies-from-browser firefox "
alias gcl="git restore .idea"
alias gst="git stu"
alias gf="gix fetch"
alias gr="git rebase"
alias pp="termpdf.py"
alias qp='qpdf --empty --pages'
alias k=kubectl
alias run='podman run --rm'
alias ginit="gset git"
alias xo=xdg-open
alias free="free -mt"
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias ddd='date +"%B %d, %Y" | wl-copy -n'   # single quotes: evaluated on use, not at shell start

# fix obvious typos
alias cd..='cd ..'

# Arch package management
alias update='sudo pacman -Syu'
# alias up='paru -Syu'
# for _t in udpate upate updte updqte; do alias $_t='sudo pacman -Syu'; done
# for _t in upall upal upqll pksyua;   do alias $_t='paru -Syu';        done
# unset _t

alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias update-fc='sudo fc-cache -fv'
alias hw="hwinfo --short"
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'
alias mirror="sudo reflector --age 6 --latest 20 --fastest 20 --threads 5 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"

# ---------------------------------------------------------------------------
# Functions
# ---------------------------------------------------------------------------
git_restore() {
  git restore --staged "$@"
  git restore "$@"
}

restore_config() {
  config restore --staged "$@"
  config restore "$@"
}

cleanup_pkgs() {   # remove orphaned packages
  local -a orphans=( ${(f)"$(pacman -Qtdq)"} )
  if (( $#orphans )); then
    sudo pacman -Rns -- $orphans
  else
    echo "no orphans"
  fi
}

ex() {
  [[ -f $1 ]] || { echo "'$1' is not a valid file"; return 1 }
  case $1 in
    *.tar|*.tar.*|*.tgz|*.tbz2) tar xf "$1" ;;
    *.bz2)  bunzip2 "$1" ;;
    *.rar)  unrar x "$1" ;;
    *.gz)   gunzip "$1" ;;
    *.zip)  unzip "$1" ;;
    *.Z)    uncompress "$1" ;;
    *.7z)   7z x "$1" ;;
    *.deb)  ar x "$1" ;;
    *)      echo "'$1' cannot be extracted via ex()"; return 1 ;;
  esac
}

# ---------------------------------------------------------------------------
# Dotfiles bootstrap (bare repo)
# ---------------------------------------------------------------------------
export DOTS="$HOME/.dots"
if [[ ! -d "$DOTS" ]]; then
  echo "dots are not on the system, so this is the first time..."
  (( $+commands[git] )) || sudo pacman -S --needed git
  git clone --bare https://github.com/alourie/dotfiles "$DOTS"
  config config --local status.showUntrackedFiles no
  config checkout || echo "config checkout hit conflicts: move the listed files aside and re-run 'config checkout'"
  echo "Now that dots are here, run install-base to bring all the things"
  exit 0
fi

# ---------------------------------------------------------------------------
# Custom functions
# ---------------------------------------------------------------------------
fpath+=($PROJECTS/zsh_functions)
autoload -Uz $PROJECTS/zsh_functions/*(N.:t)
autoload -Uz add-zsh-hook

# Install the base (also the place for: pacman -S starship fzf zoxide pkgfile ...)
# if [[ $FIRST_INSTALL == 1 ]]; then
#   install-base
#   restore_config .gitconfig .config/starship
# fi


# ---------------------------------------------------------------------------
# Completion (replaces OMZL::completion.zsh)
# ---------------------------------------------------------------------------
autoload -Uz compinit
_zcd=(~/.zcompdump(N.mh+24))            # non-empty if the dump is older than 24h
if [[ -f ~/.zcompdump ]] && (( ! $#_zcd )); then
  compinit -C                            # fresh dump: skip the security scan
else
  compinit
fi
unset _zcd
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.cache/zsh/zcompcache

# command-not-found via pkgfile (needs: pacman -S pkgfile && sudo pkgfile -u)
[[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh

# ---------------------------------------------------------------------------
# Key bindings (replaces OMZL::key-bindings.zsh)
# ---------------------------------------------------------------------------
bindkey -e
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search edit-command-line
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N edit-command-line

# Up/Down: history search by what is already typed (both normal and application cursor mode)
for _s in '^[[A' '^[OA'; do bindkey "$_s" up-line-or-beginning-search;   done
for _s in '^[[B' '^[OB'; do bindkey "$_s" down-line-or-beginning-search; done
for _s in '^[[H' '^[OH'; do bindkey "$_s" beginning-of-line; done
for _s in '^[[F' '^[OF'; do bindkey "$_s" end-of-line;       done
unset _s
bindkey '^[[3~'   delete-char
bindkey '^[[Z'    reverse-menu-complete
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^X^E'    edit-command-line
bindkey ' '       magic-space
# bindkey '^U'      backward-kill-line
# bindkey -s '^s'   'tmux choose-tree -Zs\n'

# ---------------------------------------------------------------------------
# Terminal
# ---------------------------------------------------------------------------
# Note: the kitty branch wins inside tmux started from kitty (KITTY_WINDOW_ID is inherited).
# Ideal end state: set default-terminal in tmux.conf and drop this block.
# if [[ -n $KITTY_WINDOW_ID ]]; then
#   export TERM="xterm-kitty"
# elif [[ -n $BYOBU_BACKEND ]]; then
#   export TERM="tmux-256color"
# fi

# ---------------------------------------------------------------------------
# PATH and language toolchains
# ---------------------------------------------------------------------------
path=($PROJECTS/scripts $HOME/.local/bin $path)

# Java (Arch's archlinux-java symlink)
if [[ -d /usr/lib/jvm/default ]]; then
  export JAVA_HOME=/usr/lib/jvm/default
  export IDEA_JDK=/usr/lib/jvm/jre-jetbrains/
fi

# Golang
add-path /usr/local/go/bin
if (( $+commands[go] )); then
  export GOPATH="${PROJECTS}/gospace"
  export GOSRC="${GOPATH}/src"
  path+=(${GOPATH}/bin)
  alias gtest="${GOPATH}/bin/gotest"
fi

# Pascal (language server)
if [[ -x /usr/lib/fpc/3.2.2/ppcx64 ]]; then
  export PP=/usr/lib/fpc/3.2.2/ppcx64
  export FPCTARGETCPU=x86_64
fi

# Rust/Cargo, Haskell, Conda (mini), Lua
add-path $HOME/.cargo/bin
add-path $HOME/.cabal/bin
add-path $HOME/.miniconda/bin
add-path $HOME/.luarocks/bin

# ---------------------------------------------------------------------------
# SSH / GPG agent
# ---------------------------------------------------------------------------
unset SSH_ASKPASS
unset SSH_AGENT_PID
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:-/run/user/$UID}/gnupg/S.gpg-agent.ssh"

# ---------------------------------------------------------------------------
# Prompt and tool hooks
# ---------------------------------------------------------------------------
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
(( $+commands[starship] )) && eval "$(starship init zsh)"

# This is needed to parse .envrc
eval "$(direnv hook zsh)"

# fzf: Ctrl-R history, Ctrl-T files, Alt-C cd, ** completion
(( $+commands[fzf] )) && source <(fzf --zsh)

# zoxide: `z` (replaces zsh-z), `zi` for interactive pick.
# One-off import of the old zsh-z database:  zoxide import --from z ~/.z
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

# Autorename tmux windows
add-zsh-hook chpwd update-tmux-pane

# Machine-local / private stuff (work address alias etc.)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# PROFILING
# zprof
