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

export TERMINAL='termite'
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
PROCFILE=$HOME/.proxy # add proxy
if test -f "$PROCFILE"; then
    source $PROCFILE
fi

# --- Antigen ---
export ANTIGEN="$HOME/.antigen.zsh"
# ensure that the system is not WSL
if [ -z "$(uname -a | grep "Microsoft")" ]; then
    # if not wsl, install antigen
    if [ ! -f $ANTIGEN ]; then
        echo "Installing Antigen at $ANTIGEN..."
        curl -L git.io/antigen > $ANTIGEN
    fi

# TODO: add back packages that work with WSL,
# OR use a theme that works well with WSL
# (though this should probably be done at
# installation time, with different dotfiles)
source $ANTIGEN
antigen use oh-my-zsh
antigen theme romkatv/powerlevel10k
antigen bundles<<EOBUNDLES
colored-man-pages
magic-enter
extract
vi-mode
tmux
git
pyenv
lainiwa/zsh-manydots-magic
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-completions
zsh-users/zsh-autosuggestions
zsh-users/zsh-history-substring-search
jakechvatal/autoedit
EOBUNDLES
antigen apply
fi

# autoload -Uz compinit # autocompletion
# compinit -u

# --- History ---
HISTSIZE=10000
SAVEHIST=9000
HISTFILE=~/.zsh_history
HISTCONTROL=ignoredups:erasedups
MISTIGNORE="exit"

# ZSH Settings
HYPHEN_INSENSITIVE="true" # _ and - correspond to same characters in autocomplete
DISABLE_AUTO_UPDATE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true" # faster repo status check
setopt INC_APPEND_HISTORY # add commands to history as they are entered
setopt AUTO_CD            # auto change directories
setopt CORRECT            # correct commands
setopt MULTIOS            # pipe to multiple outputs
setopt NO_CLOBBER         # str doesn't clobber
setopt RC_EXPAND_PARAM    # expand arround vars
setopt NO_CASE_GLOB       # case insensitive glob
setopt NUMERIC_GLOB_SORT  # sort globs by #
setopt EXTENDED_GLOB      # glob for more!


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

# sane shell commands
alias mkdir='mkdir -p' # mkdir always makes recursive directories

alias -g ...='../..'
alias -g ....='../../..'
alias -g DN='/dev/null'

# --- Keybindings ---
# home, end for beginning and end of line
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

# incremental search is elite!
bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M vicmd "?" history-incremental-search-forward

# search based on what you typed in already
bindkey -M vicmd "//" history-beginning-search-backward
bindkey -M vicmd "??" history-beginning-search-forward

# --- Startup ---
# Ocaml support
if cmd_exists opam; then
    eval $(opam env)
fi

# add bspwm scripts to path if it exists
if cmd_exists bspwm; then
    export PATH=$PATH:"$HOME/.config/bspwm/scripts"
fi

# startx if tty1, display and has x
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec startx
fi

# start prompt
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/jake/.zshrc'

autoload -Uz compinit
compinit
