#!/bin/sh

bold=$(tput smso)
normal=$(tput sgr0)

paris_init () {
	clear
}

paris_title () {
	echo "${bold}$1${normal}"
}
