#
# Variables and exports
#

local pluginbase="${ZDOTDIR}/plugins"

HISTSIZE=3000
SAVEHIST=3000
HISTFILE="${XDG_DATA_HOME}/zsh/history"
export TERM=xterm-256color

has_executable 'rg' && export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/"'

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

setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus # cd - produces a directory stack entry
setopt auto_cd # Move with .. or simple dir names

local zcompdump="${XDG_CACHE_HOME}/zsh/zcompdump-$ZSH_VERSION"
[ -f "$zcompdump" ] || mkdir -p "$XDG_CACHE_HOME/zsh"
autoload -Uz compinit && compinit -d "$zcompdump"

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' group-name ''
has_executable 'dircolors' && zstyle ':completion:*' menu select=2 eval "$(dircolors -b)"
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
# Functions
#

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
function exportEnvFile { export $(egrep -v '^#' .env | xargs) }

# 
# GPG-Agent setup
#

export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye > /dev/null
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

#
# Plugins
#

source $pluginbase/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $pluginbase/zsh-autosuggestions/zsh-autosuggestions.zsh

#
# Other programs
#
type 'fasd' > /dev/null 2>&1 && eval "$(fasd --init zsh)" # Initialize fasd if it is installed
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # initialize fzf keybindings, if they are installed

#
# Prompt
#
setopt prompt_subst
eval "$(starship init zsh)"

# Work stuff
[ -f "${HOME}/.profile.local" ] && source "${HOME}/.profile.local" || :
