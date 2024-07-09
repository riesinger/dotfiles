export PATH="${HOME}/.local/bin:/usr/local:/opt/homebrew/bin:${PATH}"
local pluginbase="${HOME}/.config/zsh/plugins"

#
# Aliases
#
alias c='clear'
alias e="${EDITOR}"
alias :q='exit'

# Modern core utils
alias cat='bat'
# Because of the classic Debian way, the bat executable is named batcat on Debian-based distros
if ! command -v bat > /dev/null 2>&1; then
  alias cat="batcat"
fi
alias ls='exa'
alias dig='dog'
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

# git
alias g='git'

# Configs
alias zshconf="${EDITOR} ${ZDOTDIR}/.zshrc"
alias tmuxconf="${EDITOR} ${XDG_CONFIG_HOME}/tmux/tmux.conf"
alias localconf="${EDITOR} ${HOME}/.zshrc.local"

# ansible
alias ansi='ansible-playbook'

#
# ZSH Options
#
# Completion
autoload -Uz +X compinit
for dump in ~/${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump(N.mh+24); do
  compinit
done
compinit -C
# History
HISTSIZE=10000
SAVEHIST=10000
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
  source $pluginbase/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
  source $pluginbase/zsh-autosuggestions/zsh-autosuggestions.zsh
  eval "$(zoxide init zsh)"
  eval "$(starship init zsh)"
  eval "$(fzf --zsh)"
  if which fnm > /dev/null 2>&1; then
    eval "$(fnm env --use-on-cd)"
  fi
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

#
# Telemetry
#
export ADBLOCK=1
export AZURE_CORE_COLLECT_TELEMETRY=0
export DISABLE_OPENCOLLECTIVE=1
export DO_NOT_TRACK=1
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export ET_NO_TELEMETRY=0
export GATSBY_TELEMETRY_DISABLED=1
export HOMEBREW_NO_ANALYTICS=1
export NEXT_TELEMETRY_DISABLED=1
export OPEN_SOURCE_CONTRIBUTOR=1
export RIFF_DISABLE_TELEMETRY=1
export SAM_CLI_TELEMETRY=0

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

#
# Load additional per-machine config if it exists
#
if [ -e "${HOME}/.zshrc.local" ]; then
  source "${HOME}/.zshrc.local"
fi
