#!/bin/sh

main() {
    if [[ -z "$DOT_LOC" ]]; then
        DOT_LOC="$HOME/.dotfiles"
    fi
    printf "Reading %s/links.list\n" $DOT_LOC

    while read line; do
        srcFile=$(echo "$line" | cut -d ' ' -f 1)
        destFile=$(echo "$line" | cut -d ' ' -f 2)
        printf "Linking %s to %s\n" "$DOT_LOC/$srcFile" "$HOME/$destFile"
        ln -s "$DOT_LOC/$srcFile" "$HOME/$destFile"
    done < "$DOT_LOC/links.list"
    echo "Done"
}

main $@
