# Enable powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# determines whether a command exists
cmd_exists () {
    type "$1" &> /dev/null;
}

# --- Path Configuration ---
# use the best editor currently available
if cmd_exists nvim; then
    export EDITOR='nvim' # yes
elif cmd_exists vim; then
    export EDITOR='vim'  # perhaps
else
    export EDITOR='vi'   # oh god
fi

export TERMINAL='termite'
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export MANPATH="/usr/local/man:$MANPATH"
export BROWSER=$(which google-chrome chromium-browser firefox links2 links lynx qutebrowser | grep -Pm1 '^/')
export RANGER_LOAD_DEFAULT_RC="FALSE" # only load zsh once

# TODO only add things to path if they exist
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

# --- Antigen ---
export ANTIGEN="$HOME/.antigen.zsh"
# ensure that the system is not WSL
if [ -z "$(uname -a | grep "Microsoft")" ]; then
    # if not wsl, install antigen
    if [ ! -f $ANTIGEN ]; then
        echo "Installing Antigen at $ANTIGEN..."
        curl -L git.io/antigen > $ANTIGEN
    fi

# TODO: better WSL compatibility
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
jakechvatal/p
EOBUNDLES
antigen apply
fi

# --- History ---
HISTSIZE=10000 # long history
SAVEHIST=9000
HISTFILE=~/.zsh_history
HISTCONTROL=ignoredups:erasedups # no duplicates in history
MISTIGNORE="exit"

# ZSH Settings
HYPHEN_INSENSITIVE="true"            # _ and - are the same for autocomplete
DISABLE_AUTO_UPDATE="true"           # disable omzsh auto update
DISABLE_UNTRACKED_FILES_DIRTY="true" # faster repo status check
setopt INC_APPEND_HISTORY            # add commands to history as they are entered
setopt AUTO_CD                       # auto change directories
setopt CORRECT                       # correct commands
setopt MULTIOS                       # pipe to multiple outputs
setopt NO_CLOBBER                    # str doesn't clobber
setopt RC_EXPAND_PARAM               # expand arround vars
setopt NO_CASE_GLOB                  # case insensitive glob
setopt NUMERIC_GLOB_SORT             # sort globs by #
setopt EXTENDED_GLOB                 # glob for more!

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
alias mkdir='mkdir -p'  # mkdir always makes recursive directories
alias -g DN='/dev/null' # easier

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
cmd_exists opam && # ocaml support
    eval $(opam env)

cmd_exists npm && # redirect node_modules
    export NPM_CONFIG_PREFIX=~/.node_modules

cmd_exists bspwm && # bspwm-specific scripts
    export PATH=$PATH:"$HOME/.config/bspwm/scripts"

test -f "$HOME/.proxy" && # add proxy config if it exists
    source $HOME/.proxy

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
