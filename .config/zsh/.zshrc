export PATH="${HOME}/.local/bin:${PATH}"
local pluginbase="${HOME}/.config/zsh/plugins"

#
# Aliases
#
alias c='clear'
alias e="${EDITOR}"
alias :q='exit'
# Because of the classic Debian way, the bat executable is named batcat on Debian-based distros
if [[ "$(uname -v)" =~ "Debian" ]]; then
  alias cat="batcat"
elif [[ "$(uname -v)" =~ "PMX"]]; then
  #                        ^ This is Proxmox
  alias cat="batcat"
else
  alias cat='bat'
fi
alias ls='exa'

# ls
alias l='ls -lAh'
alias ll='ls -lh'

# tmux
alias tmux="tmux -f ${XDG_CONFIG_HOME}/tmux/tmux.conf"
alias tls='tmux ls'
alias tat='tmux attach -t'
alias tns='tmux new-session -s'

# go
alias got='go test ./...'
alias gots='go test -short ./...'

# kubectl
alias k='kubectl'

# git
alias g='git'

#
# ZSH Options
#
# Completion
autoload -U +X compinit && compinit -u
# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="${ZDOTDIR}/.zsh_history"
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

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

#
# Load additional per-machine config if it exists
#
if [ -e "${HOME}/.zshrc.local" ]; then
  source "${HOME}/.zshrc.local"
fi
