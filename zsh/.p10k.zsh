# Config file for Powerlevel10k with the style of robbyrussell theme from Oh My Zsh.
# Temporarily change options.
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh

  unset -m 'POWERLEVEL9K_*|DEFAULT_USER'                # Unset all configuration options.
  autoload -Uz is-at-least && is-at-least 5.1 || return # Zsh >= 5.1 is required.

  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(prompt_char dir vcs) # Left prompt segments.
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()                   # Right prompt segments.

  # Basic style options that define the overall prompt look.
  typeset -g POWERLEVEL9K_BACKGROUND=                            # transparent background
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=  # no surrounding whitespace
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '  # separate segments with a space
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=        # no end-of-line symbol
  typeset -g POWERLEVEL9K_VISUAL_IDENTIFIER_EXPANSION=           # no segment icons

  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS}_FOREGROUND=green  # success prompt
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS}_FOREGROUND=red # failure prompt
  typeset -g POWERLEVEL9K_PROMPT_CHAR_CONTENT_EXPANSION='%B➜ '   # Prompt symbol: bold arrow.

  typeset -g POWERLEVEL9K_DIR_FOREGROUND=cyan                    # Cyan current directory.
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last      # Show only the last segment of the current directory.
  typeset -g POWERLEVEL9K_DIR_CONTENT_EXPANSION='%B$P9K_CONTENT' # Bold directory.

  # Git status formatter.
  function my_git_formatter() {
    emulate -L zsh
    if [[ -n $P9K_CONTENT ]]; then
      # If P9K_CONTENT is not empty, it's either "loading" or from vcs_info (not from
      # gitstatus plugin). VCS_STATUS_* parameters are not available in this case.
      typeset -g my_git_format=$P9K_CONTENT
    else
      # Use VCS_STATUS_* parameters to assemble Git status. See reference:
      # https://github.com/romkatv/gitstatus/blob/master/gitstatus.plugin.zsh.
      typeset -g my_git_format="${1+%B%4F}git:(${1+%1F}"
      my_git_format+=${${VCS_STATUS_LOCAL_BRANCH:-${VCS_STATUS_COMMIT[1,8]}}//\%/%%}
      my_git_format+="${1+%4F})"
      if (( VCS_STATUS_NUM_CONFLICTED || VCS_STATUS_NUM_STAGED ||
            VCS_STATUS_NUM_UNSTAGED   || VCS_STATUS_NUM_UNTRACKED )); then
        my_git_format+=" ${1+%3F}✗"
      fi
    fi
  }

  # SSH Status formatter
  function my_ssh_formatter() {
    emulate -L zsh
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        primary="9"
        accent="146"
        typeset -g "%F{$accent3}[$(hostname)]%f "


    fi
  }

  functions -M my_git_formatter 2>/dev/null
  functions -M my_ssh_formatter 2>/dev/null

  typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
  typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${$((my_git_formatter(1)))+${my_git_format}}'
  typeset -g POWERLEVEL9K_VCS_LOADING_CONTENT_EXPANSION='${$((my_git_formatter()))+${my_git_format}}'
  typeset -g POWERLEVEL9K_VCS_LOADING_FOREGROUND=246

  typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet # no debug output

  # If p10k is already loaded, reload configuration.
  # This works even with POWERLEVEL9K_DISABLE_HOT_RELOAD=true.
  (( ! $+functions[p10k] )) || p10k reload
}

# Tell `p10k configure` which file it should overwrite.
typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
