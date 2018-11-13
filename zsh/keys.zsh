autoload zkbd
function zkbd_file() {
[[ -f ~/.zkbd/${TERM}-${VENDOR}-${OSTYPE} ]] && printf '%s' ~/".zkbd/${TERM}-${VENDOR}-${OSTYPE}" && return 0
[[ -f ~/.zkbd/${TERM}-${DISPLAY} ]] && printf '%s' ~/".zkbd/${TERM}-${DISPLAY}" && return 0
return 1
}

[[ ! -d ~/.zkbd ]] && mkdir ~/.zkbd
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
unfunction zkbd_file; unset keyfile ret

[[ -n "$key[Home]" ]] && bindkey -- "$key[Home]" beginning-of-line
[[ -n "$key[End]" ]] && bindkey -- "$key[End]" end-of-line
[[ -n "$key[Delete]" ]] && bindkey -- "$key[Delete]" delete-char
