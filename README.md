# Pascal's Dotfiles

These are my personal dotfiles (at least most of them). I would like you to look
through them, get inspired and maybe even suggest some better practises 
(especially in my Neovim config).

I have to thank Nick Nisi for a lot of inspiration with the install script.

## What you'll find

- Neovim config
- ZSH config (with oh-my-zsh)
- tmux config (maybe in the futurre)
- **An installl script**

## Installation

My dotfiles include a script called install.sh. It will create symlinks from
the ~/.dotfiles directory to the appropriate locations. 

The install script also has a 'bootstrapping' process, which will install 
my most commonly used applications (I only use Archlinux on all of my
machines - *Yes, even the servers*, so the package names and install commands
are Arch specific. The bootstrap should still work on Arch derivatives such
as Manjaro or similar). 

Just call it with `./install.sh bootstrap`

To install the dotfiles, just call `./install.sh`

## Software

This is a list of software I use on a regular basis:

Type                | Program
---                 | ---
distro              | arch
package manager     | pacman+pacaur
boot loader         | systemd-boot
config mgmt         | git + zsh
display manager     | lightdm (webkit2 greeter)
desktop environment | none
window manager      | bspwm
hotkey daemon       | xshkd
screen locker       | // TBD
text editor         | (neo)vim
shell               | zsh
network manager     | NetworkManager
terminal emulator   | termite+tmux
launcher            | rofi
wallpaper setter    | feh
panel               | none, see [Panel](#panel)
compositor          | compton
notifications       | dunst
file manager        | none, need to find a good one
browser             | Google Chrome (I need Netflix)
password manager    | LastPass (I know, no FOSS)
image viewer        | feh, but in need of something better
music player        | Google Play Music in Chrome, lately giving [jam](https://github.com/budkin/jam) a try
video player        | vlc
mail                | Google Inbox (I tried, but I can't live without it)
pdf reader          | Mostly viewing PDFs online, so Chrome
firewall            | ufw
backup              | rsync to home nextcloud server
fuzzy searching     | fzf (vim+terminal)
screenshots         | scrot
calendar            | Google Calendar on my phone (can't stand the look of the web interface)
notes               | vimwiki/markdown
fonts               | Noto Sans, Ubuntu Mono

