#!/usr/bin/env zsh
# Simple-style prompt (path in blue, git branch only in red, white input text, no % before 🌳)

: ${SIMPLE_SHOW_GIT:=true}

autoload -Uz colors
colors
setopt prompt_subst

# Optional git helpers you already have
if [[ -f "$HOME/GitHub/gansel51/dotfiles_matt/scripts/shell/git/functions.sh" ]]; then
  source "$HOME/GitHub/gansel51/dotfiles_matt/scripts/shell/git/functions.sh"
fi

# Get branch name only (no status symbols)
_git_branch_only() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null
}

precmd() {
  local gitseg=""
  if $SIMPLE_SHOW_GIT && git rev-parse --is-inside-work-tree &>/dev/null; then
    local b; b="$(_git_branch_only)"
    [[ -n "$b" ]] && gitseg=" %F{red}(${b})%f"
  fi

  # Path in blue, branch in red, tree at end, white input
  PROMPT="💻 %B%F{blue}%~%f%b${gitseg} 💻 %F{white}"
}

# Secondary prompt (multiline continuation) also white
PS2="%F{white}>%f "