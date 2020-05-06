autoload -Uz compinit
compinit

# TODO: remove oh-my-zsh from configuration. write my own!
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true" # _ and - correspond to same characters in autocomplete
DISABLE_AUTO_UPDATE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true" # faster repo status check
plugins=(git)
source $ZSH/oh-my-zsh.sh

# --- Settings ---
setopt INC_APPEND_HISTORY # add commands to history as they are entered
setopt AUTO_CD            # auto change directories

# --- Aliases ---
alias vi="nvim"
alias vim="nvim" # always use nvim
alias ec="emacs"
alias sudo="sudo " # fix sudo for some commands
alias spotify="/usr/bin/spotify --force-device-scale-factor = 2.5"
alias td="todoist " # fast todoist

# Git aliases
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gco='git checkout '

# --- Path ---
export npm_config_prefix=~/.node_modules
export EDITOR='nvim'
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export MANPATH="/usr/local/man:$MANPATH"

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:~/.bin
export PATH="$HOME/.node_modules/bin:$PATH"
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/home/jake/.gem/ruby/2.6.0/bin
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
export JAVA_HOME=$JAVA_HOME:/usr/lib/jvm/java-8-openjdk/jre

# load opam if installed
if opam --version 1> /dev/null; then
    eval $(opam env)
fi

# configure f if installed
if thefuck 2>/dev/null; then
    eval $(thefuck --alias)
fi

# startx if tty1 and a display is connected
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec startx
fi
