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
    [[ "$SSH_TTY" == "" ]] || print -n "$USER@%m:"
}

check_dir() {
    print -n "%1~ "
}

check_status() {
	[[ $UID -eq 0 ]] && print -n "%{%F{yellow}%}⚡"|| ([[ $RETVAL -eq 0 ]] && print -n "%{%F{green}%}›" || print -n "%{%F{red}%}›")
}

check_branch() {
    local branch="$(git branch 2>/dev/null | grep '^*' | colrm 1 2)"
    if [[ "$branch" == "master" ]]; then
        print -n "%{%F{red}%}$branch"
    elif [[ "$branch" == "develop" ]]; then
        print -n "%{%F{yellow}%}$branch"
    else
	print -n "$branch"
    fi
}

end_prompt() {
    print -n "%f"
}

build_prompt() {
    RETVAL=$?
    check_return_color
    check_machine
    check_dir
    check_branch
    check_status
    end_prompt
}

PROMPT='$(build_prompt) '

setopt prompt_subst

