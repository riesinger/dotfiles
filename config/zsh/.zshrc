# This is my ZSH config

#
# Variables and exports
#

# If the profile hasn't been sourced yet, do it. For some reason, this happens in TMUX sessions
[ -z "$DOTFILES" ] && source $HOME/.profile

export TERM=xterm-256color
export PATH="/usr/local/lib/cocktail:$PATH"
local pluginbase=$DOTFILES/zsh-plugins

HISTSIZE=3000
SAVEHIST=3000
HISTFILE="$XDG_DATA_HOME/zsh/history"

has_executable 'rg' && export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/"'

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
# Keyboard configuration
#
local zkbd_base_dir="$XDG_CONFIG_HOME/zsh/.zkbd"
autoload zkbd
function zkbd_file() {
	if [[ -f "${zkbd_base_dir}/${TERM}" ]]; then
		printf '%s' "${zkbd_base_dir}/${TERM}"
		return 0
	elif [[ -f "${zkbd_base_dir}/${TERM}-${DISPLAY}" ]]; then
		printf '%s' "${zkbd_base_dir}/${TERM}-${DISPLAY}"
		return 0
	fi
	return 1
}


[[ -d zkbd_base_dir ]] || mkdir -p "$zkbd_base_dir"
keyfile=$(zkbd_file)
ret=$?
if [[ ${ret} -ne 0 ]]; then
	zkbd
	keyfile=$(zkbd_file)
	ret=$?
fi
if [[ ${ret} -eq 0 ]] ; then
	source "${keyfile}"
else
	printf 'Failed to setup keys using zkbd.\n'
fi
unfunction zkbd_file; unset keyfile ret zkbd_base_dir

[[ -n "$key[Home]" ]] && bindkey -- "$key[Home]" beginning-of-line
[[ -n "$key[End]" ]] && bindkey -- "$key[End]" end-of-line
[[ -n "$key[Delete]" ]] && bindkey -- "$key[Delete]" delete-char
[[ -n "$key[Up]" ]] && bindkey -- "$key[Up]" up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

#
# ZSH options
#

setopt EXTENDED_GLOB
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus # cd - produces a directory stack entry
setopt auto_cd # Move with .. or simple dir names

local zcompdumpdir="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
[ -d zcompdumpdir ] || mkdir -p zcompdumpdir
autoload -Uz compinit && compinit -d "$zcompdumpdir"

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
# Plugins
#
source $pluginbase/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $pluginbase/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f ~/.dircolors ] && has_executable 'dircolors' && eval $(dircolors ~/.dircolors) || :
[ -z "$(has_executable 'fasd')" ] && eval "$(fasd --init auto)" || echo "fasd is not installed"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh || echo "~/fzf.zsh does not exist, is fzf installed?"

#
# Functions
#

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

# Prompt
setopt prompt_subst
eval "$(starship init zsh)"

