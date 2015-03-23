# get the name of the branch we are on
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}$(parse_git_dirty)"
}

# Checks if working tree is dirty
parse_git_dirty() {
  if [[ -n $(git status -s --ignore-submodules=dirty 2>/dev/null) ]]; then
    echo "*"
  else
    echo ""
  fi
}

_prompt_precmd () {
  RPROMPT="%{$fg_bold[red]%}$(git_prompt_info) %{$reset_color%}${STATIC_RPROMPT}"
}

_prompt_setup () {
  setopt prompt_subst localoptions

  # Setup helpers for color
  autoload colors zsh/terminfo

  colors

  local c_wd="%{$fg_bold[blue]%}"
  local c_prompt="%{%(!.$fg_bold[red].$fg_bold[green])%}"
  local c_rprompt="%{$fg_bold[grey]%}"
  local c_hilight="%{$fg_bold[yellow]%}"
  local c_host="%{$fg_bold[magenta]%}"
  local c_reset="%{$reset_color%}"

  [ -n "${SSH_CONNECTION}" ] && local p_host="%m "
  local p_cwd="%25<...<%~%<<"
  local p_exit_code="%(?.%?.${c_hilight}%?)"

  local p_glue=$'%{\e[G%}'

  PS1="${p_glue}${c_host}${p_host}${c_wd}${p_cwd} ${c_prompt}%(!.#.$)${c_reset} "
  PS2="${p_glue}${c_prompt}>> ${c_wd}%_ ${c_prompt}:${c_reset} "
  STATIC_RPROMPT="${c_rprompt}(${p_exit_code}${c_rprompt})$c_reset"

  add-zsh-hook precmd _prompt_precmd
}

_prompt_setup

# Coloured manpages
export LESS_TERMCAP_mb=$'\e[01;33m'    # blink?
export LESS_TERMCAP_md=$'\e[01;33m'    # standout (headings)
export LESS_TERMCAP_us=$'\e[01;31m'    # keywords
export LESS_TERMCAP_so=$'\e[01;44;33m' # status line
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'
