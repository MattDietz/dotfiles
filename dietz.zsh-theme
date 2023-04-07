function git_prompt_info_custom() {
  if ! __git_prompt_git rev-parse --git-dir &> /dev/null \
     || [[ "$(__git_prompt_git config --get oh-my-zsh.hide-info 2>/dev/null)" == 1 ]]; then
    return 0
  fi

  local ref
  ref=$(__git_prompt_git symbolic-ref --short HEAD 2> /dev/null) \
  || ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) \
  || return 0

  # Use global ZSH_THEME_GIT_SHOW_UPSTREAM=1 for including upstream remote info
  local upstream
  if (( ${+ZSH_THEME_GIT_SHOW_UPSTREAM} )); then
    upstream=$(__git_prompt_git rev-parse --abbrev-ref --symbolic-full-name "@{upstream}" 2>/dev/null) \
    && upstream=" -> ${upstream}"
  fi

  echo "${ZSH_THEME_GIT_PROMPT_PREFIX}$(parse_git_dirty)${ref}${upstream}%{$reset_color%}${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}

PROMPT='%{$fg_bold[green]%} %{$fg[cyan]%}%c%{$fg_bold[blue]%}$(git_prompt_info_custom)%{$fg_bold[blue]%} %(!.#.») %{$reset_color%}'

typeset +H my_orange="$FG[214]"

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075]($FG[078]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$my_orange"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"
