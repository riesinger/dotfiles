# Create some shortcuts for moving in dirs

setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
setopt auto_cd

alias -g ...='../..'

# List directory contents
alias ls="ls --color"
alias lsa='ls -lah --color'
alias l='ls -lah --color'
alias ll='ls -lh --color'
alias la='ls -lAh --color'
