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
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-completions
zsh-users/zsh-autosuggestions
zsh-users/zsh-history-substring-search
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
# alias mv='

alias -g ...='../..'
alias -g ....='../../..'
alias -g DN='/dev/null'

# system-independent package management aliases
# TODO handle these at install time with script?
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
    alias pr='sudo pacman -Rscn'
    alias pu='sudo pacman -u'
    alias pug='sudo pacman -yyu'
    alias puu='sudo pacman -Syyu'
    alias par='sudo pacman -Rc'
    alias ps='pacman -Q'
  else
    echo "Make sure that either the pacman, apt or apt-get package manager is installed."
  fi
}

p_mgr

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


# VIM PLUGIN - auto edit file
auto_edit() {
    cmdstr=${BUFFER//[$'\t\r\n']}
    extension="${cmdstr##*.}" 
    edit_ext=(
        js 
        jsx 
        py 
        txt
        org 
        md 
        yml 
        yaml
        toml 
        json
    )

    edit_files=(
        Dockerfile 
        # .gitignore TODO allow for editing dotfiles
        # .zshrc
    )
     
    if [[ ! $cmdstr =~ ( |\') ]]; then
        if [ -z ${cmdstr##*.*} ]; then
            if [[ ! "$(($edit_ext[(Ie)$extension]))" == 0 ]];  then
                # if the file name has a text editing extension, 
                # use the default editor to edit the file
                BUFFER="$EDITOR $cmdstr"
            elif [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then 
                # if the file type isn't supported and GUI is available,
                # touch it and open it with X
                BUFFER="touch $cmdstr && xdg-open $cmdstr"
            fi
        elif [[ ! "$(($edit_files[(Ie)$cmdstr]))" == 0 ]]; then
            # if the full name of the file matches, edit it
            # TODO match only the last . or / (support full paths)
            BUFFER="$EDITOR $cmdstr"
        fi
    fi

    zle .accept-line
}

zle -N accept-line auto_edit

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
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/jake/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
