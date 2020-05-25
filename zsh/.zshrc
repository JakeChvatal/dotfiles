# determines whether a command exists
command_exists () {
    type "$1" &> /dev/null;
}

# --- Path Configuration ---

if type "nvim" > /dev/null; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

export NPM_CONFIG_PREFIX=~/.node_modules
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export MANPATH="/usr/local/man:$MANPATH"
export BROWSER=$(which google-chrome chromium-browser firefox links2 links lynx | grep -Pm1 '^/')

typeset -U PATH path
path=(
    "/usr/local/bin"
    "$HOME/.bin"
    "$HOME/.local/bin"
    "$HOME/bin"
    "$HOME/.node_modules/bin"
    "$path[@]"
)
export PATH

export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
export JAVA_HOME=$JAVA_HOME:/usr/lib/jvm/java-8-openjdk/jre

# install antigen
export ANTIGEN="$HOME/.antigen.zsh"
if [ ! -f $ANTIGEN ]; then
    echo "Installing Antigen at $ANTIGEN..."
    curl -L git.io/antigen > $ANTIGEN
fi

source $ANTIGEN
antigen use oh-my-zsh
antigen theme geometry-zsh/geometry
antigen bundles <<EOBUNDLES
command-not-found
colored-man-pages
magic-enter
ssh-agent
extract
vi-mode
tmux
git
Tarrasch/zsh-autoenv
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-completions
zsh-users/zsh-autosuggestions
zsh-users/zsh-history-substring-search
EOBUNDLES

antigen apply

# --- HISTORY ---
HISTSIZE=10000
SAVEHIST=9000
HISTFILE=~/.zsh_history
HISTCONTROL=ignoredups:erasedups
MISTIGNORE="exit"
setopt inc_append_history # update history in all windows

autoload -Uz compinit # autocomplete
compinit

# ssh config
zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities id_rsa # other ids ...
# zstyle ':completion:*' menu select completer _complete _correct _approximate

HYPHEN_INSENSITIVE="true" # _ and - correspond to same characters in autocomplete
DISABLE_AUTO_UPDATE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true" # faster repo status check

# tmux TODO what is this magic?
# type tmux > /dev/null \
# && [[ -n $SSH_CONNECTION ]] \
# && [[ -z $TMUX ]] \
# && tmux new-session -A -s ssh && exit

# --- Settings ---
# setopt INC_APPEND_HISTORY # add commands to history as they are entered
# setopt AUTO_CD            # auto change directories
#
# set editing-mode vi # vim-style editing

# --- Aliases ---
# always ensure that the right editor is used
alias vi=$EDITOR
alias vim=$EDITOR
alias nvim=$EDITOR
alias ec="emacs"
alias sudo="sudo " # fix sudo for some commands
alias spotify="/usr/bin/spotify --force-device-scale-factor = 2.5"

# system-independent package management aliases
# TODO ensure these are all desired
# TODO build out to install/update script so check at compile time
if which apt-get &> /dev/null; then
  alias pi='sudo apt-get install'
  alias pp='sudo apt-get purge'
  alias pr='sudo apt-get remove'
  alias pu='sudo apt-get update'
  alias pug='sudo apt-get upgrade'
  alias puu='sudo apt-get update && sudo apt upgrade'
  alias par='sudo apt-get autoremove'
elif which pacman &> /dev/null; then
  alias pi='sudo pacman -S'
  alias pp='sudo pacman -R'
  alias pr='sudo pacman -Rscgn'
  alias pu='sudo pacman -u'
  alias pug='sudo pacman -yyu'
  alias puu='sudo pacman -Syyu'
  alias par='sudo pacman -Rc'
else
    echo "Make sure to use a package manager compatible with pacman or apt-get."
fi

alias td="todoist " # fast todoist

# Git aliases
if which git &> /dev/null; then
    alias gs='git status '
    alias ga='git add '
    alias gb='git branch '
    alias gc='git commit'
    alias gcm='git commit -m '
    alias gd='git diff'
    alias gco='git checkout '
    alias gcb='git checkout -b '
fi

# load opam if installed
if which opam &> /dev/null; then
    eval $(opam env)
fi

# configure f if installed
# TODO i do not really use this
if which thefuck &> /dev/null; then
    eval $(thefuck --alias)
fi

# Tmux specfic configuration TODO
# export TERM=xterm-256color
# [ -n "$TMUX" ] && export TERM=screen-256color

# add proxy if it exists
PROCFILE=$HOME/.proxy
if test -f "$PROCFILE"; then
    source $PROCFILE
fi

# startx if tty1 and a display is connected
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]] && startx 2> /dev/null; then
    exec startx
fi
