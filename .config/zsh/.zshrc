# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="${HOME}/.local/bin:/usr/local:/opt/homebrew/bin:${PATH}"
local pluginbase="${HOME}/.config/zsh/plugins"

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line
bindkey -M vicmd ' ' edit-command-line

#
# Aliases
#
alias c='clear'
alias e="${EDITOR}"
alias :q='exit'

function scripts() {
  cat package.json | jq '.scripts'
}

# Modern core utils
alias cat='bat'
# Because of the classic Debian way, the bat executable is named batcat on Debian-based distros
if ! command -v bat > /dev/null 2>&1; then
  alias cat="batcat"
fi
if command -v dog > /dev/null 2>&1; then
  alias dig='dog'
fi
if command -v fdfind > /dev/null 2>&1; then
  alias fd='fdfind'
fi

# ls
alias l='ls -lAh'
alias ll='ls -lh'

# tmux
alias tmux="tmux -f ${XDG_CONFIG_HOME}/tmux/tmux.conf"
alias tls='tmux ls'
alias tat='tmux attach -t'
alias tns='tmux new-session -s'

# go
alias gob='go build ./...'
alias got='go test ./...'
alias gots='go test -short ./...'

# kubectl
alias k='kubectl'
alias kc='kubectl ctx'

# git
alias g='git'
alias lg='lazygit'
alias prv="gh pr list | fzf | awk '{print \$1}' | xargs gh pr view"
function prc() {
  set -o pipefail
  if [ -z "$1" ]; then
    gh pr list | fzf | awk '{print $1}' | xargs gh pr checkout
  else
    gh pr checkout "$1"
  fi
}

function p() {
  if [[ -f bun.lockb ]]; then
    command bun "$@"
  elif [[ -f pnpm-lock.yaml ]]; then
    command pnpm "$@"
  elif [[ -f yarn.lock ]]; then
    command yarn "$@"
  elif [[ -f package-lock.json ]]; then
    command npm "$@"
  else
    command pnpm "$@"
  fi
}

# Configs
alias zshconf="${EDITOR} ${ZDOTDIR}/.zshrc"
alias tmuxconf="${EDITOR} ${XDG_CONFIG_HOME}/tmux/tmux.conf"
alias localconf="${EDITOR} ${HOME}/.zshrc.local"

# ansible
alias ansi='uv run ansible-playbook'

# History
HISTSIZE=50000
SAVEHIST=50000
HISTFILE="${ZDOTDIR}/.zsh_history"
HISTDUP=erase
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt share_history

# cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus # cd - produces a directory stack entry
setopt auto_cd # Move with .. or simple dir names

# Prompt
setopt prompt_subst

#
# Interactive mode additions
#
if [[ -o interactive ]]; then
  source $pluginbase/zsh-defer/zsh-defer.plugin.zsh
  zsh-defer source $pluginbase/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
  zsh-defer source $pluginbase/zsh-autosuggestions/zsh-autosuggestions.zsh
  zsh-defer source $pluginbase/fzf-tab/fzf-tab.plugin.zsh
  zsh-defer eval "$(zoxide init zsh)"
  source $pluginbase/powerlevel10k/powerlevel10k.zsh-theme
  # Completion
  autoload -Uz +X compinit
  compinit
fi

#
# Telemetry
#
export DISABLE_OPENCOLLECTIVE=1
export DO_NOT_TRACK=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
export NEXT_TELEMETRY_DISABLED=1

function brew() {
  [[ -z "$BREW_USER" ]] && BREW_USER="$(whoami)"
  if [[ "$(whoami)" == "$BREW_USER" ]]; then
    command brew "$@"
  else
    pushd /
    command sudo -Hu "$BREW_USER" brew "$@"
    popd
  fi
}

source <(fzf --zsh)

#
# Load additional per-machine config if it exists
#
if [ -e "${HOME}/.zshrc.local" ]; then
  source "${HOME}/.zshrc.local"
fi

[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
