# This is my custom promt, it is based on the seoul colors
# Feel free to copy and share

# Load the colors
autoload -Uz colors && colors
# Initialize promt customizing
autoload -Uz promptinit && promptinit

check_return_color() {
    [[ $RETVAL -eq 0 ]] && print -n "%{%F{green}%}" || print -n "%{%F{red}%}"
}

check_machine() {
    [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]] && print -n "$USER@%m:"
}

check_dir() {
    print -n "%1~ "
}

check_status() {
    [[ $UID -eq 0 ]] && print -n "%{%F{yellow}%}⚡"|| print -n "›"
}

end_prompt() {
    print -n "%f"
}

build_prompt() {
    RETVAL=$?
    check_return_color
    check_dir
    check_status
    end_prompt
}

PROMPT='$(build_prompt) '

setopt prompt_subst

