# Config file for Powerlevel10k with the style of robbyrussell theme from Oh My Zsh.
#
# Original: https://github.com/ohmyzsh/ohmyzsh/wiki/Themes#robbyrussell.
#
# Replication of robbyrussell theme is exact. The only observable difference is in
# performance. Powerlevel10k prompt is very fast everywhere, even in large Git repositories.
#
# Usage: Source this file either before or after loading Powerlevel10k.
#
#   source ~/powerlevel10k/config/p10k-robbyrussell.zsh
#   source ~/powerlevel10k/powerlevel10k.zsh-theme

# Temporarily change options.
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh

  # Unset all configuration options.
  unset -m 'POWERLEVEL9K_*|DEFAULT_USER'

  # Zsh >= 5.1 is required.
  autoload -Uz is-at-least && is-at-least 5.1 || return

  # Left prompt segments.
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(prompt_char dir vcs)
  # Right prompt segments.
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

  # Basic style options that define the overall prompt look.
  typeset -g POWERLEVEL9K_BACKGROUND=                            # transparent background
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=  # no surrounding whitespace
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '  # separate segments with a space
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=        # no end-of-line symbol
  typeset -g POWERLEVEL9K_VISUAL_IDENTIFIER_EXPANSION=           # no segment icons

  # Green prompt symbol if the last command succeeded.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS}_FOREGROUND=green
  # Red prompt symbol if the last command failed.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS}_FOREGROUND=red
  # Prompt symbol: bold arrow.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_CONTENT_EXPANSION='%B➜ '

  # Cyan current directory.
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=cyan
  # Show only the last segment of the current directory.
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last
  # Bold directory.
  typeset -g POWERLEVEL9K_DIR_CONTENT_EXPANSION='%B$P9K_CONTENT'

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


  # changes prompt name if ssh'd into system
  function my_ssh_formatter() {
    emulate -L zsh
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        typeset -g "[$(hostname)] "
    fi
  }
  functions -M my_git_formatter 2>/dev/null
  functions -M my_ssh_formatter 2>/dev/null

  # Disable the default Git status formatting.
  typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
  # Install our own Git status formatter.
  typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${$((my_git_formatter(1)))+${my_git_format}}'
  typeset -g POWERLEVEL9K_VCS_LOADING_CONTENT_EXPANSION='${$((my_git_formatter()))+${my_git_format}}'
  # Grey Git status when loading.
  typeset -g POWERLEVEL9K_VCS_LOADING_FOREGROUND=246

  # instant prompt
  # TODO change to quiet once i am sure config works
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose

  # If p10k is already loaded, reload configuration.
  # This works even with POWERLEVEL9K_DISABLE_HOT_RELOAD=true.
  (( ! $+functions[p10k] )) || p10k reload
}

# Tell `p10k configure` which file it should overwrite.
typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
