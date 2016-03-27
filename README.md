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

The current list of installed packages includes (probably outdated):
- git
- neovim
- htop
- zsh
- lm_sensors
- ttf-hack
- thefuck
- termite
- yaourt (+ package-query)
*Technically not a package, but still included*
- oh-my-zsh

To install the dotfiles, just call `./install.sh`
