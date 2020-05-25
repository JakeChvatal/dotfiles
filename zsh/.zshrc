# Enable powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# determines whether a command exists
cmd_exists () {
    type "$1" &> /dev/null;
}

# --- Path Configuration ---
if cmd_exists nvim; then
  export EDITOR='nvim'
else
  export EDITOR='vim' fi export NPM_CONFIG_PREFIX=~/.node_modules
fi

export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export MANPATH="/usr/local/man:$MANPATH"
export BROWSER=$(which google-chrome chromium-browser firefox links2 links lynx qutebrowser | grep -Pm1 '^/')
export RANGER_LOAD_DEFAULT_RC="FALSE" # only load zsh once

# TODO only add things to path if they exist?
typeset -U PATH path
path=(
    "/usr/local/bin"
    "$HOME/.bin"
    "$HOME/.local/bin"
    "$HOME/bin"
    "$HOME/.node_modules/bin"
    "$HOME/.cabal/bin"
    "$HOME/.ghcup/bin"
    "$path[@]"
)
export PATH
export JAVA_HOME=$JAVA_HOME:/usr/lib/jvm/java-8-openjdk/jre
export QT_AUTO_SCREEN_SCALE_FACTOR=1 # qutebrowser scaling

# --- SSH ---
zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities id_rsa # other ids ...

PROCFILE=$HOME/.proxy # add proxy
if test -f "$PROCFILE"; then
    source $PROCFILE
fi

# --- Antigen ---
export ANTIGEN="$HOME/.antigen.zsh"
if [ ! -f $ANTIGEN ]; then
    echo "Installing Antigen at $ANTIGEN..."
    curl -L git.io/antigen > $ANTIGEN
fi

source $ANTIGEN
antigen use oh-my-zsh
antigen theme romkatv/powerlevel10k
antigen bundles <<EOBUNDLES
colored-man-pages
magic-enter
ssh-agent
extract
vi-mode
tmux
git
z
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-completions
zsh-users/zsh-autosuggestions
zsh-users/zsh-history-substring-search
EOBUNDLES
antigen apply

autoload -Uz compinit # autocompletion
compinit

# --- History ---
HISTSIZE=10000
SAVEHIST=9000
HISTFILE=~/.zsh_history
HISTCONTROL=ignoredups:erasedups
MISTIGNORE="exit"
setopt inc_append_history # update history in all windows

# ZSH Settings
HYPHEN_INSENSITIVE="true" # _ and - correspond to same characters in autocomplete
DISABLE_AUTO_UPDATE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true" # faster repo status check
setopt INC_APPEND_HISTORY # add commands to history as they are entered
setopt AUTO_CD            # auto change directories
set editing-mode vi # vim-style editing

# --- Aliases ---
# always ensure that the right editor is used
alias vi=$EDITOR
alias vim=$EDITOR
alias nvim=$EDITOR
alias ec="emacs"
alias sudo="sudo " # fix sudo for some commands
alias spotify="/usr/bin/spotify --force-device-scale-factor = 2.5"
alias distro='cat /etc/*-release'
alias reload='source ~/.zshrc'

# system-independent package management aliases
# TODO handles these at install time with script?
function p_mgr() {
   if cmd_exists apt; then # prioritize apt over apt-get
    alias pi='sudo apt install'
    alias pp='sudo apt purge'
    alias pr='sudo apt remove'
    alias pu='sudo apt update'
    alias pug='sudo apt upgrade'
    alias puu='sudo apt update && sudo apt upgrade'
    alias par='sudo apt autoremove'
    alias ps='sudo apt search'
   elif cmd_exists apt-get; then
    alias pi='sudo apt-get install'
    alias pp='sudo apt-get purge'
    alias pr='sudo apt-get remove'
    alias pu='sudo apt-get update'
    alias pug='sudo apt-get upgrade'
    alias puu='sudo apt-get update && sudo apt upgrade'
    alias par='sudo apt-get autoremove'
    alias ps 'sudo apt-cache search'
  elif cmd_exists pacman; then
    alias pi='sudo pacman -S'
    alias pp='sudo pacman -R'
    alias pr='sudo pacman -Rscgn'
    alias pu='sudo pacman -u'
    alias pug='sudo pacman -yyu'
    alias puu='sudo pacman -Syyu'
    alias par='sudo pacman -Rc'
    alias ps='pacman -Q'
  else
    echo "Make sure to use a package manager compatible with pacman or apt-get."
  fi
}

p_mgr

# Ocaml support
if cmd_exists opam; then
    eval $(opam env)
fi

# startx if tty1, display and has x
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]] && cmd_exists startx; then
    exec startx
fi

# start prompt
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
