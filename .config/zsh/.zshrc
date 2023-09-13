# This is my ZSH config

#
# Variables and exports
#

export TERM=xterm-256color
local pluginbase=$ZDOTDIR/plugins

export HISTSIZE=2500 # How many entries to load into memory
export SAVEHIST=5000 # How many entries to keep
setopt INC_APPEND_HISTORY # Immediately append to history file instead of on exit
[ ! -d ${XDG_DATA_HOME:-$HOME/.local/share}/zsh ] && mkdir -p ${XDG_DATA_HOME:-$HOME/.local/share}/zsh
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS


command rg > /dev/null 2>&1 && export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/"'

# GPG-Agent setup
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye > /dev/null
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

#
# Aliases
#

# General
alias c="clear"
alias e="$EDITOR"
alias :q="exit"
alias cat='bat'

# ls
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

# Tmux
alias tmux="tmux -f ${XDG_CONFIG_HOME}/tmux/tmux.conf"
alias tls="tmux ls"
alias tat="tmux attach -t"
alias tns="tmux new-session -s"

#
# ZSH options
#

setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus # cd - produces a directory stack entry
setopt auto_cd # Move with .. or simple dir names

local zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION"
[ -f "$zcompdump" ] || mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
autoload -Uz compinit
compinit -d "$zcompdump"
autoload bashcompinit
bashcompinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' group-name ''
command dircolors > /dev/null 2>&1 && zstyle ':completion:*' menu select=2 eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search


#
# Plugins
#
source $pluginbase/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $pluginbase/zsh-autosuggestions/zsh-autosuggestions.zsh

#
# Functions
#
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
function exportEnvFile { export $(egrep -v '^#' .env | xargs) }

# Prompt
setopt prompt_subst
eval "$(starship init zsh)"

# Initialize FNM if it's installed
command -v fnm > /dev/null 2>&1 && eval "$(fnm env --use-on-cd)" || :

# Import per-machine config files
[ -f "${HOME}/.profile.local" ] && source "${HOME}/.profile.local" || :
[ -f "${HOME}/.zshrc" ] && source "${HOME}/.zshrc" || :
