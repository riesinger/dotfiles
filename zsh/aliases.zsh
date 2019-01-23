# General
alias c="clear"
alias e="$EDITOR"
alias week='date +"%V"'
alias :q="exit"
alias ag="ag --hidden --ignore .git"
alias cat='bat'

# Tmux
alias tls="tmux ls"
alias tat="tmux attach -t"
alias tns="tmux new-session -s"

# Steam
alias steam="LD_PRELOAD='/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1 /usr/$LIB/libgpg-error.so' /usr/bin/steam &"
